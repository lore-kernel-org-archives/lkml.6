Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C26C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D18220882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eSPZxkqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D18220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeINMct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:32:49 -0400
Received: from mail-eopbgr710049.outbound.protection.outlook.com ([40.107.71.49]:37917
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbeINMcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVJMUFwvOod03yDrUeijBm+X+yfL8DSDT31ZrB61iE8=;
 b=eSPZxkqDUVnTIDgg3ilzmAQnPsCKxQmSoFi+0lC9hz7S+J81YbfYgEObHgK2ohkhyd5K8zIklX8SjX0IjAXQr7m4qYo/41qRG+kY2EVt8N3xiiYDou4PRBH9fY+kF3V5xUlvsdEmItcsf7uBDoqutvR6FY5WQqasYJHgzHaURII=
Received: from MWHPR0201CA0085.namprd02.prod.outlook.com
 (2603:10b6:301:75::26) by BYAPR02MB4470.namprd02.prod.outlook.com
 (2603:10b6:a03:10::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Fri, 14 Sep
 2018 07:19:35 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by MWHPR0201CA0085.outlook.office365.com
 (2603:10b6:301:75::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Fri, 14 Sep 2018 07:19:34 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Fri, 14 Sep 2018 07:19:32 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g0iO3-0007Wi-TV; Fri, 14 Sep 2018 00:19:31 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g0iNy-0008LT-Q5; Fri, 14 Sep 2018 00:19:26 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8E7JHBw005137;
        Fri, 14 Sep 2018 00:19:17 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g0iNo-0008KL-Tb; Fri, 14 Sep 2018 00:19:17 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 1240E1215B3; Fri, 14 Sep 2018 12:49:16 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <manish.narani@xilinx.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>,
        <broonie@kernel.org>, <arnaud.pouliquen@st.com>,
        <eugen.hristev@microchip.com>, <rdunlap@infradead.org>,
        <geert@linux-m68k.org>, <ak@it-klinger.de>,
        <freeman.liu@spreadtrum.com>, <lukas@wunner.de>,
        <vilhelm.gray@gmail.com>, <gregkh@linuxfoundation.org>,
        <kstewart@linuxfoundation.org>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 4/4] arm64: zynqmp: DT: Add Xilinx AMS node
Date:   Fri, 14 Sep 2018 12:48:30 +0530
Message-ID: <1536909510-7166-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(5660300001)(8676002)(103686004)(126002)(26005)(4326008)(39060400002)(106002)(336012)(476003)(16586007)(426003)(8936002)(486006)(110136005)(11346002)(2616005)(44832011)(90966002)(6266002)(50226002)(7416002)(51416003)(186003)(356003)(54906003)(446003)(48376002)(76176011)(81156014)(50466002)(316002)(42186006)(6666003)(81166006)(305945005)(36756003)(47776003)(478600001)(52956003)(2201001)(72206003)(63266004)(106466001)(2906002)(14444005)(36386004)(921003)(107986001)(2101003)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4470;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT040;1:VYIDi9APpmbO3AUupTpOsX8bseMSb+DHTggJyxYZKSPTPU+2lrdJwuzBGT0XuTIND6FkyVCbxjBZKETnjU+CO72rIftrzFFHUeIpHBmnJnyN4fM1l0fS7ViNhpj5gEBR
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 877bcc9a-8fe9-4ea7-ed0d-08d61a126b27
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4470;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;3:o6eBE1bquiG9hPviKsMyDl3+HkszWCatnhrgSLsbOytU27fgE8/xDn7coLVqRi4DIbqdAjozSFbyFWuvL3VANV9hjBqMZoUJBUyRpS4y2LgcDkL6ti/8vo1H5XR8G3mViMvQPS9lDxlRiWJZsBSRGrzXHuYsF0YYQNSjHLVoIvMtnaaPMCCuxsEhqf2pEB02knrVUk4pfeW+3r+gXfUd1kIV0rtCa0RCj41bBqECMJA271dDzdsFfaNhzIVz9BZCoe72sNl2o+AeUBXPEKt2GCoqzMwg7VbPY6gMvhCBgpfNnRwVYyiQXygG81HEcHyDP45W7XNWn5I1/HgWEc/JGQ/4BZTWWDBUD+T3RbUPagU=;25:P4NqPcWNef0+bp3RORbzO/97wySHrmnIZkDicYNzIRW25Kwstt1UJn42tNhbP0E9B89C9raOiOLevTXVXeGQ6uen3+GUisMkuBb8qpe76a37z5HLvgSizjn+FoOGDz2Z1gLlU6c3JjjNVtdPoKyiyxefo2F/ErgaotuboUO8nfh2Mt9A9rTRfNqHCtvunGmfygnpwZPoj9KhVUhn5hXYflNAhO2GVRJqCp40h8gPU9eXq2z3cmjGrg1NuFu5l46LjXRNIj/JZB+j7WNXdzPWbtfArelfeeKqEKB4RN7EdE6tZ/g+1vNeJLsvcVb6JOmm7R7wHedPNc2pSB1r4NVgcA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4470:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;31:uQf3Dp7a/rsPw+Sb3XLoc//CtSVtwifOhOJks5BX0wYJ1C3rAx2WZsmomCY+Z0s2ynrTl3o/NdTK6ljfwWmj/wdL5Q0Kv87ZdY7wy8NWknAWupZ0GdOdM+YnYJXpO2tufmpFZtOSpM5t0efIyrR6GIHsxUxYgCzuMfkkeGUUgQ92wpJ5QAnx1UuR/ry6YJeEvh27Z94ps/lGvYVSLPw4HgqxCLMGzm9hNvN3lFkbOz8=;20:NItdVZZxkOIsvYVXQR0HPEDatLMzWbaHUjT2r12kAAb9fWoqTn7maNAwubAi54ti3Fz4TSXjb3mP+KUIIfHL3DFkh8fdLfyC8rDhiIHtZ4k5/froRXHfn4Ec8th/Z6olYBL1VtsvfLutTJA6qDRIbhcaR2LXGixnx/dMLmpxA3XULmoilL1d+vNWpK4OiSK0GcVxSN9PA42SG5hpeGztv4LASluK061SToDNOeX+hZ+C0ZOj98HllYgLEBYoLMbXGcGXXALIcnkSHms2n9lZ8z3+24RZaPvUmTPTPFtNcJBzVdzAt3qjazy3y0+58fUSrc/P428s8reLmsPCQaL0BJ6flfD2URGmNvkaHhBW+3Rl04v+QxDOrDjwvRDWmMJgCph5lNk1004NXQpHQuhzHmBBNlJxVDgk7NVp8hhjPdCKLtyhP/XOipangd+kNx/oxdT4b6sANz0bxDnqntz0CtOBwJDjcc0maeuz6fIQDu8A0FLzJMyfgcCl/IRvalXc
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB44702ED703AA4B3C65A58E00C1190@BYAPR02MB4470.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BYAPR02MB4470;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4470;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;4:KlXz/OjKhv69xm6mVwTMdvWwPLHq1NXbvRz0OwxwOdn2lJlLaEiZTlRWj4LcljSafy+8A5XfG/FeuFwOXhBJELm3WetdmD7EaGDpZcRqaYd0jn4BFEm6u8dVPuA/BWQzK3vfT8/S3RhAV5YhtCzi/3fJF++FoJ2IaMnheTf3l8ayP+nPQBCh+AhZea0Jm110qnVy1opLYwVHeVTDLbCvlGFOPBPbkpRm1aQ+zZBN8B551IpRkmaf8rkFRsmDe5vxtLV6fiZD3zDLwlF5ieObdgR5he3dg5JORnzAhxF3TU2lMynLj4rZIDd0NaL8bD9w
X-Forefront-PRVS: 07954CC105
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4470;23:kD5TBJ/1hXWcgsH1OI7oBPoRhCwkG1OtQ6lD1AF3r?=
 =?us-ascii?Q?5vIGvvncTNizVQQQlkhvtveCKkWo7ieEODETDf9fdPNIfUp5BrAQgbl/CA0X?=
 =?us-ascii?Q?K+Xts/vZG6A/sVDxcEFCmgKYJ4pOoDuICSHUpP4r5g0odvoIibQC+7VkjIX4?=
 =?us-ascii?Q?U+oglRb7PfDgJlG7pnelOflf42K5OUOnOIBvWuhKYdr0sDszrMhqlntTaXkf?=
 =?us-ascii?Q?YebhEFdSV+s1S2gxPjcUcOfglrqFQg0q8igC0p6xEXhmdqtcp09JHfuzKWaq?=
 =?us-ascii?Q?z9Lb/GMDhaBy7glzHmr1TPO0RRvCcg6r4rJFZotrTWqqVGD0M0LL2bE0BuCu?=
 =?us-ascii?Q?NCdCpj0mxil37jT9wS5oqOu0/td+11MumCXR+uaZ77RV5cmM6skW4kcxUWsI?=
 =?us-ascii?Q?jr3w5sKv3eqSVFQiPFHur6vbGfX+gNKNqUYk7yQsfpRqVZcTd6tfdaFPNhDg?=
 =?us-ascii?Q?5N7rs/mOwazdy9QSxX6S7FtuNsAcZd5lLVU0YrEPgEPNqafvUwEv8VWk2y8M?=
 =?us-ascii?Q?VPANULEynhLqxOV+VTgTwes3xrUmUVTzgV3FOGgijba+2DtPIxTJBrvIyt8d?=
 =?us-ascii?Q?hCPatoz08mdosHlJoGBRN/VxKpXqYebiRN0wlI9AYBbmGkGLMhWiaWjrvp5Q?=
 =?us-ascii?Q?GCrXPi4VKy+61IsmAOeShnNcwjem6BhyMVD+hPhER7clxRHQyUx0M5gFndBb?=
 =?us-ascii?Q?swk/3JJj0F8dY7lloYoEJECfWt0dfxuoBWW+WT/0/CUDSAWBgbc0d8DV/Fgm?=
 =?us-ascii?Q?xs6ZDaLJ7qdiXq9r7cSQQN99s7nupkXSpQkp9meoNpO1Z7E1uH+3/yPaXrxA?=
 =?us-ascii?Q?hWDtinFX534h+XL1DlSq9OTW5YPZF5kyn9PSyq0xrVCwkSZfIZGnmRDhyvix?=
 =?us-ascii?Q?r5Ine/lwVDhv5yTbCKfbbvGg4eHwqd+CJcD1F/qky6v7uKxh93Wz/2kLfZVn?=
 =?us-ascii?Q?xq86onJt+OSP1YrGhDl9BV22Wd22udg0NHIkLjZ4FGJrHcw/YqHJ1oAXRZj0?=
 =?us-ascii?Q?Kd7cizVN3jT5bL2jxQ+2s6p7E2Ka91ssRmDJ94jKJV9uA2wazGePRR2eDy3e?=
 =?us-ascii?Q?vGRbExE1cbrTvJldCgzU48Ab7yqfk1LR/743K863AM34M7T0N2LJDDXCEiab?=
 =?us-ascii?Q?MInxOVoUDF3+jSOuzCjW6S6vjiNYsr5S2QFOX27H65EJpTMRdEbCipAF9u/F?=
 =?us-ascii?Q?xYkz5WCV0QVc+QhTAPGNs4YZeA7zDFsqGvZSjUQln3Qrq/CU04znIhPdnajO?=
 =?us-ascii?Q?UC/GBNYsmJtaAs1mGY23PJ1cIlYo96UoPDkabFCL67ZXMbzpVXI+5tI2QTJP?=
 =?us-ascii?Q?WqrwhsB+iLUdKLSk6FTNC/Uf/v/1LQsNfznnnL7L0QlWtvkP4TLVXY109I+r?=
 =?us-ascii?Q?qXQvQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: l++e3/XIabqLaJlQNgFD+wrmi+6CVkcaJ0KOsuK80T7WBxm+uAWx9DJP5QYcv5e7GQ8aoCp35dcQd4wie1uR77c5miw8+0TjYfCsLXh8ZbDZy6x3e8F4mRxI+iDdJbDgcpgaEwo9ejN22SEbJ7DaTn7bwLph2QnxI5jMMl7iiOw6YwzwaEz43MJVicOzwSq/bZJidzeCvrRe1IiUTLAraNZmsOpcVgMlRFlLEJqP9MD/V5qYOXOuDs+O0hzLp8SAlhPFyH7AT22qREAq3bibyYlYhRlurOeDKjYXRIBzVCrGDT134szkxec8tY/wI4I4BPBH5GlYRdt2OzD4ETFBG8Nibu3mHyuPFuhuvbSxcyw=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;6:UoPT2kbvuyLpZtcrrSSajInQ9g+6KoSBfSLupTG51ANFYH/s3THkmkc/Bhsq/d+dYpXq9yewO51d1cCCXoTWBFMai0c2VJWMGdS68CC2EvdrIbeeHc6dey6fI54nbY5eFoszarM46BqLDUyOi3BrAWPuNJnhHYhtRqjHJnpOLIPlx4UJmDuqU8xTj+yqdinqnI3v2diyTNk57isIfPAlzCjfpXgfjRUkidoYXgsjk0xo3OJeWDQHFR/8HFaLchBuhew2yptKQ5Ktnzlogou8ROR1z1cbFwANMtQi/OCkR7r4xKEI7ja10ryaydwWTQWPz3BNLrZarG69MqsbN+yLlgCaH2EvJKEWBZExDrgSWpLGggqtILxuG3wCAPIDk4GJQ242D7kmMnHlIuBMCrj7UqpqOZ2AMoLGnRQScDbzrjIYWNbo8ULIQBm2R12oS+p2Kn/HvwzBZA58tR/Y3dRJWA==;5:5l45YXELlGygFbkkeOHNqJjOq40ZRBV5kj54PtIls+/ZiGDvB4u84+PBve+JOi9SDsQB5fO6Llbpvlve0nqfO+Jqv9Sg+Xgf4y0yIjEN6sz4ninWSgW9LwQaQpA6gA8qncdhZpKYHKQ/DYuPu/jAlmEeCUjg2KoQV8HYFFH6QOE=;7:LaoqARoA3J2D04JQIsvO+WffZfEVarN6ZV6p6NOowzMNuCK1Y7iltbAhCR59nHIMEUUGh10Va7kHryj/Re4cFNSzM/tPpIm4JUWnGzbkEgiJ7XuXF7yGhv7xPqb/G1mXr0333rulxb68yVOK761hsZRoOcjzc2mBWYp9NDjP6D0UiCLMGbZrTGYH97CxcbvNDfdbazGK92JAvweiZRu887rK07HXU1QDTlHJmkk76VS155QcLTedoCLiheeQmQj6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 07:19:32.7141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 877bcc9a-8fe9-4ea7-ed0d-08d61a126b27
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xilinx AMS includes an ADC as well as on-chip sensors that can be
used to sample external and monitor on-die operating conditions, such as
temperature and supply voltage levels.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 29ce234..6e42ca2 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -617,5 +617,31 @@
 			reg = <0x0 0xfd4d0000 0x0 0x1000>;
 			timeout-sec = <10>;
 		};
+
+		xilinx_ams: ams@ffa50000 {
+			compatible = "xlnx,zynqmp-ams";
+			status = "disabled";
+			interrupt-parent = <&gic>;
+			interrupts = <0 56 4>;
+			interrupt-names = "ams-irq";
+			reg = <0x0 0xffa50000 0x0 0x800>;
+			reg-names = "ams-base";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			#io-channel-cells = <1>;
+			ranges;
+
+			ams_ps: ams_ps@ffa50800 {
+				compatible = "xlnx,zynqmp-ams-ps";
+				status = "disabled";
+				reg = <0x0 0xffa50800 0x0 0x400>;
+			};
+
+			ams_pl: ams_pl@ffa50c00 {
+				compatible = "xlnx,zynqmp-ams-pl";
+				status = "disabled";
+				reg = <0x0 0xffa50c00 0x0 0x400>;
+			};
+		};
 	};
 };
-- 
2.1.1

