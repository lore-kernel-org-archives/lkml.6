Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72369C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341F9206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xt0FFsix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfAJPvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:51:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47560 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbfAJPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P/yTMXkLu9gvc+z9xe7moubzeShd0sYXGXbDLnyUI+s=; b=xt0FFsixmVLdFd40SYkBLjTt2
        dLYPWB32hoHPjLRsChxb4qhF2om57OvrKmJs0PZBgun8U3fbGKZm+ofn9w1Wglmc7M1W3b9OmC1nI
        Wc1+jdL4/rFET+MTXcp64yRcXFxNWXQZ+pjKl7+iEUbRTmLIFT0RgrhY5+TuiUQIplSnoogdfNw56
        l86GHKN49cQ52IDkkeh9LyjNc+/suOW9+7xoY6SLtAGElWo65QgSIfuI71O5eb+K+W6+vtJS9aWK+
        pqCkE9tjsV8zlkFRrO8mI3sJbh1gwFfSu0zXybbIW20X+ny/d/3eMey+zfNOrj0qSRuzAvKDwGqwd
        HZggSOQQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghccS-000577-Qx; Thu, 10 Jan 2019 15:51:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85F4C20815190; Thu, 10 Jan 2019 16:51:42 +0100 (CET)
Date:   Thu, 10 Jan 2019 16:51:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v5 11/15] locking/lockdep: Check data structure
 consistency
Message-ID: <20190110155142.GI30894@hirez.programming.kicks-ass.net>
References: <20181217213002.73776-1-bvanassche@acm.org>
 <20181217213002.73776-12-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217213002.73776-12-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 01:29:58PM -0800, Bart Van Assche wrote:
> Debugging lockdep data structure inconsistencies is challenging. Add
> disabled code that verifies data structure consistency at runtime.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  kernel/locking/lockdep.c | 183 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 3a63142d4764..d411660572e1 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -74,6 +74,8 @@ module_param(lock_stat, int, 0644);
>  #define lock_stat 0
>  #endif
>  
> +static bool check_data_structure_consistency;

Should this maybe be CONFIG_DEBUG_LOCKDEP ?
