Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C72C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BD120866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BD120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeIJRC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:02:28 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:56512 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727649AbeIJRC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:02:27 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8AC5JXi007805;
        Mon, 10 Sep 2018 07:08:22 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2mcaukabgt-1;
        Mon, 10 Sep 2018 07:08:22 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 086AF611C8B6;
        Mon, 10 Sep 2018 07:10:36 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 10 Sep 2018
 13:08:21 +0100
Received: from [198.90.251.121] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w8AC8KuE005118;        Mon, 10 Sep 2018 13:08:21 +0100
Subject: Re: [PATCH v10 2/2] irqchip: Add driver for Cirrus Logic Madera
 codecs
To:     Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <patches@opensource.cirrus.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kate Stewart" <kstewart@linuxfoundation.org>
References: <20180828130934.18135-1-rf@opensource.cirrus.com>
 <20180828130934.18135-2-rf@opensource.cirrus.com>
 <alpine.DEB.2.21.1808301154040.1210@nanos.tec.linutronix.de>
 <4aa5941b-547d-7218-1b8f-4cd2a01a4fa5@opensource.cirrus.com>
 <alpine.DEB.2.21.1808301349380.1210@nanos.tec.linutronix.de>
 <20180910113333.GL28860@dell>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <1eb18ed1-3c05-cec2-ec8c-0dfc512b366a@opensource.cirrus.com>
Date:   Mon, 10 Sep 2018 13:08:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180910113333.GL28860@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=599 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809100125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/18 12:33, Lee Jones wrote:
> On Thu, 30 Aug 2018, Thomas Gleixner wrote:
> 
>> On Thu, 30 Aug 2018, Richard Fitzgerald wrote:
>>> On 30/08/18 11:31, Thomas Gleixner wrote:
>>>> On Tue, 28 Aug 2018, Richard Fitzgerald wrote:
>>>>> @@ -0,0 +1,244 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * Interrupt support for Cirrus Logic Madera codecs
>>>>> + *
>>>>> + * Copyright (C) 2015-2018 Cirrus Logic
>>>>> + *
>>>>> + * This program is free software; you can redistribute it and/or modify
>>>>> + * it under the terms of the GNU General Public License as published by
>>>>> the
>>>>> + * Free Software Foundation; version 2.
>>>>
>>>> You have the SPDX identifier above, which makes this boilerplate
>>>> superfluous.
>>>>
>>>
>>> Our legal people want it left here.
>>> They are ok with the SPDX reference, but they want to keep an
>>> explicit statement of the license that was intended.
>>
>> The SPDX identifier is an explicit statement. Sigh...
> 
> Richard, could you please try to re-engage with your legal team and
> explain that the SPDX identifier replaces the licence statement.
> 

I'll ask.
