Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F4BC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2428E27057
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vQhrKmif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2428E27057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934317AbeF1Hl0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:41:26 -0400
Received: from mail-eopbgr700081.outbound.protection.outlook.com ([40.107.70.81]:4992
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933896AbeF1HkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1msWc9l2if2whBq8sEfawYTGG6QwXQuD0nhUKll9BlQ=;
 b=vQhrKmifIoPkl1KWCtaN6arvJf9nB7wGa8xa5Ok8GtXyCa/LgyNmvLrUJhIiIf0xSrK8mhdz9yF68NWPeMRAplCmScm9jzbT7doGycUOjeRe9HnR1ptKzWtgYc9c9kqDFczYeoB2ayrMs/jYpNS1ZeKkER/JE5wDxbLuo4QdVlo=
Received: from MWHPR0201CA0009.namprd02.prod.outlook.com
 (2603:10b6:301:74::22) by CO1PR02MB174.namprd02.prod.outlook.com
 (2a01:111:e400:101e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.906.20; Thu, 28
 Jun 2018 07:39:59 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR0201CA0009.outlook.office365.com
 (2603:10b6:301:74::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.23 via Frontend
 Transport; Thu, 28 Jun 2018 07:39:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 07:39:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34931 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYRX3-0004OG-V4; Thu, 28 Jun 2018 00:39:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYRWy-000195-S5; Thu, 28 Jun 2018 00:39:52 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5S7dlvg022794;
        Thu, 28 Jun 2018 00:39:47 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fYRWt-00018C-EI; Thu, 28 Jun 2018 00:39:47 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 99016B20955; Thu, 28 Jun 2018 13:09:46 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <joe@perches.com>,
        <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/5] net: emaclite: Fix block comments style
Date:   Thu, 28 Jun 2018 13:09:43 +0530
Message-ID: <1530171584-20673-5-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1530171584-20673-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1530171584-20673-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39850400004)(136003)(396003)(2980300002)(438002)(189003)(199004)(90966002)(51416003)(47776003)(478600001)(6666003)(5660300001)(106466001)(36756003)(106002)(50226002)(103686004)(63266004)(4326008)(81166006)(50466002)(36386004)(446003)(336012)(2906002)(6266002)(16586007)(126002)(2616005)(476003)(52956003)(11346002)(8676002)(356003)(42186006)(486006)(2201001)(14444005)(76176011)(305945005)(316002)(26005)(426003)(8936002)(81156014)(54906003)(110136005)(186003)(48376002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO1PR02MB174;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT036;1:nPRgh/GUJZP5FtkDLIXe2NBlJ1NoDBCkE/3frYRL3TJGFpk+9Pk3wrf6r4HsWqlXKC7NO4qLZbMKO7HXqlp9kwgkhPB0a9WpsThxwu0rgcMdKuP8ueJMmUGpDLLhYzJt
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2033b3e3-ae91-419a-9a9c-08d5dcca5997
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:CO1PR02MB174;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB174;3:tWBlNH3Dvwo1yf5PMLFF5AajquJpVo3/mesrrzt0tntMhRv0iPPH9EgkOT6Vqk9Kzmqb5huVHmRbix5Sbf/BfTI56z1+Cy3xJM/rBVbAecIJlqCa68Hd0iXSrPBwAiVBB5V06FeY4lYptvHHzWw1SMMHvNb+VSb/ZyRTkf9yyXUmu336mr7aqT4+ooxxVq0Sxw0Xv91FvwRKSw64mc2y66JdPUUfPOeaoSWor8YmXUAFz1jSIHroEO+pMP2TCA/ptPyCQ5XQzddPjuD+3nl0gz30MrjP5Bh9DjEikZnUOrGDjmks0QN3FHfOiq7+sYXXjMPbo/CPA6nUIKHDM2aeNAM11uDI7gzdFAXaQR9DlX0=;25:6hBtD7Yfqh5FDoM28bSOmN3SZFZQw4LCRFL3byms/s1uCWmCI8G7Hmub3KkUwnn8D436lclVTFl5FCTji3ptQyJOT5tUxhOF32VFY6DHoXvphfJQvbYIiE04qwOqcpIF2xSiD9VKa+0NCuTjhnoA9NN3jCpmwC38hlTw6RePB/OOAatDyfTuZ/6KHCDaqF+Ph9Ba8KKyENNlzH0hTjPQGqladLA8WgHujlb2eXke+foQghJahYl5gqCIjiJSPHclNuT5lNAHhH2UcJl7LxEJ44ykcuJWxONi7MyyIutLKBDocAdzOki+OiCyhgQCA0bwvBb/SUtLGDGilsdSM0NIDA==
X-MS-TrafficTypeDiagnostic: CO1PR02MB174:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB174;31:CUcwDX8YsV+xFLKBRBiyLRXbj2YSXAcb1QAqG0x45ir5JU3338gDZyg3oH3hDIUe/VZi9aYoOalFJyITGd85bZdMfueWDyunDbrHw3tdO5VCM4WmAGhtMGA04UDpspZ8cn1UEFWRV6XYZlrxjT/y4ioehWoA4Edgyx8MO6k7/Nnh1uE7m3GjW8x7I06D5FpQQGccsbezih9yVFY3Ed+XTps3EANBQZHWaKGFX4ZXULs=;20:hNtvkIxVsVax8Jf+ZOUT/hf9yNRWqS5O9Yq6A1IU2Vz/60+2RLzvTpz9soGAPPVT8CFdMfhQw4YcKHKwmLtZ97FNhCvHMUaDnShRrA+NLi0vKqJixvz/DLQMqyGuIxp5CiclGY8uM84Aqg7agTzsmMqEBQiJmWNX3Myfq8ZkVlO+4Qz+Ms3jfVYRXdaAXiW7nRfLbiEQ9LlJ2RBNmiyWVamGAsMrHXQnhs3PEfCI/Rvx/bX1xH+W+H4hK0P1QzsNUqaXDb6CzXFRoTyCzfiArXktYY0o4efFgcEqOJIeBYnwwY/mREdzKYd/W1rDTEECTFx+1w8ZHkzi3reINt7+6vOsXRNTymxBJJyvhJdHCFT6vZRRGpnW/l0/qvwdtzihjkHVaqK7tav/3OBqcCOmNGlUeJJsC6KyFjftimbQGk+Jt4ZnoMblRuZQtbkpBu5umWFiUMsSr242KRq0Xl+iCzGwVcXGclXubO+oKufKq4PKizIO+7R8qOv4O/PRUPFG
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CO1PR02MB1740E90180AC2227BDCB66EC74F0@CO1PR02MB174.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CO1PR02MB174;BCL:0;PCL:0;RULEID:;SRVR:CO1PR02MB174;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB174;4:vek7qNx6XEwPP9qBYtFyDmp/3dV5h8TOKlxU0lDq3MvUH8nHRTeQZ3YOV3XBFIolHi5af9A4CrAuDI9G3lnLiMfIdfsZkfL66L2FkYJWXpqhpp/Ujm35FxoMTt5am/ez6fMqvr07jrWAfK1/iMvXvzOAvtzykxvD6m/D+RbK883dLYPnd2Oo6SB9OEKf48DuM/wvG007y9DoGjpN2qheslNjA/qhatMSsIN3WNxvdIH9J5kQA91GoXzXN/l/5bajRmfTAZh0h/z2pHmyj46e3kCdB359KVWzdhlaBGq6KDeUo3Ju0XZ4+gLr4q1UqcOS
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR02MB174;23:oGqLTQPpBDYB3/9TEpUhUA6ElPSM9LDX6nPrVav773?=
 =?us-ascii?Q?6Ur5DqfU7i7nEUHN2JI0WoTocvrEKZlLvJdGQdA/83EAp/h/uBu2aEO7FPHT?=
 =?us-ascii?Q?Eaj4vzYbeTEjfXdbAqcAf+EIDeKCmRtWMwP2V5lgsiRtFrVtnMCcX8gsIYWH?=
 =?us-ascii?Q?dJXiLDS3sxelcLAjyfwTAsERqat5RqphYOcHdC3MGJQp7RwrSmIPjiM0CZ6o?=
 =?us-ascii?Q?xVGmGwAkthEr1JAc/7mLuNmTgtinuhk7dc1hGPkmGxti7Uc6T7yu6s5eJT3G?=
 =?us-ascii?Q?eKRbn/aYIjMjZ5orUbVpLNyyvPjb83alKUnhX1HM68HTN8+uNAcpf7SJfsUT?=
 =?us-ascii?Q?fw4yUh5sZuQ5gSULg1ajtYShqv0eYaN3px33CGoEERv+Ay1RxvHbrVJcm50U?=
 =?us-ascii?Q?ADtQpP8rGmgIENhjGPpp3gcTUniAqALtsEMOl/Ya/QdTftS3JkDPLH3lJeP1?=
 =?us-ascii?Q?l3v4kezHlQAKuAezXimTk42SCN+vOSS0yPLIDHHBh6G5sRkc0H7A3gaXXTc1?=
 =?us-ascii?Q?Bwn3B8ptCXTlZSX8niLH00bDFPYSrA4cNI12AuOOqrkxL2REQ8gvm2NKX21v?=
 =?us-ascii?Q?Ff9M0+hNr8aI2AnBQypY1+gtKZ2T1a0j5HoVNiPa9YMS7IhfTYkcn+1LH8ud?=
 =?us-ascii?Q?RUBpRc1R/hLUdflSXjJlopOEFcaRbKlfuHms0Db3SE+9XT4VN23+92eS90jq?=
 =?us-ascii?Q?bkVc8/cMIg3Ub4oT9ZJf43NUsLB/LQdd/KYUva6LwOhQdTqt4kaRy1iO4VWJ?=
 =?us-ascii?Q?N2v1aIzXhCxMk1QwzK6ZN4KJNsMv4YH3D2GV82XIxL3AeaMrsCooA5FyKgLh?=
 =?us-ascii?Q?EM+xXkzsmQGHuuXXXIN2T5I9Wk8R8MSYPhB4EPc1QFYH8nW/76yxt+8gadzf?=
 =?us-ascii?Q?+DHw/IvLPKHp5XsdCoctfaICtlZh7UrBJYRgbq6k/ImzNvFulZPu19BFrxNy?=
 =?us-ascii?Q?aPokVJ2NHu35afeabgt2/kKmVKezBIzcGMu73hpkaJuuur4VKd4ztmJXdMQZ?=
 =?us-ascii?Q?I81RxyIzY6MKgCjT8B1kEYqrp8up78PJp4yhgztGKAy/xeEz1ShbkobAUXQm?=
 =?us-ascii?Q?TcAH04noyi7EtCoA5jixGsi/Jo1rudmfx1xIMopmnALOBnVQHWAXZJvOe6JB?=
 =?us-ascii?Q?wwF8xKch20x2j8gnSwDOFZenMOXiiNvt6rEA9lcCeOOBJhAqyPcTg91B9Ker?=
 =?us-ascii?Q?Z9gTn64CEu/5DQRQu1ybfUYiIvnWZBYTda?=
X-Microsoft-Antispam-Message-Info: wFtUu9Wc1cnBiBU5aCOC4fh1cVliAy0F9ZonO2KZoN0e9G+X+kBvndqsm8+QRTlfp8RkMFOylyD4wxS/wRofsnuyvBZh8cqSnY6hAfMUcOA1GQfkb2muPH09DtQkFRp48tdMrcz1g62MAg4xzoRWHIj1caKRlqsNFf6Efr5EkfU78r/NaHCLC+X29+IgNHnCItFWg1JdKl+tkAQy7scYBbR7pCrAqVoxuo6XAF2Q8MZfLZkDBFLU75/R/6me5q8iJQ+gSojknrIdNg80CHX5bxu7FN64G3DvFiPF+pzqFBYuMsgTdX5n++kW9EO/7AKI61DtOoDvCiPr5klCY/nHQZQUTvXEXzUuG6K/EIxCixg=
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB174;6:STy/lDrMEALQZlhmFxHWWV/1zDdpkg959f9/miBZJr2v4Z3lISOqZrTlSn0o6Ex+GUqfUhVnEKWDGoMQRKQp2EOiG5mtxrI2HXG1RvswmcUm4BuX8Hw1agma+lribA64HKXF60m9xyNYQUuE2x3iKF0JB980nlMkDotxPBF191IzN19syblryhHJ1Lm48cReVirdGD42JBG2PCmxMWa5XO6BC1ngliFx439sm9ki/VSdzYOVIDJEFRTHXlweKFr46pRvgLr0ekx7SfqqJZDgEJ0+U3+Ex3wPyRqM9V0HLQ2UG2gTJlcQiSBl+gnBK6VOZ9AlPMITbXQvt8oT8U/a1VR2bz3qu94I0FpPbhCS7z4htEJMsWJh/05T/IsN7O6fkcW5byPXRSzeAiHYTtUyCORsn6n6TbYsIuLYER/6Ay6CkYf1x9P6F7xEwCil+LR3b1T9ueE/QqlC8/nu0zMY0w==;5:rZ+XKiZbE8IsPffmQyT2CbIrF2/Wxntot+4D59UuO5LSr3EkfA+xffPzP17cHk34TgfUn5XFKC74sZ59s8gOxgKJw1IUY8Rc677/iJqPLv7P1hs/WjuVkn9Nf5F/A0hu0hCEbIvDSH8Xh42FfrFUzXh5Op18uxOWM5LkMzcspJc=;24:qLFAREL8SfE7inGAe+OWmvjqF6p1IKiaeW9i0DVsuc3zpgy6nh6IMdTfd0neiMJSOkBVKbdU+mDDLJWc2Uw5VEOxj7sqDG0/l5F1dEP0mYM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR02MB174;7:e8CYXLEr1NJDDmw+jlubRyauQiijxS5KIV4zwLn8OWVszdgRCgqbXR3q3iNMh3ujSU6DS2HqAg6EfS9PgNzoiX+p0gkQoq9StXR5K/TIt7m2GyeBjfuRpiDxg8hlhnpSsw4HfWIXw0F+aZwj+xXkpAtsbXwY5P7MC5TD3XQigg1ab++E/ID3BZl7Po3WZlATG1PdDCXCw1tKTJ1rSwqGTd4O/DX+i2ZOqCUZUbfmfjlA2NDHzr+RJdlfwqG4DwXI
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 07:39:58.4905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2033b3e3-ae91-419a-9a9c-08d5dcca5997
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below checkpatch warnings-

WARNING: Block comments use a trailing */ on a separate line
WARNING: Block comments use * on subsequent lines
WARNING: networking block comments don't use an empty /* line,
use /* Comment

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes from v1:
	- None
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |   34 +++++++++++++++---------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 2cc9353..59f4ab8 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -70,7 +70,8 @@
 #define XEL_TSR_XMIT_IE_MASK	 0x00000008	/* Tx interrupt enable bit */
 #define XEL_TSR_XMIT_ACTIVE_MASK 0x80000000	/* Buffer is active, SW bit
 						 * only. This is not documented
-						 * in the HW spec */
+						 * in the HW spec
+						 */
 
 /* Define for programming the MAC address into the EmacLite */
 #define XEL_TSR_PROG_MAC_ADDR	(XEL_TSR_XMIT_BUSY_MASK | XEL_TSR_PROGRAM_MASK)
@@ -336,7 +337,8 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
 			drvdata->next_tx_buf_to_use ^= XEL_BUFFER_OFFSET;
 	} else if (drvdata->tx_ping_pong != 0) {
 		/* If the expected buffer is full, try the other buffer,
-		 * if it is configured in HW */
+		 * if it is configured in HW
+		 */
 
 		addr = (void __iomem __force *)((u32 __force)addr ^
 						 XEL_BUFFER_OFFSET);
@@ -357,7 +359,8 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
 	/* Update the Tx Status Register to indicate that there is a
 	 * frame to send. Set the XEL_TSR_XMIT_ACTIVE_MASK flag which
 	 * is used by the interrupt handler to check whether a frame
-	 * has been transmitted */
+	 * has been transmitted
+	 */
 	reg_data = xemaclite_readl(addr + XEL_TSR_OFFSET);
 	reg_data |= (XEL_TSR_XMIT_BUSY_MASK | XEL_TSR_XMIT_ACTIVE_MASK);
 	xemaclite_writel(reg_data, addr + XEL_TSR_OFFSET);
@@ -395,7 +398,8 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 		/* The instance is out of sync, try other buffer if other
 		 * buffer is configured, return 0 otherwise. If the instance is
 		 * out of sync, do not update the 'next_rx_buf_to_use' since it
-		 * will correct on subsequent calls */
+		 * will correct on subsequent calls
+		 */
 		if (drvdata->rx_ping_pong != 0)
 			addr = (void __iomem __force *)((u32 __force)addr ^
 							 XEL_BUFFER_OFFSET);
@@ -409,13 +413,15 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 			return 0;	/* No data was available */
 	}
 
-	/* Get the protocol type of the ethernet frame that arrived */
+	/* Get the protocol type of the ethernet frame that arrived
+	 */
 	proto_type = ((ntohl(xemaclite_readl(addr + XEL_HEADER_OFFSET +
 			XEL_RXBUFF_OFFSET)) >> XEL_HEADER_SHIFT) &
 			XEL_RPLR_LENGTH_MASK);
 
 	/* Check if received ethernet frame is a raw ethernet frame
-	 * or an IP packet or an ARP packet */
+	 * or an IP packet or an ARP packet
+	 */
 	if (proto_type > ETH_DATA_LEN) {
 
 		if (proto_type == ETH_P_IP) {
@@ -431,7 +437,8 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 			length = XEL_ARP_PACKET_SIZE + ETH_HLEN + ETH_FCS_LEN;
 		else
 			/* Field contains type other than IP or ARP, use max
-			 * frame size and let user parse it */
+			 * frame size and let user parse it
+			 */
 			length = ETH_FRAME_LEN + ETH_FCS_LEN;
 	} else
 		/* Use the length in the frame, plus the header and trailer */
@@ -602,11 +609,11 @@ static void xemaclite_rx_handler(struct net_device *dev)
 		return;
 	}
 
-	/*
-	 * A new skb should have the data halfword aligned, but this code is
+	/* A new skb should have the data halfword aligned, but this code is
 	 * here just in case that isn't true. Calculate how many
 	 * bytes we should reserve to get the data to start on a word
-	 * boundary */
+	 * boundary
+	 */
 	align = BUFFER_ALIGN(skb->data);
 	if (align)
 		skb_reserve(skb, align);
@@ -708,8 +715,8 @@ static int xemaclite_mdio_wait(struct net_local *lp)
 	unsigned long end = jiffies + 2;
 
 	/* wait for the MDIO interface to not be busy or timeout
-	   after some time.
-	*/
+	 * after some time.
+	 */
 	while (xemaclite_readl(lp->base_addr + XEL_MDIOCTRL_OFFSET) &
 			XEL_MDIOCTRL_MDIOSTS_MASK) {
 		if (time_before_eq(end, jiffies)) {
@@ -1029,7 +1036,8 @@ static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 	if (xemaclite_send_data(lp, (u8 *) new_skb->data, len) != 0) {
 		/* If the Emaclite Tx buffer is busy, stop the Tx queue and
 		 * defer the skb for transmission during the ISR, after the
-		 * current transmission is complete */
+		 * current transmission is complete
+		 */
 		netif_stop_queue(dev);
 		lp->deferred_skb = new_skb;
 		/* Take the time stamp now, since we can't do this in an ISR. */
-- 
1.7.1

