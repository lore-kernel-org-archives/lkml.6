Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862FEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54322217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R6qYykyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbeLQGB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 01:01:57 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47556 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeLQGB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 01:01:56 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBH61tAV093951;
        Mon, 17 Dec 2018 00:01:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545026515;
        bh=AqLnCKPttMMoVBVoWmkxLk6XSMtMBNQrUYiUrZ36+ys=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=R6qYykyDDj/REs7GlcL3eIimzjturCvnphdC8NJ+QB3YEDc0muGD8n9hTO0LOppk5
         JjyiX7RAPUmq+3R+nbHSEQ3jiugP46xoR6U4QCFUNOYBIPg0Ljv7LEQbOwHHFLqT6y
         28NHiXLOIbyWexP/N8VlG38nPy6mrpeDQPR6YgTo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBH61tdS094274
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 00:01:55 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 17
 Dec 2018 00:01:55 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 17 Dec 2018 00:01:55 -0600
Received: from [172.22.216.133] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBH61pjP020195;
        Mon, 17 Dec 2018 00:01:53 -0600
Subject: Re: [PATCH] tps65218.c: fix IRQ resource leak in tps65218_probe()
To:     Lee Jones <lee.jones@linaro.org>,
        Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <1544090279-26762-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <20181214122559.GV4497@dell> <20181214122619.GW4497@dell>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <f584aab6-374c-5a53-51c5-61098f8bb792@ti.com>
Date:   Mon, 17 Dec 2018 11:31:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181214122619.GW4497@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/2018 5:56 PM, Lee Jones wrote:
> On Fri, 14 Dec 2018, Lee Jones wrote:
> 
>> On Thu, 06 Dec 2018, Christian Hohnstaedt wrote:
>>
>>> Free allocated IRQ if reading the device ID fails.
>>
>> The patch is fine.  However, in future please submit patches using the
>> format set (by precedent) by the subsystem.  I will fix the subject
>> for you this time.
>>
>> To check the format, you can do:
>>
>>    `git log --oneline -- <subsystem>`
> 
> Patch applied, by the way.

This would no longer be needed as the bigger clean up is here:

https://lkml.org/lkml/2018/12/9/86

As both are applied it results in a compilation issue.

Lee Jones,

Do you want me to submit a fix patch? Or you can revert this patch?
Anything fine by me.

Let me know.

Thanks,
Keerthy
> 
