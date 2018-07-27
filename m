Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCF5C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E84620842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gi7tM37w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E84620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbeG0GEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 02:04:02 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38188 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeG0GEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 02:04:02 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6R4htnm130886;
        Thu, 26 Jul 2018 23:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532666635;
        bh=EjxdLIfuGZctNJySJUZyuR37j1oXjx/8TXLNYlT7D58=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gi7tM37wMhr58JOvcR/zW9B0ICIPdOe4cKTe61FVxLKR3L99UCKGVP22J1nuZz26B
         stSJ291gHeJMCkUhda8Ncf8Q6+Y8KfKjB0HCG3DEI/2rAlmOuk3aVnFUB22ObG5b9P
         h8EBxqK+LLpYsfHbVeZdHEtWBJFxtv8P/VMiwBiA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6R4hta2004134;
        Thu, 26 Jul 2018 23:43:55 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 26
 Jul 2018 23:43:55 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 26 Jul 2018 23:43:54 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6R4hpw4021612;
        Thu, 26 Jul 2018 23:43:52 -0500
Subject: Re: [PATCH 01/14] thermal: ti-soc-thermal: fix TALERT IRQ handling
 for DRA752
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
 <1526298141-14045-2-git-send-email-b.zolnierkie@samsung.com>
 <fd458da1-75d6-84ed-838a-0495045fad77@ti.com>
 <CGME20180725142707eucas1p25bf4bc7b63babc0732db13ae9a79d983@eucas1p2.samsung.com>
 <2243156.HcYyxvpmOE@amdc3058>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <e9452238-319e-ad4b-5e9a-df3cd0d25ae8@ti.com>
Date:   Fri, 27 Jul 2018 10:13:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <2243156.HcYyxvpmOE@amdc3058>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 25 July 2018 07:57 PM, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday, July 11, 2018 07:49:41 AM J, KEERTHY wrote:
>>
>> On 5/14/2018 5:12 PM, Bartlomiej Zolnierkiewicz wrote:
>>> .report_temperature is not set in dra752_data which
>>> results in temperature updates not being propagated by
>>> ti_bandgap_talert_irq_handler() (it doesn't make much
>>> sense to handle TALERT IRQ without reporting temperature
>>> updates to the thermal core). Fix it.
>>
>> ATM no one is using TALERT as the thermal software polls on the 
>> temperature. No real benefit from TALERT.
>>
>> TALERT is set at different temperature and software polling thresholds 
>> come from Device tree and i believe its best for software to go by 
>> polling and then act on trip points.
> 
> Could you please explain what do you mean by "no one is using
> TALERT"?
> 
> The code in ti_bandgap_probe() sets TALERT thresholds and requests
> IRQ if the TI_BANDGAP_FEATURE_TALERT feature flag is set (and this
> flag is set in omap4460_data, omap4470_data, omap5430_data and
> dra752_data).

The software thresholds and the polling takes care of reducing the
temperature. What i actually meant was we never relied on talert and the
polling takes care of keeping a check on the temperature.

Regards,
Keerthy

> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
