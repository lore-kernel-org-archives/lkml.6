Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FFFC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4431D21916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549586547;
	bh=qZXdWOc89XVHySKfM2B7o0I6mdeY6kjbnFlaTHr+BGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=K+jnyVAra3+AHLNmzuL8hZaCiLYL145ZSpPFl5JgnuWpow2b8VazCVyjhXh0TulMf
	 /uJ8jgHBwRUwxC2g/obbD488fzRDYMxVeWEHidRROMJ/18OYl/EZyOsZ6FLem6WLP3
	 5UUL/ICu9iahJNyl0eNlq/yGhXsQmhfXCluJoIgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfBHAmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfBHAmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:42:25 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E628921907;
        Fri,  8 Feb 2019 00:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549586544;
        bh=qZXdWOc89XVHySKfM2B7o0I6mdeY6kjbnFlaTHr+BGE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f9d6Z2jktLhOUpCUmJKZmrHXdJVZjUFfU/vmP4GnJhxByXFxOdxxWgbTWtWgsG64W
         zGZbSuDeMkWETQ2qEdQ9yEHyvetGKRHyXu2Qz7sWH3N4nfN8AvQ2jPipWmQITUtVAp
         CBRCcIW/3gEuQhMMRYDc0W3Hcgy5/6/oQNsGsGpg=
Date:   Fri, 8 Feb 2019 09:42:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tracing: uprobes: Re-enable $comm support for
 uprobe events
Message-Id: <20190208094220.83ae0df5c71a9cd8891e598d@kernel.org>
In-Reply-To: <20190206155243.725bc30d@gandalf.local.home>
References: <154778663676.19927.12774448308165809570.stgit@devbox>
        <154778666570.19927.5960654930869453736.stgit@devbox>
        <20190206155243.725bc30d@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 15:52:43 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 18 Jan 2019 13:44:25 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > @@ -180,7 +183,12 @@ fetch_store_strlen(unsigned long addr)
> >  	int len;
> >  	void __user *vaddr = (void __force __user *) addr;
> >  
> > -	len = strnlen_user(vaddr, MAX_STRING_SIZE);
> > +	if (addr == (unsigned long)current->comm) {
> > +		len = strlen(current->comm);
> > +		if (len)
> > +			len++;
> 
> Why only add 1 if len is non zero? Why not always do it.
> 
> One thing, len should always be greater than 0, and the other is that
> this makes it inconsistent with the NULL case of reading the address in
> userspace.

Agreed, it should not 0, so it should be;
len = strlen(current->comm) + 1;

Thank you!

> 
> -- Steve
> 
> 
> > +	} else
> > +		len = strnlen_user(vaddr, MAX_STRING_SIZE);
> >  
> >  	return (len > MAX_STRING_SIZE) ? 0 : len;


-- 
Masami Hiramatsu <mhiramat@kernel.org>
