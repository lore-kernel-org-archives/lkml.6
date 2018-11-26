Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E32C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727CE20664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DWZHbzgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727CE20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeKZSBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:01:35 -0500
Received: from mail-eopbgr710069.outbound.protection.outlook.com ([40.107.71.69]:25376
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbeKZSBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3xpn+seqQXOSqguswk+4Gzb3d2d8/1AeL/XfpQ1Q74=;
 b=DWZHbzgzBPQ6ubdnk1RPxHWcksGd+cWl+hWE24gTYlC5L/0Q1x+BgXG0HcIfPLsdhQXJ0lP8o9KJGVK6a8oNsjTcZ6aDjZ9IlSLNdwSygIQtNVILqf/j+H2WWoI59CUKxrThlmBfrO5NemqMgzHhJRt8UBlAExYAqoku29rs7ik=
Received: from DM6PR02CA0028.namprd02.prod.outlook.com (2603:10b6:5:1c::41) by
 SN6PR02MB4464.namprd02.prod.outlook.com (2603:10b6:805:a8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 26 Nov 2018 07:08:15 +0000
Received: from CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by DM6PR02CA0028.outlook.office365.com
 (2603:10b6:5:1c::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1361.15 via Frontend
 Transport; Mon, 26 Nov 2018 07:08:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT030.mail.protection.outlook.com (10.152.75.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
 via Frontend Transport; Mon, 26 Nov 2018 07:08:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gRB0A-0005r2-1r; Sun, 25 Nov 2018 23:08:14 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gRB04-0007FU-Vz; Sun, 25 Nov 2018 23:08:09 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wAQ786X3026365;
        Sun, 25 Nov 2018 23:08:06 -0800
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gRB02-000758-42; Sun, 25 Nov 2018 23:08:06 -0800
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>, Harini Katakam <harinik@xilinx.com>
Subject: [PATCH v2 2/4] net: macb: Support clock management for tsu_clk
Date:   Mon, 26 Nov 2018 12:37:50 +0530
Message-ID: <1543216072-9623-3-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(346002)(136003)(396003)(376002)(2980300002)(438002)(189003)(199004)(54906003)(106002)(316002)(9786002)(110136005)(16586007)(5660300001)(305945005)(106466001)(63266004)(5024004)(36756003)(14444005)(47776003)(26005)(77096007)(186003)(6666004)(356004)(126002)(336012)(476003)(2616005)(446003)(11346002)(426003)(48376002)(2906002)(76176011)(7696005)(51416003)(486006)(44832011)(50466002)(4326008)(575784001)(36386004)(8936002)(50226002)(8676002)(81166006)(39060400002)(81156014)(107886003)(2201001)(478600001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4464;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT030;1:XdiB8tMzQq+56+7n9+Tq08DxqwJsK8NG2XfRdI5HrrABIFC9QtVE/uWSYozbHNTgGHbmMTZOTdjwkj+BHH2lvSR+yBqo1aDfDAwQizq08UomeQ8cpBwN5eO+SUK12ToG
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38b09a3b-0093-46cf-19c1-08d6536def33
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN6PR02MB4464;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;3:+cEoiP9RXtMSyDBnoa+WNLVfbEE2jv860U1ZMxkAcYmsvnYZ26SssEImmOFOghG7P/7Ruk8jNrAPYLD9AIKMEn+I9DuMvrV31zktTGDf2lmWapBbjvny/pIdAmoCTepfVk1Ol5VZwMmL/BUxASwMGDE4tEPAcLnz7ClrC9GPicGtsi4kvjSWw5H4bo1zKURu/h7XrR+J02R0WRgeDPR8cSprB9AvqV4Do9hUcKXVVJ2U659AQ2y6nPXUIKNAgFrfoBZmxOCS55TcCCPnrqV8Nh4oid9vEHqlJUm2qSRZJrZ+m8Xy60OC3r/1BwHxLj+8djo3z916541941yRAqskQpnSfNqmMHMiwNBPzLK1Prc=;25:FvrSJWHK0Na2Sm9R2wK9XyLJYNEIcdw+ViXqQQfZ4ZCuIt+bz/yxhes2VVIjPTr4LU/y77HSvkjXn9xO/z6n59vC8o7WPx4l+5Z3bTcn8/64+oMKrMOlrxXvbWV/xisUr2kRbNOiRA5wktZP78eapeaYgMI8Fc+De5zHkrhJ0ekTzGnCrpGeu3hA9QENhlxBcdEpRyhjay19gzvnjDzLLbmjRK93yBISjhXrCS5AHrj+lCSS3+4PELYJCAcq14CjJoUX2xe//fiOXQVt1DV9qibLFeqqujvMtJnOe42BhuGma4uSsm3ETuBKsNx7FJ9q71wbKcXSuZo8Ah+T7oUiDA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4464:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;31:IL8HHdoan4CI5CA8vUYotSwjNSJytNpWM0UwWPBitU2oszZRs8+uHF7SsxRXIC5H6dF6szN3sghRV0owBJuG1aCBf6eLVdFqK39PDT/J1vHK1He4rZWPGH2F+g4zBSsy3ZHS9yA0+vb4C50qUWyGmcffK+GsXj8bppS9kde08JioNE/3iK3NtkUG9vE9WdaZ9XYyGX2Qe1V65MY0p8QNddaUa9dJg0m6HeYC8B7BMqY=;20:AE7fvhwJ6BEMJxdnTL1lxCumicY40ykEa9l84uoLv3yGCMpdzFZ9UjSRjcWOPTIWpOycoPpOJItecI0UQWF6rJAMm/REmznCYraGpbiRxSg5wTaP0uBCUvTsxx3rFC4RV2Iq7d9ytzEAcNInqtC1pvWUD15pEesBGE6Z+4KrGlqzPpiCv91DpH+W2UnlQNQN1o0E0EaQVlux6NlcAGS4d9662nGin8K5SEjDsV83PZvxHZsmM41Fmn9UvjGG5XCskYdJhLpmWoy1VhSC0Aonk3aiiFzNJWQsSrnj/OpRwaps1gfmtmpL/kLx5cOxUl7nk4LMtfmZ5jL/Rn9tibNqLsF4Y4jrp54uPw6FbEp6MRw/OxEeiRDFAPoQTsgbbeQHUzjGBGhYwabXwmuKtIjM2GTnshxmJ/Dv6zruJax6r2WAuvzzbfc/yMj1dakXE8KzbE/KUre7+0REhpXLVYFD9ldQX0QGjJpPgnFcoLcZv9dMxdtefeZSQlrVexcGGyKa
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB446415C185199165A35FFB2CC9D70@SN6PR02MB4464.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231443)(944501410)(52105112)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB4464;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4464;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;4:5UqmGJBmrY//GF+UVQ4o7irf9OKygnk+ye5UOEqm5zsEXwNgdx/e+oVtLeagWTc1+pz8QIWIDUBQNvnR/YH28im8AHvUX1J2ZkJq3IHw+8Pbjtzg+2G23bUJM+w8bzArcoPZAtfBq4fGXmapZ49V0guD6NxiSLt2rrPuHuF8ztfW4SdMnuENbdVesHnsNdnFgM2uEn96fWNaaJMm1tyzSRV1Tfoq7qX3+NzTduTOo3BFVnpti8ux9/VN/j8W4GB9xojWG4B5aP6NK+n3trp9SQ==
X-Forefront-PRVS: 086831DFB4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4464;23:rnc+CL8hmP891bup8tdeyOnayppqtwNVSDfYckmog?=
 =?us-ascii?Q?WMxNXRCyzSXmo8FZMbd4vt5aS2qhvqUznFhuE+bbZgoDCpuEIJTF5TyjGUQG?=
 =?us-ascii?Q?BYgmrW/odbkGrxS+YPmzIdXCRBoHYINu1wjI4s9RXMoSwP3MMkM7UU+rQsVu?=
 =?us-ascii?Q?X1tr7ZYtMNPjIFu/+9miSmUaM+yYLa9HX3oRyNlTZybEh431cQ5GRSrJUYrI?=
 =?us-ascii?Q?3P14OEKJzgU1/r8xOL7LD2h2gSpfRozhA6zuafSwahppz5ojOKCvelqCwW0M?=
 =?us-ascii?Q?1wTO7FJshP/rsNBJK+X36WIQgHYUcYmpyOMx/Lox8QV4SVmvVjf/DVXkNdr/?=
 =?us-ascii?Q?RzAvuFGSEeP6jrCLpKvbTAbcxFRFCR8GCrzC79LSJdS302GHzAO/RDeyrcD3?=
 =?us-ascii?Q?rLGo3Mk9Q63VO+Ws1RrIzAcGUPnQv08NLiy4vzraRahDfPd8zd2PUajMjOwd?=
 =?us-ascii?Q?H+dUpF4bGmE6eeNWWwrIDd6zABn2T+Y8gZReX6hIJEhfW1PV+t8MOWrZQZs3?=
 =?us-ascii?Q?0n6JdwxtnzfHdA7/miqcRXbU1VIdqXtLuRae4k4N8RxxBWLFE5R4No3xJvz/?=
 =?us-ascii?Q?9Q8URYTIclAo42l246Q2rhyoTNAhmy1yKZ7ij++zpGyB+MnjyMGT8duawc1e?=
 =?us-ascii?Q?AuGGszY2VBxhVGs8vnhaF94hklazOGt/Khw4FnKd9hfQzokhMk/dCwsMp3bl?=
 =?us-ascii?Q?fVZN1sYoKoQgmIkwf1GZf5loTx9N/B6uJq3De+e3W7eIKdkReH2CwwMqS6nk?=
 =?us-ascii?Q?JhDE17Cm173tfVgaaY+VYc3i7tyevlxxxMfEXhoDF7VOP+45N9osud+bpjSZ?=
 =?us-ascii?Q?fLS0+Pn+IlgKSjgWzeZEzUqTIfc1PB7g9WRmZ6PI/RhMq0VbqyrnriVJj1D/?=
 =?us-ascii?Q?rpHVVOh3jisiSrw+9TcMzcWL8bzZb+zu7aba0/fwAE5HEZoNZ4JKhqtotcse?=
 =?us-ascii?Q?tViDhZC5Gz1OZluTOqUUvUAMqetYO8D/tq/BHTAnClpX8cb5IjIw0PWtg56j?=
 =?us-ascii?Q?5XogKqggdkhbep/8eivP0B4q0Pd0cXvt9wBuCyBHwBDTD5f+k1ytvlbiiTLz?=
 =?us-ascii?Q?worTJuUzvr0qzF6v1RsavCxcnFubqAUJq4CkDgfYhNu/I270MPz1oIOIryt4?=
 =?us-ascii?Q?Dh9Ib/BdZV5NlPn2LJUW1cpsAGqE3qVRNeenpdLOMQXQnJi4b1FSJcHyYqaF?=
 =?us-ascii?Q?mjgamkOZvdh0EkJJwd4k9YIFFczW3UUAHu1OSmXxqSN/tSmCZEs6ZZzNw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: SwB+BvGbXqfcs2a6eKPyLdUTXWHXE2OKGN0JZhbbgukOXNZtb4EnOn9dUWvfztsvTpquhjpGXfOwKWOUdpyAsFro4cNoc72605+uRO6kJw8N/y0zYIh7P/DybzxYHWvBizWdlYl2ar2LdKaMdGAbpOEU+8XhWnmHT+Eh/lIY+kRDZO0q/kEyxNTIHzW7kbR81WQ7jyoNn4UiZZ2AsS/XyMX50UnYzIQ+JOhwp4VlSBNaQiG4nzEHw0oouXYt+5xTouabP2IA3wIWf1cQkNm9uaRQVpyu/yl2Mm8eFvdJyvC4eTwHGh2k+Wy5jmKVDdfYwAX8AcqEV28idsnr7qTe/pa+IE6s4D1FFlwtVf1Z2eo=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;6:iab1ssJKUkYluY4XtmdpOQ2nOnEUjCeFuAhBC7jeTWzn8Yz3e/whbItfGAz6EvsI0txdeGyAGKjkPUmz6mfzMT/qi4bVT+EOAy35rTUkzVNUHKqnlp1mJmBdXPkfo70kSYqQqDGMzUaIBzKFUjvAHC5p1QgMeJbcxV7jHpHr06q/aIO1gdIP/IIW3zHhmRdoEC9s7b9xvsI2d6v4g3HZnrmxiJM57Jt/DQlfNO+XcYtokFTqDjIeO1zpqNFck3Mc7IKt+snbcWP55bBkQcRKNuNUdmfS9LJTweQ0Sbqyl9Zz0aqwVwC3gAz7lZ8lSUoiLI6Pr13ltysmGhqLle4/orPsu69/6wO2BjfuoRMKQm6IFY4eB2ta9m6kKYVqwLVGZNqUt9+TMYokzuwemup7bNqeFlS/z6F5suYHpMrV/Lem/JnxBMaGRieta2Hlv/CCsf/Dh9P44/827TAPI0JkjQ==;5:e1CBO92TnFzAn+NrBy5Bp/h3GoyQA6UUkpfGO6mokb+IyxYq5jKZYO3JblH2aducOsrIvFPnvEHOw34edIQh0+dUqnZx7F5fC0TJj2zgSseWkuc5ZLnkpw7bRKu9xurslUFgijbsmi2MPe4YB29pn7SnveCjDm9QpLrxnehOYFE=;7:YLyMY+KnUbDEqFKoOSQfigwIilvVRsE0WXHko+CCXy+KWaNWrEZLAR9Z6lrtgO0xVCxfyveecd22krmeGrLBS5s5xMLfDQhU4sOlzbLmjU0qHqgrHRtg7PKbJIi+gcUcQ2L4U2qS/0BTNMHpuwlvbw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2018 07:08:14.4773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b09a3b-0093-46cf-19c1-08d6536def33
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harinik@xilinx.com>

TSU clock needs to be enabled/disabled as per support in devicetree
and it should also be controlled during suspend/resume (WOL has no
dependency on this clock).

Signed-off-by: Harini Katakam <harinik@xilinx.com>
---
v2:
No changes

 drivers/net/ethernet/cadence/macb.h      |  3 ++-
 drivers/net/ethernet/cadence/macb_main.c | 30 +++++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index df7bee1..e0fddff 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1085,7 +1085,7 @@ struct macb_config {
 	unsigned int		dma_burst_length;
 	int	(*clk_init)(struct platform_device *pdev, struct clk **pclk,
 			    struct clk **hclk, struct clk **tx_clk,
-			    struct clk **rx_clk);
+			    struct clk **rx_clk, struct clk **tsu_clk);
 	int	(*init)(struct platform_device *pdev);
 	int	jumbo_max_len;
 };
@@ -1165,6 +1165,7 @@ struct macb {
 	struct clk		*hclk;
 	struct clk		*tx_clk;
 	struct clk		*rx_clk;
+	struct clk		*tsu_clk;
 	struct net_device	*dev;
 	union {
 		struct macb_stats	macb;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index fd86ece..32453d4 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3293,7 +3293,7 @@ static void macb_probe_queues(void __iomem *mem,
 
 static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 			 struct clk **hclk, struct clk **tx_clk,
-			 struct clk **rx_clk)
+			 struct clk **rx_clk, struct clk **tsu_clk)
 {
 	struct macb_platform_data *pdata;
 	int err;
@@ -3327,6 +3327,10 @@ static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 	if (IS_ERR(*rx_clk))
 		*rx_clk = NULL;
 
+	*tsu_clk = devm_clk_get(&pdev->dev, "tsu_clk");
+	if (IS_ERR(*tsu_clk))
+		*tsu_clk = NULL;
+
 	err = clk_prepare_enable(*pclk);
 	if (err) {
 		dev_err(&pdev->dev, "failed to enable pclk (%u)\n", err);
@@ -3351,8 +3355,17 @@ static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 		goto err_disable_txclk;
 	}
 
+	err = clk_prepare_enable(*tsu_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable tsu_clk (%u)\n", err);
+		goto err_disable_rxclk;
+	}
+
 	return 0;
 
+err_disable_rxclk:
+	clk_disable_unprepare(*rx_clk);
+
 err_disable_txclk:
 	clk_disable_unprepare(*tx_clk);
 
@@ -3803,13 +3816,14 @@ static const struct net_device_ops at91ether_netdev_ops = {
 
 static int at91ether_clk_init(struct platform_device *pdev, struct clk **pclk,
 			      struct clk **hclk, struct clk **tx_clk,
-			      struct clk **rx_clk)
+			      struct clk **rx_clk, struct clk **tsu_clk)
 {
 	int err;
 
 	*hclk = NULL;
 	*tx_clk = NULL;
 	*rx_clk = NULL;
+	*tsu_clk = NULL;
 
 	*pclk = devm_clk_get(&pdev->dev, "ether_clk");
 	if (IS_ERR(*pclk))
@@ -3957,11 +3971,12 @@ static int macb_probe(struct platform_device *pdev)
 {
 	const struct macb_config *macb_config = &default_gem_config;
 	int (*clk_init)(struct platform_device *, struct clk **,
-			struct clk **, struct clk **,  struct clk **)
-					      = macb_config->clk_init;
+			struct clk **, struct clk **,  struct clk **,
+			struct clk **) = macb_config->clk_init;
 	int (*init)(struct platform_device *) = macb_config->init;
 	struct device_node *np = pdev->dev.of_node;
 	struct clk *pclk, *hclk = NULL, *tx_clk = NULL, *rx_clk = NULL;
+	struct clk *tsu_clk = NULL;
 	unsigned int queue_mask, num_queues;
 	struct macb_platform_data *pdata;
 	bool native_io;
@@ -3989,7 +4004,7 @@ static int macb_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = clk_init(pdev, &pclk, &hclk, &tx_clk, &rx_clk);
+	err = clk_init(pdev, &pclk, &hclk, &tx_clk, &rx_clk, &tsu_clk);
 	if (err)
 		return err;
 
@@ -4026,6 +4041,7 @@ static int macb_probe(struct platform_device *pdev)
 	bp->hclk = hclk;
 	bp->tx_clk = tx_clk;
 	bp->rx_clk = rx_clk;
+	bp->tsu_clk = tsu_clk;
 	if (macb_config)
 		bp->jumbo_max_len = macb_config->jumbo_max_len;
 
@@ -4141,6 +4157,7 @@ static int macb_probe(struct platform_device *pdev)
 	clk_disable_unprepare(hclk);
 	clk_disable_unprepare(pclk);
 	clk_disable_unprepare(rx_clk);
+	clk_disable_unprepare(tsu_clk);
 
 	return err;
 }
@@ -4168,6 +4185,7 @@ static int macb_remove(struct platform_device *pdev)
 		clk_disable_unprepare(bp->hclk);
 		clk_disable_unprepare(bp->pclk);
 		clk_disable_unprepare(bp->rx_clk);
+		clk_disable_unprepare(bp->tsu_clk);
 		of_node_put(bp->phy_node);
 		free_netdev(dev);
 	}
@@ -4193,6 +4211,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		clk_disable_unprepare(bp->pclk);
 		clk_disable_unprepare(bp->rx_clk);
 	}
+	clk_disable_unprepare(bp->tsu_clk);
 
 	return 0;
 }
@@ -4212,6 +4231,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 		clk_prepare_enable(bp->tx_clk);
 		clk_prepare_enable(bp->rx_clk);
 	}
+	clk_prepare_enable(bp->tsu_clk);
 
 	netif_device_attach(netdev);
 
-- 
2.7.4

