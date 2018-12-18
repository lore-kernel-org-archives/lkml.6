Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A20C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DEE21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="yl66ulVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeLRNpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:45:53 -0500
Received: from mail-eopbgr700055.outbound.protection.outlook.com ([40.107.70.55]:15936
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbeLRNpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnxpokqWzBM2KqaFe4cbNAzsbRvZEjHmeDHhB0DtT4Q=;
 b=yl66ulVijIf5tp5BxUgRxSkb75Q10cnY/lWUDdjl3YR59xZVUo+YGqVoMMRQIkxXe5jEgycvzGDZXYB0zyCKfeuhiXPU2Ct/2nkk9y+qCfay+gQHfwlsctZkg1vV9VsLIb2ssme+Oht3JRyY8hodTdrnJptbH3NxdPPPqpqYGhE=
Received: from CY4PR02CA0008.namprd02.prod.outlook.com (2603:10b6:903:18::18)
 by BYAPR02MB4326.namprd02.prod.outlook.com (2603:10b6:a03:56::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.22; Tue, 18 Dec
 2018 13:45:49 +0000
Received: from SN1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by CY4PR02CA0008.outlook.office365.com
 (2603:10b6:903:18::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.17 via Frontend
 Transport; Tue, 18 Dec 2018 13:45:49 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT010.mail.protection.outlook.com (10.152.72.86) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Tue, 18 Dec 2018 13:45:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gZFgy-0000gh-7S; Tue, 18 Dec 2018 05:45:48 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gZFgt-0003k6-3w; Tue, 18 Dec 2018 05:45:43 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBIDjZ0O020253;
        Tue, 18 Dec 2018 05:45:35 -0800
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gZFgl-0003hV-0K; Tue, 18 Dec 2018 05:45:35 -0800
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 26A36604C5; Tue, 18 Dec 2018 19:15:34 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <kishon@ti.com>, <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <vivek.gautam@codeaurora.org>
CC:     Michal Simek <michals@xilinx.com>, <v.anuragkumar@gmail.com>,
        sundeep subbaraya <sundeep.lkml@gmail.com>,
        <apandey@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v5 0/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy core
Date:   Tue, 18 Dec 2018 19:15:31 +0530
Message-ID: <1545140733-20689-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(396003)(376002)(39860400002)(346002)(2980300002)(189003)(199004)(51416003)(110136005)(63266004)(6666004)(356004)(36756003)(52956003)(103686004)(316002)(16586007)(106466001)(50466002)(48376002)(42186006)(81156014)(81166006)(126002)(486006)(6306002)(8936002)(6266002)(36386004)(8676002)(4326008)(39060400002)(107886003)(476003)(5660300001)(2616005)(426003)(478600001)(90966002)(26005)(47776003)(186003)(2906002)(336012)(106002)(966005)(305945005)(50226002)(54906003)(107986001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4326;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT010;1:3qTyo/5DFW6gw+zJ0LZmoLgnHRrauMevD6HgqwS8QCqz6UmyNuly1KvmGVxAwcle/g8jwZvW1tVUdTWAI++8t2ElJgQKdIClQMkEHzcmeYHs4EO0pkpp4JK9Rf+3xW3j
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a0aaae8-3273-4044-ac2d-08d664ef1e6f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;3:m1nEjXUKFNIxlsJFWtq42otjRyk+aVNNbKlluUo8fH9Dz6k71c9zSa9pWpiAADhGSHeBFfgs1lJyBmFVmdw1mcrHKo8EnVkg8j512+jBOG5MIWSSqH0wMY9RmrCR+w4fzeLWDX0UPhHg3y2i5rZWMDHGmn3NRCFcSxjSk/ovJqaKphbVEnPOidlfPD/xFHdNJpsVKN1RiSEog8IWgbcm2spJqamrF1iuWPp0ZP1VyMgRQKT4HYI6dbkqBQPsU6veOLWTWXSveyFK42O2QXqy79zIgjdGAKBcqkMxlYRRlByDu+PSB+e+Ri79l+91iu0PvMzAcVOaiieIyzS9nI7zC56L6/hmMyMa2JQWbUQok+k=;25:In+CFPDD9k/pBnUYj3HlTOu0Kp1kwkTnk7zR1QBHAnrDsC1RHosh89Kw8rb2OYlokxk0s3+VhY8WNf6aWnLS6T9i7uhCD1C/bTQuMzbJpuIr6DgTi7TStbB/qYA44UM/EsMizPWdLQhoeZdzKSDtkjo6dMYM+SPvR5syOE8Aytjte5TAQP61KoWs0BtMxr6abuL59KRKyeNpdf9IDkeh9MYtqOD9y8HwI2DdwxMF6jKB5davCrY5U6Wn30VpZPWwkEKtKsj123sdIwl7J2XVQY0M34+iCrdCvwapud8ziNYHZ58nD+x8jUTWpexTr5aHVTGiZ9R5pmqhaHJq9zPlPg==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4326:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;31:gkXHonQ3+LW47fwqvNqbw0T6KbzwrStu6mCwR3HIA0Ey6S5uhM7pBdcnRgYIMOqLA3volM/+CHxxnHfClOIXed/f6FUd6TFp0OWowQisA4Xq+CCprCQkMrsSRHQtpslqNrn8PI/LeVP1BQsAKUJx54y0iOae0VHOgX/y+gM+iF3ZxcrBlPPOxG+TEH3r2QytJpzCg1mS8jwk8leBAj0XL5vGpBL1ygGCxOD8RYY0Z/g=;20:vdffdgbzmnnmBJ8tkA1tiUOO2ABciYORr1xD+pp64T9NSklPva6L7++Vl1r63XMroFwSzMscX00PZbDAZGIJ7dkKoMpVNRV+bA9rv2ZIkohjD1Ot76rkweIPT3stfIhh4YMVA0fvCUd70Um1qQxDGxU50a8qktB2PxePdz/JrJS7476ceO1lp0Ui7I2qUns+t1z8NUJt908T1/U0HnNige2fV1Ug0qH5CrttQki3vMvtItEq5QdiwRMl+0Z2xs+FhMDC+W6R2gicrUtr8VUiVgu3afJgPhvmfl2yDJHPpfailEkXAd8Wz6OBJQ5tzhzwQKqgfuXB/CG/9r7TflgWjw/hfFzXB6bJQqS9AA1ytidlIaWbmpwRsh/ndo8txNXEqBlW4qy+0vkY9FqTRSNby2jnyNfOv/9LwWzYnLG7H8Oqrt+97Vz4VFoRKmmo5ygW5E+NEDoLtf/QsonD3pqX9iBM9/ro2byBG68F+ZLCqoKjTrraP/9W30qwWQ9awcMx
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB43267B567725BFCD73AE3B8AA7BD0@BYAPR02MB4326.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93004095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4326;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4326;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;4:XzXoEFCt67/tI6ucWQUcLSHrhQmYLi9UA8t53Zwi9YrFGaPLHdx+MOV7mZWVG/j+xJv8wbueeFIOKCjV6TRtz2dvrck4QeGl7Ffpc7nxRkSMa5fkunY3tM07gWVl7wlLpP0EGRGpHLcmhjLGMO6mQd1r+FtbswqkuBJDj3LgXKefHpMdG26MdAeUoi3DPrAc/tL7XAtZUmOv60KH92SDcAHdHnqfEqKspSDS8pgchO9s1kX9s2eUm9U1yFCcgwDR1W2G7V0sLeO6WTXaKfnenw==
X-Forefront-PRVS: 08902E536D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4326;23:Hnlh5C5AZbeRhxIuHaNUkfp0pScRYVgpc3JbXw3jo?=
 =?us-ascii?Q?Wwu72dMEO12Dr0vXw0snR14DZyphEMZq2+UYrnmMDjARsJysCVTHV3V0Ve5W?=
 =?us-ascii?Q?5jK9GRIXXUGje24CBGsrslG8uaKw4iHhVgkyv+XXhDdznYWJ6fz5FcSXBYLs?=
 =?us-ascii?Q?WCsTMqYt3gpAhsZKHchCKe3hRvbBjyB/l2Tp79E4GYkv0xRseoDlhJ9JvmXb?=
 =?us-ascii?Q?in/62ekZLRWnxI3TkwtdRK9vYHhl7ua+JpuulCocQoMVpKph2010fJ8OqpGJ?=
 =?us-ascii?Q?wcBSjXbUjY6V8dtx3EmRm8BNp10jbPDjueMAU5eBGACOXwcKRwmICOR3kPKY?=
 =?us-ascii?Q?ifafztEygsF2xxj9WDwaEbhGchgBEYJbJRC9Qslvq5sjloThDCRpEvuS5tzg?=
 =?us-ascii?Q?51DHVHCJ6uZpQ6wgr8dpNmCHa/y89DUDgk8AKMfSgp9jJN9H85gdFjVrdPAF?=
 =?us-ascii?Q?GFgdt18hn9MqNxBQUy9l95P30rKZ9TyEd6e6V1dXS9ObX5FhiNersxi5lgLF?=
 =?us-ascii?Q?EUBw7d6lGKMSlMtq/4xvF54YdcW00EbDg8T7FTR0ZoxheECLEN3VmPFfde5c?=
 =?us-ascii?Q?hksrXulqxRH04mAe2LjNQy2GZ4S8lkXSOhu1E9Oz5m+1a2P43wf4GjZr7A6V?=
 =?us-ascii?Q?nOk/p1ey7pDmSjFyhaFm1gEL4G2OcohT527VHPUn2GDX/2iiVAlzFxDW1gc2?=
 =?us-ascii?Q?mntJ6OO1l5TpNL5gRtfiJ9wafK1uAZLpeZbHuPKzlw8IFn01n2sZb9AuA2Gs?=
 =?us-ascii?Q?jyrZiRgcrd1gGachWuW/mA/sZ7zsAPdUYUuPUXlpQ1EubNioLwMuiTpQ3OcJ?=
 =?us-ascii?Q?Qcn96gp6dXIEz4+NxCeKi9aYJWAqF83dbF4N5I7fk9Gea9EK2g08rLWLkQ+J?=
 =?us-ascii?Q?Rndy4MaU5bcPM2w6C+1OBqQXTVVGwWLMb3MtMIbryvqvxNgbXLtG27h4jE6J?=
 =?us-ascii?Q?Tf+FDhgAFoZdyh2Om/KHutDBeJ8RUk7kOf49Yansvhqm8iu8zmO9ZSifB5ea?=
 =?us-ascii?Q?wlFBvSg9BKWWCfbH+h9YKMWNrcQ07USbVRgLeLI6i1EUuqlwsCmetFbjlCfd?=
 =?us-ascii?Q?75/5RpCgPLkqHVp9AtfbNsJ7yodOcfoHY2j9HaJEujAeRca1QfsEtA1VSzG4?=
 =?us-ascii?Q?hY44Pk38ZSmNitWDI/gEFCzc3PqeqQtgyj1m5brcjEpRDBj5CiOTmzBSKSzb?=
 =?us-ascii?Q?JgHNLWC3vXrsgmMEsmiIoB6oJt/ANyTvbul5KHz/PT9iKrUodbbtZ+xfQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: l/dwYjVJvLPnVXrsb89sbNtzYpA7Bgpi+h8gW5U7uInQc/OA6DRzPZrD8k7NHcB35ZBkfr9qlAu6TVBclj1Cc5rituVl+1w5bEyZxFL2aTTMmNO1d82pnPkYp5Dj+87Gg14qx30wv6/OyYChEmi0mLD5JFXvUqUojZ85hf2e6eeLcp/qx706AxW0MYTc0JNYW+MsELFSkwLwDidr+pdTLzcGe5i/zL7lLj2hCI/3A6BYfmbtMuDJ+RkRepgLkfZNXDE7/3YMXK1vgSwIsvpBpTHzqhbSJL5EnfOjY2iirYldYExW6vfKLk8tUFWyfm+h
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4326;6:+Zx4OMZKCaRDnxalpz2K15CBqW6kr0V4KoIZGsnxO1b9SzeVJwKjQ3rplSq2MLkK/qZDfShjwVBH/EY5CL/uQ1rPJoKp6DosNBxH9+rsM0QiTSnJJUXXknJXaimo4GHyqCHj35l+242dmVvK9RltMrgtnS8GdUcUdZrGZXVRm/d8nper/lMmXmQMH677ZsG/s5+d6PzTqaLGMN19rZHfZBdSTkWaf+WX6dx8nzafWcjh2byaqoinfjYhN4rh6y10giZuUDVGAw6HKPQvzLqD3D/UajIAchKR+8eKC+r0awPbZuONvksHvGAClKZyCKfDvQTIVayy+BgnA6FAxXu3vcgTf1P66lR0Bx5RHJp5F8x/74jhBqPHIClN61WcRh+UCSzdhMTNLsvl6TV11/caXYDKR6NCk0a/9c1xrILly3HuynSVN3BvfoN43AARhqNgBWepikKDiZDZzNUpJa2F0g==;5:q6nvHDlDoiGO+RA8PTRR4hTOL+kyY0yyARO++e78T1ku1XYTLB3+/Uqhw9b7K6/e3PH3JHS5Xb/rbq3t1wGlsZBrfChzpReE4qUon8ro/8HV/s5Lt81qs60G22fi3BSTyw5knE3E0USV1rdviX1poWazc3k9xXR6v+AW+AZjy9g=;7:Voe/dG2zdAwzGXibvf89Ka1/EAarUkV9bTA97Zg6Q1fzTEeRJYGUQB+9h4KDez60taybLbbfTSeHTco43ktw3uYytG/EgRcC7u7VMec1uhxoWqQqFa3YCAG/6esb7vR6ZppaPtABziGpYOcljHe7mQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2018 13:45:48.6506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0aaae8-3273-4044-ac2d-08d664ef1e6f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZynqMP serial input output unit (SIOU) is a high-speed serial interface block
that acts as a phy interface for the PCIe, USB 3.0, DisplayPort, SATA, and
Ethernet controllers. These controllers use any one among the available four
multigigabit transceivers for high-speed communication with their link partners
outside the SOC

ZynqMP SIOU supports multiple protocols working at different reference clock
frequencies to operate simultaneously. Each of the four lanes will be having
a dedicated PLL associated which generates the desired frequency required by
the protocol configured based on the reference clock input given. Using this
driver, user can select the desired reference clock frequency for each of
lane 0, lane 1, lane 2, and lane 3 respectively. Each lane can be programmed
to have its own reference clock or can share reference clock from its
neighboring lane, this is called as "Clock Sharing". This driver supports
the above mentioned clock sharing aswell.

These set of patches add support SIOU support by adding zynqmp-phy driver to
linux.

This patch series is based on the initial work done by "Subbaraya Sundeep"
https://lore.kernel.org/patchwork/patch/635317/

Changes in v5:
	1. No functional changes. Added missing Author name

Changes in v4:
	1. Fixed the changes in phy-zynqmp.txt as suggested by "Rob Herring"
	2. Moved the dt-bindings patch from 2nd to 1st

Changes in v3:
	1. Corrected the Documentation as suggested by "Vivek Gautam"

Changes in v2:
	1. Fixed the compilation error when compiled phy-zynqmp.c as a module
	2. Added CONFIG_PM macro in phy-zynqmp.c driver


Anurag Kumar Vulisha (2):
  phy: zynqmp: Add dt bindings for ZynqMP phy
  phy: zynqmp: Add phy driver for xilinx zynqmp phy core

 .../devicetree/bindings/phy/phy-zynqmp.txt         |  109 ++
 drivers/phy/Kconfig                                |    8 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-zynqmp.c                           | 1582 ++++++++++++++++++++
 include/dt-bindings/phy/phy.h                      |    2 +
 include/linux/phy/phy-zynqmp.h                     |   52 +
 6 files changed, 1754 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt
 create mode 100644 drivers/phy/phy-zynqmp.c
 create mode 100644 include/linux/phy/phy-zynqmp.h

-- 
2.1.1

