Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A40C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8848E20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GOOoGz4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8848E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeJPQim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:38:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53960 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeJPQim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:38:42 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9G8n5nt119262;
        Tue, 16 Oct 2018 03:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539679745;
        bh=Ce3E/4zqvUsh8GuCm4chNn1zZc1v7Uthae5OVfJialk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GOOoGz4EpuGybDOvfslKNkl7n7linkHFgJGH8qzhFjVA0IkHwyoHGE/fSEyJ2FMiH
         6lyMxkmGTZQvD8zzR1GD1p9WwSlaXVAskkCd7rVzdy7jhuMMSapCfJXDbJaVwhCLr6
         fu47G4EcbpWE7x8iStB7R8ouBumAM+AD8IWzsB/k=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9G8n5tc007526;
        Tue, 16 Oct 2018 03:49:05 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 16
 Oct 2018 03:49:05 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 16 Oct 2018 03:49:05 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9G8n3Gv000530;
        Tue, 16 Oct 2018 03:49:04 -0500
Subject: Re: [PATCH 2/2] phy: ocelot-serdes: fix out-of-bounds read
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>
References: <cover.1539036280.git.gustavo@embeddedor.com>
 <30c1dcb4a8d3707238fcf0a996b9e0bf0a4a7bbc.1539036280.git.gustavo@embeddedor.com>
 <20181009072808.5eynmktmkgjpi2ho@qschulz>
 <f60ee2ae-6b19-4a61-6d9c-38acdebd7fbe@embeddedor.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <93008479-9e81-1d27-bd31-0cff75c4dd12@ti.com>
Date:   Tue, 16 Oct 2018 14:18:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f60ee2ae-6b19-4a61-6d9c-38acdebd7fbe@embeddedor.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 16 October 2018 02:16 PM, Gustavo A. R. Silva wrote:
> Hi,
> 
> On 10/9/18 9:28 AM, Quentin Schulz wrote:
>> Hi Gustavo,
>>
>> On Tue, Oct 09, 2018 at 12:22:33AM +0200, Gustavo A. R. Silva wrote:
>>> Currently, there is an out-of-bounds read on array ctrl->phys,
>>> once variable i reaches the maximum array size of SERDES_MAX
>>> in the for loop.
>>>
>>> Fix this by changing the condition in the for loop from
>>> i <= SERDES_MAX to i < SERDES_MAX.
>>>
>>
>> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
>>
> 
> Friendly ping. Who can you take this?

This can go during the 4.20 -rc cycle.

Thanks
Kishon
