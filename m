Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FE0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371A1214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371A1214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbeKLNGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:06:55 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53070 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730056AbeKLNGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:06:54 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAC3FjLh102248;
        Sun, 11 Nov 2018 21:15:45 -0600
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAC3FjPw119438
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 21:15:45 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sun, 11
 Nov 2018 21:15:44 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sun, 11 Nov 2018 21:15:44 -0600
Received: from [172.22.218.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAC3FeTm030765;
        Sun, 11 Nov 2018 21:15:41 -0600
Subject: Re: [PATCH 1/2] opp: ti-opp-supply: Dynamically update u_volt_min
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <d-gerlach@ti.com>, <t-kristo@ti.com>
References: <1541565263-8296-1-git-send-email-j-keerthy@ti.com>
 <1541565263-8296-2-git-send-email-j-keerthy@ti.com>
 <20181108055401.btrixinlqcfh22du@vireshk-i7>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <e383feb1-ba04-7f56-0cd8-257660a95bd3@ti.com>
Date:   Mon, 12 Nov 2018 08:45:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181108055401.btrixinlqcfh22du@vireshk-i7>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/2018 11:24 AM, Viresh Kumar wrote:
> On 07-11-18, 10:04, Keerthy wrote:
>> The voltage range (min, max) provided in the device tree is from
>> the data manual and is pretty big, catering to a wide range of devices.
>> On a i2c read/write failure the regulator_set_voltage_triplet function
>> falls back to set voltage between min and max. The min value from Device
>> Tree can be lesser than the optimal value and in that case that can lead
>> to a hang or crash. Hence set the u_volt_min dynamically to the optimal
>> voltage value.
> 
> And why shouldn't we fix the DT for this ?

The DT voltages do not cater to the broad range of devices. In some 
particular cases the DT min voltage is slightly lower the voltage at 
which the device cannot sustain a particular frequency in which case the 
device just silently hangs. So best thing to do is to actually read the 
device specific voltages dynamically which will guarantee a particular 
device sustaining a particular frequency at the optimal voltage.

> 
