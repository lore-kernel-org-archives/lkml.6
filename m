Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0FBC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689C220823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uOhA3WNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfBHLpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:45:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47838 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBHLpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:45:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x18Bhs5b122569;
        Fri, 8 Feb 2019 05:43:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549626234;
        bh=LzHUrENdQtad7aZ9C8w4CNHKlWbfppzru+yr3K9GrhE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uOhA3WNMe86QOdtyAO3XEx52LK63fyqApmmHeXPr+/eMbjQCBBR9D5H6q50H13YeU
         0miZqOAo1yKISS1AMRdQdhNR71gm+7KYkBa7ohBPPJCPFbyfUPu6H+wNTJaF1GQgCe
         Poce4eAVF7ZnlkSb83W/CB/lhuNGoAkDfAJ9bLpM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x18BhsdP081422
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 05:43:54 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 05:43:53 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 05:43:53 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x18Bhnvx007023;
        Fri, 8 Feb 2019 05:43:51 -0600
Subject: Re: [PATCH 00/35] ARM: davinci: modernize the irq support
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        David Lechner <david@lechnology.com>
CC:     Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <edfcdc52-3ff0-ec58-94f7-4816d2b2b3f4@lechnology.com>
 <CAMRc=MfPAg_j-DfaQCaTd2GmBDctv7L0eSzTET+fcj+WArejdg@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <b70bbda8-b448-d9d1-e3fa-57dbfa6c2fbb@ti.com>
Date:   Fri, 8 Feb 2019 17:13:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MfPAg_j-DfaQCaTd2GmBDctv7L0eSzTET+fcj+WArejdg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/19 9:41 PM, Bartosz Golaszewski wrote:
> pon., 4 lut 2019 o 22:49 David Lechner <david@lechnology.com> napisał(a):
>>
>> On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> This series ports the davinci platform to using SPARSE_IRQ, cleans up
>>> the irqchip drivers and moves them over to drivers/irqchip.
>>>
>>
>> This has been on my todo list for years, but I've never had enough
>> time to figure it out. Nice to see it finally getting done!
>>
>> Series tested on LEGO MINDSTORMS EV3 (da850-like). I can now use
>> IIO triggers without having to patch the kernel to add extra
>> interrupts.
>>
>> Tested-by: David Lechner <david@lechnology.com>
>>
>>
> 
> Wow thanks for taking the time to review it!
> 
> I'll address certain remarks - for those unaddressed - I'll fix them in v2.
> 
> Sekhar: are you fine with sending both the clocksource and interrupt
> series together next time with additional patches on top making
> davinci part of multi_v5_defconfig?

I think its better to keep them separate. You can base both on latest
mainline.

Thanks,
Sekhar
