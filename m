Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484FD2184A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="W4mr8YSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfBRJeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:34:44 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16268 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfBRJen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:34:43 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6a7c360001>; Mon, 18 Feb 2019 01:34:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 01:34:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Feb 2019 01:34:42 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 18 Feb
 2019 09:34:40 +0000
Subject: Re: [PATCH V1] i2c: tegra: fix tegra186 hw supported features
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
CC:     <talho@nvidia.com>, <wsa@the-dreams.de>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>
References: <1550334787-27703-1-git-send-email-skomatineni@nvidia.com>
 <20190218084227.GB19363@ulmo>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <42aa92c1-309e-88c1-1cd6-07592990730b@nvidia.com>
Date:   Mon, 18 Feb 2019 09:34:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218084227.GB19363@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550482487; bh=UNsoWaQVzEXqEU8IZzoQBAcMWGBcFG1IMPaAZtMeMFk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=W4mr8YSCi5HlknbOXC0tpnyMXXkmCnKEQxHpN/e1F2qmI8/Nyo9XRr9Jyt4EDqr/m
         w/qypFrzmGekN0ggFIRdNScnHIQfJOtlYEMa7yPottwUSsUY8f6ShV/EbMYnqAmXui
         LzjhcnEKhestDq1wK0cf8PbK6/uw4kaPvJICLjeeg7BiL80Ss/HEadO1Vw5sjqZGv5
         vIAcaGAAzhqA2rryiX0ssXWGG1wRXOxIHa/wau4PtCvtlEC2TErk+3ngwQfttXk4Jj
         NGwbGob5rL9jmrxdLYfQVRYBk2JTzfnJmT1rxw5FnCNsAc3VmFnD54D82vu2KmNBHU
         27zYo26h+hXGg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/02/2019 08:42, Thierry Reding wrote:
> On Sat, Feb 16, 2019 at 08:33:07AM -0800, Sowjanya Komatineni wrote:
>> Tegra186 does not support multi-master mode and also there is no
>> master fifo control register.
>>
>> This patch fixes supported features of Tegra186 and prevents
>> crashing during boot as master fifo control register are not
>> present on Tegra186 and prior.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>  drivers/i2c/busses/i2c-tegra.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> We really should've caught this earlier. Jon, let's think about ways to
> make it easier to catch these things in the future on our test system.

Indeed. This has fixed the boot regression I was seeing over the weekend
on -next for Tegra186. However, I am bit confused here, because when I
look at the Tegra186 TRM it states that the I2C supports multi-master
mode which disagrees with this patch. Furthermore, it seems odd that
Tegra210 and Tegra194 would support multi-master mode but Tegra186 does
not. So is this really correct?

Cheers
Jon

-- 
nvpublic
