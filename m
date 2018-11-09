Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690EFC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 05:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A00F2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 05:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sbIGp5Wz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A00F2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeKIOj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 09:39:56 -0500
Received: from mail-eopbgr710073.outbound.protection.outlook.com ([40.107.71.73]:61437
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727474AbeKIOj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 09:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GASDJ7dyg76MPCQMD8YKuz2gfW35SG86WfcRo/RfnHw=;
 b=sbIGp5Wz4IabEd3aiCaGZ/pys2KBTWtD0l0PeMiEBLqVFcoJ1nB7drTpiwmRa+82GKBjRzl04CJjVNXReLynAsmYfm/08t9ndZDNAVE3R/WR4/GGJhEPTVm/BarVrdWG2bCgtmKg47b0+7YaSx9TNTP3i+L+R3dvHIy2eF/9DsE=
Received: from BN7PR02CA0027.namprd02.prod.outlook.com (2603:10b6:408:20::40)
 by BL0PR02MB4449.namprd02.prod.outlook.com (2603:10b6:208:45::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26; Fri, 9 Nov
 2018 05:01:02 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by BN7PR02CA0027.outlook.office365.com
 (2603:10b6:408:20::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.21 via Frontend
 Transport; Fri, 9 Nov 2018 05:01:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.11
 via Frontend Transport; Fri, 9 Nov 2018 05:01:01 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gKyuj-0002Sf-Ex; Thu, 08 Nov 2018 21:01:01 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gKyue-0001Kw-B7; Thu, 08 Nov 2018 21:00:56 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wA950sKg025666;
        Thu, 8 Nov 2018 21:00:54 -0800
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1gKyuc-0001Cd-1o; Thu, 08 Nov 2018 21:00:54 -0800
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <michals@xilinx.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasuresh12@gmail.com>, <robh@kernel.org>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v12 2/3] mtd: rawnand: Add an option to get sdr timing mode number
Date:   Fri, 9 Nov 2018 10:30:40 +0530
Message-ID: <1541739641-17789-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39850400004)(376002)(346002)(2980300002)(438002)(189003)(199004)(478600001)(7696005)(6666004)(106466001)(336012)(76176011)(51416003)(63266004)(356004)(6636002)(36756003)(316002)(2906002)(106002)(110136005)(8676002)(81156014)(50226002)(8936002)(54906003)(81166006)(9786002)(16586007)(5660300001)(4326008)(48376002)(39060400002)(476003)(107886003)(446003)(126002)(486006)(50466002)(77096007)(2616005)(11346002)(426003)(26005)(305945005)(7416002)(36386004)(2201001)(217873002)(186003)(47776003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT046;1:3A4Mm39SW3cJoGBNCjihAPQub0gGaXwJC9OmjqW0UPUptjU7cLZtfAmdo1mbf0Xo9Fi6rrmUJvChz4gz/L1SXY1LVLgX+8zzKox01g/r1jR3MLJjX7PIZWafRIeLEEvO
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84ab05e2-f561-4ec4-f542-08d6460058d0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;3:RGG8VD3qz8ZVCwTFLOLLIn+yhyQbHQH/UM6dP8K971S9orns5hisE26gZ7qP8Jbm3z4AvD6gQyrTyJE6Wn/a4nfa3cjyMaa64ezxXR0BxgXWHM5os7vGvdLWh8T2SWAlRwY0bEeWJeM/B1beTgmbDqC7YHkxzQCHnr6FSHB3w5ybmpofwWlgs7HGusG0tPAe65kIxRmr6qQSHoAe5MihUfKhxzFx11s5NkuVh0qqW18wjZqcym6vQ6iDcRhNwWwMejb5Dw2Sc4/KMZI2SBq/OlLORH/LH6srwuBfILjZhkky7tHqMHdW4bQHeICmN57KgDifEbPt5klt84lO9FAgLXLJD3zYbGaVI8dGmIhXsMw=;25:ZrbY1bGfVsgAzuaqZz0KHwG+qxGTV6eyM2/quhkKSxOlr4x3//jTUaRrVoa1+UBMbym2nij34b7TBj/PlKYxN29FrrWUe3jBTn3+nAvxe0ZuA9xZaOxgpWXvuqUa0ZGPmCs7QPOHNGBLqZqhMQUpTQKwkD4+m5DqjDp4v4jxXFM8YNwHiiuuhbeVBFmY9qRIH2C6JWip8Hr20MIFavOIwncLLj8noDnHeuABdpaZxeoz+W8Gce+lcp1ZJFya25yYObvoQcjzCr24glwxKsFjQyKpYfVUbmVRZWBPAA4CpdeQ6+MKpREDugpCG02fgqADypyONCCefg/gW4l+UPZrGA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4449:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;31:jnsDvtJU5wgPCtnKuDL4JdnIny+xrWc2v5M6PeIQzVxYjkgD/i++Er/SfR1SuZ58dXs45//kooOmasYPaCAxz6evkBT1LrQISa53j05OgNTwnvEC19PWWwaQa5JO+VyycbGlgdujkP/U6oeNA3zIXx/CNAc/WWFcH0Ddq5/xzVPX4wseKZ4X18FFpWvM4t8UF+WQ4gBWqmUcbOJw1nSm8acAjhnUPyM/kkDG0djDNr4=;20:CQaJ/LMLp1f9hmi29EIJywK3VBpNlfGUnP/tXBlshLBldLrS+wSNYiyBp+NdMTdcOBuvwTN9cmQOu/4OOsZRkC9NWP/c3W9+824rp0k4CA8uLrIHr+bh6D8ES5FSsoNzev3nLlEXEYsrcCrVSfLFzbVpBhGyiRbP0+XAGSnud/C3cN4ojqRM+4H4FxaPMRR41xhZ9P0gIjNKIBdrZVkZUd4pcTGMZ2/wxSoNxj737/V0mfCoiGpPZlbXo0WEyy2yYxJm86d6r/JL7vn7FqtacCNOCVr17m6JfWVlMJNGQL1O4W9h4hP2gpX5ViIQ/vZK7xySt6OoaD1UJpJeTs5E9C3F7Ld1Z06/KOwKA2gunInO6RoVAcfnhIo/6T7COKP4hLEgJTZlHO/Oq9agW7CWdowPzGjAmqK5uwd1ACML0ClgWcbm5hi7W4WHniv/suRwjByoiyoK/6Pl3WJGwYHDXiphIpgjskOAJydUJ2RQc1zx0j5jXkMrTPHz8ia4k25b
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4449F4D9B759AE86D00CBA19AFC60@BL0PR02MB4449.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(163750095850)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4449;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;4:JYYdGPNKjdIdLqq/i040uoQjw+qFW8R2RIJnf8HC/cw6UrmOMKiGIp/0LHtS1MVGZqHgkXDjTdejk/kBSFsDIRx9H7Q8j04qc3vabC+ehmvFbbPEUdIZtwP0ZZimIkGu4pOWXc4rYWK9TwpLkFpOB1py3RIpQv68v+EP7Y+woYzjfZmwx6atihTk/wdqMsc0PZnmOqUqh7Vfywk+xo3jVfEy+o1BW3LMm6oTg2NXG1MNu2oH+c2vnatEhVDslJbwd+O3v800EmbEb3tkXicBse7zsMIgnVUKGg+w7wcDjf2tx/eqhSiky2+eVtSmA4b5sDF6wXVnKkW6nAVPT7BLpw==
X-Forefront-PRVS: 08512C5403
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4449;23:S2/1VducsW61Uu4OJOkK/kYAI2CSnMa9vxGxViHzX?=
 =?us-ascii?Q?tNoR26GbZsfhtiL2eILi9Hz5Hkmq1TvLwYx5FAOudCE61cX6ju9JW2XEzvEj?=
 =?us-ascii?Q?cHiW/kyiwlAOEWqp6PZWHEUmEsM9zcIDhWKiNBZtPq9LoQvbLayEj/D9TKwr?=
 =?us-ascii?Q?7ghho+8E3sAy5PyDGe7b4zFU48xvM5Ba10oXG5BOk6AHuvteHYgt2EDtD0lz?=
 =?us-ascii?Q?MYFkDbSfXotaMRQ9buTQkry4cPC1jrrR7XzvMJuyfszJBdS7rhUmdtZIHEiI?=
 =?us-ascii?Q?FclBVLbRcahi9jHbebiIn2Jr/yRIbSNQZK3iyzQ5PBJ/ZxZ6f2pFkBHEmzhy?=
 =?us-ascii?Q?dwEARUJbroqZYQyFjxLBbtD1K1b28pAcmEzdVh64m3JnsxIjoipQTC8f9Wt/?=
 =?us-ascii?Q?EXi/lJw3Sz/Ae5KXgDR0s3Bg2dXxXzzVk2rTxhWx7ka1HRfuGgtSuS7pykJM?=
 =?us-ascii?Q?pcYJ/cthplkHJi6bBgusGGixemqRRGht7aMFSzjmYmGOdD5zJ1lims1ac738?=
 =?us-ascii?Q?n8iAJvAD3iR16q/vDszGnv5BgSGSN+PmFJFF1vPVXVKTjiQbW/1adzOPazXV?=
 =?us-ascii?Q?JGtxkDtvij8NX+ul6dKeWmQTorHnvYQBSJqbus6jtw66DI4zljYQoploFUYw?=
 =?us-ascii?Q?HNaeZfh10hEZB+LbvN5XqU+7JuqznEviBaTkRYYkYd1+epz+lcFE8fGPxxS4?=
 =?us-ascii?Q?HtR5W2wwGE8Ql2+lSnXAt+PwtE28DSrZVd5cW+HpRqoeS5/PSZzeAl3hROLX?=
 =?us-ascii?Q?ooysdg2M7wvKfFXt2ENg5KZeVfkmXljSGVLHvYhsaQKxshBCm7NslhoW5+gb?=
 =?us-ascii?Q?8qtl+oRoBhRnwwUpZf8IyMsbIbfidugmJcJlByFqBI9Z4sYBwNcb2XIVWPF8?=
 =?us-ascii?Q?paX2gGqNB5HkQfJnNIQzEHVIz4wBi5mQGH/7RB7aFneEoO3YUvkPxw/HeZVm?=
 =?us-ascii?Q?/ux/EgYZFnDBk1Y2tPUYijBbWhXtAl17T73pmfiMeiMVFsqMefPwjjWPGzsf?=
 =?us-ascii?Q?0H+h3zXdaFowdR+Hkfbl9dnDhBi0hyBkY3r13Dy6bBtITak8cxnjxRLcv5km?=
 =?us-ascii?Q?3qYway2kpCUlKsfx+8tMN6afbstG2UydqDMwKpiNHoVNhy/JcZXLWWqklJRT?=
 =?us-ascii?Q?0oa5OT9Ct2wN/Z2UJKhwTWZnaVPJ08QiOnARg92mwLj02V9+VmkN12Bv/UeL?=
 =?us-ascii?Q?DNkFYasDAwKs9vTdKWC0X7LdlfYyjx+SZjxnDcDXd3ohWivfSsMZILldQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: TYz6Wbo5yHjFrQY1kMK6Qre2XSbdOF50eXOhOpT2t1RjFcwndL6osIwEwm6SzHUvU4jnU+NA46I1eUSyfSJBgWHaCL1R0fOoY+XAPT3dCIZwla9qt83i9n1HTHOu7weM01DzKFOce7PJNlGvbz/9/yfV9D/z0RkMNw4L/VgJs2SwgfHTzVljxD5ETwDTqW8deIsec/e2pHsKC67X30eLJloyNP/6AwA24Q86LO/FLzCull9WJVbBaKBQWjjJ857FASDNMEB1Hx84sFoCmPwVWhSkaGyH+CDtKZjQTLZ4Xbjgd2kVtFxHEk6nq9/XM8O9pY7rUm1xC/LWOPPHGO2jNxI4CFMrao7ujca9ToKbvy0=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;6:J8TsdQQFCIQktoNlvRTfMwWL5GvmohbEYRKmGggsA/brIoXDSvKueKlafwthRCgtXRJ3Crct2+GvoL7E1n0coPS6UnGMmoY9MmpA1/BopzgEJz4mlMBWRducUbiLS/MQAVQUN3FaA5LuDEE7h7XUJ8ROSMD3vfaPlXRVnbIjYJ3q9jF4vrcf4319Hksfjc2pcrOqtI+fpyk0CkV3QSYnW2beNWSLTikz5NLLyrOlszaGX1X+oVimxkP5W8s35TKHsqKaScxtjSN/pnXvTyIaq+wprg6Db8qMqDkQwsDFqvfsQwddIcsZ4duoqZg1Tj/r8dkZHD3cPpuUGla6JuPq737tzDIcX6LLIuHMsup6MWIKC2fZuunZJwV67UVw7T+kR6v+Qs3citFG4mg9aS0wcIpptka2DPcBxIKoK9qz7ojC5mw2mm+PW04S1sN4lj8cY5zhb5wlTYGcKh+VEZtsaQ==;5:jRKdrjnCz996+/uf7vbSdDGZZ5cg/eV9DInAoUQCcZixk1uKgb38gH1ksK7TYkPZllFbSFdv0VTkmQf/uc6x9Ax7fxhcFtf226GcvzxBSfsSn5rdVz4LOuxWdBOgaHIMdLgMF9ZBDpfmjKKSgqRKHzrYosNrllcXa/wqrsk7wss=;7:drgqJK6G0GaKI5hO06vFV+F6jViZGLkEKn6Jd3G3+SKxWcD7k2veuuESdxk5E687wnCj2GqmuXMaDC5ht6sZufTDYSo0zz0N9A2tZgT2aZiJS0rcX7fTgYJ8PM5dmoIIP1Wj2F8Kv4W0gIdvD9thWQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2018 05:01:01.8693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ab05e2-f561-4ec4-f542-08d6460058d0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NAND controllers need SDR timing mode value, instead of timings.
i.e the NAND controller will change its operating mode by
just configuring the sdr timing mode number. So add a mode field to
struct nand_sdr_timings

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v12:
 - Typo corrections as suggested by Boris
Changes in v11:
 - None
Changes in v10:
 - None
Changes in v9:
 - None
Changes in v8:
 - None
Changes in v7:
 - None
Changes in v6:
 - None
Changes in v5:
 - None
Changes in v4:
 - None
Changes in v3:
 - None
Changes in v2:
 - None
---
 drivers/mtd/nand/raw/nand_timings.c | 6 ++++++
 include/linux/mtd/rawnand.h         | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_timings.c b/drivers/mtd/nand/raw/nand_timings.c
index bea3062..500c16b 100644
--- a/drivers/mtd/nand/raw/nand_timings.c
+++ b/drivers/mtd/nand/raw/nand_timings.c
@@ -57,6 +57,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
 			.tWHR_min = 120000,
 			.tWP_min = 50000,
 			.tWW_min = 100000,
+			.mode = 0,
 		},
 	},
 	/* Mode 1 */
