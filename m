Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3BCC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825882192D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="dbXlcUCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfBQJkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:40:02 -0500
Received: from vern.gendns.com ([98.142.107.122]:52686 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfBQJkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OLrETPYPsFwEdPITog9RDbfkIjTDsapPYRtogRriLGE=; b=dbXlcUCbN5D0/gn8xukomwUHCv
        Td7JWrbBsPSo7ICPXz2g8CuwPRRDsNqOpRM5mDIW9p7p1Ul04/+f4RyouckJUS/Em/eqGKX2hUOyU
        rmI7unv3XQDXzUyGZUsHKT11b1RF/zwwY9S6TZirQ5bH2sD6uHYA0L6ckqnp6tZ0FknacG2McEjyP
        RdrZTiL7fu5NizLVpcsnfntpxEFJEkcvnnVuTmhHw/RPHgh99Sm17wKLBZEKY1woiAQMbU8pOsSkL
        ZoB3rTxu4MqyFQ+ap6pHfGbKuur8t7jmZ2G86flansFo3Qa8cbdOZpYCh7noEhXBc0Mm89UxCr0yX
        sqiMPieg==;
Received: from [185.122.190.68] (port=16065 helo=gerda-5.local)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gvIvN-00062B-GL; Sun, 17 Feb 2019 04:39:49 -0500
Subject: Re: [PATCH v4 14/37] ARM: davinci: aintc: use readl/writel_relaxed()
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190214145231.8750-1-brgl@bgdev.pl>
 <20190214145231.8750-15-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <9df95fcb-49b3-bd53-69d1-f8cd363f3ee3@lechnology.com>
Date:   Sun, 17 Feb 2019 10:39:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214145231.8750-15-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 8:52 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Raplace all calls to __raw_readl() & __raw_writel() with readl_relaxed()
> and writel_relaxed() respectively. It's safe to do as there's no
> endianness conversion being done in the code.

This patch only changes writel. There is no readl.

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/irq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> index 2df91fc0dade..509be44eda22 100644
> --- a/arch/arm/mach-davinci/irq.c
> +++ b/arch/arm/mach-davinci/irq.c
> @@ -36,7 +36,7 @@ static struct irq_domain *davinci_aintc_irq_domain;
>   
>   static inline void davinci_aintc_writel(unsigned long value, int offset)
>   {
> -	__raw_writel(value, davinci_aintc_base + offset);
> +	writel_relaxed(value, davinci_aintc_base + offset);
>   }
>   
>   static inline unsigned long davinci_aintc_readl(int offset)
> 
