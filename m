Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19926C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE09A20868
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="37KdoiGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE09A20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeLAW0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:26:10 -0500
Received: from mail-eopbgr700084.outbound.protection.outlook.com ([40.107.70.84]:64747
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbeLAW0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9ZuiERyxY6/S8X/sgZVSpcVPHDruHemBriWRmnOye8=;
 b=37KdoiGmJUvCAEkdH6a/TUTSjnR7W8bIJpKVDDYqNIpuQwMtC7meLTRCNRRt+rSJ6a5HNJ9v3LMt2e27nGQT+AXSLOyBzD64bVoRHAosPwVQhfMc5D3jF913vQUXkgXKDOTBKNcirVRWA6F7xxE0XL+zHDxp6N9bmmoOKlLjcIY=
Received: from SN4PR0201CA0047.namprd02.prod.outlook.com
 (2603:10b6:803:2e::33) by BL0PR02MB4324.namprd02.prod.outlook.com
 (2603:10b6:208:40::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.21; Sat, 1 Dec
 2018 11:13:45 +0000
Received: from CY1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by SN4PR0201CA0047.outlook.office365.com
 (2603:10b6:803:2e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.21 via Frontend
 Transport; Sat, 1 Dec 2018 11:13:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT005.mail.protection.outlook.com (10.152.74.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1382.18
 via Frontend Transport; Sat, 1 Dec 2018 11:13:44 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DT-0002W1-SP; Sat, 01 Dec 2018 03:13:43 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DO-0001kp-Ot; Sat, 01 Dec 2018 03:13:38 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB1BDYir015255;
        Sat, 1 Dec 2018 03:13:34 -0800
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gT3DJ-0001jk-Nm; Sat, 01 Dec 2018 03:13:34 -0800
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id E52D160503; Sat,  1 Dec 2018 16:43:32 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        <martin.petersen@oracle.com>, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v7 02/10] usb: gadget: function: tcm: Add timeout for stream capable endpoints
Date:   Sat, 1 Dec 2018 16:43:23 +0530
Message-ID: <1543662811-5194-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(39860400002)(376002)(2980300002)(199004)(189003)(186003)(50226002)(8676002)(81156014)(106466001)(8936002)(81166006)(110136005)(54906003)(336012)(5660300001)(76176011)(42186006)(316002)(26005)(16586007)(551934003)(356004)(478600001)(6666004)(305945005)(90966002)(106002)(36386004)(51416003)(63266004)(7416002)(486006)(103686004)(476003)(126002)(2616005)(426003)(11346002)(446003)(2171002)(6266002)(107886003)(39060400002)(4326008)(48376002)(2906002)(50466002)(14444005)(47776003)(52956003)(36756003)(107986001)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4324;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT005;1:LUHWffkwBVXWGm0P4scUkzqdCKbBmsRmkWyL3cxTdb24lrO/gcMQ0mkHHL2I99wovS6hPU+OhV+St3lJgpy6qNc+i0j0onW3rjCtSvsJHArLxxYN0Lj/zR6jM1ZsGUUI
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b528620e-fe38-4945-c401-08d6577e0f50
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;3:/+TcCou8keDNZCHbGoXZKzo5RaCiy7TBgEqWu6oM8g8RdliO6oP6/kfJUvEeU1fM6PKzc3KFRABVN/fFGkeWn2e2eMFLwbWktpX8gDkpULZy7I0k2YGDVEx5CrpceM4MysCElrCSSCgALLvjnPYUCGX4SnzxaErsJEh0UG+MRkH6pe3Zx2Km/eGpIUal4KQC4ofN129MHyvNU5MU1fxp9BPGBxpFyPfeYw7CBM5UT1LRd+qPIktN4JfJTOUz+PrEbmweMknfLND/4BGeHNwbyM2K08AGf94nbm6ZZliYSDXy9aieoYhtkq54TwJjWBdySSKgyQWGllukJ9f/F3Rufr+9wTtrsvAljdF1ZYFTVVY=;25:3CtCrQsQzQOQ134kqlFyLYdW5io4O+9IZCnpLKOg5pJnitpxfzW/ffVeE0GomyfmgudY+fVuB7McrLb/7Ai04coQTOzTh3jVvNZr4GY5cdhaXsGY6M4dC/VcZL2ORDmqmPlpME6Nm1elqa6v1uGSb+6Oge1DU847vAAX9kZOAIRwueZ4b4mWrJkh0EZH14lIAGb3u9UG3er8o/d0zaHdYZ8/SxQBSPc77G72ldCv8kBneu01HIzNBVU3Qmo3iR+UwTCHnoTwX6ESZM0XOr1s4H7WteCtsM2dsvK0Yu2BCHkNkjYve/NpAnBwWftFXTmu13jXvM7V34djOlig2x/3lg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4324:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;31:cXCHoGbtDtTokfIDAV5KnVdxfy4Lkv7T3JfNTwwUva4Upglx7GR1C5gKXiKwsr0DEHHjXv5OQ9KEGsyrUiQ7r3UhdRQzV7kw0+LkK4+I7Yb9HRpUQDh0IKnnsJCniIvnlM4o6vt6LXQs4UT4xssx+QHRNVgv0lGueJhdXXHlowNH/Mag0Uf4DJsqsARYQFMrwBS2+540vreurGwbaaxlVh+/fFDt34hXf0cu0jav2yA=;20:oY6yM85OMpHmujtMQx++T3N6nLF4p3vGc/+IrGMvTYKrazzXDgc4khYpIv40GeSOhs5j1TTiiFsdbfMcnCjsgylqWit+wdkFHpO6YLmFxHpmEN5l4DxjxGQA9NzmTdwGyQlFifyJmdON81YfwVCsV4n2LQ9Bg4K8YecO25fChh9VOknohph0tRnGx0BMzkBK5T7JrRjc/hHMRwGaTpTkulh9fkWiHnp2W8MDifTYX7saVZNrzoxrXhd5PnS32oEUDH/euFl+G2YOoPhonaosXyluubO0CxZIMAGcvbkTe5zO0xeJRLwSp8trmpb5mxcpV+sO1M7L3St3DnHSz2ghDiKZmFwLCj5r1lzQD7xXenwYDHtO7OKSjzF2xBjd2Ex8i2+UQuaka4eIvmsYJDVkvLbu+tqKmvgne2eEs6rp6c35N0o9PKVjq/t0DIn16OtDKbD3++JsFtljkRdNPqYTOxyFyzK13pMIwK0/0dAPfzW1tj9JP5qtLmAcpnoa3XwZ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB43247F70B6F49E84519EFD94A7AC0@BL0PR02MB4324.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231454)(999002)(944501475)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4324;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;4:KhFbqp/z+fvrHwsqwDzCaZw7nutWf1SAf/mU1p1D7dZiD3Yi8oHLZhQduHxSSMDLLJycWo+Zoo2SYjpcQUvl/K7rWXNubXFlCuO8TnZgMtaQ4T3I40cypmWmIfuldl3OFRrLAST3BTuR8LfUQtEezIBWN4cIe8y5ZMHWHoc385zNge7wDmQqPeidUlbtVQQGoL6BrFARdfc2PL35mHF6Xd+XM5+GypH4hhrP8mkKmyP5TZpIXUqu958JqG0gpSrowV6MGpo/VI+aPtpIEwZOLA==
X-Forefront-PRVS: 087396016C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4324;23:/2iJ02CBRdh+uBFtZbTvCAtjcn1Q+DP7jSE/s9KLb?=
 =?us-ascii?Q?/ltzGj/xmTNUteSE9hBUbb2g5VDJDfVFim6vrsVHvRPWnExOsqmORgW2G4JE?=
 =?us-ascii?Q?84dhlyod/fXAHC4KvWnq2b7foX/ifukiNO/X+PJsVUMMRw0ztWHOIZmEsj9A?=
 =?us-ascii?Q?XIGTlxgMJtOL6tAR3iypp16z/PJ+Hf6yzZEen9zRy0RPDfWxoMRV3jiJ1F6l?=
 =?us-ascii?Q?Y3vItXsm4CuBnOyj7uO068BbFf31Nh1L8sWjNIKdF3EU+MyuU8Z6YUcr8wbS?=
 =?us-ascii?Q?qAGiAZ78kUdKWCXp+LcfLef6eMJbxtixLwLDhBOz2Hz6AZ4DHbY25jdB/rAi?=
 =?us-ascii?Q?rqhWr9nNc7mCzV47wsgrr4D7LgR5sj2+4B6LPYMKkhEiaSs/rZhP9U/aBxc3?=
 =?us-ascii?Q?s31/GyqFbvIM482wEdFsBkl7EWqNbymPeNPMm1x60p4tjdJxhULHv1ZpytgZ?=
 =?us-ascii?Q?1D3d8CMbnf547yq5mYKUvlg+b58pVI/G8cu0QrDygFtgPvGdXZkBiUfA2Tx/?=
 =?us-ascii?Q?jvhlwjrZAkhOQZxYlLVTerEohqn4m+/c5eGV3kj22THsR6L1HZP/rA3ebc7x?=
 =?us-ascii?Q?de8szhdDjD1BEQqN9tXYKrs+/nM7oIxoXKLEshDKTaw00cxI+hNOyIC2fBoq?=
 =?us-ascii?Q?aZSY/IYQ6T/fLTB36w1zFYQgN44eIddNsZF/A3aTHZFaMH2KWiQsLxyffvEx?=
 =?us-ascii?Q?tM2tHqk6Sy4SU5Y+7YXt/om2gscW2jqdvJmwVOVIhSWksE/aMZFmYqoca84X?=
 =?us-ascii?Q?+DfuN4R0EDMn9ZgZIlSTnmTK1HyPokMu1/sQvusWu0IIWYWItDxgc7iXukf6?=
 =?us-ascii?Q?k/NxFIsP6oACutMR7sktVF8i7LvYFtLOMAGCZ3taKRuDHZY1LdD0Gmd0Y6ns?=
 =?us-ascii?Q?Stipq4JMAagF5efRoNkZhlEqtbU/mHmP+9p1zIrejkmMAgrUEcEEDfOh5JaL?=
 =?us-ascii?Q?RW+QN2chqXCR1jgZkoYNy90tp0S19dDUCUTDNlATyfuZ2kInXgaSJhIf9Qfk?=
 =?us-ascii?Q?XpQEL1syFU4QEPo0XSOiCk7rHiEM4DoVwnx/SNJj/exkR6ACG8tjLo/H63W7?=
 =?us-ascii?Q?UbKytZvwVxwrM63iA4xWpn5U6Z/QMRVkPJ35bSNb8NXOqrvpWASAssqu+mBi?=
 =?us-ascii?Q?3+Fq/PZR7j8bzcLz/KabSijkLm0I7+37ZvGkHhVDpHre5yH/d38KvEL3SSDr?=
 =?us-ascii?Q?sa7leVAvxk5xRnwhhZ+kmjqyLNZQUuvtBqkvwk2k7I/NMQNpd39jmi6IVgq8?=
 =?us-ascii?Q?NTnTwQuAmg/Rz/E1E7Dc+WicYAfBZvykqkDkdrqf2AaSQ7DRSZf6g+OHQ8hL?=
 =?us-ascii?Q?ILci8VK66/mdDwrL3BtN3U=3D?=
X-Microsoft-Antispam-Message-Info: ee40X8w7FLgMz8mKJM2aWg1VPUUBnOsovxqJuvuMYfOg8jL9MUAvGt1E0c38wutcmaMBIoo14siooMflKK09Ab+1ZPC4CKm+QlvSU6intOVLpkEkJlCp6i4b5RWVria0WAlO0jhwySK69wzbGkmGw6DbFD5sUHr32LdFfuG6rvCKnL2TuenOsfzpCSnIv8TIltROeV2WLkvlkwKzQi15GZJzCgIw4GQ7hVPLciWpstqhEyaTvywlO2+IT+KBHe7JXsSqV8NIJiGYpXO6ulYoSeLGVU9ZepflEyN9ImwUCI6+J2jE+XeS3rWaEs5MFmQPaNdOItvkiuxA7JRdoJQ3FmaE9EYwyahTtzowOUhDiC8=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;6:hlT83cTZJ4psqv25jPTsLelcYyMnUHOx6kvJ0Jt7xtaDQPU2Vxh/EZWkn/0xpWttBjw/y+wKNk310581XZu12SmA/EW1XsqVrxwy9tUew5SsIIrUaOFvABmVeJ+g4VZAo3l39vrZU7X0Nd4jmD8tlM5Z4t+xinsRlqhm+Q/OfwAByvyo3g9FFh8BuewVDnhh/b/BAjDJt4AE2xZaFKk/Rv1Ny3hePDjA4Gxks1g8oscWKHlRt2tt3FFFyQtfnqgzFnUNUVHyJnTQkmQi7lUS6mcrxKLAcARi5aZyfAJ72sDqWzKV3TalxoT1acGv3trrrngm9DgMSA64y1lebXG3bU960DIwokEiuY/VCITzUfAaND0S44JGAkYyx43QkLbaOjFOez5FPt7lQvHgCC5voBWQP2XE9ApfIeOeO3YxyJaFve3pK/1ecAVd1ChLpMFB4W+lW0nNytCQtY3ke7Ko2w==;5:S6xyFfBOnnkwEbMqqKx6Yo35FXn0qBCnhiN5hXKVEEb0+RHcqUhq/TELy5JGr11FdWOwzGWkWXdrm94NJCi7wfyd1TKvtIT4ZYycZw5iVuJ+dnigkq9zIPwWEPZzgObmADfycYH33/ZJdUmhx3RwOBHDa6HvcqV1i20Rv3rQb/U=;7:rU53NYoPRlHI7MHOfVI8wHEFuQom0/6iC8R4bhT49IB0NC5Lf6uQ7ojAPBVp0MwqWYLlbceP8Emor+0TCAlT+Vh1LEX4+Y1Tf/5/ZLWJ0upx2I+PQs5xhmwfi5/5YzZRYv64F2thonpmT09zaVu8LQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2018 11:13:44.3325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b528620e-fe38-4945-c401-08d6577e0f50
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When stream transfers are enabled for an endpoint, there can
be a condition where the gadget controller waits for the host
to issue prime transaction and the host controller waits for
the gadget to issue ERDY. This condition could create a deadlock.
To avoid such potential deadlocks, use usb_ep_queue_timeout()
instead of usb_ep_queue() for stream capable endpoints. The
usb_ep_queue_timeout(), after queuing any request starts the timer
with STREAM_TIMEOUT_MS timeout value for the stream capable
endpoints. The gadget controller driver is expected to stop the
timer for every request if a valid stream event is found. If no
stream event is found, the timer expires after the STREAM_TIMEOUT_MS
value and a callback function registered by udc/core.c is called,
which handles the deadlock situation by dequeuing and requeuing the
request. This kind of behaviour is observed in dwc3 controller
and expected to be generic issue with other controllers supporting
bulk streams.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v7:
	1. This patch is newly added in this series
---
 drivers/usb/gadget/function/f_tcm.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 106988a..6eaee04 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -27,6 +27,12 @@
 
 #define TPG_INSTANCES		1
 
+/*
+ * Timeout value in msecs passed as an argument to usb_ep_queue_timeout() for
+ * stream capable endpoints
+ */
+#define STREAM_TIMEOUT_MS	50
+
 struct tpg_instance {
 	struct usb_function_instance	*func_inst;
 	struct usbg_tpg			*tpg;
@@ -575,7 +581,8 @@ static void uasp_status_data_cmpl(struct usb_ep *ep, struct usb_request *req)
 		ret = uasp_prepare_r_request(cmd);
 		if (ret)
 			goto cleanup;
-		ret = usb_ep_queue(fu->ep_in, stream->req_in, GFP_ATOMIC);
+		ret = usb_ep_queue_timeout(fu->ep_in, stream->req_in,
+					   GFP_ATOMIC, STREAM_TIMEOUT_MS);
 		if (ret)
 			pr_err("%s(%d) => %d\n", __func__, __LINE__, ret);
 		break;
@@ -584,15 +591,16 @@ static void uasp_status_data_cmpl(struct usb_ep *ep, struct usb_request *req)
 		ret = usbg_prepare_w_request(cmd, stream->req_out);
 		if (ret)
 			goto cleanup;
-		ret = usb_ep_queue(fu->ep_out, stream->req_out, GFP_ATOMIC);
+		ret = usb_ep_queue_timeout(fu->ep_out, stream->req_out,
+					   GFP_ATOMIC, STREAM_TIMEOUT_MS);
 		if (ret)
 			pr_err("%s(%d) => %d\n", __func__, __LINE__, ret);
 		break;
 
 	case UASP_SEND_STATUS:
 		uasp_prepare_status(cmd);
-		ret = usb_ep_queue(fu->ep_status, stream->req_status,
-				GFP_ATOMIC);
+		ret = usb_ep_queue_timeout(fu->ep_status, stream->req_status,
+					   GFP_ATOMIC, STREAM_TIMEOUT_MS);
 		if (ret)
 			pr_err("%s(%d) => %d\n", __func__, __LINE__, ret);
 		break;
@@ -622,7 +630,8 @@ static int uasp_send_status_response(struct usbg_cmd *cmd)
 	stream->req_status->context = cmd;
 	cmd->fu = fu;
 	uasp_prepare_status(cmd);
-	return usb_ep_queue(fu->ep_status, stream->req_status, GFP_ATOMIC);
+	return usb_ep_queue_timeout(fu->ep_status, stream->req_status,
+				    GFP_ATOMIC, STREAM_TIMEOUT_MS);
 }
 
 static int uasp_send_read_response(struct usbg_cmd *cmd)
@@ -640,7 +649,8 @@ static int uasp_send_read_response(struct usbg_cmd *cmd)
 		ret = uasp_prepare_r_request(cmd);
 		if (ret)
 			goto out;
-		ret = usb_ep_queue(fu->ep_in, stream->req_in, GFP_ATOMIC);
+		ret = usb_ep_queue_timeout(fu->ep_in, stream->req_in,
+					   GFP_ATOMIC, STREAM_TIMEOUT_MS);
 		if (ret) {
 			pr_err("%s(%d) => %d\n", __func__, __LINE__, ret);
 			kfree(cmd->data_buf);
@@ -686,7 +696,8 @@ static int uasp_send_write_request(struct usbg_cmd *cmd)
 		ret = usbg_prepare_w_request(cmd, stream->req_out);
 		if (ret)
 			goto cleanup;
-		ret = usb_ep_queue(fu->ep_out, stream->req_out, GFP_ATOMIC);
+		ret = usb_ep_queue_timeout(fu->ep_out, stream->req_out,
+					   GFP_ATOMIC, STREAM_TIMEOUT_MS);
 		if (ret)
 			pr_err("%s(%d)\n", __func__, __LINE__);
 
-- 
2.1.1

