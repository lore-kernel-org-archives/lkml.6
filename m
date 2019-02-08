Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87682C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547D72177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nuzz/y4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfBHMaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:30:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54328 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHMaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:30:23 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x18CTC6D004571;
        Fri, 8 Feb 2019 06:29:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549628952;
        bh=D5ta3hfxhZ7v174cvkVpIOjsg0s9Y9cf9WFazKjR38Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Nuzz/y4ngIywYVkm6QUWRRbtPGjvBZo63EXH8aBvDIQQbJKb14/fqDbdiFJy1eGtQ
         +zwAnjH+8TUM9+i376gBJ2+MkabIEHU6Hk6MDIoWYI85/PynT/gQq1qFLJuiXl5Qj5
         WhyYn9jo/Oqo4z6QGSE1LIyGNotaGzt+qN0trYKE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x18CTCdk128372
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 06:29:12 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 06:29:11 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 06:29:11 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x18CT80a011657;
        Fri, 8 Feb 2019 06:29:09 -0600
Subject: Re: [PATCH 00/35] ARM: davinci: modernize the irq support
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <edfcdc52-3ff0-ec58-94f7-4816d2b2b3f4@lechnology.com>
 <CAMRc=MfPAg_j-DfaQCaTd2GmBDctv7L0eSzTET+fcj+WArejdg@mail.gmail.com>
 <b70bbda8-b448-d9d1-e3fa-57dbfa6c2fbb@ti.com>
 <CAMRc=McNvvowdQG3zNhLpAuOL-Q_U1184mTwcJWJMRxto1LYbg@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <8314e494-c990-8c53-bd60-726b7ac795f2@ti.com>
Date:   Fri, 8 Feb 2019 17:59:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=McNvvowdQG3zNhLpAuOL-Q_U1184mTwcJWJMRxto1LYbg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/19 5:57 PM, Bartosz Golaszewski wrote:
> pt., 8 lut 2019 o 12:43 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>
>> On 05/02/19 9:41 PM, Bartosz Golaszewski wrote:
>>> pon., 4 lut 2019 o 22:49 David Lechner <david@lechnology.com> napisał(a):
>>>>
>>>> On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>
>>>>> This series ports the davinci platform to using SPARSE_IRQ, cleans up
>>>>> the irqchip drivers and moves them over to drivers/irqchip.
>>>>>
>>>>
>>>> This has been on my todo list for years, but I've never had enough
>>>> time to figure it out. Nice to see it finally getting done!
>>>>
>>>> Series tested on LEGO MINDSTORMS EV3 (da850-like). I can now use
>>>> IIO triggers without having to patch the kernel to add extra
>>>> interrupts.
>>>>
>>>> Tested-by: David Lechner <david@lechnology.com>
>>>>
>>>>
>>>
>>> Wow thanks for taking the time to review it!
>>>
>>> I'll address certain remarks - for those unaddressed - I'll fix them in v2.
>>>
>>> Sekhar: are you fine with sending both the clocksource and interrupt
>>> series together next time with additional patches on top making
>>> davinci part of multi_v5_defconfig?
>>
>> I think its better to keep them separate. You can base both on latest
>> mainline.
>>
>> Thanks,
>> Sekhar
> 
> If you prefer I can keep them separate, although there were a couple
> conflicts when I merged them in my tree, which are now resolved.
> 
> Let's maybe start with the interrupts (I'll send a v2 tonight if you
> don't have any more comments), and once you have that in your tree, I
> will rebase the timer code and then the multi_v5 series.

Sounds good. I have no more comments on the interrupt series. We will
need acks from irqchip maintainers before merging though.

Thanks,
Sekhar
