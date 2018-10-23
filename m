Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998F0C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6668E20651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6668E20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeJXDvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:51:43 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:44120 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXDvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:51:43 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gF2KJ-0003oc-8T; Tue, 23 Oct 2018 21:26:51 +0200
Message-ID: <b3aae7aa8241c9828c04d2f2b58927f4ce1411b9.camel@sipsolutions.net>
Subject: Re: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme @ lists . infradead . org" 
        <linux-nvme@lists.infradead.org>
Date:   Tue, 23 Oct 2018 21:26:31 +0200
In-Reply-To: <63ae9bac-3587-bded-ea98-e43fb4d7240d@grimberg.me> (sfid-20181023_024355_374203_678E864D)
References: <20181022151818.135163-1-bvanassche@acm.org>
         <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
         <1540244870.128590.39.camel@acm.org>
         <63ae9bac-3587-bded-ea98-e43fb4d7240d@grimberg.me>
         (sfid-20181023_024355_374203_678E864D)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-22 at 17:43 -0700, Sagi Grimberg wrote:
> > > I must also say that I'm disappointed you'd try to do things this way.
> > > I'd be (have been?) willing to actually help you understand the problem
> > > and add the annotations, but rather than answer my question ("where do I
> > > find the right git tree"!) you just send a revert patch.
> > 
> > Sorry that I had not yet provided that information. You should have
> > received this information through another e-mail thread. See also
> > http://lists.infradead.org/pipermail/linux-nvme/2018-October/020493.html.
> > 
> > > To do that, you have to understand what recursion is valid (I'm guessing
> > > there's some sort of layering involved), and I'm far from understanding
> > > anything about the code that triggered this report.
> > 
> > I don't think there is any kind of recursion involved in the NVMe code
> > that triggered the lockdep complaint. Sagi, please correct me if I got this
> > wrong.
> 
> I commented on the original thread. I'm not sure it qualifies as a
> recursion, but in that use-case, when priv->handler_mutex is taken
> it is possible that other priv->handler_mutex instances are taken but
> are guaranteed not to belong to that priv...

I also commented over there regarding this specific problem.

I think my wording was inaccurate perhaps. It's not so much direct
recursion, but a dependency chain connecting the handler_mutex class
back to itself. This is how lockdep finds problems, it doesn't consider
actual *instances* but only *classes*.

As Sagi mentioned on the other thread, in this specific instance you
happen to know out-of-band that this is safe, (somehow) the code ensures
that you can't actually recursively connect back to yourself. Perhaps
there's some kind of layering involved, I don't know. (*)

As I said over there, this type of thing can be solved with
mutex_lock_nested(), though it's possible that in this case it should
really be flush_workqueue_nested() or flush_work_nested() or so.

johannes

(*) note that just checking "obj != self" might not be enough, depending
on how you pick candidates for "obj" you might recurse down another
level and end up back at yourself, just two levels down, and actually
have a dependency chain leading back to yourself.


