Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D144CC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F349208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="rGtZjDMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F349208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbeLMMrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:47:33 -0500
Received: from mail-eopbgr820081.outbound.protection.outlook.com ([40.107.82.81]:29315
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729310AbeLMMrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMeICaMm/XhivYWUU8HXq/shO0jdR/AfEEEjqsR2oF4=;
 b=rGtZjDMYmDJ6OFi0fN3yZwQLWU75EpC0f8lIvlv8enXzEbxSomxqiI4D8v6mDj8CSoallafXgcjdMnhB8joaxu/9LSzNqjcCAeMTTyU7Yn/83aiOBnatil4aS6WX/EvKYM/HPYBgirEsjvhe828PBY+uK/P1vdedx0qqsZXckgw=
Received: from BYAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:a02:a8::17)
 by MWHPR03MB3135.namprd03.prod.outlook.com (2603:10b6:301:3c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.19; Thu, 13 Dec
 2018 12:47:28 +0000
Received: from BN1BFFO11FD011.protection.gbl (2a01:111:f400:7c10::1:124) by
 BYAPR03CA0004.outlook.office365.com (2603:10b6:a02:a8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.18 via Frontend Transport; Thu, 13 Dec 2018 12:47:28 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BN1BFFO11FD011.mail.protection.outlook.com (10.58.144.74) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1425.16
 via Frontend Transport; Thu, 13 Dec 2018 12:47:27 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id wBDClRPe004233
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 13 Dec 2018 04:47:27 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 13 Dec 2018 07:47:27 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: [PATCH 07/11] staging: iio: adc: ad7606: Use vendor prefix for DT properties
Date:   Thu, 13 Dec 2018 14:46:19 +0200
Message-ID: <1544705183-13288-8-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(3190300001)(189003)(199004)(7696005)(246002)(47776003)(8936002)(7636002)(14444005)(76176011)(48376002)(8676002)(50466002)(316002)(16586007)(77096007)(51416003)(26005)(186003)(50226002)(4326008)(36756003)(11346002)(476003)(2616005)(72206003)(446003)(478600001)(44832011)(126002)(486006)(106466001)(5660300001)(6666004)(2906002)(336012)(7416002)(426003)(116002)(110136005)(54906003)(356004)(305945005)(106002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3135;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD011;1:rrSEx4+TuPVRLreYQvK6fzdxCx/mHqO6hdx1hwQYFqTx8NDKkurxhCoiZ2lp6fR4DLegskOgqUSXr1KZ1+AXk9oZhwxSiBdqcdt/3qowyWfNCLdkZmVSKfiAQGwsVBRp
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8209a8f-ca53-4792-148c-08d660f923a5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:MWHPR03MB3135;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3135;3:/4zRGqnSZur70QGyJPnqNsHhLk7XIJYEBOZp3NROT00/J+7SbiUpc0tP+OSIbNlSxgSPeejo+64qHOxwIHHetKJJVUDkFWtgRtZb/y2DKhjeY4Kv2/okUcpU184aJ4Xjnvp+QMWqgStRJZfU7v73kQr4idEySZHG7B4gjwmMlPjbyDzaqY6ogHheLATPzP8ay28W55UYKqL7B8YsVQe+5jx5zxsRXilGI7A/JwWI01+JSG8Sv14AmIZjdKibZKTBjUzNx37KkosAoNJ+Oy0wJ4Fhm75QELlsTv17KEQkswxmwf4s+xXkD45L9axrIF88iLQL34tUhOfvl5IBh7JgcBwwuK3Sp9Dyx3SuTyqgy2I=;25:CtZmnEvT0niKcPxmz4SlIzDjhHoc7V4okG4dyLgHT350lGDy6npVU7ZYjhOW3VOpHXd1zonvl2zUEdkCYxZ/Qhrd4m8jBhaJCdFQClIBKVoHCdibz47Bnv0jNwpGd/ZeeWrEiTTZeSBsU6Lzeu+uwW+fu/Xd9nMVyFwO/QezDspcSgCBCIanVvPrjrrQfyhBaU3yzMVYa6E9LSXN0yK79tudKi52go8jSrwrUmATlpq029+PVUb+prJAy+i7rG9l4Bzey3Oj2hKemT46vS+7NGVJ7MtU5S8vjV33GHzr3c9PRaWuVyKXMW5T8hqoPEmsw1qBknMalBd6fQHT8Rs77Q==
X-MS-TrafficTypeDiagnostic: MWHPR03MB3135:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3135;31:Tw+P5Yn/D5zVUcSch2wb0pSutRYrh33iuIfHOkaeAWawO6wECfkLWS62pl4zY40Px72bfCzECJxqsPdLBBmSkhEcGYSEPFV2WYr0xwdVpzJ9DBm8vPaYHQEafJJ5Eaq4A/y8h4lyH5rLb+u38d9BV9+k9/v3u8b1pcV68hRgMuwwJx3YZDJ6PBfav+TVChHt+MXDN+En9xZ9MDp8iWLdbKanZasbBFNtWse/HK/Z9eY=;20:ftm9dLETtZiiQu/2O14TpwmG6eGHhtBX/3AcyGpf1jNiNUIBlvw6a0AtXyf5Z8p8BrqKF1PGgWo51fMg/dEhZpLsMi/QiL6KjCwgb539XluVojNPyHow99NtcSh67HI0vs3ztu7fRqed9oKWo2gqSKmlGyUFgmWO9hm0xGWmwfyl56eUR0Jd+I5d/DdLLv5GtymtVp0fK3gzo82lxbrmGPy8qbedbri8GLfMTN+F69ADQiQ6ioQCEtFehp/KnH+yR5JvVcOPsEiCHizUtGudeVsN94SihnuFJeGvh4VY76rBAwRM7uvFLaflxhpLmSMdTUnXzpAgl+xIHIzkWeO4jjJZjuzMwWCiU4uYFkiUmBTwINgiLKYPUyPHZ3Ol/Egto0y6ETgTF6QsDh0Ou1sX9nBEJs0IKi6PX4CHiX9GBeMcL7//Wj/2ns8oYGQ8YVoucq+N6Czmxea3CPP6Uwf57sSMEr+eVnin7s5EUdsKM0c61RHXhxDKURWHjupwDcFS
X-Microsoft-Antispam-PRVS: <MWHPR03MB31350CB0D4A325F61A4DF3D09DA00@MWHPR03MB3135.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR03MB3135;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB3135;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3135;4:ZrU8OB098iIJ4EIgKergRNi4bQWwLhNy1AKoGFf1WPbOljOcp2wuO37rkPyWSOtBSgOcaKe5dbXQy1bBvCXqSJ9E6G2ZuWF/ADGp9dwckbdW8ea1fMhFs058YXH9aaN71qMlNExN3DtdKopzwbkM8CROmniJ+57gzkyN/fqbvV3RIukimATogcWrX5PZaoSSUGD/XXY7FBm3898sy8/JQV4eBxRDDOLvEE6QiMT5vQtp8AHHAIa1vnxvSLjkZunmyJ+cGjeVHKIiIajKJl/+Sw==
X-Forefront-PRVS: 088552DE73
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB3135;23:89VR5pHe8hdDCS+/jMe3D1xIvDR1HuwgBhkHRvcMN?=
 =?us-ascii?Q?i3OdW0wXGn9qhg6F5T5Etn4kepq5VCgJqkMCGaHAQTpIy2bA8iEEkAynAqub?=
 =?us-ascii?Q?Sh7HwI8rpMIW72Lor7NNn6SO7taBL1Ho5nxosf4sPeDK3FSNRhiLygCBtJfY?=
 =?us-ascii?Q?u5rc+nXntAdrpZmCG6nwiy/baUOkSePsXv8V8BwO6dhAgeIclrdylv9zGdO9?=
 =?us-ascii?Q?PQkascx3P2x2wMMT2fRKMljLSNm+GlBYGuusoMkAUPqKGYFTUhfwyfa82QxF?=
 =?us-ascii?Q?KD3Whv8gnNhCCgmnYwQZUaRLDq36TJr7eV4nsGdHbMX1HVbrvzpMRAeHag6l?=
 =?us-ascii?Q?AtGr2sAG4oh+lBBi/7hQwbOpBq58LQbb7ARYo6WdKp7xmY5OnCnK3hVPSAFv?=
 =?us-ascii?Q?kPP6rq1pM5VOThOWb9v0kEQBTlSHv3qDmQez3MWEHtbM3cT7+4Xk2yzimWCr?=
 =?us-ascii?Q?CTgt6KqUKtKgQCqyoM971cMZrFgej3qgqtSt1/tX62vmf389eYyCXKX5OZuU?=
 =?us-ascii?Q?9EesHb8nyZxfV3zleGwAxWNxJpgmpLfQ9DATdBKOTb666B7SO9IMZeMeMIQ0?=
 =?us-ascii?Q?cJQTpva4V6o6RQOg9D5nZsCFx9ACf3lsqM8a+YITIzaQKXsPJntgT2PExGMx?=
 =?us-ascii?Q?HhssN/HWlISy+ZlysPfIikZ/DsMiAoOdu0RXiQEvAEBYgRBvBkLhfCQ9fLdZ?=
 =?us-ascii?Q?58iX/Rj2edBP3zOcPC0AqXb7NgWO9mPosL9TLMjXkBrUKWeN2S5sgExyP5hd?=
 =?us-ascii?Q?irMDgiRy5E+SkZcmMfEi2a3tgP83J4D3O8UStqhGTb16GmStLcyRytlfJWzw?=
 =?us-ascii?Q?Yfp/WSNYD/sY+9U8hf5M1VtmKvcCMjrkjj1EoNfyh8FbJufAVBASz42RVmQd?=
 =?us-ascii?Q?ILpswiRnE4pUnAY3taEHQMh5snR0mnR37HC9b/9yeEjrc1Ixrq1mmYNlot+R?=
 =?us-ascii?Q?Icrmy2K7twUU0y0sRWe8mm8BVw/WQOsmmYJYzaO5XDjZ+1xWxJaT3BNSrr+p?=
 =?us-ascii?Q?eA5q7IXw5ix5aJqClV5W6UngQV0NukOSvXEyA3OfmhTRIvgBMoSp70xybLIP?=
 =?us-ascii?Q?MHj1gOi8/VAj+Y9BzZrymeRx7TcCUFHqeyFlDBY7OM84+7pmg=3D=3D?=
X-Microsoft-Antispam-Message-Info: slOa6X8XF13NehubI7BHHPC4nZgwkg4xY4tX/DJk2rCCTvfUYjFLu5NNqWGYFihVT+az/Q0Cee8zcgyiVWW9T/fTfNP/+ZRWm6AhO5ePo1mvaaZ18ffsIRNVH/FMng1y7q709UbFy8DUCpQLzWCQmGByNziCS9PGAZRwFyZ4OihZv0DNdolEllc1iu7KVVTgyucylzlFPXGCK9COiIalCzKHLJmWEXIQvnwSjmsEuFSpnUed0cWEhOt60sKymmPU5V5NnPAc8rPImvujT+fkVm/CyZmbDqEK2YsZBIS9FvtwPGVyuQFcBO3qYniw3UeO
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB3135;6:i2SYTBaAJc75C8Hg0MCIuDfEQvs/OVOaPX6U/SSLhbylFdlO1DMaQIOm1aVYCZe6TSNZP/JUDynDFXP0Y1xsv+P6NXdNTchx98oGbHgUUiaULvj+8N4pMjdjbj5pmxo1/IynNxnqdayxyrh9XdRLMqe7kOAH+x++aMEuBe97k/w4w1hr2Zr+tnZRfyblv8+fJVLgy3kYq+m8oSK8TcbW0cz65P2WdDpstKL0dyDTvFclOqe89QSU/brTdspumjSKjQJO9fSWjGcyCN3ehOdfBWehc1MDjzTgB65RKizV5zY/g/BwiEvCycmZzseWLQXq2gsgSk6AtmbxNFZ27YQyjzLb5lCHvJCZ4/7YWwdpju3Y/afANXhWzqh4HP1f9coNQdg/nvXvI6PToZwWRQ4OHtj8ZzLBcDXQhVATNFR3xxuLqSibnFO1ju+SUiAkgFES6ge03euqBTG6lrGU8WsCcQ==;5:aJOb8JBeZTTkcj6Ky7XhjIQ7is0TsgEnygOAl9ayGerc+Q/f9+kc9pjPuXCe8lB8K2gQuNsst+bfj1GRkON5RiJ1+tJ1ck0yhfYpF/b9suRFzrZ4HuN6/1joVMb3osHKrxwV9Dy+jGHQ4vn9GtTAfze5n/TwS2I3fs00aLeh4Xk=;7:AJSNFgNMNSUIzhpqNmFohQmk3TiQPmIhkxYudnxl0BuTeCBRcfxwRGweBmhGhoeB76jC79rZs88zekP/82JWRyopyZ8JyfNDT12DgjLZKqxgvf0AhEf9I0Cw73Ie4PqvcgoodBBeuG1f3HJfnWhUNg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2018 12:47:27.9242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8209a8f-ca53-4792-148c-08d660f923a5
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'adi' vendor prefix needs to be added to conversion-start, range,
first-data and oversampling-ratio properties.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/staging/iio/adc/ad7606.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 0925379..3355301 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -322,7 +322,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 {
 	struct device *dev = st->dev;
 
-	st->gpio_convst = devm_gpiod_get(dev, "conversion-start",
+	st->gpio_convst = devm_gpiod_get(dev, "adi,conversion-start",
 					 GPIOD_OUT_LOW);
 	if (IS_ERR(st->gpio_convst))
 		return PTR_ERR(st->gpio_convst);
@@ -331,7 +331,8 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 	if (IS_ERR(st->gpio_reset))
 		return PTR_ERR(st->gpio_reset);
 
-	st->gpio_range = devm_gpiod_get_optional(dev, "range", GPIOD_OUT_LOW);
+	st->gpio_range = devm_gpiod_get_optional(dev, "adi,range",
+						 GPIOD_OUT_LOW);
 	if (IS_ERR(st->gpio_range))
 		return PTR_ERR(st->gpio_range);
 
@@ -340,7 +341,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 	if (IS_ERR(st->gpio_standby))
 		return PTR_ERR(st->gpio_standby);
 
-	st->gpio_frstdata = devm_gpiod_get_optional(dev, "first-data",
+	st->gpio_frstdata = devm_gpiod_get_optional(dev, "adi,first-data",
 						    GPIOD_IN);
 	if (IS_ERR(st->gpio_frstdata))
 		return PTR_ERR(st->gpio_frstdata);
@@ -348,7 +349,8 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 	if (!st->chip_info->has_oversampling)
 		return 0;
 
-	st->gpio_os = devm_gpiod_get_array_optional(dev, "oversampling-ratio",
+	st->gpio_os = devm_gpiod_get_array_optional(dev,
+						    "adi,oversampling-ratio",
 						    GPIOD_OUT_LOW);
 	return PTR_ERR_OR_ZERO(st->gpio_os);
 }
-- 
2.7.4

