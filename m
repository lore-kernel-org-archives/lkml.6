Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADB3C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3959521904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SET6Beng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfBGMWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:22:04 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38010 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfBGMWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:22:03 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17CLhtl115848;
        Thu, 7 Feb 2019 06:21:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549542103;
        bh=dCTLPZKdBwcNKIjpTTCnTDXhgBzRhnn4VA2HiHM1NZk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SET6BengYn9qOMCljixmToS9/L2bWaHzAn91LaRrK66nJL8aHWMyGdZEol2Vk1gJb
         Cj7LlKJn2uDF+G1Oe22/T6mhILtHTsvLUlLudARXYSFfclwFUTXVv1ejaPck5Q5HQi
         XdtpxlQQlQ2TcTB0yTtYWzDht4yif3prfgo5H4MU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17CLhGt069850
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 06:21:43 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 06:21:43 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 06:21:43 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17CLeAg003399;
        Thu, 7 Feb 2019 06:21:41 -0600
Subject: Re: [PATCH 16/35] ARM: davinci: aintc: move timer-specific
 irq_set_handler() out of irq.c
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-17-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <9f6e023c-71cc-197a-d651-83a3b1662d85@ti.com>
Date:   Thu, 7 Feb 2019 17:51:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-17-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/19 7:09 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> I've been unable to figure out exactly why, but it seems that the
> IRQ_TINT1_TINT34 interrupt for timer 1 needs to be handled as a
> level irq, not edge like all others.

Not sure of the history myself. This has been this way since beginning
of DaVinci support in kernel.

> 
> This timer is used by the dsp on dm64* boards only.

This would be T1_TOP in code, which is actually marked as unused. T1_BOT
is the one used for DSPs.

> 
> Let's move the handler setup out of the aintc driver where it's lived
> since the beginning and into the dm64* SoC-specific files where it
> belongs.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/dm644x.c | 4 ++++
>  arch/arm/mach-davinci/dm646x.c | 4 ++++
>  arch/arm/mach-davinci/irq.c    | 1 -

I think this should be done for DM355 too?

Thanks,
Sekhar
