Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF51AC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7194321764
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="p8CVlYji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7194321764
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbeHCPAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:00:47 -0400
Received: from mail-bn3nam01on0086.outbound.protection.outlook.com ([104.47.33.86]:21328
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729367AbeHCPAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqKb4p/fAe8qGbWkwacH3pPg3o+2GcynS+zElp1wu5Q=;
 b=p8CVlYjiAOGijMEwxOZpOIy63j5kBnfhMVBWoOgy8qWW9yidjIqrpSXoupXKoizEDl+E8hY+lLUbOl+fem9IWlDWwPC9wG3BUIepKHHWnkUdNJ79/wRn66/nxuLWIGsoZ4V+vZ7V2q0+Ab6dOJoJrKQxki73kZN6SQjNpletbXo=
Received: from BYAPR03CA0032.namprd03.prod.outlook.com (2603:10b6:a02:a8::45)
 by MWHPR03MB3134.namprd03.prod.outlook.com (2603:10b6:301:3c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 3 Aug
 2018 13:04:27 +0000
Received: from BY2FFO11FD012.protection.gbl (2a01:111:f400:7c0c::161) by
 BYAPR03CA0032.outlook.office365.com (2603:10b6:a02:a8::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Fri, 3 Aug 2018 13:04:27 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BY2FFO11FD012.mail.protection.outlook.com (10.1.14.130) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1017.15
 via Frontend Transport; Fri, 3 Aug 2018 13:04:26 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w73D4P1S012378
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 3 Aug 2018 06:04:25 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 3 Aug 2018
 09:04:25 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/6] iio:adxl372: Add sampling frequency support
Date:   Fri, 3 Aug 2018 16:02:20 +0300
Message-ID: <1533301341-26560-6-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
References: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(346002)(39860400002)(396003)(136003)(376002)(2980300002)(438002)(199004)(189003)(246002)(110136005)(50466002)(126002)(476003)(356003)(54906003)(44832011)(14444005)(77096007)(26005)(106466001)(106002)(4326008)(5660300001)(486006)(7416002)(53416004)(6666003)(47776003)(305945005)(336012)(36756003)(508600001)(426003)(7636002)(16586007)(316002)(76176011)(2616005)(48376002)(7696005)(51416003)(8936002)(11346002)(446003)(8676002)(50226002)(72206003)(2906002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3134;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD012;1:EyKK6haP5a5cEF6RjWYKBJ8y9p6UAZKcP4xvHswx2viv0RQCnKQMniyq89wqKfpT0KjVxBXDVau26t/GbiGi9GTty3c+T4KKAWHdwmVx3kMLaGC6pLKWVX06joCNiHzK
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9233ad0-a821-416b-2f13-08d5f941a472
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR03MB3134;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3134;3:SqO+IfneOTNDHvuYLmTdKjcSVhGQD/y/R0vwEtkOx8caS8iETx3IYq925nikg4AHl+Ov9Dk2/wX49JlFazw932ol16bxEHGDhpciEVkN1qJSijJBQtBBBdA43DsBNdbtJk6/odqRETEQA/zSZ15aIimfw1mpzMSKFjk3Uk6hA1UYH7USyQUhgr1+wrcvhHcGZTjOVKB6Rw9Ii8y5NQaEwubnZuXXYWKAvm7cRcUivJMMPNnyKzLtkpVkBH7GyW97xWlwlafV6ncBT6XRod9bWF2xutiQTqiVRv2Hlgvho9yV7da0GaMjuy12s25SkXzft32PskPRqntsJ6VUjjyE1t+ODP3tEBkoXJw4LjVMozU=;25:auDHaB535V3AQnPdrFYd9Mz20/y4fZxaFwXJo7nnLD447F3bY8ROcHkNp5iAguVKqyNZDGV028BUS3XwE7J8YxpFoDOoIQ8YuKperdGQZRXt53j3s40B1HiivwZxKnxdG4nwg7Ky/w+uOOZfXnHgDXE4RqAOjLxiotZh4VqKNV4oHzvlhwjgIca/ocIRnSadDXUeoDyVHuFzDy7iTyuobab4teZ0VzC9pZvhlRz0yTqDR38KreRjSkGif8GSwLwgm8tIY+DibOqM8bBwHmRO8SJ/Yw0lesiNPI5+k517rU3Isn8o0+hnNFray7238iOeZcfzT7TAjDoYYsp+bdqtLw==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3134:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3134;31:pUMa0WgYLVPYPQWeQW768twA/l0TKBJntRJcECa8K8f3/A5Vl+MoagxbMryg4Ao0GEz5MLtNFEqzg1ZpBH9WAe0nbeEvJBWLExyS+FnB/RSI3A1lfyPGaRYWQ+q+Sg0n5rEI22NNBT/LkWQArbQGvJbPCbup7eJW0M+k/KAqt2kzHryrD/Yf7RcJUP8PUqqPIPRaMkvcZqx3W2ahy49K6W1GO2NfUPsEwtWZ6O88iRM=;20:+XARh4VxyKMiUpZh7JGvLtAgc87F31nIc5N/kxDI62DWBaMvAFkLEhOqVJOjAFdyfEnRq7c4hhlQYGzVycN54XwI5GcrR2OcdpfTr5v5O9adTul+6uoj0Gr+H+64WbMhuX1y4kDZNnn1O9gVfFoUmdNldcOOwoGRmke8sv48zdgvk7gsFVqj417A/eWpXr3egZ1i5uKFgW07zkgrBMsA57uPsaRX9PVfAnbvqRlCamTwAa+e+3JbSvExr7lP9PvmYygONrVU7ALUUoKm4KUQTMQgugCMVuWElyV4uoZ0HVChvoBPb6ooIKZbOMjNVoYw4f88N2m0Gf1izboLGrTyJnE8lDOpLw/5dcLHdQP3Za6+uinhlnzvBf6z8DlGGRi/aPepBRyn3d3WDny6rzLaWFmQ599XR2GNFFUfJFErmBNP1FOgigIWhBF/oATSU+uTn4NAH6QIhnsAlTNDZU3gve1twf72RAMT4OQw7/IgUw4IG34aTkm/O4NJcds15PYI
X-Microsoft-Antispam-PRVS: <MWHPR03MB31342CB40AA8CDCD74B8C8639D230@MWHPR03MB3134.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201703011903075)(201702281528075)(20161123555045)(201703061421075)(6072148)(201708071742011)(7699016);SRVR:MWHPR03MB3134;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB3134;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3134;4:E3n0q5pyo1ZeeMKUU5+U4dgv02itxBA+63YyYn0MVsGX2bmo5VfciLf/6Qz5Ta0AgJU2FBRBmC7BnYMIEFDRg/1phB1x9EjAk5YRWp9zgt/sCwlLqVeXlC78dQOzFGoGAdTeuSmddB0/yPwSFsrkDtUo2gDygo8Fzq2Bu6ZGTySbm3eiqv70deidJiGQjrZ7za5uhUrpZMjbmjqTQO3hzSgdREskIjjlLANhKcfiFuH1dHmFgGnyfwI3yS8/APMeRGCkKD2oJL2LQ7fQfU2roImTgtWS/OOB5Lyoqfp0ebjMDQfJPHVvputh+8vZXrnQ
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3134;23:7BxOlnzRiANE84UBtBxYomBBTGJUR8bx2k6zvkiPH?=
 =?us-ascii?Q?CmlOyx9kpOl4D3G1eGtRji/UEzmE/kj1/5h6xQCSt0VdNJCnJOt7qUiU4LzE?=
 =?us-ascii?Q?cVan9sgzmPhF+ZzIg5JGx2qs+XNp7ZBOck96GJbU1EeSG/4zrOqpcReLV8bB?=
 =?us-ascii?Q?a8BK6vVOBmhjwk7fhHsdJQi1PPDzDGnl7wuQYhyvqqoA38mL7+mewelyCFR+?=
 =?us-ascii?Q?saGGCmLhLFYJGRjAeZ3caK4nAidwTpbCUhq9GSEzbTaBkcvrXds4CnPJoPT0?=
 =?us-ascii?Q?mltZKqxsfe3GlGXGMcddMgy7wCTDKhtvdqS6YJaKX/HlCKXO/Q/TZu8SrY29?=
 =?us-ascii?Q?eo46SWiRInBuTQ6/w1Ow6+ZYayjYm1EilFX8bNN/34DPAdXIqSSd+l8Jhtuq?=
 =?us-ascii?Q?mk0weA0n06eOLj1WrCgUs6/iqcHxXqyvzYI4M7nrbLuxesaYCTBgyrPxuxM5?=
 =?us-ascii?Q?m+N64aQ2l63UrFnRjTLWgN8pR/oxXDDLmAFTNJ/XAAjAYwR+Xl2eri3lBKAw?=
 =?us-ascii?Q?qxV5JVf6Sou+06bNbk4vCGh7cOFQvtqUs14VE061NFt4KmhL+8OxBPC0fy2S?=
 =?us-ascii?Q?MA2J0H69kkmLULRSx0lToTofh3LsIC/BtIUmkCMFIp2BCXCre5NS+mT4eMN9?=
 =?us-ascii?Q?lzVzEVk/m9mvOm6LqHMZdeG6gqvtMYAViIYrGrNdI3CD0YBLCu3wfQiSdJic?=
 =?us-ascii?Q?AzyjbDrFnY8VbHYcMQL2uVoxrNG7yqDZ7GVCS0atW71mgRPBamoSCi/QuYG/?=
 =?us-ascii?Q?tqaueNajx2Zk99xZZUnVWEgSQ+mhrAxvj5CQd7C053/bzlzu4dT6S2V95fk6?=
 =?us-ascii?Q?DjyinKe5YcFpEt4SqWaXG0S0WQiqmlh1Xg01tWsE40ojIwMv7s1PZKSqgOAp?=
 =?us-ascii?Q?WYShkdRDemJGp3EZy4V46M/DdJqGGVJIb5sgYa58/UZLjuxviYaHBPKaRSpU?=
 =?us-ascii?Q?PGauo/pbpWBnwc0RF5fmO7accVKqhgIrPYTqgKYxZazBPRGhaoW9Z6LaHn4z?=
 =?us-ascii?Q?nOHbbzDT0XuvPobI1R2sNnQZEYLWYgFQVbqvuJXW/nJAKVBaQHjYlovonS8y?=
 =?us-ascii?Q?H4HZqs1dagd5SsyBRQKJ6d/jOIsvb4pfOesjTDUIQfD1u2610Tw1UICqqVCA?=
 =?us-ascii?Q?wPjBlQjQ64=3D?=
X-Microsoft-Antispam-Message-Info: XFjcFl21/gVxAKXYKRPH95VpybWXyHxsk2nM6z1Uys08HsKAl2APk58k0gbV9wj3an43iB/9qJW0CAIujQSS09D/B4XFKrJF4vq6k1vn9Ylopv7RX/A0pYla3LXBvCuTnYhV0+Hv2O2yNaSAWRU/0ETC0rW1jkJ1DPbnB390EdN/YxwXM2XcLSAQS+adv5ViPCgyR7ILtvU8bhzMkhKdrEhhQKKLY2ZHkfpxc6KUMkJgGvmtkyeVg7nANE474b4BRshebFPvfddupxh/Hg+6B3h0VNL8t5lqjIAOMfL1vmeRrZLHXSjtwYa8Yk7CiCGX/CvLS1Kkj0xL5gM5hf55gYPqYTMhzBCHRtVJJLvzFog=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3134;6:nA5TntfoUb33UtRRuPdk76gSGvfPHM76txn8Ibe2G60Vr0xJ5eKni/gu7+v4UaudoRlbk2Vva74RK4DHEpOErvk1ABzoG42olIHyoyZJK1NQ48S52xkioUcCact2mb/J81y+sZfUghRazOw/rfDZ7CVQ4DUJZYRdJv5tt5uvBRHLF2uFytAcEMYoUcj2r+79ZQf5ZHmiymuNobLnnluzgok7gmHUSfGbLpwfwqkVj4IV5DZGh2eA8YTIO5kPLw/3kFiyNpGYvVeeJfgajV93aTasir3IGmodKBQ1qbUEXs5IUJIvGWOGHhc5sCAwEFoKALOHSaqa0TlqQ7EO/5dH3qZpdbNFXloHbtkm+dcLiNQOxedU5oZm/Oa0u8B9XH3FOdJWK4daTUPFgJI7Rev02HFZHO2GJBuimlC/I0Xz0goBMxTT7tBtM0nE1wLxkIe6rT1OfwDCNZTiT92saQoQaw==;5:ObMx71LOc1Zo7OlJLzT5snsE4CtPrVm9CcusJ0QgwIyPYUIEUH4BJng+LyfzPkb0tEQ38jfG0dNJAKbc6vFQdADL/hWuI8wiM4mwVfbI6TzWSPurD39sO+Jn1ogDtDIBzgEcsRqiFlKALzqNBybUTOanNF+mlG9O2uJ/WtbxWrI=;7:NaLBVPgd94LmGHdDZx84g0wp3+dfZ1CQhtkoci7WgADsHrMWVz1VNHin9Jey2i40myWcgg0EnbkqsBH1glsRwnY9hxxbWlKRAm/PcTAdtftiS6x4v5/aTz5JoPXR6IjEN1Nx2XuAutb5+9sotWKnwwmsRtx8/LGYNvOJEAZuMidAfmor6yVEx+4yAyAsZlo/Ev0W1KIqFLs5X2lHGryZMwBw37q0aeLYB9hOYM9Clmcn56s5ceJT+idCuIkgz585
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 13:04:26.7117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9233ad0-a821-416b-2f13-08d5f941a472
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the option for the user to select the sampling frequency.
Also, the user can read the available frequencies and read the currently
set frequency via the read_raw function. The frequency can be set via the
write_raw function.

When the frequency is set, the bandwidth is also checked and ensured
that it is constrained to at most half of the sampling frequency. Also, the
activity and inactivity timers have to be updated because they depend on
the selected ODR.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/accel/adxl372.c | 74 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index e31e096..80b1838 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -217,7 +217,8 @@ static const struct adxl372_axis_lookup adxl372_axis_lookup_table[] = {
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.scan_index = index,						\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -311,6 +312,19 @@ static int adxl372_set_odr(struct adxl372_state *st,
 	return ret;
 }
 
+static int adxl372_find_closest_match(const int *array,
+				      unsigned int size, int val)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (val <= array[i])
+			return i;
+	}
+
+	return size - 1;
+}
+
 static int adxl372_set_bandwidth(struct adxl372_state *st,
 				 enum adxl372_bandwidth bw)
 {
@@ -639,6 +653,51 @@ static int adxl372_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		*val2 = ADXL372_USCALE;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = adxl372_samp_freq_tbl[st->odr];
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int adxl372_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long info)
+{
+	struct adxl372_state *st = iio_priv(indio_dev);
+	int odr_index, ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		odr_index = adxl372_find_closest_match(adxl372_samp_freq_tbl,
+					ARRAY_SIZE(adxl372_samp_freq_tbl),
+					val);
+		ret = adxl372_set_odr(st, odr_index);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The timer period depends on the ODR selected.
+		 * At 3200 Hz and below, it is 6.6 ms; at 6400 Hz, it is 3.3 ms
+		 */
+		ret = adxl372_set_activity_time_ms(st, st->act_time_ms);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The timer period depends on the ODR selected.
+		 * At 3200 Hz and below, it is 26 ms; at 6400 Hz, it is 13 ms
+		 */
+		ret = adxl372_set_inactivity_time_ms(st, st->inact_time_ms);
+		if (ret < 0)
+			return ret;
+		/*
+		 * The maximum bandwidth is constrained to at most half of
+		 * the ODR to ensure that the Nyquist criteria is not violated
+		 */
+		if (st->bw > odr_index)
+			ret = adxl372_set_bandwidth(st, odr_index);
+
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -766,8 +825,21 @@ static const struct iio_trigger_ops adxl372_trigger_ops = {
 	.set_trigger_state = adxl372_dready_trig_set_state,
 };
 
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("400 800 1600 3200 6400");
+
+static struct attribute *adxl372_attributes[] = {
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group adxl372_attrs_group = {
+	.attrs = adxl372_attributes,
+};
+
 static const struct iio_info adxl372_info = {
+	.attrs = &adxl372_attrs_group,
 	.read_raw = adxl372_read_raw,
+	.write_raw = adxl372_write_raw,
 	.debugfs_reg_access = &adxl372_reg_access,
 	.hwfifo_set_watermark = adxl372_set_watermark,
 };
-- 
2.7.4