@@ -99,6 +100,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
 			.tWHR_min = 80000,
 			.tWP_min = 25000,
 			.tWW_min = 100000,
+			.mode = 1,
 		},
 	},
 	/* Mode 2 */
@@ -141,6 +143,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
 			.tWHR_min = 80000,
 			.tWP_min = 17000,
 			.tWW_min = 100000,
+			.mode = 2,
 		},
 	},
 	/* Mode 3 */
@@ -183,6 +186,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
 			.tWHR_min = 80000,
 			.tWP_min = 15000,
 			.tWW_min = 100000,
+			.mode = 3,
 		},
 	},
 	/* Mode 4 */
@@ -225,6 +229,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
 			.tWHR_min = 80000,
 			.tWP_min = 12000,
 			.tWW_min = 100000,
+			.mode = 4,
 		},
 	},
 	/* Mode 5 */
@@ -267,6 +272,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
 			.tWHR_min = 80000,
 			.tWP_min = 10000,
 			.tWW_min = 100000,
+			.mode = 5,
 		},
 	},
 };
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index e10b126..223b656 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -466,6 +466,7 @@ struct nand_ecc_ctrl {
  * @tWHR_min: WE# high to RE# low
  * @tWP_min: WE# pulse width
  * @tWW_min: WP# transition to WE# low
+ * @mode: sdr timing mode value
  */
 struct nand_sdr_timings {
 	u64 tBERS_max;
@@ -506,6 +507,7 @@ struct nand_sdr_timings {
 	u32 tWHR_min;
 	u32 tWP_min;
 	u32 tWW_min;
+	u32 mode;
 };
 
 /**
-- 
2.7.4

