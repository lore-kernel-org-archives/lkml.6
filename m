Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7790DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3273325DD7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q2bWNGj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3273325DD7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932747AbeFYQJQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:09:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeFYQJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2NgM7YrKZmrnqEcYPjfXixd/FNHqc0vvvHWU5gh/hyw=; b=Q2bWNGj2pGREm54f3XL4zZaWU
        LQE+5yg/94PYaQpEwkCqYWc+3oZtLCiVgpdwv4ukjX++qu0I/V5LK4UH5wXuVi2I7pLRym4wBArbE
        bsafudgxMXHj3lAUMB8VgPRPIXgnNnfAQpWKr+pAoVpDNTePU1C/ENHhz16ZlYQeSiqPx4SEN1GYA
        hUCJlDGHyf7YOezE1z7WWy3HrVPXAHH6O4XwLbhZK6ZtsBty6bcUT6krlmub3iphytR/cGZgI/Tfr
        eFlVeJvF9ZVsmvraNtgPelLHNx0ydtXPqcmWJnCguygwn5vU6uEI7TNa5SyG0D9RPXdiUrumCXoao
        +k4rjo8ig==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXU3G-0005u8-2v; Mon, 25 Jun 2018 16:09:14 +0000
Subject: Re: [PATCH] add param that allows bootline control of hardened
 usercopy
To:     Chris von Recklinghausen <crecklin@redhat.com>,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@vger.kernel.org
References: <1529939300-27461-1-git-send-email-crecklin@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5fe64898-d4df-1edd-37f0-5abbce6b2462@infradead.org>
Date:   Mon, 25 Jun 2018 09:09:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529939300-27461-1-git-send-email-crecklin@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 08:08 AM, Chris von Recklinghausen wrote:
> Enabling HARDENED_USER_COPY causes measurable regressions in the
> networking performances, up to 8% under UDP flood.
> 
> A generic distro may want to enable HARDENED_USER_COPY in their default
> kernel config, but at the same time, such distro may want to be able to
> avoid the performance penalties in with the default configuration and
> enable the stricter check on a per-boot basis.
> 
> This change adds a config variable and a boot parameter to conditionally
> enable HARDENED_USER_COPY at boot time, and switch HUC to off if
> HUC_DEFAULT_OFF is set.
> 
> Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
> ---
>  .../admin-guide/kernel-parameters.rst         |  2 ++
>  .../admin-guide/kernel-parameters.txt         |  3 ++
>  include/linux/thread_info.h                   |  7 +++++
>  mm/usercopy.c                                 | 28 +++++++++++++++++++
>  security/Kconfig                              | 10 +++++++
>  5 files changed, 50 insertions(+)
> 

Hi,

> diff --git a/security/Kconfig b/security/Kconfig
> index c4302067a3ad..a6173897b85c 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -189,6 +189,16 @@ config HARDENED_USERCOPY_PAGESPAN
>  	  been removed. This config is intended to be used only while
>  	  trying to find such users.
>  
> +config HUC_DEFAULT_OFF
> +	bool "allow CONFIG_HARDENED_USERCOPY to be configured but disabled"
> +	depends on HARDENED_USERCOPY
> +	help
> +	  When CONFIG_HARDENED_USERCOPY is enabled, disable its
> +	  functionality unless it is enabled via at boot time

	                       it is enabled at boot time

> +	  via the "enable_hardened_usercopy" boot parameter. This allows
> +	  the functionality of hardened usercopy to be present but not
> +	  impact performance unless it is needed.
> +
>  config FORTIFY_SOURCE
>  	bool "Harden common str/mem functions against buffer overflows"
>  	depends on ARCH_HAS_FORTIFY_SOURCE
> 


-- 
~Randy
