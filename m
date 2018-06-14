Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9B997C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F8F208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Km6KPx5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F8F208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755481AbeFNS3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:29:39 -0400
Received: from mail-eopbgr700080.outbound.protection.outlook.com ([40.107.70.80]:42432
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755332AbeFNS2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1To/JqyFPYETuvOC1pQtSEVIt2Rv0/RZmbw3sa5mRg=;
 b=Km6KPx5ckz8ePPOEsZ70/hmsQHT7dvkKWai0BZ7qGghFrf2RwUZVDyA3pWN3cic8Wix82DqJHB1oq2ukwEd4EFD7rWaevPvFE9uLqVzfuixovNOAR480jLr2rn2NonRpF/VU54FGlj7HUYkdtsYu10fQIz8nTK5jISZO1x34XnE=
Received: from CY4PR02CA0019.namprd02.prod.outlook.com (2603:10b6:903:18::29)
 by BL0PR02MB4946.namprd02.prod.outlook.com (2603:10b6:208:53::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.18; Thu, 14 Jun
 2018 18:28:12 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by CY4PR02CA0019.outlook.office365.com
 (2603:10b6:903:18::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.14 via Frontend
 Transport; Thu, 14 Jun 2018 18:28:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Thu, 14 Jun 2018 18:28:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyg-000214-Ny; Thu, 14 Jun 2018 11:28:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyb-0006HA-L2; Thu, 14 Jun 2018 11:28:05 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5EIRtt0022827;
        Thu, 14 Jun 2018 11:27:55 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fTWyR-0006F7-KU; Thu, 14 Jun 2018 11:27:55 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v8 02/10] firmware: xilinx: Add Zynqmp firmware driver
Date:   Thu, 14 Jun 2018 11:27:34 -0700
Message-ID: <1529000862-11510-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
References: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(36386004)(26005)(478600001)(81166006)(81156014)(316002)(6666003)(356003)(50466002)(8936002)(9786002)(77096007)(8676002)(336012)(11346002)(486006)(426003)(47776003)(59450400001)(72206003)(2201001)(476003)(446003)(186003)(126002)(575784001)(2616005)(44832011)(50226002)(106466001)(63266004)(36756003)(7696005)(106002)(2906002)(7416002)(51416003)(4326008)(110136005)(54906003)(16586007)(5660300001)(305945005)(107886003)(39060400002)(48376002)(76176011)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4946;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT018;1:T/02MiZyFePY/fyRHF10rAVOmK9aJvtKjXwuDhv9MjPjdbde8ABMCJXAEd8c0Z7kcQkOOiELDQAJWwA7+r91djpvy2ZdV4+keW1tEH48xQ36XFGPp6AgvMTxZ0KDVzMv
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aed219c7-4dfd-439e-5e90-08d5d22495db
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4946;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4946;3:xFn8vFn6ggJf9uj3uFTXv8iesa7AfEbVBpNZjGapr+yLav1NCM8mkimKN8zgYpD7NSA+1QFvpbuC5HDTp7sQRXhTewKzVnQG9aGeK/OlxDas4iLhIeIHc/7qTxjt2tEEelB6qEqN67/XQyU75ILy2GMKOlau7FsiGjlJGb39yIh1eEASvwVAm8MKIwRZMn2MSzRVli/pPHvBscjzvD+kA8p4DIsskY+lzxDtnXiHeiUBIMxhrof1GusIBadBzEvmwLgL9oH7u56rvGqCvehwmm5G19Nf4Mbh5BzbVu6NfoEq1j2DcYx5pshCJY6nBBlnYJDVK3aR/8Js/UhogGGfxn3CGJo2GWvoKpVTbdSIBuI=;25:lUt3Q/JnPav/ooo4YHob3ZXPeuPCFMR7y7Yqqd4tKhqwG4ppjF1D02KE3F1EHLEFgwdfJ+dqXOqzOVzD6oSmtl7bW9vYpHzIjSekm65dAR4TFTNtk0+ShrE80Ym2msL9J/ZKYEUkE0m5zrYoE/DTk0rZ8SnPgaw/DXgYpaCsN/ooHZiwJGqqkzhAviGp5ShTjNK5dk24ovXedsBdeSBYnbrN0Ms252iK2HplatfyBh8GWlSThUMcSpndDOJBuliRwq/DWE3pz7x9inYewADOZ+y2rcbXeZIfahXcfuS0hurj9SSasI+X+qMxFBkmhx+LmY0pYvsn8eZsrzIpCHoqrw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4946:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4946;31:0EagVmCN9mDdazCL3Y+kryq1qTWrdl9/e9fdUMB81WlKIK7P8DCesM3+nx2anfvi0aPnxuHfmxKZ0kQMF+YNKhET6df7hg/4NNZW3COzYWfiOUYp4qaV7k0bS1L0c6c8GsjJaj56LwWLfWopY4kZVvKP45aauMB02Tr1P+nezY0DhnhyJvXUomn2OdwYMmGbcBiH1hzKUP3L8IYWmjzxwH2pBnAFbeRPaxAc80pBcXQ=;20:V3w2qCPPrPcW1ct8UhSIsx7fQpo5SaSrWrRmiNG9PsJcPE5GEJwNGH8Z9RB8EncgZMbUPQMrAMmlE9Gyrl0k54cESUG4U5A7lgtVkrJlXXeo4a7e6NG8gDq7APytjKErIvykxI3QqTkdzwZpixOB215CWq1vxOZcyov1qrc0NLHqVubOs39SyYaa/8zaQiBIccPBaCio+NUYLK7iGIUD4ugaGN1EDNko72PcNpmz5Jj2DFOmPNEaWTSxrRdasWqhBRpdHfLjAMr9Ete2fXKgvk5ygW8ZyCXoHiggwPjttbF9vx6bjjYeWNu+gN4IpDup+j0vp8SeK995pFB3KPbwouIuxjOBFy8BhGuAxyJ8qn/fZXZbE4J5bHUn2oMkkaasPnEBk13gEeFJge1zpqhNy8YSQJ4yx79AnWOTiGJPEUt9QhfTn6O3xQgoMvs6QXai5nY0qLsan96Miz6jda6ufYMGTaSR5EFm5AmUjnpnSL9F5ZKnaMKyIdL9llM+mOau
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4946E9FB9DA3F106FC668475B87D0@BL0PR02MB4946.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4946;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4946;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4946;4:aKOt6TgP7wea3SvsVlyBnZboE8Fdf/XUOaAwVG1pC53JOPrI+JLxr0c0zalokrErliNRpTY1J9qQZOgkEJrdOPnN9cABxCbq+L/2WG2XrLi5VmK4Xb4a+/RLDLvF9faf5kh2uSmLhe51wlZftYxETdcxLX4zhu5FRNfgKLYjsK3h/n+LP/hLlr86tkNAvLVFhm3xA/n0EvAqnta/EadpscnkNohBMy+BWa3Cjg9rZZ+pHUwp5urMMCLR5xEv+e31CRYTPgU7J9dSsD+LqCWFXlF3JTdCNM2uPUaj4iPPAueNAh/P8ilMgABpbeBvJiuM
X-Forefront-PRVS: 0703B549E4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4946;23:ba59qiTmq64FBfvUy8FnDVgmpeTxvht2MZpeynEUx?=
 =?us-ascii?Q?PFuYM7QPxcrL15K+bhO7IkCDYrmOpdEh3eQg4IXa/zOMKnMy8xVMP0bwegQu?=
 =?us-ascii?Q?O5uu5WdOPzqsC5rFiwbvNuouMCZVg82+pAMZvsMajAyaffvuZpgUT2DzaYut?=
 =?us-ascii?Q?54SZbP/PSaHWCVuYPQSH/qKD14W3OW06ahz4jE2/6jA+dyFN0KSAPJNp4lsn?=
 =?us-ascii?Q?/q3mb/jRWKRVZoEO46var42Mx9LwLyEy9SFhXcoz9Ey2QXBB3t5EWddydKhE?=
 =?us-ascii?Q?AkkCeJgtXumwrRXPvZBubHqiKuNAwVajikzhbt8MA9cWX4zpv51MdfWMo9Mz?=
 =?us-ascii?Q?H8OREufDxlHJClTH7jWbgQShBWS04xlalHf9iUVIMqT+34pTjzkoETJ8vbO5?=
 =?us-ascii?Q?/RDZ96YMUzrGuAj3W5c7kLFHPrUtqFnJ1PIk28lMH7DRz8BEKTuIBh3BCJFX?=
 =?us-ascii?Q?iAqsm25G8HKhA6GpCVIMXHBTMX3y8t4I+/qrjBMgDPIP3hXIG89fEHUyS0td?=
 =?us-ascii?Q?VXFzSxJJczfy3SHilEqcAh2KeArC8uDYkyQTh2mpsSLDLi4qfLi9n4UnFdVM?=
 =?us-ascii?Q?4i/gf68O7upvTrMuIelMP/jEBPV/YDC3/xS9WL2qQL41chwNorkxZkIKHrQU?=
 =?us-ascii?Q?bm9GEtQe3XE3wAvjeutop6QbbTeKvenFliI2x7RXtNoM3Ifcihd16r1D+HhB?=
 =?us-ascii?Q?F5r4d+83kZrSI4g0UEGj9YiomO2UYxy9lqL/1/8IP9KEC1+soUk5nvjpGpUZ?=
 =?us-ascii?Q?ZFPd6piGzX8Js02GqtaPccf+2Z/HJOF796VtSl7ODnsdbNHilavEg5wJF7xE?=
 =?us-ascii?Q?M+GOn36syjYckRWxCJ6Oe/8dt8fVcisHoKY72J9UVX6JedOtjoTBuAZF6634?=
 =?us-ascii?Q?bQe+K9mlpxAXNsrxsElRrxmZHgWK6ov9DjPrx1xF+JRwcGglpK0ej14X3mHS?=
 =?us-ascii?Q?7XrSV+V/jI7eTS8lvnRtDO4DlEhvo9Y9CFuVoJYQrbiu70c2gpqJy8Z/knnP?=
 =?us-ascii?Q?vXdXQmWMD2PGHkqyKxIv9uJU9OPv0QdFS+HGikIAirCsHpk8Dc+cGJGp+NuV?=
 =?us-ascii?Q?+FNUg89hlcYgbtjCfvZm1FgNIFfDKI9faeGojmqSMbcN7qZ6mhYwKWUtQmhM?=
 =?us-ascii?Q?i4Zokg6Jm3dV1U5OKqP6g1/PDaLhlWK1I0zK8bLyInhQZuNqJyjSgGJx2mHz?=
 =?us-ascii?Q?JgjCqDmwZN9XOy83xHZ2S1ZC7nWvoDRUg+t7iz7NVTbZ+bTg6MQCY2OBTv7F?=
 =?us-ascii?Q?ISufnTf3ADnpkWRSY96LtaItGnKV03zyeR3iqrOTTu0zgR/To9QvyP7Nv9Bn?=
 =?us-ascii?Q?VpwptE+Azed0Lo1RPm4e40=3D?=
X-Microsoft-Antispam-Message-Info: /15Wh14e7W2LBTd7cqKRons4PTMS2fq+nlyQ1TsjTK0GmUisow2CDePboNm78ZSFZBtulo7+5CgzLkOa8huYYTMiUQXi5NBjnosVfGVYYEd5gsWMX0a8T6DXif3mXiBejgisAw4P+Cs9RwGcKM+/7m532uBmYmRo9eho+dqL/1qyQMY9UozmoKQ/P/wHvoS0
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4946;6:Z4u39yHQi+Do4McVlh4u+or5oHDo2w5mhtq3HJf5RuyO75Z6T3CZ5svjuQAWbZZMqon47le+QVS0+5kPv7Gcd6oT10uARE+5M+ikqp+wpTfMnhwOqdM2uHI5IdXh4NvBQ96h4xrXR1D8FFwZcV9IpbA3Dac6MOTH66jAYjjv9G6ZS2ZDSmQEo8nhxjbzeywfQaDuUk+MoRBgqQI0TUlALxcI4r+GJVflFYH3Ci4xYiLP2SuDzMBiywOrjOYiExSJVIRUsbEBMb1yalN/flgOS+20ve7appPgKrDWUpvsbEHLBDc+IjURaD6RrsqMlVJrQIXB/Cjou6kuF/vgvIz0gPwLj5FG1np6twM/6BuCfAms+zBq8C7EWY2DzPQqATx1HPCPwoXJKEjhbEGelGnEgQh6HyYRiXmWf3Q7do59FcOXoGaY1+EID0De/or/+K1meXQa6pBX/V6/8YnC0NeJLg==;5:NQ24DsDSQTJY+GSeKBjpfNUDfoU5LYhdqEj8xofIeLN+24eGFohpMbLb7i8xGwtiMVhP4xj7Fv/oXEXjynVy3lwFukdqUxVSB3WqJLCKrdgkwGR4frc1El/JDm9kDs3QV3rXCLYbJr8QujlD+ZoYmQRD6hvNlvx1PuxZmaN/57s=;24:VCXoonpEnpCNrRs06UVGdi0XDdqbxxx5JQYv2vzt76LB19ZXHUS+krSgSoggC0WYlXNL6e3RhpKnEfQOFUfNx0OVpDDxXBszOpHRAuW/LL4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4946;7:62Ek+l8ehw9QjIFamJs2MY2JOTTcuoeFjiasG+olkI+WGqiPwp0ORCslEKvLdnofANQEHv2Ksllm3OukbqZCvabZBGZN2NNoWoHr13wjV6s4vY9woKX8Q1zhE8RyBlLzuLepOG2CT1288YNXRZF5PdQK7SU+lWpbBOgK+TL7pCBbwviIt4XDV8bmSphZGhBPhFpfEMXRSjC0g4Hyou9X9AlmHvbfr758eYX/CmPSYkBF2GYsby2QEmwdOfm2MBkK
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 18:28:11.4036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed219c7-4dfd-439e-5e90-08d5d22495db
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

This patch is adding communication layer with firmware.
Firmware driver provides an interface to firmware APIs.
Interface APIs can be used by any driver to communicate to
PMUFW(Platform Management Unit). All requests go through ATF.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 arch/arm64/Kconfig.platforms         |   1 +
 drivers/firmware/Kconfig             |   1 +
 drivers/firmware/Makefile            |   1 +
 drivers/firmware/xilinx/Kconfig      |  16 ++
 drivers/firmware/xilinx/Makefile     |   4 +
 drivers/firmware/xilinx/zynqmp.c     | 337 +++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  63 +++++++
 7 files changed, 423 insertions(+)
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index fbedbd8..6454458 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -274,6 +274,7 @@ config ARCH_ZX
 
 config ARCH_ZYNQMP
 	bool "Xilinx ZynqMP Family"
+	select ZYNQMP_FIRMWARE
 	help
 	  This enables support for Xilinx ZynqMP Family
 
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b7c7482..f41eb0d 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -257,5 +257,6 @@ source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
+source "drivers/firmware/xilinx/Kconfig"
 
 endmenu
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index b248238..f90363e 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
 obj-y				+= tegra/
+obj-y				+= xilinx/
diff --git a/drivers/firmware/xilinx/Kconfig b/drivers/firmware/xilinx/Kconfig
new file mode 100644
index 0000000..cce4e4f
--- /dev/null
+++ b/drivers/firmware/xilinx/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+# Kconfig for Xilinx firmwares
+
+menu "Zynq MPSoC Firmware Drivers"
+	depends on ARCH_ZYNQMP
+
+config ZYNQMP_FIRMWARE
+	bool "Enable Xilinx Zynq MPSoC firmware interface"
+	help
+	  Firmware interface driver is used by different to
+	  communicate with the firmware for various platform
+	  management services.
+	  Say yes to enable ZynqMP firmware interface driver.
+	  In doubt, say N
+
+endmenu
diff --git a/drivers/firmware/xilinx/Makefile b/drivers/firmware/xilinx/Makefile
new file mode 100644
index 0000000..29f7bf2
--- /dev/null
+++ b/drivers/firmware/xilinx/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for Xilinx firmwares
+
+obj-$(CONFIG_ZYNQMP_FIRMWARE) += zynqmp.o
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
new file mode 100644
index 0000000..70e335a
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/compiler.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/**
+ * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
+ * @ret_status:		PMUFW return code
+ *
+ * Return: corresponding Linux error code
+ */
+static int zynqmp_pm_ret_code(u32 ret_status)
+{
+	switch (ret_status) {
+	case XST_PM_SUCCESS:
+	case XST_PM_DOUBLE_REQ:
+		return 0;
+	case XST_PM_NO_ACCESS:
+		return -EACCES;
+	case XST_PM_ABORT_SUSPEND:
+		return -ECANCELED;
+	case XST_PM_INTERNAL:
+	case XST_PM_CONFLICT:
+	case XST_PM_INVALID_NODE:
+	default:
+		return -EINVAL;
+	}
+}
+
+static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
+				    u32 *ret_payload)
+{
+	return -ENODEV;
+}
+
+/*
+ * PM function call wrapper
+ * Invoke do_fw_call_smc or do_fw_call_hvc, depending on the configuration
+ */
+static int (*do_fw_call)(u64, u64, u64, u32 *ret_payload) = do_fw_call_fail;
+
+/**
+ * do_fw_call_smc() - Call system-level platform management layer (SMC)
+ * @arg0:		Argument 0 to SMC call
+ * @arg1:		Argument 1 to SMC call
+ * @arg2:		Argument 2 to SMC call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function via SMC call (no hypervisor present).
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * do_fw_call_hvc() - Call system-level platform management layer (HVC)
+ * @arg0:		Argument 0 to HVC call
+ * @arg1:		Argument 1 to HVC call
+ * @arg2:		Argument 2 to HVC call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function via HVC
+ * HVC-based for communication through hypervisor
+ * (no direct communication with ATF).
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
+				   u32 *ret_payload)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+
+	if (ret_payload) {
+		ret_payload[0] = lower_32_bits(res.a0);
+		ret_payload[1] = upper_32_bits(res.a0);
+		ret_payload[2] = lower_32_bits(res.a1);
+		ret_payload[3] = upper_32_bits(res.a1);
+	}
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
+}
+
+/**
+ * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
+ *			   caller function depending on the configuration
+ * @pm_api_id:		Requested PM-API call
+ * @arg0:		Argument 0 to requested PM-API call
+ * @arg1:		Argument 1 to requested PM-API call
+ * @arg2:		Argument 2 to requested PM-API call
+ * @arg3:		Argument 3 to requested PM-API call
+ * @ret_payload:	Returned value array
+ *
+ * Invoke platform management function for SMC or HVC call, depending on
+ * configuration.
+ * Following SMC Calling Convention (SMCCC) for SMC64:
+ * Pm Function Identifier,
+ * PM_SIP_SVC + PM_API_ID =
+ *	((SMC_TYPE_FAST << FUNCID_TYPE_SHIFT)
+ *	((SMC_64) << FUNCID_CC_SHIFT)
+ *	((SIP_START) << FUNCID_OEN_SHIFT)
+ *	((PM_API_ID) & FUNCID_NUM_MASK))
+ *
+ * PM_SIP_SVC	- Registered ZynqMP SIP Service Call.
+ * PM_API_ID	- Platform Management API ID.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
+			u32 arg2, u32 arg3, u32 *ret_payload)
+{
+	/*
+	 * Added SIP service call Function Identifier
+	 * Make sure to stay in x0 register
+	 */
+	u64 smc_arg[4];
+
+	smc_arg[0] = PM_SIP_SVC | pm_api_id;
+	smc_arg[1] = ((u64)arg1 << 32) | arg0;
+	smc_arg[2] = ((u64)arg3 << 32) | arg2;
+
+	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
+}
+
+static u32 pm_api_version;
+static u32 pm_tz_version;
+
+/**
+ * zynqmp_pm_get_api_version() - Get version number of PMU PM firmware
+ * @version:	Returned version value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_api_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM API version already verified */
+	if (pm_api_version > 0) {
+		*version = pm_api_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, 0, 0, 0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
+ * @version:	Returned version value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_get_trustzone_version(u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!version)
+		return -EINVAL;
+
+	/* Check is PM trustzone version already verified */
+	if (pm_tz_version > 0) {
+		*version = pm_tz_version;
+		return 0;
+	}
+	ret = zynqmp_pm_invoke_fn(PM_GET_TRUSTZONE_VERSION, 0, 0,
+				  0, 0, ret_payload);
+	*version = ret_payload[1];
+
+	return ret;
+}
+
+/**
+ * get_set_conduit_method() - Choose SMC or HVC based communication
+ * @np:		Pointer to the device_node structure
+ *
+ * Use SMC or HVC-based functions to communicate with EL2/EL3.
+ *
+ * Return: Returns 0 on success or error code
+ */
+static int get_set_conduit_method(struct device_node *np)
+{
+	const char *method;
+
+	if (of_property_read_string(np, "method", &method)) {
+		pr_warn("%s missing \"method\" property\n", __func__);
+		return -ENXIO;
+	}
+
+	if (!strcmp("hvc", method)) {
+		do_fw_call = do_fw_call_hvc;
+	} else if (!strcmp("smc", method)) {
+		do_fw_call = do_fw_call_smc;
+	} else {
+		pr_warn("%s Invalid \"method\" property: %s\n",
+			__func__, method);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct zynqmp_eemi_ops eemi_ops = {
+	.get_api_version = zynqmp_pm_get_api_version,
+};
+
+/**
+ * zynqmp_pm_get_eemi_ops - Get eemi ops functions
+ *
+ * Return: pointer of eemi_ops structure
+ */
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return &eemi_ops;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_get_eemi_ops);
+
+static int zynqmp_firmware_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+}
+
+static const struct of_device_id zynqmp_firmware_of_match[] = {
+	{.compatible = "xlnx,zynqmp-firmware"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, zynqmp_firmware_of_match);
+
+static struct platform_driver zynqmp_firmware_driver = {
+	.driver = {
+		.name = "zynqmp_firmware",
+		.of_match_table = zynqmp_firmware_of_match,
+	},
+	.probe = zynqmp_firmware_probe,
+};
+module_platform_driver(zynqmp_firmware_driver);
+
+static int __init zynqmp_plat_init(void)
+{
+	int ret;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
+	if (!np)
+		return 0;
+	of_node_put(np);
+
+	/*
+	 * We're running on a ZynqMP machine,
+	 * the zynqmp-firmware node is mandatory.
+	 */
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-firmware");
+	if (!np) {
+		pr_warn("%s: zynqmp-firmware node not found\n", __func__);
+		return -ENXIO;
+	}
+
+	ret = get_set_conduit_method(np);
+	if (ret) {
+		of_node_put(np);
+		return ret;
+	}
+
+	/* Check PM API version number */
+	zynqmp_pm_get_api_version(&pm_api_version);
+	if (pm_api_version < ZYNQMP_PM_VERSION) {
+		panic("%s Platform Management API version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_PM_VERSION_MAJOR, ZYNQMP_PM_VERSION_MINOR,
+		      pm_api_version >> 16, pm_api_version & 0xFFFF);
+	}
+
+	pr_info("%s Platform Management API v%d.%d\n", __func__,
+		pm_api_version >> 16, pm_api_version & 0xFFFF);
+
+	/* Check trustzone version number */
+	ret = zynqmp_pm_get_trustzone_version(&pm_tz_version);
+	if (ret)
+		panic("Legacy trustzone found without version support\n");
+
+	if (pm_tz_version < ZYNQMP_TZ_VERSION)
+		panic("%s Trustzone version error. Expected: v%d.%d - Found: v%d.%d\n",
+		      __func__,
+		      ZYNQMP_TZ_VERSION_MAJOR, ZYNQMP_TZ_VERSION_MINOR,
+		      pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	pr_info("%s Trustzone version v%d.%d\n", __func__,
+		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
+
+	of_node_put(np);
+
+	return ret;
+}
+early_initcall(zynqmp_plat_init);
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
new file mode 100644
index 0000000..cb63bed
--- /dev/null
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx
+ *
+ *  Michal Simek <michal.simek@xilinx.com>
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#ifndef __FIRMWARE_ZYNQMP_H__
+#define __FIRMWARE_ZYNQMP_H__
+
+#define ZYNQMP_PM_VERSION_MAJOR	1
+#define ZYNQMP_PM_VERSION_MINOR	0
+
+#define ZYNQMP_PM_VERSION	((ZYNQMP_PM_VERSION_MAJOR << 16) | \
+					ZYNQMP_PM_VERSION_MINOR)
+
+#define ZYNQMP_TZ_VERSION_MAJOR	1
+#define ZYNQMP_TZ_VERSION_MINOR	0
+
+#define ZYNQMP_TZ_VERSION	((ZYNQMP_TZ_VERSION_MAJOR << 16) | \
+					ZYNQMP_TZ_VERSION_MINOR)
+
+/* SMC SIP service Call Function Identifier Prefix */
+#define PM_SIP_SVC			0xC2000000
+#define PM_GET_TRUSTZONE_VERSION	0xa03
+
+/* Number of 32bits values in payload */
+#define PAYLOAD_ARG_CNT	4U
+
+enum pm_api_id {
+	PM_GET_API_VERSION = 1,
+};
+
+/* PMU-FW return status codes */
+enum pm_ret_status {
+	XST_PM_SUCCESS = 0,
+	XST_PM_INTERNAL = 2000,
+	XST_PM_CONFLICT,
+	XST_PM_NO_ACCESS,
+	XST_PM_INVALID_NODE,
+	XST_PM_DOUBLE_REQ,
+	XST_PM_ABORT_SUSPEND,
+};
+
+struct zynqmp_eemi_ops {
+	int (*get_api_version)(u32 *version);
+};
+
+#if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
+const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
+#else
+static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
+{
+	return NULL;
+}
+#endif
+
+#endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

