Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FD6C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 20:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A052214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 20:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pxlUfJQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfAZUZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 15:25:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfAZUZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 15:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hazEsmpqbDvFZ2wfJl1VeB9kYj/SI5azh2E2e6QjFsU=; b=pxlUfJQsE54HL/pI4wH4T/6dp
        nD/t5X46kcJ1ERAl4cGeyJMLeWHM3sKLdthI6G8kV1LEcqtw1ImPBairXYMjbp2Wg6ZSo2JVCQXb8
        G0hoJv056FSlT8/5fY7K5BWJriYfHkO7TKOH+CCUxQ+3K4kTSCVHNWjNblYiq/QPMZ0QEahKqlB2L
        FWjHP0c2gWxLyGO09VJs3//qo0Mp8FPex/gumUpsZWIOyVXAU3+DbxnRl01lfWDRLMGtYCAc4GIqJ
        g9us0pNzRUDznCquW150VjKlVO3pZzDW2lxZ/DNqYUx7dzFpSrBtT8KdXiDDfzWcDML/VkEyIX2WN
        p85iXAtHQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gnUWH-0007Gm-CK; Sat, 26 Jan 2019 20:25:37 +0000
Date:   Sat, 26 Jan 2019 12:25:34 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] futex: no need to check return value of debugfs_create
 functions
Message-ID: <20190126202534.GC7439@wrath>
References: <20190122152151.16139-40-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122152151.16139-40-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:21:39PM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

As documented, and futexes can't be modules, so no need to check for the dentry.

Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>



> ---
>  kernel/futex.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index be3bff2315ff..c2ed57b084a4 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -321,12 +321,8 @@ static int __init fail_futex_debugfs(void)
>  	if (IS_ERR(dir))
>  		return PTR_ERR(dir);
>  
> -	if (!debugfs_create_bool("ignore-private", mode, dir,
> -				 &fail_futex.ignore_private)) {
> -		debugfs_remove_recursive(dir);
> -		return -ENOMEM;
> -	}
> -
> +	debugfs_create_bool("ignore-private", mode, dir,
> +			    &fail_futex.ignore_private);
>  	return 0;
>  }
>  
> -- 
> 2.20.1
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
