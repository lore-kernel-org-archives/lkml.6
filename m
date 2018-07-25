Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562B8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDB620852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 01:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvAE6qXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDB620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbeGYCOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388517AbeGYCOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:14:31 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 844DC20852;
        Wed, 25 Jul 2018 01:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532480723;
        bh=MkutZ6Iq8zkXBC7KWbtN0iE3PYyZlTFpgq4rLA6FFUg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bvAE6qXzpJ2fww/h2nd5ayaya9eDN6AXXVfCYnC9dqjEbPZWPodPOnFbOcwJbqlvv
         BxKFycfM7aOinp6Y47x4Etj+Cg0MbG+9KXtCu8NjIOuEZADBD0Hpl4KQq7TLsZ5PaC
         mrNyWYp1NX7Ehe5NlfuNBfZxZhCdd5DhB85jH6ZI=
Date:   Wed, 25 Jul 2018 10:05:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] [BUGFIX] tracing: Fix double free of
 event_trigger_data
Message-Id: <20180725100520.9370df20d29d529236f4a368@kernel.org>
In-Reply-To: <20180724164959.3cbc1422@gandalf.local.home>
References: <153149923649.11274.14970833360963898112.stgit@devbox>
        <153149926702.11274.12489440326560729788.stgit@devbox>
        <20180723221006.60cc7aa9@vmware.local.home>
        <20180725000909.6c8b2f3881ee75c4f6bd466b@kernel.org>
        <20180724164959.3cbc1422@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 16:49:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 25 Jul 2018 00:09:09 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hmm, your patch seems to leak a memory since event_trigger_init() will
> > be called twice on same trigger_data (Note that event_trigger_init()
> > does not init ref counter, but increment it.) So we should decrement
> > it when we find it is succeeded. Moreover, if register_trigger()
> 
> Good catch, and easily fixed.
> 
> > fails before calling data->ops->init() (see -EEXIST case), the ref
> > counter will be 0 (-1 +1). But if it fails after data->ops->init(),
> > the ref counter will be 1 (-1 +1 +1). It still be unstable.
> > (Ah, that means we may have another trouble...)
> 
> I'm not sure there's a problem here. I now have:
> 
>  out_reg:
> 	/* Up the trigger_data count to make sure reg doesn't free it on failuer */
> 	event_trigger_init(trigger_ops, trigger_data);
> 	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
> 	/*
> 	 * The above returns on success the # of functions enabled,
> 	 * but if it didn't find any functions it returns zero.
> 	 * Consider no functions a failure too.
> 	 */
> 	if (!ret) {
> 		ret = -ENOENT;
> 	} else if (ret > 0)
> 		ret = 0;

Can we mixed up ret == 0 and ret > 0? It seems cmd_ops->reg() == 0
is a failure case.

> 
> 	/* Down the counter of trigger_data or free it if not used anymore */
> 	event_trigger_free(trigger_ops, trigger_data);
>  out:
> 	return ret;
> 
> Thus we increment trigger_data before calling reg, and free it
> afterward. But if reg() did an init too, then the event_trigger_free()
> just decs the ref counter. 

To avoid confusion, I would like to suggest to rename those pair to
event_trigger_data_get/put(). :)

> 
> As for register_trigger()
> 
> 
> > 
> > > 
> > > P.S. This brings up another minor bug. The failure should return ENOMEM
> > > not ENOENT.  
> > 
> > Hmm it seems we should review the register_trigger() implementation.
> > It should return the return value of trace_event_trigger_enable_disable(),
> > shouldn't it?
> >
> 
> Yeah, that's not done well. I'll fix it up.

Thanks!
> 
> Thanks for pointing it out.
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
