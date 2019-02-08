Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB282C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B806F2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a3XOjLvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfBHMh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:37:59 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57090 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfBHMh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:37:58 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x18CbeXh083437;
        Fri, 8 Feb 2019 06:37:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549629460;
        bh=J5H1/KGfmAvzG6oKJoJn4IseVaJm3ElBp7a+t8K9gsE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=a3XOjLvUjHcNWSxpXvzmhVOupotH+rhFYbK6Z9klTrooPXtgJWDSq7HZZP/tiMp/0
         XhNJ2CW1oFQ1iG6N68wJu3/vCrGZxl/bAgPGfBHfiymQ711npsmLmqT0mV12VEKcSZ
         U364Nh2HSJd0LrMGqbJnLdZyKLHAgTWfnZK97Fwg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x18CbeKR055428
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 06:37:40 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 06:37:39 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 06:37:39 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x18Cbaf0004092;
        Fri, 8 Feb 2019 06:37:36 -0600
Subject: Re: [PATCH v2 05/12] ARM: davinci: da850: switch to using the
 clocksource driver
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-6-brgl@bgdev.pl>
 <9d423e18-8c85-731b-388a-1843067db242@ti.com>
 <CAMpxmJW0qMi0BmiK2SOwdagw2-t8+1g20XJR418mWb8f1dwxtQ@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <acd3f8ca-8ed7-f86a-9bdf-24e4e6e9a6a4@ti.com>
Date:   Fri, 8 Feb 2019 18:07:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMpxmJW0qMi0BmiK2SOwdagw2-t8+1g20XJR418mWb8f1dwxtQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/19 6:04 PM, Bartosz Golaszewski wrote:
> pt., 8 lut 2019 o 13:06 Sekhar Nori <nsekhar@ti.com> napisał(a):
>>
>> On 04/02/19 10:47 PM, Bartosz Golaszewski wrote:
>>> +static const struct davinci_timer_cfg da850_timer_cfg = {
>>> +     .reg = {
>>> +             .start          = DA8XX_TIMER64P0_BASE,
>>> +             .end            = DA8XX_TIMER64P0_BASE + SZ_4K,
>>
>> SZ_4K - 1
>>
>> This should have prevented watchdog timer from getting registered.
>>
>> Thanks,
>> Sekhar
> 
> My clocksource driver doesn't call request_region() so a subsequent
> devm_ioremap_resource() in the watchdog driver would still succeed. I
> now fixed both the missing call and the value here.

Ah, got it. Perhaps a call to request_region() should be added to catch
issues?

Thanks,
Sekhar
