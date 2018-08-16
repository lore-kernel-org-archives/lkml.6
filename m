Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29A1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C6120C07
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCr9Y6ur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C6120C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbeHPUHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbeHPUHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:07:03 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7849E20C07;
        Thu, 16 Aug 2018 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534439240;
        bh=FQ0n5w61dU9nAEtsa/DVY2BfrnuoBz7JXc1oRc42sMg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YCr9Y6urf+Ei8KxDRCjYR7+GtDQd4/eja4pYNPE0FWiiI6XraM+V0Gd7dJ5jnJ2iu
         PEY6YWGLmPJR7juvxpcXHxBpk3pIfFFgPotwN10k6JXO5ewR/V9eGWw7+2aG7mEozh
         evcJb5xWILLbVWBN/00/0QKFEniKdktZmUTOWNlU=
Date:   Fri, 17 Aug 2018 02:07:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing/blktrace: Fix to allow setting same value
Message-Id: <20180817020717.7c0402429f0d4397f1b8d586@kernel.org>
In-Reply-To: <20180816124917.77c82f04@gandalf.local.home>
References: <153441301698.6024.1680500212551396320.stgit@devbox>
        <153441307534.6024.2684721209411781531.stgit@devbox>
        <20180816103802.08678002@gandalf.local.home>
        <20180817013847.85ff26224bfd48d0fca1fd3f@kernel.org>
        <20180816124917.77c82f04@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2018 12:49:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > 
> > > Hmm, why not just do this? Does this fix it too?  
> > 
> > Ah, yes, but we need to clear "ret" in that case.
> 
> Sure.
> 
> > 
> > Thanks!
> > 
> > > 
> > > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > > index 987d9a9ae283..10b2b9c5fd25 100644
> > > --- a/kernel/trace/blktrace.c
> > > +++ b/kernel/trace/blktrace.c
> > > @@ -1841,6 +1841,8 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
> > >  	mutex_lock(&q->blk_trace_mutex);
> > >  
> 
> > >  	if (attr == &dev_attr_enable) {
> > > +		if (!!value == !!q->blk_trace) {
>     +                   ret = 0;
> > > +			goto out_unlock_bdev;
>     +		}
> 

OK, I tested and ensured that this works.

Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
