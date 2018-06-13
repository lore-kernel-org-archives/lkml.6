Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D1A8DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C45620891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ps74ky8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C45620891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933788AbeFMDsk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 23:48:40 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:62695 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933408AbeFMDsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 23:48:38 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5D3mcgj012585;
        Tue, 12 Jun 2018 22:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528861718;
        bh=8i5IJcbPoUsolR0CGUjFAGcRj5U2XoXiQfvLQD+YTRA=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=ps74ky8XPFwOJwTLAPYqHQ6pG9EBsUQmmF4psdLMUS43l06uUBqHs4BAfG4wvJVv6
         mPHIitg1rZgoHZXCLt4fvAfWwQdEkPnBNSIm4h9l7rDxYG1m6L5BrNawEIXAUjSMfx
         bgEyMNccbN6tBLzalVO2sNfoA6fIbEwZXcdckpsg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5D3mcwW019171;
        Tue, 12 Jun 2018 22:48:38 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 12
 Jun 2018 22:48:37 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 12 Jun 2018 22:48:37 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5D3mZu7013985;
        Tue, 12 Jun 2018 22:48:36 -0500
Subject: Re: [PATCH 1/2] gpio: davinci: Move fetching IRQ to beginning of
 probe
From:   Keerthy <j-keerthy@ti.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>
References: <1528276734-1483-1-git-send-email-j-keerthy@ti.com>
 <CACRpkdbsww1m5GMJ9A8dhn5vXfjaozzb2QaZOkWATdOGg83qMQ@mail.gmail.com>
 <cac77b7b-b22e-a8ab-d43d-efceb25f4be9@ti.com>
Message-ID: <d9955907-9c14-3c74-48c7-0370b084be60@ti.com>
Date:   Wed, 13 Jun 2018 09:18:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <cac77b7b-b22e-a8ab-d43d-efceb25f4be9@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 12 June 2018 08:05 PM, J, KEERTHY wrote:
> 
> 
> On 6/12/2018 6:39 PM, Linus Walleij wrote:
>> On Wed, Jun 6, 2018 at 11:18 AM, Keerthy <j-keerthy@ti.com> wrote:
>>
>>> Currently IRQ resource fetching is done at the very end of probe.
>>> In case the of IRQ resource not being ready, we defer probe
>>> and need to revert prior changes. Hence move it to the beginning of
>>> the probe so as to avoid reverting.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>
>> Patch applied for v4.19.
> 
> Linus,
> 
> There is a minor fix in v3.
> 
> https://patchwork.kernel.org/patch/10459591/
> 
> Also v3 of Patch 2 Here:
> 
> https://lkml.org/lkml/2018/6/12/146


Posted a v4:

Patch 1: https://patchwork.ozlabs.org/patch/928638/
Patch 2: https://patchwork.ozlabs.org/patch/928639/


> 
> Regards,
> Keerthy
>>
>> Yours,
>> Linus Walleij
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
