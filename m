Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BF7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D8520660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q57eDDGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D8520660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeK2Ac6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:32:58 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49286 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbeK2Ac5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:32:57 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181128133116euoutp01742277a1bb3444ade270d4fbb0053e3f~rTOyJ2stm2413124131euoutp017
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 13:31:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181128133116euoutp01742277a1bb3444ade270d4fbb0053e3f~rTOyJ2stm2413124131euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543411876;
        bh=Jw/t1l2cJz4qEEPFoIJF3H32Ru2+izjUqV6D1wWwymw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Q57eDDGn7OSipzGy+d6sYxmSsI+ZSTpliZ9ehr9qrAw9cIirv9f0pNsZEYKnjWFjm
         0/SnBM/bDxNnwK8P+F94Pgv2AiKkbR7slJWnff946T1AsBb8fI54XBVwIe+uBXvocG
         JVIu92pp6iWDIPEOKnOJZ0Ba90fcr8iei5OrHIlk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181128133115eucas1p2b2314cd39ad793ec1a358f00a1d1a132~rTOxhXz112304323043eucas1p2D;
        Wed, 28 Nov 2018 13:31:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F2.64.04441.3A89EFB5; Wed, 28
        Nov 2018 13:31:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181128133114eucas1p2b175e7b359d445822527f5adfc6f8e60~rTOwutafr1149111491eucas1p2S;
        Wed, 28 Nov 2018 13:31:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181128133114eusmtrp25af4ecae1933c315088d1d6e6552a7af~rTOwf2Z9O1374113741eusmtrp2U;
        Wed, 28 Nov 2018 13:31:14 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-10-5bfe98a30948
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2D.3E.04284.2A89EFB5; Wed, 28
        Nov 2018 13:31:14 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181128133113eusmtip14809befec8f66d04b330a29b2929fe1d~rTOwCFVVM1893918939eusmtip1P;
        Wed, 28 Nov 2018 13:31:13 +0000 (GMT)
Subject: Re: [PATCH 4/4] clk: samsung: exynos5433: add imem clock
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-ID: <29a0412e-1209-b633-8a10-f6db8eb8af09@partner.samsung.com>
Date:   Wed, 28 Nov 2018 14:31:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5BF5520A.5050500@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djP87qLZ/yLNrjTxm1x/ctzVov5R86x
        WvQ/fs1scf78BnaLTY+vsVpc3jWHzWLG+X1MFkuvX2SyaN17hN2B02PNvDWMHptWdbJ5bF5S
        79G3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZP1v72AoeiFe8nzmHqYFxs3AXIyeHhICJRMOG
        eexdjFwcQgIrGCWevH0A5XxhlNj7dSUzSJWQwGdGiVsbMmA6Dk9uZ4QoWs4ocXzCZSjnLaPE
        mZWPmECqhAUcJead/MUGYosIaEjM/HsFrIhZYAaTxJpjX8ESbALmEo+2nwFr4BVwk9g/fTY7
        iM0ioCpx99okVhBbVCBCouP+ajaIGkGJkzOfsIDYnALaEgsXrWEEsZkFxCVuPZnPBGHLSzRv
        nc0MskxC4Bi7xOGdt5kg7naROPP2MyOELSzx6vgWdghbRuL/zvlQNeUSu7c+Y4dobmGUmDt5
        EVTCWuLw8YtAF3EAbdCUWL9LH8SUAPry36wKCJNP4sZbQYgT+CQmbZvODBHmlehoE4KYoSsx
        7/8ZVghbWqLr/zrWCYxKs5A8NgvJM7OQPDMLYe0CRpZVjOKppcW56anFhnmp5XrFibnFpXnp
        esn5uZsYgUnp9L/jn3Ywfr2UdIhRgINRiYc3IPVvtBBrYllxZe4hRgkOZiUR3lK7f9FCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGOcoLMl9ufjjJ8fm
        yeqJS3dsXX4l5utGtlkud1bq5iytdU+7xib2N7He72rM4o49UWmnH2hcPNVT4DA3NKnu3kme
        HwY/XGzFF39W58lPunNF/OXuPa9LLv0+9MKt2v94ys73LYc2603s3Beqvv7o6rW9HxZzpi2R
        bJowzV78vZPNxgffT4vou01SYinOSDTUYi4qTgQAc6xvlkYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xu7qLZvyLNti2n9fi+pfnrBbzj5xj
        teh//JrZ4vz5DewWmx5fY7W4vGsOm8WM8/uYLJZev8hk0br3CLsDp8eaeWsYPTat6mTz2Lyk
        3qNvyypGj8+b5AJYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJz
        MstSi/TtEvQyfrb2sRU8EK94P3MOUwPjZuEuRk4OCQETicOT2xm7GLk4hASWMkpMPfCUESIh
        LdF4ejUThC0s8edaFxtE0WtGiabL7cwgCWEBR4l5J3+xgdgiAhoSM/9eAZvELDCDSaL1/DJm
        iI4vjBJXZx4G62ATMJd4tP0M2FheATeJ/dNns4PYLAKqEnevTWIFsUUFIiTOvlzHCFEjKHFy
        5hMWEJtTQFti4aI1YHFmAXWJP/MuMUPY4hK3nsxngrDlJZq3zmaewCg0C0n7LCQts5C0zELS
        soCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgLG479nPzDsZLG4MPMQpwMCrx8Aak/o0W
        Yk0sK67MPcQowcGsJMJbavcvWog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgWkiryTe0NTQ
        3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QDo+LMTX7W2s+/7HnH5/lSNT7i
        gO+TU3e5j5evZs86xLx/59n8Qxdz+48K63b0r+a58O7O5q+uW2unX21aK5u3JaX9xD1ztV8Z
        9nMnxMsVLNbs3LRb/PnyvM9vWI/ycDXFlM/Z90X/6fTeP/qGibrnPu1mOne46mTrB3fN65Om
        mt7f9+hzQPKLa5pKLMUZiYZazEXFiQCf3TiC2wIAAA==
