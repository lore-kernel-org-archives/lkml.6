Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63E1C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B0720821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="KYSvtCap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfBDWv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:51:26 -0500
Received: from vern.gendns.com ([98.142.107.122]:37690 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfBDWv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zqg6PQDYEksqf7XsBp5pfxKN6SfqgMCc7RZIl+8gYLU=; b=KYSvtCapND8J38JXa8jSp5+cEu
        RD+tfR/9XC75AAHmof/kGbWSYW//7vdOPkMnTT9HwecO31VHFow4c3dBZqLPouy61+gN23+RjaQzZ
        6ZsByyZny117JvBk2Q00WGSGWP3DDAmDhQ7uoWghPn5vs/rwfBne8qbANybKF6mDLh81idIwoN0iZ
        FFapBClZSA7na3z6qLWrzN1fs83J6DYU7T4MMdLODl+ED3Qbq+BYMe3sudN5nlxQAbRv60N3jtsKC
        1WvsREGfRkvFidn+MR297tmpeYES0nqAsG7SHqJxN8c6odyiyjME0u+oPnWaxLPv85cq150XiuEV7
        W/aYXDpg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:58572 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqn1p-0007Zg-3M; Mon, 04 Feb 2019 17:47:49 -0500
Subject: Re: [PATCH 10/35] ARM: davinci: aintc: wrap davinci_irq_init() with a
 helper
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-11-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <fd54b5bb-5241-e5f4-3d6e-5f8f6bd0700e@lechnology.com>
Date:   Mon, 4 Feb 2019 16:51:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-11-brgl@bgdev.pl>
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
> We're going to extend the davinci_irq_init() function with a config
> structure so we can drop the intc-related fields from davinci_soc_info.
> 
> Once we do it, we won't be able to use this routine directly as the
> init_irq callback. Wrap the calls in additional helpers that don't
> take parameters and can be assigned to init_irq.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>


One bikeshed comment: I would use xxx_init_irq instead of xxx_init_irqs
so that the function names exactly match the .init_irq field.

