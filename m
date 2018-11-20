Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EDEC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410962146D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NolKvM+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410962146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeKUJjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 04:39:05 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50856 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUJjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 04:39:05 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAKN73f3043795;
        Tue, 20 Nov 2018 17:07:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542755223;
        bh=ckDKzDv74ZNO4z7WmGEsXZV25XcaquiTbZAt2DmHPlU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NolKvM+z5B1HO1i99Pp3v3aL96klO6K6DJ9xd1/DTzo7Cec4VNVqeReAd8K2XXXLV
         WHZri3TBgRMvgzV5p4VPsBTWFkSvTnhN1/5Gz75OvuOG1dBM9Y8CTUUD+MXPwsdBjZ
         RLFLsrpdNd9u8dkq6qq1w9VpW+nd6hQxRlGGNgS8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAKN72K7130922
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Nov 2018 17:07:03 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 20
 Nov 2018 17:07:02 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 20 Nov 2018 17:07:02 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAKN6w7Q021270;
        Tue, 20 Nov 2018 17:06:59 -0600
Subject: Re: [PATCH 1/3] ARM: davinci: define gpio interrupts as separate
 resources
To:     "J, KEERTHY" <j-keerthy@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <stable@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
References: <20181113135051.15308-1-brgl@bgdev.pl>
 <20181113135051.15308-2-brgl@bgdev.pl>
 <c092b014-d5cf-f1ad-de91-6696b05cdf17@ti.com>
 <63ac671f-b202-2533-3878-af16149fbdbb@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <b30f6b76-52c1-89ca-dbf3-a4156d1fb55e@ti.com>
Date:   Wed, 21 Nov 2018 04:36:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <63ac671f-b202-2533-3878-af16149fbdbb@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/18 12:08 PM, J, KEERTHY wrote:
> 
> 
> On 11/20/2018 2:22 AM, Sekhar Nori wrote:
>> On 13/11/18 7:20 PM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> Since commit eb3744a2dd01 ("gpio: davinci: Do not assume continuous
>>> IRQ numbering") the davinci GPIO driver fails to probe if we boot
>>> in legacy mode from any of the board files. Since the driver now
>>> expects every interrupt to be defined as a separate resource, split
>>> the definition in devices-da8xx.c instead of having a single continuous
>>> interrupt range.
>>>
>>> Fixes: eb3744a2dd01 ("gpio: davinci: Do not assume continuous IRQ
>>> numbering")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> There are a number of other boards that need such fixing too. And the
>> commit in question does not do a good job of explaining why it was
>> needed in the first place. The description  just repeats what can be
>> inferred by reading the patch.
> 
> Cc Lokesh
> 
> Sekhar,
> 
> DT explicitly mentions every IRQ number. The patch in discussion
> explicitly calls platform_get_irq for all the interrupts which to me is
> the right thing to do as: platform_get_irq-->
> of_irq_get-->irq_create_of_mapping--> sequence is to be done for every IRQ.
> 
> k3-am654 definitely will need explicit calls to platform_get_irq as it
> will be involving interrupt router and interrupt numbers need not be
> continuous.
> 
> So i do not think reverting the patch is the right idea.

Well, all of this description of patch motivation should have been in
the patch description to begin with.

Bartosz, can you please extend this patch to fix this problem for other
DaVinci SoCs too? I am on the road this week, but will do my best to
queue these fixes at the earliest .

Thanks,
Sekhar