X-CMS-MailID: 20181128133114eucas1p2b175e7b359d445822527f5adfc6f8e60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121120524eucas1p166a26857df78947c9e08f0fb8dbf75e4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121120524eucas1p166a26857df78947c9e08f0fb8dbf75e4
References: <20181121120509.18892-1-k.konieczny@partner.samsung.com>
        <CGME20181121120524eucas1p166a26857df78947c9e08f0fb8dbf75e4@eucas1p1.samsung.com>
        <20181121120509.18892-5-k.konieczny@partner.samsung.com>
        <5BF5520A.5050500@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your review, see below for answers and questions.

On 21.11.2018 13:39, Chanwoo Choi wrote:
> Hi,
> 
> On 2018년 11월 21일 21:05, Kamil Konieczny wrote:
>> Add imem clock for exynos5433.
> 
> It is diffcult to understand the meaning of 'imem' without the description.
> Please add more detailed description as the patch2 description.
> 

Will this be enough for description:

Add imem clock for exynos5433. This will enable to use crypto Security
SubSystem (in short SSS) and SlimSSS IP blocks.

What do you think ?

>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos5433.c   | 123 +++++++++++++++++++++++++
>>  include/dt-bindings/clock/exynos5433.h |  55 +++++++++++
>>  2 files changed, 178 insertions(+)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
>> index 24c3360db65b..db29cbd1fbdc 100644
>> --- a/drivers/clk/samsung/clk-exynos5433.c
>> +++ b/drivers/clk/samsung/clk-exynos5433.c
>> @@ -2345,6 +2345,129 @@ static const struct samsung_cmu_info fsys_cmu_info __initconst = {
>>  	.clk_name		= "aclk_fsys_200",
>>  };
>>  
>> +/*
>> + * Register offset definitions for CMU_IMEM
>> + *
>> + */
>> +
> 
> Remove unneeded blank line.

ok

> 
>> +#define ENABLE_ACLK_IMEM			0x0800
>> +#define ENABLE_ACLK_IMEM_SSS			0x0808
>> +#define ENABLE_ACLK_IMEM_SLIMSSS		0x080c
>> +#define ENABLE_PCLK_IMEM			0x0900
>> +#define ENABLE_PCLK_IMEM_SSS			0x0904
>> +#define ENABLE_PCLK_IMEM_SLIMSSS		0x0908
> 
> When I checked the registers of IMEM block, there are more registers as following:
> Why do you implement the clocks for only six registers?

I added only those that will be used by crypto block (aes and hash block).
I can add all of them in version 2.

> CLK_ENABLE_ACLK_IMEM			0x0800
> 
> CLK_ENABLE_ACLK_IMEM_SECURE_INT_MEM	0x0804
> 
> CLK_ENABLE_ACLK_IMEM_SECURE_SSS		0x0808
> 
> CLK_ENABLE_ACLK_IMEM_SECURE_SLIMSSS	0x080C
> 
> CLK_ENABLE_ACLK_IMEM_SECURE_RTIC	0x0810
> 
> CLK_ENABLE_ACLK_IMEM_SECURE_SMMU_SSS	0x0814
> [...]
> 
>> +
>> +static const unsigned long imem_clk_regs[] __initconst = {
>> +ENABLE_ACLK_IMEM,
>> +ENABLE_ACLK_IMEM_SSS,
>> +ENABLE_ACLK_IMEM_SLIMSSS,
>> +ENABLE_PCLK_IMEM,
>> +ENABLE_PCLK_IMEM_SSS,
>> +ENABLE_PCLK_IMEM_SLIMSSS,
> 
> Add a tab in front of registers.
> 

ok

>> [...]
>> +static void __init exynos5433_cmu_imem_init(struct device_node *np)
>> +{
>> +	samsung_cmu_register_one(np, &imem_cmu_info);
>> +}
>> +
>> +CLK_OF_DECLARE(exynos5433_cmu_imem, "samsung,exynos5433-cmu-imem",
>> +		exynos5433_cmu_imem_init);
> 
> Except for "samsmung,exynos5433-cmu-atlas/apollo", the remained clock blocks
> were added to exynos5433_cmu_of_match[] table for power management.
> 
> If there is no any h/w issue, add the new entry to exynos5433_cmu_of_match for imem block.

ok, I will add this.

>> [...]

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

