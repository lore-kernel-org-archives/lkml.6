Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45846C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016832083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="nWkOO4q6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfBDXnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:43:19 -0500
Received: from vern.gendns.com ([98.142.107.122]:49996 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfBDXnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fl/CEWgft1iHybGMEoq4yVj+5dj+wGNYdkifmBg0VPI=; b=nWkOO4q6tOF+PipLhGDydpvDkn
        Y4Y3zzBwna/ii/fO7MlQnkRZN+3NAXadCHxUTtwELVdarvvQpY5ot8Ou0IelWIWrt6RsaDQHxjO/4
        1e3sIMRQb4AhPm7W762HrZH+LKguZYCVCdOnPuQAfh2pxJ2HWFQ7k8/QX3gwFq7x6C5NejjL2Dr87
        GCLinf5oH7O7QVcjJP+yLnUJA9HPrywVC8l9HPmKFPXU+ho7JJeRdxMlSskrZq4vnCL9XieecQAyV
        2xP1Ay4qXZwpVCKbJTxyjc5Ct91mC13iXOjyGbCzN2W8OQZiD+G9vpz3PpLG9Yx0VuMRMuP76HMmA
        Z0iATFiw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:59600 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqnq2-0005p5-8k; Mon, 04 Feb 2019 18:39:42 -0500
Subject: Re: [PATCH 18/35] irqchip: davinci-aintc: move the driver to
 drivers/irqchip
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-19-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <9fb82a77-9732-b9ec-5394-c6a5148b4f7f@lechnology.com>
Date:   Mon, 4 Feb 2019 17:43:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-19-brgl@bgdev.pl>
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

On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The aintc driver has now been cleaned up. Move it to drivers/irqchip
> where it belongs. There's no device-tree support for any dm* board so
> there's no IRQCHIP_OF_DECLARE() - there's only the exported init
> function called from machine code.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>


> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 3d1e60779078..ea0eb82bf1d2 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -129,6 +129,11 @@ config BRCMSTB_L2_IRQ
>   	select GENERIC_IRQ_CHIP
>   	select IRQ_DOMAIN
>   
> +config DAVINCI_AINTC
> +	bool
> +	select GENERIC_IRQ_CHIP
> +	select IRQ_DOMAIN

No help section? :-)

> +
>   config DW_APB_ICTL
>   	bool
>   	select GENERIC_IRQ_CHIP

