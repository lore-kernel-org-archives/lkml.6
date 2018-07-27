Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA951C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575BA2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NeAAEhs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575BA2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbeG0MMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:12:24 -0400
Received: from mail-bn3nam01on0055.outbound.protection.outlook.com ([104.47.33.55]:64475
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730488AbeG0MMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs1IyQTyoZ1A/wqyUJcYIyKIYRmnqjAjQpbB8W4/G5U=;
 b=NeAAEhs6Isrbp6LFitsULhsHIiD0eJFUgWegbjMW7i6+4dusCSb8sjsTRDQTpw11rM0Hzvfwugr5aSr6MoTvgQxwuAFkC+wdR5D88qSWJMJ2BS+bCd1s2iQiFiWbJLkKdSFgrNEzMSCPtw5OWntIdlGP7JFhfW1O6oTNWSooq1I=
Received: from DM6PR02CA0012.namprd02.prod.outlook.com (2603:10b6:5:1c::25) by
 DM6PR02MB4330.namprd02.prod.outlook.com (2603:10b6:5:2a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Fri, 27 Jul 2018 10:50:55 +0000
Received: from BL2NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by DM6PR02CA0012.outlook.office365.com
 (2603:10b6:5:1c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Fri, 27 Jul 2018 10:50:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT043.mail.protection.outlook.com (10.152.77.95) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Fri, 27 Jul 2018 10:50:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fj0Kh-0000O5-F5; Fri, 27 Jul 2018 03:50:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fj0Kc-0001O0-Bn; Fri, 27 Jul 2018 03:50:46 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6RAogR6011880;
        Fri, 27 Jul 2018 03:50:42 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fj0KX-0001NR-Rc; Fri, 27 Jul 2018 03:50:42 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 0B88AB2085E; Fri, 27 Jul 2018 16:20:41 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <dan.j.williams@intel.com>, <vkoul@kernel.org>,
        <michal.simek@xilinx.com>, <appana.durga.rao@xilinx.com>,
        <lars@metafoo.de>, <radhey.shyam.pandey@xilinx.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] dmaengine: xilinx_dma: Fix 64-bit simple CDMA transfer
Date:   Fri, 27 Jul 2018 16:20:39 +0530
Message-ID: <1532688639-32230-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1532688639-32230-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(438002)(189003)(199004)(7049001)(4326008)(81156014)(81166006)(103686004)(6266002)(8936002)(478600001)(2906002)(50226002)(5660300001)(48376002)(50466002)(106466001)(63266004)(8676002)(36386004)(2616005)(36756003)(2201001)(305945005)(356003)(90966002)(47776003)(476003)(106002)(51416003)(336012)(76176011)(54906003)(110136005)(26005)(52956003)(486006)(126002)(42186006)(446003)(186003)(426003)(16586007)(11346002)(316002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4330;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT043;1:5SfwZR536Kw/sZhxqEaHzJ0/UEznqLMRgpxnq/e6SVU2JWe+tfPkIU0rpprDU8aQgV1vWwbpX6ydPYJ2XnjjgtWlq167LCBW5pGNbx8HQYx5YL5zLh3rdhUTIfup+VPn
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b7346ea-1de4-4f10-0e8b-08d5f3aed3a8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4330;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;3:rQGecF/gEllyOaiacgCIQ2ahUsk14IkDesMQG/xNWkGLozBxfofHqwEdbmC1xsTlb+0cKno0INckHHCGus2XIAm79tBMZuL9zdwMjT0WCdcHWOVk7YPLdxNY1aEJ46lptrJVldFeLvhPYm/MsDE/5bhWGSiaL3Rnig9hm7mHRrru2ygI7iI1I423q6KVfxjQlbw65WOc1tDTxfC/SlJSa4rCYnAafsRWBC12g4GBQw0AGKVPRDmdNcAScMuTtz16cBVk9Zvrg95gSGrNB0+ATdsQ0ESnKktqrnO93EqtQPhfy8zFWnKsVXenN8DkVK1eKfeWK0nD92e3Hw7zUVUFI+Urb5gcgtZTymvnqtr8G9k=;25:gL5389jntMuXZ+pFLehWDWmMboooRXHkS+I1cUYa/CmLl8N6gPVyCzl6Ne8SN1QX3YwcTo3wD/eDKNJDvC5ELHofMy416nlX+lX8WBJ0QynJNFRbGUnSRcpqL8yC4LzWcZCly0MxUnNiTEKT7KMXvCjOjYvMCfTgjmY46JP4KaWm7SaK7CDnpbkEaibH4ccxhwK+iNI88cgbKlnP81F1SzuztN+FueldXUe06c6dGq0gTXplme2JaNGya1S3q+BO4vaBINXh+y1ouczV3CNT/P9xGi8+UKDbY96ZwtMX5s9qlqtnyBPjxno8JVPurLcK2gJ/T2BYMdek7SUjFrB7Xg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4330:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;31:q50ufl/+vIKyiWSofIVIGJSjU0p7V7Mdnq5mWSitiTX7iIxhBrS06cCD40N0XXfW6aFOrLw4qt4NGorzC4y1ISHeMrCD8m9cJ8n3qw29XfMiqRIO1gsFfg+pCd9IRldl7xdDvIIQPAhnXtUxoJBi629+IxfLDGWv2sNmD846RXsu0p5kSopi0EaNuQ+s6TexiQYIxjg0mJlJ982SbJdgQuvS13tNOBIi1hCw1eIqkgM=;20:KC8oa7c4w4pr89b2AVBnF8kNyeLKAwTC95Yc3SUAfb9ridGwR7c8b9+4QDIXDaL0nlRFrTzNZ5B3V2rwIvAhxgjPAmoK5630CNALBH4SunjMwEuqyVThViFDIBgWPQIenyfujO4H2EfaKvAdo5m2NQpZ+CUYBPMP3TKss+UoKizUg96R5Kr03YsyK7coU18U1qRDSELUSsoSoCvD/sCbvNALv1wwkQwPf8VR4TNBfxHfw+bjFuKExhtKasbLI22Ijl4/PuG8o/USP+49MRUmiTPkj/3Fhaffr6wG80qmD7yHA9Ramkkci23+C48AS4APqNow8X/5WexK4kak/cJivIaB+xla7iQkvkRZc4r1HhIOZSruN4Ad0/4VQzU8/Epi3wejW+ti00Is6paxcjyn2q+qjU8MXlD9fWUmogT0wbRZqDbwfVqb95xrKY7567T/XsXeViEOqSFB0YT/MXCrnK7MAhtECBPCTv7rKCzqraQ4Q8LToInhGarfMjzTg1zm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4330D39CAFF50C4B21B29C59C72A0@DM6PR02MB4330.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4330;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4330;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;4:+vgI+LPxXeHJiStKCvxnSK39jplDNYvAO5SOn7xAS3yxbbBK1/h50L02b8v6aIV8geaCxMvbWDHMbw87yhO94fB+ZKHRxFL5G4wYujoY0V1YbhPOZ1rdOxWG2c0tgX8jX5ibwSFZb/4/a4jlX6rmO5kH5ERUdyFjOdf+kXgTBup2wUO21ZYU5nQjRzcnyuxVH7xdPxnjTklx7pkK4GSCXi39TUCg2XgSkzc9fWg0yn3anDhZABKSOhuKdwZ6+Zth2ZlUMskK7gQFeDVTRSDaEncgG7UK47mG2RM9jZ8x8yYRrZOJM9Xq0tbUYI6dTsxm
X-Forefront-PRVS: 07467C4D33
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4330;23:U8q/bmdJsmJKqD/CDNHofmVLKhnx6/0jgZ2CPmdlj?=
 =?us-ascii?Q?LCp8bB3eyTPEoxYZTa6+Irn3Xy/bu/w9FzI18w1k7/lk9Kj3UwC/dXKREdu9?=
 =?us-ascii?Q?eYiDttow7nSOyt/YNdCWkT0fHrG9FaGRxqZzz63vlSYm19DF1+mElOO3zYZE?=
 =?us-ascii?Q?nx8kb1lsJMrE2eiKCnzdpjbQ7k1N8PmjmyyFxMetDia2RxCouJSP4kF5fWvz?=
 =?us-ascii?Q?a6XO1BcKcWjnRCBCXeW9thyf/VTkWljWykYxPlj9lHaXV/YCYrmFLKLrzo++?=
 =?us-ascii?Q?0Rh8o678j1NwLUZbyAm1t5UKN4lsds74HUDj9D7uxdIe/3ltrCXIUbLQNUBt?=
 =?us-ascii?Q?FXixFu0iWrYsbeUdZNBZaPMhN2vKgNVxKu/bJVZz0qafBfxdk6+xcgfBy5B2?=
 =?us-ascii?Q?Uw99A0nQ7Bdou5ssFr+ZFi6zYId1FHU6P3NtiTYaYoz2PgeXeD0sUMpeYIA/?=
 =?us-ascii?Q?Vd8eUOJ5AwptyWZGJOegR7Lnh7VnS3g8g03Xp4E6tef3vuACgUfHOjNmh1P1?=
 =?us-ascii?Q?FAALy/UGDElI8yiNHpy6qvXdd1Ez5RDcy/lP2QsbccuEfNt3hi/KRYbjWJ6p?=
 =?us-ascii?Q?shoSxcwn1aYRZv1a6QD9vtI2cvhDGf4T7iCYZJ7kkWw/pJ4Kpe/BiLB5ByBU?=
 =?us-ascii?Q?rMXlZur5u5m9xsEGFHvWlHQXyd89e9S5TksXfj0Vf/oHYCcy2S5YqMf6jZPi?=
 =?us-ascii?Q?hhCLMd7fa8QobtEzt/TK6icrakvF2chsG1V0QilAt7FnQT8VNxGb+TjY9Z/p?=
 =?us-ascii?Q?QbVgPIMNh4WRBXQAF0xWz0+SeSwS+CtWM+dwkPJx1itIXTn4nz99+XIQ3MQX?=
 =?us-ascii?Q?pb/IjxIQVzSXOGAGeWzOJ5r4JlJylucrtt3Lfb+OMu/OQ7pGqrYIUU+CnVx2?=
 =?us-ascii?Q?2K1c7qviOxYQMk+lTKjtJ3sPryk4FtSDjrdXJy0C/r43BZKER2nKXtEqvdSQ?=
 =?us-ascii?Q?DdKP3dhYsNpB5P4fWzePIDMW87jSR1qwF+5NYtdNnVPKnNEjd3borzXlrlcR?=
 =?us-ascii?Q?CZ+H+LY3BHLFeQaUkzj+d6V9x6mU7ogL0hAGPRCc1CsPApBayU0etMqV0u9h?=
 =?us-ascii?Q?WapHs/gCcyT4P5np+M+3ASliHsK8XlolKcndBfhG0xvGiGoSJ9xbeIX5tSpC?=
 =?us-ascii?Q?JdloCUN3hxkh7DvzuZYZziTcxAooGof?=
X-Microsoft-Antispam-Message-Info: BpEL3BN1aHGftpJ+vXJEQ3b1XEFAx6ZRN5ZnhhoNWO0mL8NGmTXb6AKiRnF+dKXQ/nR2cwgeTIT+I8hxlNyyfMlVDczIOdc5utbKoA1XoF6NGT5iwRw5OCc6CrOxqphDNUbJ9a5dXOSiMK6IVZ6t5TKBV7Tl/8J895ZxDvuOCAGUY5q4JjhY+XyV30VRu2x2O7KaXwV6wjjs70fkIxzr/ezgJCgcERiz153v/rNR5QYhQwu+6CGK1Qqz4W0ryAnlFTBg5ZLPvUAyHYultPlSLJIumQEbvfcRE4n+eed7Vcv7gZ9guBJE4ZbSpxzGSPnQE4huFxE5Zv+r548qftFJpYuz+n0ncziNgKnpiCXKbKQ=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4330;6:4NPySRpmt7oe7EQbonk0vIlXam4KLriVXBIeW2KFOfrg6PcfWM7yg6oaNkYN+4pIEym3GsWJbF8RpJu4kSzxK9vOvuR+oDa7vcE4XP6F+/hcDiegj4LNnRs+C2iceIbML2ECrgRKyi82FNeWoxRGTUsx2FhRg/1B8s/f3AsBooBcFqs5R1rOUt2Q9u97OjXFiJX4ZnpBrpXD+0qB0AgJDDQHKFZODjh9GnSHjYWYwcaCDQ42DS9kbPMUVE2q3UTbtGmjobH2GaLOmBV5tCE2bnK0FBqTwWgx5lXyj8Fh7rXViasBpXuQIxcTy0OlowdZpeuC4hOllvPNfX1vnAw2A78ORe+3aFyw0eYoTYQ4FACofrEjSYiszU5GXC4a3I2Hx+rFc2OcymjwU70iZuAXgA/hkZ37tEKxMZTKO+g7cppyijN3iy0SP5Wo8kTVfzJi4b/F8WWk5EaqdHTgK/ax/w==;5:up4FbBP5VUazbQiI+6pbLjcWY0ZqN6BRvxzUGXuZl2AiSRGodMQBS+a0MP8ZG6VUrFRK7gIPOUMwrZQsKBKUJUQpfAap+ndFd8vH1eD1b9HYvsZMT4R7tV5BkEzPhe0Aw8BXR9cIAqdyFbMqJ2tyHofN3E9RakaVAGxGDSEu5J0=;7:eNVl0LQbLwYd34lV+dBgZh5bZ5IpXambKA89pcUIFJ4kAd7CYSsE/Zze0TGl2h85try/ZQj5SLbzMGlY2CTrF21ywZhmdxCbefUJ9FBLorRQK5JBGND29ueZ3Ggx+t0RF3WXb89nwfdb956Bal6f3gnqokHa50/UzwQffVhBzyoPye4/+VVdZtHOiB9ZWbsCP68/dPABjjY/eb1ZM/gIxVm8ehl6LRrvQvNpkvHc20+lV/XG3l2ARJFTOQJER3J9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 10:50:52.3635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7346ea-1de4-4f10-0e8b-08d5f3aed3a8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In AXI CDMA simple mode also pass MSB bits of source and destination
address to xilinx_write function. This fixes simple CDMA operation
mode using 64-bit addressing.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a37871e..2e15d86 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1245,8 +1245,10 @@ static void xilinx_cdma_start_transfer(struct xilinx_dma_chan *chan)
 
 		hw = &segment->hw;
 
-		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, hw->src_addr);
-		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, hw->dest_addr);
+		xilinx_write(chan, XILINX_CDMA_REG_SRCADDR, (dma_addr_t)
+			     ((u64)hw->src_addr_msb << 32 | hw->src_addr));
+		xilinx_write(chan, XILINX_CDMA_REG_DSTADDR, (dma_addr_t)
+			     ((u64)hw->dest_addr_msb << 32 | hw->dest_addr));
 
 		/* Start the transfer */
 		dma_ctrl_write(chan, XILINX_DMA_REG_BTT,
-- 
1.7.1

