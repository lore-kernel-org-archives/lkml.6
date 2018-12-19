Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24F2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC8C218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="p1x0gMd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbeLSRTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:19:42 -0500
Received: from mail-eopbgr720076.outbound.protection.outlook.com ([40.107.72.76]:3954
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728199AbeLSRTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:19:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/upsBXiWFcBkiXwIzP/sqKhEHtHgdDI1j+CfXKccRw0=;
 b=p1x0gMd4ny9Bran4GolMb2tcPHtjStXjGsZX0PMjmCM3/TrYrAPda1eHlPCjcXfVocuH/Y+y0hKiUz/fhaqblfTcIOWKD6P40fRlXyWi7VOspsU+KVYcNWmnECTZcagtVK+ILjYW9CmQEXiv/X/ZK35S5Q/mateYLsFc1w6g+kE=
Received: from MWHPR0201CA0019.namprd02.prod.outlook.com
 (2603:10b6:301:74::32) by BY2PR0201MB1894.namprd02.prod.outlook.com
 (2a01:111:e400:58b6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.22; Wed, 19 Dec
 2018 17:19:37 +0000
Received: from BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by MWHPR0201CA0019.outlook.office365.com
 (2603:10b6:301:74::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.17 via Frontend
 Transport; Wed, 19 Dec 2018 17:19:36 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT041.mail.protection.outlook.com (10.152.77.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Wed, 19 Dec 2018 17:19:35 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51335 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gZfVP-0003mn-BA; Wed, 19 Dec 2018 09:19:35 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gZfVK-0002mn-7z; Wed, 19 Dec 2018 09:19:30 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBJHJJr8030295;
        Wed, 19 Dec 2018 09:19:19 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gZfV8-0002k9-IQ; Wed, 19 Dec 2018 09:19:19 -0800
From:   Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/3] ASoC: xlnx: enable audio formatter driver build
Date:   Wed, 19 Dec 2018 22:49:09 +0530
Message-ID: <1545239949-112845-4-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545239949-112845-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1545239949-112845-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(2980300002)(189003)(199004)(106002)(336012)(478600001)(6666004)(356004)(316002)(36386004)(16586007)(426003)(110136005)(48376002)(39060400002)(50466002)(63266004)(106466001)(186003)(305945005)(47776003)(26005)(77096007)(7696005)(51416003)(76176011)(5660300001)(9786002)(7416002)(2201001)(36756003)(8936002)(81156014)(8676002)(81166006)(486006)(50226002)(446003)(126002)(476003)(2616005)(2906002)(11346002)(921003)(107986001)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1894;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT041;1:0GepvTtcmRVQuE6oBRQJ70r9KFYwCVy0iIbYymyrRSAoYE4FvQH+8QC+ZQ1mJOnin4kWRUm7SoIKUn/Fe1ozZXln9ffW+vpHeHWRUF9nA3yq+bcgrlCoC7pYXRXkQCei
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95b59c2d-8f40-4fa9-6122-08d665d62662
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR0201MB1894;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1894;3:3AY6eSjLhUbxLHoTKvIybdfw9Qf2TOE5A05DjbOv9+z6tnuPFjWW3entu2J9bji96n0fJ76nl40qu/EojVpoOlDnHi62aIKFsTGMm7gH8kh9JAnigSAt1aJJnXtq+TAA/YCyKEysXP49xqNfL5e2c61RXvqMPCrVkmBvfcaWG5n3YtwMDNvZ46x9KK936f3RxGhGizH/IfMkpBDRZmuPwPQT5V7tI3nwTz6vbc5kD5kSIMarF6xZcAgcRDQWscmwuwIoajcwGT620T/dgeWFCzgo91vJkgPJE+CHpPbMZzsyQt3oZhb83Xe7bIHvqDwMfm2nXwIdiFTYQztI68nu4Cc4ak3dFemWJ8c9RFKfHrU=;25:u+K3kGQpuAMHsMHmILCsBTgRM/NSFAAQGH0krBpGbzavc/JhnlZKHC68d53NICQGXsjSdML2M8ij2erQ3gl/77yjgNHsHWb5MyV6AZv/RHfzn5BG/ytj7a89LelFeE2GARDw6aWAAKVfxDSXT5/XTrBrrgW4Mm+kfVs/7IFJS96AbFhZd/dXsmbTvzBQzQ2h7ASuZ4kB9OVdHCG4cHmu6fCoZ+ZVcLJv2xF7W1LtNR3tejPNXOqrvJlavON3DL/kjsnFgIkGdDC1YWpToXa6ZgUa0OhFXKbPCG6s6GUyj8peS4fwxG3YuAK0bQ/h0IGWX4CCbytv/2yQZY7rWfVi1avz/Fv+Vd2015+2hiPEaME=
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1894:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1894;31:9Tsnl6GEDjbqSmpummchZtGLXxLwL4Ht8Dch+wjFM3Ppmz6M+eO7LHPBK/H3tuAFtVWt68mk926R8pwOtDwkYuvMaX1HBjP4nTJ2CMhYRt7VmUtpempjVvlWEbvHcVM1n6tAcrIe2kI6hp27f78XOhM2yEpEWC99LVyCuI2sW4MEG71Gzkgok+jC6UVoVLIjlOuETil47Do1QnyUkG9oP8rq60pmxieZEx4n/A+lQKc=;20:YbktFtPSB7lgvCF20tmVJJ8MC7cYJk4nzLierUQCd/x0XJLPCE4lP9UBwyZw9fLqGBlMLIlUSnTfouDVtacud5T/pryEw9AEhQRrK6rl40IxVMfA5sE2ljFb2dgj22tJeKFSedanWLn4l7lPG3SHTojwufwMFK4A+hP/4Qb9TqmYyuuVScLvOybEoTQu2h731I0+omkiDFQZaCjD+C+4Lr5uNO/OyloIlerLUB9vRS69zjgGQ/GydNf0Vwn5ysrJTKKIdi97HeY9J8zKVjGoG7hIlAUX6r4OIKK5G5E8BzyV8++I6Nnh3REUR+DZaDw98+X3YJLtXtGZ6pJkyvnBkIa/Ejv4qkf+mGr8mrbevWfR461Pm3KU4PrF109zP0KTohsWSmj9LSdqtzx0si2j2nRMUfjIXhpWSyubBxs5i22e4G3HffZ0i8tVq5gfNQs3i12lMWQXL2o5E8AetwxO57q08WRCkfjZ/MgxX7RRVNm45ZhWShfAHLUwB6mqchg8
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB1894BA9AB4842E8FD8975470BABE0@BY2PR0201MB1894.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR0201MB1894;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1894;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1894;4:UNhioar+OSJ4gpT/NtkgV2HRhznfQKH8mtOxFIrTiYaa6pfxxSJAzeAu4Jyoyge52RgCjzFi42/P9KSqRkgX83CMviSQLkAmdPJrfrq+GbG7tdWLxBNyFQzOA/4EpV/eaZgFN/IG52pp9K+lBmZK5iLcXOeTT6ytqDeu7d4EwNMkg6otNjl0yvQH22HCONqpGfC+OZFYUptBg/bvydsRdw/bAM4gdzhCzumqxcMXbSh2DeMtBsMeRGWeyBqJaJh26hXAaYWlDUdWvNLWQjygfQ==
X-Forefront-PRVS: 0891BC3F3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0201MB1894;23:U6WuAd0mUTZjggvoUAhWHs6UpVELFVup3fqDhPQ?=
 =?us-ascii?Q?80mN9UvbiOU9Tnj/okcqdbrDjDiXG2MfviUrYM7W2AtD1xnQEBsghqjwODqs?=
 =?us-ascii?Q?v+7sgsu+xHHuldFFt+JCzsnqdF6i+PPZmfo6eHtmGPZxcYyOSqFzcsaIbYMZ?=
 =?us-ascii?Q?6btLX5lUmu9w4mulCSRYqmcuvvBUmzSi83DOkOrrACSYlSwHY6VS9xgO8SpZ?=
 =?us-ascii?Q?QzTU1QXUx7kpttwTST1gTNjzfD0c9sAOKXveTiBOvB2mfV5U8utobQLf+5DO?=
 =?us-ascii?Q?zSqWoAYiPieH8alJLmDwOMpIMfgxr05iATRjUX3mUW3EvKjcjMp+lLEHe3bb?=
 =?us-ascii?Q?oyZLIwp9lPL7Ly9iU6/KNwitT3Wm3+UcpRlYjyGowWJS1sMTl85yP7QjcUhJ?=
 =?us-ascii?Q?LU08ViicWpBJax8Vv8DsSwhhlIWvBYa/hsFp8wMct+Wcrjg6JG9yVQK+EzcL?=
 =?us-ascii?Q?dHeH/6qm9NRn8CvKns3UHzHL6K6z0vQHOLvogogTWTaSJnX2LNppVER3/xEJ?=
 =?us-ascii?Q?loe2k9FyE77/Lbci27G7rJs4tYbEME5938DjZTq0fYw/tDRwYL46x1jbhDm+?=
 =?us-ascii?Q?+42V+fQsegk9NDQzZXvXOyTxzF2rvaWSYFN43gcRIAFtQRwg0HxOO0sUpROf?=
 =?us-ascii?Q?PlsN9ikNWnGLSNuzPvpWQGW1qM4H8zmHRTuLfwjIczLxyGmrpI6zRKAUkKfj?=
 =?us-ascii?Q?JGEL+Qz6kZNRL9OA7qr8y0RAXCA+RqyycDAfANle5sLsLtAJ4/AFpyYdJ9Jp?=
 =?us-ascii?Q?EGaG45NH09KHHFuekrU8mlxO5Y2ynigZ3SacE4XJp2mqQR48/WwbDit7WPqa?=
 =?us-ascii?Q?1qqHs6O8ZilptTbhPC1ZXlj9O7QvlDFVkPNQaXhU9oAoNlCtU2WDGH93eeQG?=
 =?us-ascii?Q?FNvOIGvyR8TFxqTuqClAJOVBQKs1LYOeLKlIv2Ovh26Rb70xbZPQqUnzMMni?=
 =?us-ascii?Q?aLU3Xh8JLrnPdiIW30Fa25Na4cVwq+qkEX0k7y/gXJJNnWCM4jagGBZEjPpD?=
 =?us-ascii?Q?nNrlI2BGI/POTcvQ4PDtE8bJMjAp32pA42qM63dEyd3v5M7PAe1SUkiRcmdP?=
 =?us-ascii?Q?tSk12qKBiQsFNyQVDaV0Py7Fz/F939aFi/OXYK8lmbBGppev+74mGzBjyZq9?=
 =?us-ascii?Q?bWWZYXslLxiY5Be/aeum9bPg2o3Ib+OHUUAn5O6TN9LCiuYtNumMvdg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: RJQIkKztyXxjSm5F8tIaMIrSKAUYE+CNwRrirFzDFczWOxtbsyPMsWyjyq65iYU8WGP7UD5C6HTb4vDQ+KtWI1maTTtyxx3FO6NWzKxBfwi4p2HhRt29YuNew2+IpDERvGblYO+c/WlqEMrhEmT33eVPkydBt/b2AuIK5eVC/sWu8xNguFHJ4NGTKDK5JpeZKxWhIcVr8Pc4VdUwyGSdMSN4VQLc14+Z2KYpn62I0FQ+gJ0yAMueb31t3bbBR2zLYkxYBRJn3euOTlpiWbprZigkmAkZ9lblOzTlHXllbn52Mm4O2H2784cdkOEWC7TM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1894;6:OnaMNIWPQQSc0EnM7AO4l/q8QIX8z8ZOttP1npZ96F2KDOBh3dW6j+fWAIbvFupYBuHvfbcFn3qAr6cQGiRc2mR+33HqOi78IPvIQ4Fr1FND4A5FfDr04034ez2YcRk/lFV9RM1exAFHs4C7MWteVaoa3GoI2ztI9D+xsxsDbb5wX2f5Jp5H8FaT0B34QuAgC86rZ/GGuKDtkxE4j84DfycSjuhQoBJRyGrJvji7S5vRMOUy0g3j3wWHqThjaUw5Wp9l+vKc3+P6ko0vtqmTO1MUZpQGxesANeQQkDjQmelN1enl5OX8LuNde3Hfi4GWFFqk+eGdzADrH5dkrtkFN+RI6xubLT29tui6N5yNa2Fkr76zEmpflMry8M51CRjXKvoWSeRoOB8kkhUYXJ/4Jr115jLX2NLlxzi5oEzJFo6bDlKOMCm9ZSXmKZOaXbz6PCqDg9ocDzLB4IRT9QwhcA==;5:e6p9SW9DxnGtLpQ55xBG20Sh2uFIWY+EUVveOPmera/sWxzuHYoiyrcwFOLTvd2tsA/JOFhfIq96IH1baJZQZX9ZZ0Frm9j2p6fqgHFnCka6qOGqDLczCAIsdfgBwsaIMMArx2urQbzeV4TlgA9e5gTDs2ZcnkahDQf+dOYjgKo=;7:dYoilitCcWcwokdCG98RtN56c3ktJXB6+ohV84XdOhBi+4KZU5Z6SZd7z4AFUSKezanx3DFakBXKWwSIAlV+wIWcJfy07hqNgqNIQKb+UkUHw5FiG/80yFb2v0ILF+3gyIXDpEvEzHO0dyfzUu1U3Q==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2018 17:19:35.9173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b59c2d-8f40-4fa9-6122-08d665d62662
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1894
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable audio formatter driver build.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 sound/soc/xilinx/Kconfig  | 7 +++++++
 sound/soc/xilinx/Makefile | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/xilinx/Kconfig b/sound/soc/xilinx/Kconfig
index 723a583..ac48d6a 100644
--- a/sound/soc/xilinx/Kconfig
+++ b/sound/soc/xilinx/Kconfig
@@ -6,3 +6,10 @@ config SND_SOC_XILINX_I2S
 	  mode, IP receives audio in AES format, extracts PCM and sends
 	  PCM data. In receiver mode, IP receives PCM audio and
 	  encapsulates PCM in AES format and sends AES data.
+
+config SND_SOC_XILINX_AUDIO_FORMATTER
+        tristate "Audio support for the the Xilinx audio formatter"
+        help
+          Select this option to enable Xilinx audio formatter
+          support. This provides DMA platform device support for
+          audio functionality.
diff --git a/sound/soc/xilinx/Makefile b/sound/soc/xilinx/Makefile
index 6c1209b..432693b 100644
--- a/sound/soc/xilinx/Makefile
+++ b/sound/soc/xilinx/Makefile
@@ -1,2 +1,4 @@
 snd-soc-xlnx-i2s-objs      := xlnx_i2s.o
 obj-$(CONFIG_SND_SOC_XILINX_I2S) += snd-soc-xlnx-i2s.o
+snd-soc-xlnx-formatter-pcm-objs := xlnx_formatter_pcm.o
+obj-$(CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER) += snd-soc-xlnx-formatter-pcm.o
-- 
2.7.4

