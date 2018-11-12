Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD50C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BA6216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BA6216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeKLSUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:20:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36916 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbeKLSUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:20:43 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAC8SMrU096674;
        Mon, 12 Nov 2018 02:28:22 -0600
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAC8SMUH003160
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Nov 2018 02:28:22 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 12
 Nov 2018 02:28:22 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 12 Nov 2018 02:28:22 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAC8SKSx017328;
        Mon, 12 Nov 2018 02:28:21 -0600
Subject: Re: [PATCH 2/2] phy: ocelot-serdes: fix out-of-bounds read
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>
References: <cover.1539036280.git.gustavo@embeddedor.com>
 <30c1dcb4a8d3707238fcf0a996b9e0bf0a4a7bbc.1539036280.git.gustavo@embeddedor.com>
 <20181009072808.5eynmktmkgjpi2ho@qschulz>
 <f60ee2ae-6b19-4a61-6d9c-38acdebd7fbe@embeddedor.com>
 <93008479-9e81-1d27-bd31-0cff75c4dd12@ti.com>
 <d4347a46-ff54-3b02-97b7-58ad7017c2c0@embeddedor.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ba631550-bd62-862c-3322-a4fa574ba2e2@ti.com>
Date:   Mon, 12 Nov 2018 13:57:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d4347a46-ff54-3b02-97b7-58ad7017c2c0@embeddedor.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/10/18 9:07 PM, Gustavo A. R. Silva wrote:
> Hi Kishon,
> 
> On 10/16/18 10:48 AM, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Tuesday 16 October 2018 02:16 PM, Gustavo A. R. Silva wrote:
>>> Hi,
>>>
>>> On 10/9/18 9:28 AM, Quentin Schulz wrote:
>>>> Hi Gustavo,
>>>>
>>>> On Tue, Oct 09, 2018 at 12:22:33AM +0200, Gustavo A. R. Silva wrote:
>>>>> Currently, there is an out-of-bounds read on array ctrl->phys,
>>>>> once variable i reaches the maximum array size of SERDES_MAX
>>>>> in the for loop.
>>>>>
>>>>> Fix this by changing the condition in the for loop from
>>>>> i <= SERDES_MAX to i < SERDES_MAX.
>>>>>
>>>>
>>>> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
>>>>
>>>
>>> Friendly ping. Who can you take this?
>>
>> This can go during the 4.20 -rc cycle.
>>
> 
> Should I resend the following patch to you, so the whole series is
> applied to your phy tree?
> 
> https://lore.kernel.org/patchwork/patch/997326/

This is merged by David Miller.

Thanks
Kishon
