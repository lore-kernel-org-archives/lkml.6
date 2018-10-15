Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324F8C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F3920881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F3920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeJPDBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:01:20 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:45128 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbeJPDBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:01:20 -0400
Received: from sf (trofi-1-pt.tunnel.tserv1.lon2.ipv6.he.net [IPv6:2001:470:1f1c:a0f::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: slyfox)
        by smtp.gentoo.org (Postfix) with ESMTPSA id A09F4335C58;
        Mon, 15 Oct 2018 19:14:44 +0000 (UTC)
Date:   Mon, 15 Oct 2018 20:14:41 +0100
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ia64: disable SCHED_STACK_END_CHECK
Message-ID: <20181015201441.64f6816a@sf>
In-Reply-To: <20180914070617.29203-1-slyfox@gentoo.org>
References: <20180914070617.29203-1-slyfox@gentoo.org>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2018 08:06:17 +0100
Sergei Trofimovich <slyfox@gentoo.org> wrote:

> SCHED_STACK_END_CHECK assumes stack grows in one direction.
> ia64 is a rare case where it is not.
> 
> As a result kernel fails at startup as:
>   Kernel panic - not syncing: corrupted stack end detected inside scheduler
> 
> The error does not find a real problem: it's register backing store
> is written on top of canary value.
> 
> Disable SCHED_STACK_END_CHECK on ia64 as there is no good
> place for canary without moving initial stack address.
> 
> CC: Tony Luck <tony.luck@intel.com>
> CC: Fenghua Yu <fenghua.yu@intel.com>
> CC: linux-ia64@vger.kernel.org
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> ---
>  lib/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 4966c4fbe7f7..a097dfe38d2b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1004,7 +1004,7 @@ config SCHEDSTATS
>  
>  config SCHED_STACK_END_CHECK
>  	bool "Detect stack corruption on calls to schedule()"
> -	depends on DEBUG_KERNEL
> +	depends on DEBUG_KERNEL && !IA64
>  	default n
>  	help
>  	  This option checks for a stack overrun on calls to schedule().
> -- 
> 2.19.0
> 

Ping.

-- 

  Sergei
