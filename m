Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB7AC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8260420665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8260420665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeJWEen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:34:43 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:53034 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeJWEem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:34:42 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gEgb1-0002D0-Az; Mon, 22 Oct 2018 22:14:39 +0200
Message-ID: <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
Subject: Re: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme @ lists . infradead . org" 
        <linux-nvme@lists.infradead.org>
Date:   Mon, 22 Oct 2018 22:14:22 +0200
In-Reply-To: <20181022151818.135163-1-bvanassche@acm.org>
References: <20181022151818.135163-1-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-22 at 15:18 +0000, Bart Van Assche wrote:
> Lockdep is a tool that developers rely on to find actual bugs. False
> positive lockdep warnings are very annoying because it takes time to
> analyze these and to verify that the warning is really a false positive
> report. Since commit 87915adc3f0a ("workqueue: re-add lockdep
> dependencies for flushing") causes lockdep to produce multiple false
> positive reports, revert that commit. 


What, no, I obviously _strongly_ object to this. You've just killed
lockdep reporting an entire *class* of problems over a single report
that you don't like.

"False positives" - which in this case really should more accurately be
called "bad lockdep annotations" - of the kind you report here are
inherent in how lockdep works, and thus following your argument to the
ultimate conclusion you should remove lockdep.


Say, for example (and similar things exist, like socket locks in
networking), you have a list of objects, each initialized through a
single function that does mutex_init(), causing a single lockdep class
to be used.

Now you have to acquire the locks for multiple such objects, and to make
that safe you always do that in object ID order, which is strictly
monotonically increasing.

Lockdep will *certainly* complain about this situation, since as far as
it is concerned, you've just done a recursive lock.

The solution to this isn't to remove lockdep annotations for mutexes (or
work objects, as you propose), the solution is to tell lockdep that you
actually have multiple classes of objects, and thus the recursion you do
is not a problem.

So clearly, NACK.

I must also say that I'm disappointed you'd try to do things this way.
I'd be (have been?) willing to actually help you understand the problem
and add the annotations, but rather than answer my question ("where do I
find the right git tree"!) you just send a revert patch.

To do that, you have to understand what recursion is valid (I'm guessing
there's some sort of layering involved), and I'm far from understanding
anything about the code that triggered this report.

I'm almost certain can teach lockdep about why the recursion is fine,
probably by using a lock subclass (last argument to lockdep_init_map())
in either a new variant of alloc_workqueue() or a new variant of
INIT_WORK().

johannes


