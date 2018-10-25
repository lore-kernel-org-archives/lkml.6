Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA26ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B792083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RTUdU8s1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B792083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeJYOjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:39:10 -0400
Received: from mail-bl2nam02on0073.outbound.protection.outlook.com ([104.47.38.73]:45531
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727416AbeJYOjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDVcshqKFY4h2gi9X7wytynVfvC5Q2YzN+KIajxlotk=;
 b=RTUdU8s14MJnZ1+qgx6ctUPdESIQN+B21v6bJa/U1VatfaFVPWU7w9cFJmMJEZoPmx7DJweWQepTqLQ+z0qLhMNrSE/tFu2j7CrDx0+kM1r//doxpsfC6q2LBnQ4mL7x3ISPt988w9mOrDSUggf5Mtfs0ei9zOyY4pGJ1WpN5ZU=
Received: from BL0PR02CA0107.namprd02.prod.outlook.com (2603:10b6:208:51::48)
 by BL0PR02MB4324.namprd02.prod.outlook.com (2603:10b6:208:40::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.30; Thu, 25 Oct
 2018 06:07:50 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BL0PR02CA0107.outlook.office365.com
 (2603:10b6:208:51::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.19 via Frontend
 Transport; Thu, 25 Oct 2018 06:07:50 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Thu, 25 Oct 2018 06:07:49 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gFYo8-0001Hw-Q5; Wed, 24 Oct 2018 23:07:48 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gFYo3-00086k-Lg; Wed, 24 Oct 2018 23:07:43 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9P67ZOa030770;
        Wed, 24 Oct 2018 23:07:35 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gFYnu-00082k-I3; Wed, 24 Oct 2018 23:07:35 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 9BC4C1216D2; Thu, 25 Oct 2018 11:37:33 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v10 6/6] edac: synopsys: Add Error Injection support for ZynqMP DDRC
Date:   Thu, 25 Oct 2018 11:37:01 +0530
Message-ID: <1540447621-22870-7-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(438002)(189003)(199004)(47776003)(36756003)(126002)(44832011)(36386004)(476003)(336012)(486006)(50466002)(186003)(16586007)(54906003)(110136005)(42186006)(6266002)(90966002)(63266004)(72206003)(14444005)(2906002)(316002)(478600001)(103686004)(8936002)(7416002)(6666004)(305945005)(356004)(52956003)(106466001)(26005)(4744004)(426003)(51416003)(76176011)(2201001)(50226002)(48376002)(8676002)(446003)(2616005)(11346002)(5660300001)(4326008)(81166006)(106002)(81156014)(107986001)(2101003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4324;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT041;1:FuAb9WP9lmJxhaMDpHyRYQ4gWFO82fHhAR4z/Q2GPMETzz/uaPeSXDtNvg1LISLCPLC5uzWn6DukulSMr53AfIL+qaqxPO5jQbuZCSsaXQAtG7h/A7f49LXBsclgCxpE
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d19e110-416c-4eaf-25f5-08d63a403163
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;3:gJONWa+7FU2E3p6h6phN6n88qQyXajgEhpNt2q9gaX+/xom/evyADV4UABYFF8LwlXr9XT7NkL2Bkll48xq+aUnCq7RZphe4F2QnBj625CXvv6HJ+rXcdFWymkowzapt47xIpcAigp3q7Or0egUhCYO2jANNyoOgQhZ7FdxPecMceAMKsdoHCCTvM5vo020+Lx0vm0Hby9yf40xOjcEJbJoj/0fukOJi2GMtvBnk95fRDEcT1cMikATU2aOdJf4Zj3V1u1b83QtgGzqZ9N1+W6DQrJjVdyNFbCp2WuvIJUvuaawVUgj4kN+hFSOc2Zf8aFdsEPBwFF0qClhdiM12/3W50baInhReFm508F0MVOA=;25:rMcxy5UVzE0eqT3dEUS077pchRc4FBc9AqLx2d1vMgMoXFKaoy4RghNN5/NHQiQBKuCXn0M3FI0ESOcwuW3VgSbElPhN124O9i0m11BaoCQJMGvho6y33GSxw8RyfFFQho0fE7qPUxOGdH50sNFj2thwvPozhPw3T7J6ix4ArxCiFhY0ucbUJ2r2c19sE/b+gzGyDoWPsaMOdSS4pEQVrZTS1guiGfKr7cBLIYXQbcOUjHHB5Wl4sOrR29hwK78r+0zfpikMO0Bys0MZ0WyviAutsiSawsDOmF1ecNlnyxdtXXs733hzy6DGjsY57m2hKsiG4+QAc3FgpyBR/koICg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4324:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;31:m4FRU6sv+yOrTKs08SjluzbyG2shyymE1wcYZLXVRn12XhU4CEeq5w6CE/dFSPB4MvGcO9bqbY97yH69piIMzJpMKHNH+N664WfagCkKryKphK7RtYU2UHLjt5oNDcCGGPVAAORK89TyHtkZdYAQdNFQkkHyAe9xQdydwi7PlX9+h/r9g5nB8X1oyy91mrlcFo2IW/gkU6+nj9SC4kuWuXnIauPSosWhkWcNujs0o2U=;20:gIuK4WKANIf8loelivJMSiK+V/+Jkb+wdKdizLRBd5QLWN1r31zWx6UT4TuH2FqxHHcH5RFk78qZNYVMyUxFMBC6xlZJ50God+gmzWecF2jG8bOFw1Rdefrmp5DeZd3o7vcgprxZUGku0O7xIpS4HkgvWVptSmyQAkzl6XjqV0706sBUsqYkoPhx4oBe9cU0dfXvtQzQny067GRDdr1jA3iKwvChG9XPZKAhOrWOjRccJgRnp5sXZCv59WTKvNXDuRbXPTiAoqc5oYdpwRpNK/zoHp4k1IEPdFNip02aKoMabEAw9RxwnxA7xlcjGCu63gjJRNLjRl+RHqncpOfjX99LTMehCgSe2z0HguYrraSQXLnH3pGdN4beAweFCWRKcBSrfrVVXnSPRE0OyoVLq3fMnbgUyRK8cWu3wCIyJUmyjFGfe2/07SoaYiTFgYNRqsfS3gNII7pSSkrHU3GT3I5lGAGfTxfxxQa/aZ0D4EJm3PmkyKe+gVoduPerhjsB
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB43246CF1CFEA23BFEEE4F9FEC1F70@BL0PR02MB4324.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(105169848403564)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4324;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;4:quttBAeiwQ1Yk9W2b41lIxROJNTXVrMV9fVMBmyuRs7dDU4rllL2/XJo6nue0umvshUbG8gnElLVHwAvEtFhsdsMi77dw2HBfoIsA0AabHDw4wlgx4PX3klSKU81f9fCCMS3MrH7RXe3Lyaxbj54j46IzaOLb5CKMM8RotlfxOTMlCRn0c7D9iwdCFymHATuvunbNdh4Hcjo3UoQjkRJxSab16jO7nx+3WfSCgD9gtd7x6gLqo3g7tROo2IZo03CiKn4nZKCFzDiM3LoArCCYlr3ONfSiLLAijSo6cfJYpVdGMHLGfWbul7cvAps4pQ62IqwhtGDLFnfJaldIhT+YaSELf/uMXGwqZA5b2iyGXE=
X-Forefront-PRVS: 083691450C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4324;23:F1TrQWUOe02mbWjSFD605bZO/zzDSWQ65o2Sc0jaQ?=
 =?us-ascii?Q?mF/B1mHpAOr1pn0ATchGzh5ffJken7RAOLWiOALNmLpYUQD2SqIg/o6qtity?=
 =?us-ascii?Q?Imi8T5CKf9Jda8QJSseHgn78C4g0woQZdWMwvE+4cwVuJk9XaXIEuP98B/M+?=
 =?us-ascii?Q?ahXJV6oUd5mSRTuEMbNJhLw7OESo1bqjIFX10JmWDXAJbLg/o0xx5UbM5aCt?=
 =?us-ascii?Q?4hzsxWXqyUmqPy46kfW1L8HcGxnovZYeAI2syjMnV9u81xqcprldRdmEPeho?=
 =?us-ascii?Q?0J6E8N0Lhl+ml1jG+F8X6k8G3dOTRpISkcFvmkFvkL5qvftKqbYjFWJdZ0oe?=
 =?us-ascii?Q?G2dSDK6eno3f4zZazWh+abD1aBk+pX4CEkliuUnxlM1dzs7T7saix2X6ujTT?=
 =?us-ascii?Q?YrYetXbS9qHzYHoiDSFjF5sLY4KdHMPQp+pvjq6Un5UK2XmqNTVN1f9leBXE?=
 =?us-ascii?Q?0mszvJ1+HqN1JweJODgPFfXuoCKv57W7TWwu2zbbblu9MsDIzhC8Sr0w/OKx?=
 =?us-ascii?Q?jHqnlmQyUV5jjmmSwQf6CFH0OqYy1zerM31yr/0PCd8DPYejLwLVgb9yFuGx?=
 =?us-ascii?Q?9yq8JBXCZEhrH+r+yk/r+ZBNLMN65dDrT/yB5ee6dhKiMH7hgf5BG7IrAFHC?=
 =?us-ascii?Q?Ae0oMEIjJ0NfNOAyq2OF5kE7gbp1xo581hIsk6xn2HYafRJrtuxbMqQpN3HY?=
 =?us-ascii?Q?whBSuGqTJTgrYuZagfe3yZoyoJDZ9AS7J6gzxSc0O9+LPbSe4H/N+VW4+Yc6?=
 =?us-ascii?Q?dCHFfQNCwVEErSoueEpQD+gxK9SaNfe7HrxK6AetmJLsPtLw7xisoF8JS3n5?=
 =?us-ascii?Q?4Ft4o4KGwHTWS/0ec00Xf4IEIkwSda66qL2cwk823O1mqF24wQ++R2B10G9I?=
 =?us-ascii?Q?evtTMnodN/bQxKwosrfgrGsQG2JpHrvadZ8Mm4fwhXKjKiwuUDq5k6YdsmSY?=
 =?us-ascii?Q?FdK6ONzE2suHAKWtHzsEzR4IUdEfmGNF0w+O/6L6fljtR/xz6ZLk1fVWj6bI?=
 =?us-ascii?Q?PCSLh7IS75J9S6ppkwbRDhlq0dD5YumBHjLSgxMMoO/EBYpOtnB/uXBdXOo1?=
 =?us-ascii?Q?jm1enV6/iy83g0mutbY3zV1VWKz5I2XgPpKhloAPQWZnMsQyUMfSircAwQ8w?=
 =?us-ascii?Q?Q8smoHkMegWQjEO7TwwZzbjmB9nrGg73uqtvo2mp+4ZBWLJ1V506DjqpwpxR?=
 =?us-ascii?Q?oCBtXCSJoZjPIvHqyyDPjw49TC6oNRERZmKfAUKwZQZeuaVnzkjyk38QkU2t?=
 =?us-ascii?Q?FvTI2zdXRzYcPGiLGFPR2EHvhZbGft39pgNhYoOG4LNgt1uzSgxDCMnc0Nhb?=
 =?us-ascii?Q?cvsZqvngzK0cYzqAmczGqFdKOW7jweWwU1aHMM75TkoA72mZvcpUCp5Wn9Rl?=
 =?us-ascii?Q?PhbOQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: RYpwh1Kala58t2IM+wZigV+qdmNQoc5wB687S0SiXg15jHgc5XS/7PKzA1GuTdvcuI/U9Q0cMrTJh8XfGOYXVbP2tyYCGqqYfXKJKDt8DUEMH8vVCZ0AdBxu+X8vZvDTKwSqcg74o5fRTV9PdZoLAHcv37LCqP3iohNTpovzzCldTaJo7q0aXmwesJG2VY4YR2C3rQVdrxqqQBegO/Oc4AxudJAP3aHkFO+MG/BQPEyHeiuB7uMM8ARraZAmQNUy2qVEhmie+AHTSdFcOBY2ly6s1QykL78Jwqv51DDJmws1WllYYw3ttZ8LWl/v7PSTDbqAFsAjPjpptoI0zSG2aiMFkwleG1sU3J8FUoa6eVU=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;6:Z7sDQOG64tdHwblEashmNum4NDlqQIXz3v9Erija7dTzLmap6dR4UsczN7szyzAG63+MmySmS3z96UJiyCxGFgnJtcV62SggjzdZBIcpl5PszZTdlfmQLf7m9vcLrREm1CdIpIpE8NtWbLCcTZgeHhFbW5K7TqzJu3/cDnt4UfwymoBCX9pQTbIzopgKDzKzYzFyNqSAIh+QHW7Vp9PXUIDDT+0smoZsZj2q1DNU7nBulGj1oQakPxnrCWHfh7kwyTFYdPxnH13bW83HTEsdspdPkPuDA3KT2c3hDGHsOzyJ+sDnEy7g8j1b+KHoMVHoUpx8Ya5EwZXNd42/koA0gR0d5j/EuGMh/HknUV3DtaB9qMDnbbV9KhhnDj4AugKZxERvigp9nQJklVCcwMa0IEyfCYthibSX3xic52JPpM3PoHbIp2pys9xaClKoAC75FOQ3EYX8+rooKD5QdikEkA==;5:8f1/BU/FuknXvodBd0xDDUYT6DdopwIcUyVkv3WQB39b8o0GpyemKRwNspEcHiTzbfbSvoJlOVeoJXgU9lTfBNA/sSr5VPJjuwYIBjyEWqFu4GQslLZfGyGUGmOl+0t0TT0aO3qeXG93ZdmiNx79QdN/Oy8ru+4Lgqyx0tW1m2Q=;7:xyQP9TB8cSVohvPG8g/K6cKawmWc1AUQ9sSwzGsCiP5mNYf6CXt/AaN+wHlNpqMIwJw0ULMaQj+aiJP98bIafi1A4orzZHI1WhqmqweA56jEqyXreDfYN7k8pzXmKdNo66kgXw/73rcuYSVtPmnfLZ5FmtId9031S+ixUCiSfhuMGTZ9EY9zjnWy/TJavibV2Ugh6NWTBNGv2qtemPhVR5mEGnnDBhljl6PFMtl0r5b3gj+5nthlh56SFsJiAqxl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2018 06:07:49.2746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d19e110-416c-4eaf-25f5-08d63a403163
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Error Injection for ZynqMP DDRC IP. For injecting
errors, the Row, Column, Bank, Bank Group and Rank bits positions are
determined via Address Map registers of Synopsys DDRC.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 420 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 413 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index e81f18a..2d26338 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -302,12 +302,18 @@ struct synps_ecc_status {
 
 /**
  * struct synps_edac_priv - DDR memory controller private instance data.
- * @baseaddr:	Base address of the DDR controller.
- * @message:	Buffer for framing the event specific info.
- * @stat:	ECC status information.
- * @p_data:	Platform data.
- * @ce_cnt:	Correctable Error count.
- * @ue_cnt:	Uncorrectable Error count.
+ * @baseaddr:		Base address of the DDR controller.
+ * @message:		Buffer for framing the event specific info.
+ * @stat:		ECC status information.
+ * @p_data:		Platform data.
+ * @ce_cnt:		Correctable Error count.
+ * @ue_cnt:		Uncorrectable Error count.
+ * @poison_addr:	Data poison address.
+ * @row_shift:		Bit shifts for row bit.
+ * @col_shift:		Bit shifts for column bit.
+ * @bank_shift:		Bit shifts for bank bit.
+ * @bankgrp_shift:	Bit shifts for bank group bit.
+ * @rank_shift:		Bit shifts for rank bit.
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
@@ -316,6 +322,14 @@ struct synps_edac_priv {
 	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
+#ifdef CONFIG_EDAC_DEBUG
+	ulong poison_addr;
+	u32 row_shift[18];
+	u32 col_shift[14];
+	u32 bank_shift[3];
+	u32 bankgrp_shift[2];
+	u32 rank_shift[1];
+#endif
 };
 
 /**
@@ -877,7 +891,11 @@ static const struct synps_platform_data zynqmp_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks		= DDR_ECC_INTR_SUPPORT,
+	.quirks         = (DDR_ECC_INTR_SUPPORT
+#ifdef CONFIG_EDAC_DEBUG
+			  | DDR_ECC_DATA_POISON_SUPPORT
+#endif
+			  ),
 };
 
 static const struct of_device_id synps_edac_match[] = {
@@ -896,6 +914,375 @@ static const struct of_device_id synps_edac_match[] = {
 
 MODULE_DEVICE_TABLE(of, synps_edac_match);
 
+#ifdef CONFIG_EDAC_DEBUG
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
+/**
+ * ddr_poison_setup -	Update poison registers.
+ * @priv:		DDR memory controller private instance data.
+ *
+ * Update poison registers as per DDR mapping.
+ * Return: none.
+ */
+static void ddr_poison_setup(struct synps_edac_priv *priv)
+{
+	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
+	int index;
+	ulong hif_addr = 0;
+
+	hif_addr = priv->poison_addr >> 3;
+
+	for (index = 0; index < DDR_MAX_ROW_SHIFT; index++) {
+		if (priv->row_shift[index])
+			row |= (((hif_addr >> priv->row_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_COL_SHIFT; index++) {
+		if (priv->col_shift[index] || index < 3)
+			col |= (((hif_addr >> priv->col_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANK_SHIFT; index++) {
+		if (priv->bank_shift[index])
+			bank |= (((hif_addr >> priv->bank_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANKGRP_SHIFT; index++) {
+		if (priv->bankgrp_shift[index])
+			bankgrp |= (((hif_addr >> priv->bankgrp_shift[index])
+						& BIT(0)) << index);
+		else
+			break;
+	}
+
+	if (priv->rank_shift[0])
+		rank = (hif_addr >> priv->rank_shift[0]) & BIT(0);
+
+	regval = (rank << ECC_POISON0_RANK_SHIFT) & ECC_POISON0_RANK_MASK;
+	regval |= (col << ECC_POISON0_COLUMN_SHIFT) & ECC_POISON0_COLUMN_MASK;
+	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
+
+	regval = (bankgrp << ECC_POISON1_BG_SHIFT) & ECC_POISON1_BG_MASK;
+	regval |= (bank << ECC_POISON1_BANKNR_SHIFT) & ECC_POISON1_BANKNR_MASK;
+	regval |= (row << ECC_POISON1_ROW_SHIFT) & ECC_POISON1_ROW_MASK;
+	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
+}
+
+static ssize_t inject_data_error_show(struct device *dev,
+				      struct device_attribute *mattr,
+				      char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Poison0 Addr: 0x%08x\n\rPoison1 Addr: 0x%08x\n\r"
+			"Error injection Address: 0x%lx\n\r",
+			readl(priv->baseaddr + ECC_POISON0_OFST),
+			readl(priv->baseaddr + ECC_POISON1_OFST),
+			priv->poison_addr);
+}
+
+static ssize_t inject_data_error_store(struct device *dev,
+				       struct device_attribute *mattr,
+				       const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	if (kstrtoul(data, 0, &priv->poison_addr))
+		return -EINVAL;
+
+	ddr_poison_setup(priv);
+
+	return count;
+}
+
+static ssize_t inject_data_poison_show(struct device *dev,
+				       struct device_attribute *mattr,
+				       char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Data Poisoning: %s\n\r",
+			(((readl(priv->baseaddr + ECC_CFG1_OFST)) & 0x3) == 0x3)
+			? ("Correctable Error") : ("UnCorrectable Error"));
+}
+
+static ssize_t inject_data_poison_store(struct device *dev,
+					struct device_attribute *mattr,
+					const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	writel(0, priv->baseaddr + DDRC_SWCTL);
+	if (strncmp(data, "CE", 2) == 0)
+		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	else
+		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	writel(1, priv->baseaddr + DDRC_SWCTL);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(inject_data_error);
+static DEVICE_ATTR_RW(inject_data_poison);
+
+static int edac_create_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	int rc;
+
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_error);
+	if (rc < 0)
+		return rc;
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_poison);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+
+static void edac_remove_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	device_remove_file(&mci->dev, &dev_attr_inject_data_error);
+	device_remove_file(&mci->dev, &dev_attr_inject_data_poison);
+}
+
+static void setup_row_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	u32 addrmap_row_b2_10;
+	int index;
+
+	priv->row_shift[0] = (addrmap[5] & ROW_MAX_VAL_MASK) + ROW_B0_BASE;
+	priv->row_shift[1] = ((addrmap[5] >> 8) &
+			ROW_MAX_VAL_MASK) + ROW_B1_BASE;
+
+	addrmap_row_b2_10 = (addrmap[5] >> 16) & ROW_MAX_VAL_MASK;
+	if (addrmap_row_b2_10 != ROW_MAX_VAL_MASK) {
+		for (index = 2; index < 11; index++)
+			priv->row_shift[index] = addrmap_row_b2_10 +
+				index + ROW_B0_BASE;
+
+	} else {
+		priv->row_shift[2] = (addrmap[9] &
+				ROW_MAX_VAL_MASK) + ROW_B2_BASE;
+		priv->row_shift[3] = ((addrmap[9] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B3_BASE;
+		priv->row_shift[4] = ((addrmap[9] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B4_BASE;
+		priv->row_shift[5] = ((addrmap[9] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B5_BASE;
+		priv->row_shift[6] = (addrmap[10] &
+				ROW_MAX_VAL_MASK) + ROW_B6_BASE;
+		priv->row_shift[7] = ((addrmap[10] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B7_BASE;
+		priv->row_shift[8] = ((addrmap[10] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B8_BASE;
+		priv->row_shift[9] = ((addrmap[10] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B9_BASE;
+		priv->row_shift[10] = (addrmap[11] &
+				ROW_MAX_VAL_MASK) + ROW_B10_BASE;
+	}
+
+	priv->row_shift[11] = (((addrmap[5] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[5] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B11_BASE);
+	priv->row_shift[12] = ((addrmap[6] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[6] &
+				ROW_MAX_VAL_MASK) + ROW_B12_BASE);
+	priv->row_shift[13] = (((addrmap[6] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B13_BASE);
+	priv->row_shift[14] = (((addrmap[6] >> 16) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B14_BASE);
+	priv->row_shift[15] = (((addrmap[6] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B15_BASE);
+	priv->row_shift[16] = ((addrmap[7] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[7] &
+				ROW_MAX_VAL_MASK) + ROW_B16_BASE);
+	priv->row_shift[17] = (((addrmap[7] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[7] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B17_BASE);
+}
+
+static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	u32 width, memtype;
+	int index;
+
+	memtype = readl(priv->baseaddr + CTRL_OFST);
+	width = (memtype & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+
+	priv->col_shift[0] = 0;
+	priv->col_shift[1] = 1;
+	priv->col_shift[2] = (addrmap[2] & COL_MAX_VAL_MASK) + COL_B2_BASE;
+	priv->col_shift[3] = ((addrmap[2] >> 8) &
+			COL_MAX_VAL_MASK) + COL_B3_BASE;
+	priv->col_shift[4] = (((addrmap[2] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B4_BASE);
+	priv->col_shift[5] = (((addrmap[2] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B5_BASE);
+	priv->col_shift[6] = ((addrmap[3] & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : ((addrmap[3] &
+					COL_MAX_VAL_MASK) + COL_B6_BASE);
+	priv->col_shift[7] = (((addrmap[3] >> 8) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 8) &
+					COL_MAX_VAL_MASK) + COL_B7_BASE);
+	priv->col_shift[8] = (((addrmap[3] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B8_BASE);
+	priv->col_shift[9] = (((addrmap[3] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B9_BASE);
+	if (width == DDRCTL_EWDTH_64) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[11] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		} else {
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[13] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		}
+	} else if (width == DDRCTL_EWDTH_32) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		}
+	} else {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[13] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+		}
+	}
+
+	if (width) {
+		for (index = 9; index > width; index--) {
+			priv->col_shift[index] = priv->col_shift[index - width];
+			priv->col_shift[index - width] = 0;
+		}
+	}
+
+}
+
+static void setup_bank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	priv->bank_shift[0] = (addrmap[1] & BANK_MAX_VAL_MASK) + BANK_B0_BASE;
+	priv->bank_shift[1] = ((addrmap[1] >> 8) &
+				BANK_MAX_VAL_MASK) + BANK_B1_BASE;
+	priv->bank_shift[2] = (((addrmap[1] >> 16) &
+				BANK_MAX_VAL_MASK) == BANK_MAX_VAL_MASK) ? 0 :
+				(((addrmap[1] >> 16) & BANK_MAX_VAL_MASK) +
+				 BANK_B2_BASE);
+
+}
+
+static void setup_bg_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	priv->bankgrp_shift[0] = (addrmap[8] &
+				BANKGRP_MAX_VAL_MASK) + BANKGRP_B0_BASE;
+	priv->bankgrp_shift[1] = (((addrmap[8] >> 8) & BANKGRP_MAX_VAL_MASK) ==
+				BANKGRP_MAX_VAL_MASK) ? 0 : (((addrmap[8] >> 8)
+				& BANKGRP_MAX_VAL_MASK) + BANKGRP_B1_BASE);
+
+}
+
+static void setup_rank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
+				RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
+				RANK_MAX_VAL_MASK) + RANK_B0_BASE);
+}
+
+/**
+ * setup_address_map -	Set Address Map by querying ADDRMAP registers.
+ * @priv:		DDR memory controller private instance data.
+ *
+ * Set Address Map by querying ADDRMAP registers.
+ *
+ * Return: none.
+ */
+static void setup_address_map(struct synps_edac_priv *priv)
+{
+	u32 addrmap[12];
+	int index;
+
+	for (index = 0; index < 12; index++) {
+		u32 addrmap_offset;
+
+		addrmap_offset = ECC_ADDRMAP0_OFFSET + (index * 4);
+		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
+	}
+
+	setup_row_address_map(priv, addrmap);
+
+	setup_column_address_map(priv, addrmap);
+
+	setup_bank_address_map(priv, addrmap);
+
+	setup_bg_address_map(priv, addrmap);
+
+	setup_rank_address_map(priv, addrmap);
+}
+#endif /* CONFIG_EDAC_DEBUG */
+
 /**
  * mc_probe - Check controller and bind driver.
  * @pdev:	platform device.
@@ -963,6 +1350,20 @@ static int mc_probe(struct platform_device *pdev)
 		goto free_edac_mc;
 	}
 
+#ifdef CONFIG_EDAC_DEBUG
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT) {
+		if (edac_create_sysfs_attributes(mci)) {
+			edac_printk(KERN_ERR, EDAC_MC,
+					"Failed to create sysfs entries\n");
+			goto free_edac_mc;
+		}
+	}
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "xlnx,zynqmp-ddrc-2.40a"))
+		setup_address_map(priv);
+#endif
+
 	/*
 	 * Start capturing the correctable and uncorrectable errors. A write of
 	 * 0 starts the counters.
@@ -992,6 +1393,11 @@ static int mc_remove(struct platform_device *pdev)
 	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
 		disable_intr(priv);
 
+#ifdef CONFIG_EDAC_DEBUG
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT)
+		edac_remove_sysfs_attributes(mci);
+#endif
+
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
 
-- 
2.1.1

