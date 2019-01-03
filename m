Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CFFC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A225421872
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="c7K1urIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbfACSKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:10:12 -0500
Received: from mail-eopbgr810070.outbound.protection.outlook.com ([40.107.81.70]:11136
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732643AbfACSKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xuadbj96gW3y7CW4e2DWhRuHAluLf2s8T1gLEXhD0Vc=;
 b=c7K1urInX0onHMruV5uL9/tgXzPJ7ap1Sj9xnlSRct+UGenNjlgSceC28KqK8uL4qQTMRsg8jEX3Rc1U3tKUZ8/uMR7zVl1a7alIwGSK0LzpvARHz5NN5cqrB47L/RhXeaAZJfw/Ycisbv99jmm5Tzct1D4d1VEcXvRP7yinyjY=
Received: from BL0PR02CA0055.namprd02.prod.outlook.com (2603:10b6:207:3d::32)
 by BY2PR0201MB1896.namprd02.prod.outlook.com (2a01:111:e400:58b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.7; Thu, 3 Jan
 2019 18:10:08 +0000
Received: from BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BL0PR02CA0055.outlook.office365.com
 (2603:10b6:207:3d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1471.20 via Frontend
 Transport; Thu, 3 Jan 2019 18:10:07 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT019.mail.protection.outlook.com (10.152.77.166) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Thu, 3 Jan 2019 18:10:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:52681 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gf7RS-0002JC-8M; Thu, 03 Jan 2019 10:10:02 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gf7RN-0007he-5I; Thu, 03 Jan 2019 10:09:57 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x03I9pZs025385;
        Thu, 3 Jan 2019 10:09:51 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gf7RG-0007fE-SV; Thu, 03 Jan 2019 10:09:51 -0800
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
Subject: [PATCH 3/3] ASoC: xlnx: enable SPDIF driver build
Date:   Thu, 3 Jan 2019 23:39:53 +0530
Message-ID: <1546538993-55473-4-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546538993-55473-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1546538993-55473-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(346002)(2980300002)(189003)(199004)(478600001)(36756003)(76176011)(2616005)(476003)(426003)(446003)(11346002)(47776003)(50466002)(48376002)(7416002)(126002)(5660300001)(336012)(77096007)(26005)(106002)(186003)(110136005)(81156014)(8676002)(39060400002)(8936002)(50226002)(63266004)(305945005)(9786002)(16586007)(106466001)(51416003)(36386004)(7696005)(316002)(486006)(2201001)(356004)(2906002)(81166006)(921003)(107986001)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1896;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT019;1:AopVB/n9yAxBY9J0htccNdcJ54788jEPJHMvyG9i5/tjsUP4y2/G+5yiRB2DzRBN16aNfkfXgAJsftdCrgcz2RfqP6JrQzk1N+qE50zhjWpYdquHhpJz6pLoaHUNps+c
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8472cf06-e203-4f1c-f5a7-08d671a6b11a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BY2PR0201MB1896;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1896;3:D5mRrfEIFXwQNtPhgjW53PeOYrEvFRu/q8//QGvFRybGfGftf7fmVKN7r9pM1GMx/peGrPctpit1iPkCYkE4BOz6WRNoDYBBVZCN84cYD3t8hILlYcPOtO8UJhqspi9EPqRuJYvu6ErgGoqOwClylvWlClXQeeXmkIQIXcJT4RTThR8iWKj43d3zGuUQpgYvO5RT9znObEkbi9ydBMq/KylDgarxQ3PGJcCaYN57o5q8Jgv5yycbrTQBYMp6mVf1yf/eqmmI0PBt6xmzY3qdbcw+geBrI1Dw/ryWUvcOfMIF+sXtVO3Y05uVrrkEG0UXLcBTH/rwjt6+UrW2P3gJuVG1s+tQfSxZKgpOZVWtEc2i/oO55hA9xlNL3QBXfnUy;25:4m3zyKR/dyKmltcSr8FJ06/vQMR/vUS8FNP3w/wZvS30G0fLtdVplsgB1LeLG9SWeDuokMfP6Jmtxm7l7EiaHDNTsPKg8oqlt12Ot9Pwot7JSIdeb2dPR1vdYi4JtzJTuw7/TizTElQz3TMZc1WynAXbjEJm5igDCNFRJ/z4GCv5BSdHuDNoSjGOvJAeHoSdHIBMyuLqF/WIsE5VT/Dzxdlp7kUrsP4rujYzW4SI4hgkouyqVZi/FlFRJukOnQ/ArQ8qjEKrVu08Y6WVCfWnpqxEdfAW5DdbpzvOYHqwNWv/PkHbjdNKpqvATSByuCXRE5WbgYZSSWHOVubaOWyLbg==
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1896:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1896;31:8+mtSdd5u37jh66VQk4dNiCEIUyuvpg+M2n7LaCaGHzHNlprlJyR81B9gb4MtJwG2qAflB+kbbzEytD27S0mY/bU+/BTcrn04j3PxzFYPOPf6PlUKEbizJV7i+kJ8H2CqDRH1uRWtK3U1JnK1pJiL5woVL7knVs9TKMxXs3kfv9re/EmeDib8jWwr4D8NpTo9x+kNWnL5h23moDqym15uZF3y21JdZdZqcW0numlVW4=;20:ElcJD8kV9naos7IKKHWQm0wnctGHMWWo1BmjmuilYFHsEOZU6V8ab8ai+8WjzY6lrqQFIfarxWbyHmbUFFUwZSa0Zz0/nCubXUWNOJ60IxOo114NfCNd4QelRSbvMggqKKrqQhZ0YoU06snrtT8tTSfBsotcGNDC3v97YMX4xR8MDYV9kQ25Zx1LEUOEVQPxS/rkWNrVF8AF9gI7O5JQjzP/ISwS/KEC/gEIv5cjMBMgbV29KYfL2rs7DtNe5rvWVIIZyAuMUQ25P4xgDp7jEuUAm4q3cwBOX6OpMGqqQhmCaHagAAk+dIFEhcPaeUtcx/QXMzN8nAzKnNqYJyCStnrRmLxhDPhHyVuVH0HON9gwuCcLQPCP+tQg6utRtxS3ZQKFlbe7FAxydupJYVYz/97Azm7Scs6JimHXT+qATl6PngWespipi1y/pba3lkCwIszbj3AR/P6oGxvKHVQbIq4J2iEIkCSCq15BqnfUiSNzoSYmVSA93whaS7vujbQi
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB1896114CCDEA177256801D06BA8D0@BY2PR0201MB1896.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93004095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BY2PR0201MB1896;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1896;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1896;4:GSwmdlFQJ67MGbGW3b0qfiCmSf2jM/EeR4hp9JUnQrnCsUWv3pkh/4LzMqZBrKAkBdlCGae5e+9qVkg9noyqO3Y/gdIF05LlyvUKkwtQbXmOEiBS1ESckTc/nTJvdcJ7WbL4m9oOvOA387ElMg/ZfoaP+5/HqCC0lWwU8mNOd+s5dPw7H9WTmlT65APeJqigW0b6CAys37fw36ZDCjYI1A/bXijV7krsQlSvwmScjkpqoy1rZeXJ+P73dp7FQ/sgMzb0kvZC2v2r34mGHHw23ADb8uF+b7fvSTHLxS8hC8H22362bpOfnoScz0VdxcUu
X-Forefront-PRVS: 0906E83A25
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0201MB1896;23:nLCkYoSdJcfCrIl7fkTasj0d9OAY/2pcH1NOmF9?=
 =?us-ascii?Q?HYMS5ntBu8rhBRYlXCHwNciuvTsVCx3cUGHScVpzcYGOsggHCVv8c0IciISv?=
 =?us-ascii?Q?97BIwlWZFXjBijNInaBAKONirzZM6c9HlN0tdeud/WVByVL5KELHvAnysOvp?=
 =?us-ascii?Q?WT/RW0eWduGMmh/ZUUqqtRsgrGrbXpOdDBKpZeSRkwxoHoGjFxDv/GZAhmBF?=
 =?us-ascii?Q?NPixfHJhVsC3twRRpL0JdWK7LAXfzcRK+Cxfh1aglOxjBXFz/wjKf8f/kWV+?=
 =?us-ascii?Q?1vFlojcZf14lTyGZ4Bt0mNHGW7SPK5qVqjAKRQH//bxLOnZcU7pRyfsDGatU?=
 =?us-ascii?Q?pwjBsmXOgSgomY7DHt9MIFbJcBZO24WrY2mndemId8nfBISLnbdOR2pf3oyB?=
 =?us-ascii?Q?xTORbUuLEfB7x+idmru9g2M7Eqg5EHeqp+3O4/oPQ56d63HeY9DnE3mrkxLs?=
 =?us-ascii?Q?fLWcVdH3WvDwqat9EuzmtN/0hlfKM3T8oMzYZNMUKFT4otDUO+gZJ1ekSYSy?=
 =?us-ascii?Q?d0nt5pU77m9kfpS02uZ8OXAEKjoU8N9uf284FTUEgjk6gsp9179v600xv7Nn?=
 =?us-ascii?Q?Qh8AkcM+XlLCK2vgEwD/XFDUwPy8E6oxiKtpr2T5SlGEfQaruaqfsUAD0B4m?=
 =?us-ascii?Q?WbDGPNUYDGuQUvdy+0O12pOGpUeQ0oiH4yfZCAkXeNM2QuT/kFOXmnZA9BlK?=
 =?us-ascii?Q?ctt2ABbN9Xvk6KDs6ZiPhfMWtPxGN/bhuKBoBwWMtNvxRp8m/ne4/I50jx/m?=
 =?us-ascii?Q?1ICkmZ+hIxCGO4UW+wBq0TZ8w9STfcUiIVA9Vb88w1DIQL8p56EjKLYwOmhK?=
 =?us-ascii?Q?+j+ddVRrwTXpwdoqOkQe+qClmi7PLf+qCEoMilrN24Sy4wv9QdQLGHcdebb7?=
 =?us-ascii?Q?KpzD3J3lu9LsQ3UO4iCv9SxndKszirbDXWUAecHrM2/YFiI10ZZXQiFiBJAH?=
 =?us-ascii?Q?z20QupX2tiLo37Tu2x2NExqihOSakKenhpzFjnVTmkbRVlssktX583vtymWA?=
 =?us-ascii?Q?oGe8vo0EbpPmLhfLUfKCveunIsxAbDZo0tRHUoJRXDhV6lk4G65Jvinq3h2E?=
 =?us-ascii?Q?sUKM7ZjJs+GlEZbunciuHVMQQXLzzvlUsoyOkB3bGaNUU4sz3vyMh+SoT+dX?=
 =?us-ascii?Q?JJ5y5/Q9BoV7sqRflDCyLPHI6k6Rv4ewV?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: F7tWFfehoDtDr5mY4R2Aj8eQ+jisrmA6Ar6b/u1ul5v9mYpwOq6Hr1o9TV5L9wWPot5Sryr6hEFdkNNXVL0cpF9cWR0Czg6CxWr5RbMxDv59cvgha/eDFkXUcN8OF4ZllYvj5sM++oRUhP8XjtdruL4XuxuYTSkvD+rK4FWOFvhf0rzpCYmidDdNBh45KtdB8+wVcDQTmg5C1rRCqel/u3jsoDzBKDPaoYykNnoI07T0tL0hup5l1wxy61UbqSnLV7dJeHpyz1S4uEgCQqjFvduvJ0zilifOeGxAvJDFHWp9PXwby8MgVLk3qdza/TdJ
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1896;6:7WKuBtaLmVVvhi4iRS5E0mst8bqFdER9qP0zUwrtgxxj4lA06WBHEEDkJcTxVs/VSsRTay+HOJdQoNIpKLwym/qbqPC/6iNgg+HVXou0XrzrelbXONnpgExTmGAnsnvONyqS4e0aapze62A0qP1fEqRKez6uuomv+japFaILxssZi2QXhWinifudiU6i5BJB0zXmCuz054BsbI9CBGL7UwklFxWRZ5otI2TXhHIyBh9gq0/mUTqXq/Fs4X5DB9N0otNcKzQcSkIXZKxewdNnUgZr/TJJr1Nuyx/e5EfmUSOz7CbUD0OBtApJKshJ/FgrGVQVIycqvJdRT1qu7NwwEq2F9s/oaDV2/BS7BnR4xTjjZ8z0+1TRSjA/umswbr16BXQBLJz6eT5cSTbogbw+xV7xc6ELGGF2I5S6eh+kiuJ+21sNjM/7KzseWsE5TpigEqjq//T7kIKDS2qnzgmBqQ==;5:YcEa4ohPVXms59hjJWKvorHU9TkvsTNj9rziHGoy3XjQDR3Zyi26VmqynIWJ1iwJuwzC4x6YI9afN+PzocvE1qx1qS5evW1PzPeWIbLKi2BJiq05aL1wJj7jU1MWykXKNEOAVF7b268VsBJqHE+6x7Ol+WoJfjmi3tbuC6gqF7uXKp9RrDAZG5yvE7vfc2LOSMNFtj7WwthEf3OIbPxVCA==;7:o/7p9JouOl5iASjXKsGw61RH6q6iXCPgdU2dJOyrHx8efQRDN40FFAysoHA/UwoTcDEhUcOvqXZHds8VrDdAJuLyFaG6tFpopVLUfA1aLutFmF01vbnrVOyex34EwT2mzJX1DIK4JP4317J8L7qh7A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2019 18:10:03.1846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8472cf06-e203-4f1c-f5a7-08d671a6b11a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1896
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added SPDIF driver build related changes.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 sound/soc/xilinx/Kconfig  | 7 +++++++
 sound/soc/xilinx/Makefile | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/xilinx/Kconfig b/sound/soc/xilinx/Kconfig
index ac48d6a..47f606b9 100644
--- a/sound/soc/xilinx/Kconfig
+++ b/sound/soc/xilinx/Kconfig
@@ -13,3 +13,10 @@ config SND_SOC_XILINX_AUDIO_FORMATTER
           Select this option to enable Xilinx audio formatter
           support. This provides DMA platform device support for
           audio functionality.
+
+config SND_SOC_XILINX_SPDIF
+        tristate "Audio support for the the Xilinx SPDIF"
+        help
+          Select this option to enable Xilinx SPDIF Audio.
+          This provides playback and capture of SPDIF audio in
+          AES format.
diff --git a/sound/soc/xilinx/Makefile b/sound/soc/xilinx/Makefile
index 432693b..d79fd38 100644
--- a/sound/soc/xilinx/Makefile
+++ b/sound/soc/xilinx/Makefile
@@ -2,3 +2,5 @@ snd-soc-xlnx-i2s-objs      := xlnx_i2s.o
 obj-$(CONFIG_SND_SOC_XILINX_I2S) += snd-soc-xlnx-i2s.o
 snd-soc-xlnx-formatter-pcm-objs := xlnx_formatter_pcm.o
 obj-$(CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER) += snd-soc-xlnx-formatter-pcm.o
+snd-soc-xlnx-spdif-objs := xlnx_spdif.o
+obj-$(CONFIG_SND_SOC_XILINX_SPDIF) += snd-soc-xlnx-spdif.o
-- 
2.7.4

