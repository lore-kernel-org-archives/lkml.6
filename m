Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8834BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392C5208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gkk9sj26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392C5208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933906AbeFLOf7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:35:59 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:49476 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754290AbeFLOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:35:58 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5CEZvPf022911;
        Tue, 12 Jun 2018 09:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528814157;
        bh=wJr7oIZ8zaEvDhZARV+snMDI+XPsHAFVSkci0s7iL1c=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Gkk9sj26onCqy93kTi1SnxLGHoY2rEVF4lLUuNRfF1n17JHDbI/v+/z3Z2lsjAhwL
         Nh02CksjCfsz10kLJ1lMdYNcJRVCftECYOoEEp/gaFaMNQVEmoWHdSMtIt5fRRwRJZ
         /Gk2CoU32FfiOxUSs45dgCTRNYT1qWXPAUVVRNtQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5CEZvFN004977;
        Tue, 12 Jun 2018 09:35:57 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 12
 Jun 2018 09:35:57 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 12 Jun 2018 09:35:56 -0500
Received: from [172.22.219.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5CEZsWt005214;
        Tue, 12 Jun 2018 09:35:55 -0500
Subject: Re: [PATCH 1/2] gpio: davinci: Move fetching IRQ to beginning of
 probe
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>
References: <1528276734-1483-1-git-send-email-j-keerthy@ti.com>
 <CACRpkdbsww1m5GMJ9A8dhn5vXfjaozzb2QaZOkWATdOGg83qMQ@mail.gmail.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <cac77b7b-b22e-a8ab-d43d-efceb25f4be9@ti.com>
Date:   Tue, 12 Jun 2018 20:05:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdbsww1m5GMJ9A8dhn5vXfjaozzb2QaZOkWATdOGg83qMQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/12/2018 6:39 PM, Linus Walleij wrote:
> On Wed, Jun 6, 2018 at 11:18 AM, Keerthy <j-keerthy@ti.com> wrote:
> 
>> Currently IRQ resource fetching is done at the very end of probe.
>> In case the of IRQ resource not being ready, we defer probe
>> and need to revert prior changes. Hence move it to the beginning of
>> the probe so as to avoid reverting.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
> 
> Patch applied for v4.19.

Linus,

There is a minor fix in v3.

https://patchwork.kernel.org/patch/10459591/

Also v3 of Patch 2 Here:

https://lkml.org/lkml/2018/6/12/146

Regards,
Keerthy
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
