Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CD3C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8422C21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sswKfz66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfBAWJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:09:21 -0500
Received: from mail-eopbgr720071.outbound.protection.outlook.com ([40.107.72.71]:50176
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726740AbfBAWJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRpVOCM6ngbHXXWym1UvBWBRbMKIWQaU+4lzzI3Adro=;
 b=sswKfz66LP1DtTvOjNp4XbF8a1HxMo9Y8IZHjRHfmWzXF12uTK8o3UNxlUdoeatt4O7kK8DOMZLUGuu+q4+q2xaNiWnKeoV/98kiPnAfiHBTqdHv3cB5mwxAwi6abhzIak0Up+pXcwOkah1xns6icDDoENgBaE61AVo2O0F8Zrg=
Received: from SN4PR0201CA0035.namprd02.prod.outlook.com
 (2603:10b6:803:2e::21) by BL2PR02MB2145.namprd02.prod.outlook.com
 (2a01:111:e400:c74b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.21; Fri, 1 Feb
 2019 22:09:15 +0000
Received: from SN1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by SN4PR0201CA0035.outlook.office365.com
 (2603:10b6:803:2e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.20 via Frontend
 Transport; Fri, 1 Feb 2019 22:09:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT009.mail.protection.outlook.com (10.152.73.32) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Fri, 1 Feb 2019 22:09:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gpgzq-0007Ts-6x; Fri, 01 Feb 2019 14:09:14 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1gpgzl-0000P8-3z; Fri, 01 Feb 2019 14:09:09 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x11M8wLp030350;
        Fri, 1 Feb 2019 14:08:58 -0800
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1gpgza-0000LK-LD; Fri, 01 Feb 2019 14:08:58 -0800
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v4 2/3] firmware: xilinx: Add APIs to control node status/power
Date:   Fri, 1 Feb 2019 14:08:49 -0800
Message-ID: <1549058930-18644-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549058930-18644-1-git-send-email-jollys@xilinx.com>
References: <1549058930-18644-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(2980300002)(199004)(189003)(39060400002)(486006)(476003)(2201001)(126002)(6666004)(356004)(4326008)(63266004)(50226002)(44832011)(106002)(26005)(426003)(11346002)(336012)(50466002)(48376002)(2616005)(446003)(14444005)(107886003)(77096007)(186003)(478600001)(36386004)(2906002)(9786002)(7696005)(72206003)(76176011)(110136005)(51416003)(81156014)(16586007)(305945005)(106466001)(8936002)(8676002)(47776003)(81166006)(36756003)(316002)(54906003)(7416002)(107986001)(921003)(42866002)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB2145;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT009;1:g2Qb4n9ExSejUGUljR8ZhXiIVh92O7CqKv1RLbr+O463koj8tb2NRtT9le330FI/QayHUJE/0UMZDMEUHX4Wh074rr7JRedGb1GjKSDVWljM/dCHOI0UmQMWMxAcWzxj6s5k/3Yd7m/xO9eyC/57KUGWBFrlwrrQSCgjesBNE5I=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5ca038a-cc8c-4772-5f81-08d68891e75a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BL2PR02MB2145;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB2145;3:KzAuRigncdHIu4T7frxxm0HFba0BNs6GmRWkauAfEYGhQibbJAgVpmv1eprgWRosqNfSN2RYx7yVaSVLTjYoqa/bX7JWDFz14gkvwwhsFrDWV02sPZf4dwPqq/BcGK/gyCPUM1fh9wH9lF1ZxM4w1TWaPgYNCKyztrR4+kq8nl7083VrCiA0GZ4y2j1hIGmbLmukSUCPaJaoisWuOdZjHQu0EHczreYeB0suIL9jko4NymaAnSJIRTzNptAeG5C58zwc2FKGuUtMoXgUUaxnQ8pFNZyGCD2Vi1kYzpFWOIHZrBEUZxj/daF52UiT7bUe6Rlq53U5PR8a0xHqcqMfHaSHS3AlM+a5H8FOcM/ZamcSQBFtXHUeFRub9W3dm2Oc;25:OarPgWi5+MPOIORUHoRnPAbSXKr6IvG7jlC1UevdzRY1k/6GV0+TJtm+Ur9upT+RNjyIuDQ1pCHh9LLY1OmHNveQyTjxJYHQbui0DbBrU4/3MtkeC1hiaONdm5b5Nq4aBUBgdnpAfBS8Ib51GCgzTKOOhK2sDoxomlMoThg+LkZWIWsgn5nHF2FuSp+HHhBhbkXSX1xzR7rveLUvBA8UjwJVFRwwRHE5qtkIJzVbFSOMcHund7d1y2HTO/sJoNeZHVm3zDMWjf6GzYmdOwkwpL8q1xjzCPy8hd4L8O7KPQLG4eBueKegPiPtxZBqA0YUAC8gzGEwmxP3BViu9zhULA==
X-MS-TrafficTypeDiagnostic: BL2PR02MB2145:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB2145;31:tcL2bJfECYiDrz7uLamYpHY1jVU8cHDlvS2Z2SnmkniBmqWE4t/arTB3QVnuQ/wzNzTCAY9U1qwqmkDltdtKHsgl5Iu7KOFJR3zCcXPtJUtBSCLjEkTrwqClaeGP9nHnaVGFiOdJts7UMr7t3RpnQc5Dw7KEku0GxwDbeiIB+HGwoVydEefpxj+2TKaW8HblOMREo6peVit53VYljJVZ5hOniTqATa8D/PQK1PJWeLM=;20:1yIzgBEYB49Vsak+Nys9AfeyIxAIwhmmoOLv3xjoJKe30XWRqTPyVETpJz3kLOG/DgxpiUmKSX5NmJnThUuacMQT6hQ8kkZQaelCalQc9WS17Xfr+ohnbWnT3elzHjTGVyLYi9GT1WoO1DzD60d+ShnzU/uiRL+atwluNIQh6Z+Mcl83+E8Y9QHKXBbBR5CAjVUjYOT0O4dgRgpQsAlGce0FdimbsW+0sdA3yLGA4puKyIc9VrthkkbUi1eQ99zRbQm1Ygv1KF7IZMPblrlsgvIjJYT8+6F1ekmnSn3dVxIdjJxdbRb+EICqqbgjelxZyrFqm6C4MWu+y2JXjgvFjsKTOX/AC5vw9IvJsx/wvyxU+cskSv4TEmgSdhQuqi3Ai4Cjch6zgQ73ZnsqbPrZVgKpcru3OuiiJYVOOkZsLffqx10qgacluxwVsGwDL4Ip3jK5cuWJwZTmdD2qQSH4KAXNN3FvKP1uLevyF4PDt0bBRTYpbs2pVuBdO82WUIgu
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL2PR02MB214582530707385D50E4348EB8920@BL2PR02MB2145.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB2145;4:2Tk45V29ClMwXPS1Y0t1j16rQ9Fo/bYXGkHq7gKxsB4eAVLU/cyYqI6QlsWQSVWEgTkljOYRjTrwMcMufi4EQi8BlemaP5EzcoiuLnKL5t/LrbshYb+j+z+YX/T4yisHtS2XZ8yngTKKPa8weeUBaTc8EU9AzigTvjkXWJSoU2LVip08N53T+yYdRfwNk7YsLsgLvMScXBu9fbCwXSnXi1+Qz1KlO/NRV1VhUYYRjurIh+vBqJjbFaktbPlOPErdPdT7c6edJ367r+KbtthprGA0isdkpr1a3yazdTL83b0lUzw5P8zbEDSEqatJ6+RU
X-Forefront-PRVS: 09352FD734
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR02MB2145;23:6SGGBM8r3o2DwEX+tSU6xXV2sVBSSPWi/Zb3GaFNS?=
 =?us-ascii?Q?FhrBsyliYu7VsPDHsEeBjkNd4x44WlIa7fs9/rZShkS7+47iYIxeN9vvssY+?=
 =?us-ascii?Q?PKdJji93yt4vpCl4UWlyymAWhYJmIWtEl2Ziwgt32f/7Pb++U2M9kBHV5eaf?=
 =?us-ascii?Q?V/EAUhIGcbmSebJjUT6fpLXrMk6jPm33qfX9mPgBqWrnl+Wo4DjaHvYIUh1q?=
 =?us-ascii?Q?Uxb6xruzblAboMdr4iqc2MLpIouWYVzsKDM5R8zH5S7xBEAo0DTvXKHGtOWy?=
 =?us-ascii?Q?PeDo46PTExVO/qd5aL92BSAQduO2Rci3VKvdRj0Xitz7KFNQaS8AZu32lVqg?=
 =?us-ascii?Q?mf+faEeLkCmsYHPJXDmqbOh4Pt7S/M6Xc8X1WU/J6S1GFgJNa2rXUiesSudF?=
 =?us-ascii?Q?pDYBEYJO78/LDql5fqAg8vBJt+LcDq37DktgezBCjVDvQqDLw+OV2PzB0mSa?=
 =?us-ascii?Q?8+Ay1gfPiifETU72KCtQMrex0PSxr9xQTfSBg3LVq4ColyxQKVo04AKTy9OR?=
 =?us-ascii?Q?z2PG4ZWL6MILfsX9pjQDdjf7DJriqLnGHBo2ulJaaAt3CeNOnlBGtwIl3w8+?=
 =?us-ascii?Q?NWOuFWrE/BFEOb6ND5f50skhQdAW6nmeM5v80zU+fMw/pjGncH3amz5IXi9j?=
 =?us-ascii?Q?LBJ5Y+Kcizgo1OhyJWUNkIyIFvin9iG42DQce5dFpwrtHHOqDF8gNj25kSGt?=
 =?us-ascii?Q?vKw4VgrsXLkxA3vbz274tPTe/51jNJjTPg6+lSCpLafnZjzxiH4WvGPP/xyu?=
 =?us-ascii?Q?xqeuHetMKm/8V97ajjFVLySGCqK873PiSqZFNS14ai6DhLUGiTANfyhYIuny?=
 =?us-ascii?Q?Qs+2WZPk80ctp+m1FPSzUo8XF91FywU7nTtWC+GB9VUX4EiJRwzB+GKG11cZ?=
 =?us-ascii?Q?ORQfWtXhspZtyGX6neuIWE1OgM8AzNKizjz0C7LcMMU49x226f2uDn+ojg0F?=
 =?us-ascii?Q?QB+aza2O/Q014P3/cZHy92fI6C+57NVYAn+YeHREl8VOZB9MnCRHpUFRQ1XV?=
 =?us-ascii?Q?kIbqlyXE16CVcUhOS+0vMJ9Voiz4gOOdb1dR6UVPMU6/d/1uoplczCAiqaFI?=
 =?us-ascii?Q?E97cEIouRw0En2GdDiWj1yVKkVRC/HY/f1AFpRIqN2WaAkVzFbbLyu2qQa/t?=
 =?us-ascii?Q?ndUvIqXWzPLS1kG1VPr4pwuPEmlF4xX2cLZk6oQKUzEHxMopNw1PMaHnOjDz?=
 =?us-ascii?Q?wb9KuKlzbk50kftgtKyNdrl6xLmSWX95x3mecHLiMugy8YehN9b0MHLvu2J5?=
 =?us-ascii?Q?8W0eHr3FEqifms1lvlIAS91tUfA+CakGZ1GwF02HmP8G3QwBMoHhYzSHYqi4?=
 =?us-ascii?B?UT09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 1FpFka4VlzTgKBAx51TSg1sQGr025OzVxQgDIx66ndjW0XxRc+RiYkD6JjZMwINBPagfJ/xf752bcQV+H3X74vuI/mPKi/2wluqQhxk8HiuTdRSLynZxPeo9IgtFsAtPzp4lbukwkoj00ivObRGy6kbjiK+yOffqJLGDcZ6K402zkjPKhq1U6yL09IAEocALUNnHfG5HfL+Enfxr5msXDvsOIpFohniq56Pz4/lGGba17RajaKyNEzLOSFVb2Ll8LIbV9YeixXKZ4hhcF1/VnpYb1gHVQPELvh5/iH3r/RdS55+E34Ru5ViQ/bt+R7DSUBU9VJ6SsSJqWBBpSxQOWZTwfFWxOt0mVfsgkE8RtTF2X6ohPj59WvcmRq8c6rbWbPUtqinPdJqE7yW0TXR/XkIcjdKKeYUuTs93Nq7roL0=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB2145;6:7CPCQJ7DOkmUdor5sSFOuBLbupH2Q6Hfw4bHCJx3LMM5a23HdwV96xwoWlygyYMSYhpZXES1ue6kiZKBjolL53mJXesa/igHJ1S3XhI2/XNSNEpfwOyJZ7bElKOx+08gZ+M4I7aGoGtF7ZXV2kSeQd0naiZxNcQUTFzUUUaEwk6zfYVc3sXY+seotebfNAeD9bZKAw6c/UyGBcRrde8xcmcLf2zrR1YgFQgWWxu96PNyD6sCHFEtQq/zJ2gWrwmZ/WylB3wumpV3pWXa02CLFYALVWCw9YIwxKOWS77JMd99p7AQonImjf1Nzq9KLrBk7PW/PHfw97YWUCL1R6+yA7nMw5oPB4O1rRZfdFp+o9d1l6BA1YDOUT+sshAw+K7lqreyk7c5G85dN4qOwTn2BrBZvPtb3FhazBMjLTvLdGp5kfOajg8zKfXvQw215S6z9DyG+0hBJdRBm/jsjP9BSQ==;5:xbOYeoW2Beh0aL03i0v5wx73Mk3vYMrY1o/7yHN0ZI2bCRih2qC+YwgrwrTnPF16ujzxcZotLsuOd/A3vjHXV8wby7rj+dMRBBByVXSbD1JURDO4wX3Xlwnv1jHIDM1OsCR/BzOMEyRvOt9GUL/XeU1S5rcaaOivus6D8UEZIn5+w4wsLGSXm2cwnUP1kBgzyxgdkIGnLO7Q//NaEGPYtA==;7:eddyK+kgrLHh32GU+jvV0jriDdSTOt4v5/wknwlzfx5auininG+FCITdAY8obP0ZXqDDyEr7lxs+Xb/tbdY6N6Rurumd47/wpRLhz88WY5H2lowfqDwXmi3TBTFSEojfNtnXYYlQGr+TbeNcMKix4g==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2019 22:09:14.6984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ca038a-cc8c-4772-5f81-08d68891e75a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB2145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add Xilinx ZynqMP firmware APIs to control node status
and power. These APIs allows turning on/off power domain
and setting capabilities of devices present in power domain.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 58 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 26 ++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 8065e33..6660b8c 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -534,6 +534,61 @@ static int zynqmp_pm_set_suspend_mode(u32 mode)
 	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, NULL);
 }
 
+/**
+ * zynqmp_pm_request_node() - Request a node with specific capabilities
+ * @node:		Node ID of the slave
+ * @capabilities:	Requested capabilities of the slave
+ * @qos:		Quality of service (not supported)
+ * @ack:		Flag to specify whether acknowledge is requested
+ *
+ * This function is used by master to request particular node from firmware.
+ * Every master must request node before using it.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
+				  const u32 qos,
+				  const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_REQUEST_NODE, node, capabilities,
+				   qos, ack, NULL);
+}
+
+/**
+ * zynqmp_pm_release_node() - Release a node
+ * @node:	Node ID of the slave
+ *
+ * This function is used by master to inform firmware that master
+ * has released node. Once released, master must not use that node
+ * without re-request.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_release_node(const u32 node)
+{
+	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, node, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
+ * @node:		Node ID of the slave
+ * @capabilities:	Requested capabilities of the slave
+ * @qos:		Quality of service (not supported)
+ * @ack:		Flag to specify whether acknowledge is requested
+ *
+ * This API function is to be used for slaves a PU already has requested
+ * to change its capabilities.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
+				     const u32 qos,
+				     const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_SET_REQUIREMENT, node, capabilities,
+				   qos, ack, NULL);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -551,6 +606,9 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.reset_get_status = zynqmp_pm_reset_get_status,
 	.init_finalize = zynqmp_pm_init_finalize,
 	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
+	.request_node = zynqmp_pm_request_node,
+	.release_node = zynqmp_pm_release_node,
+	.set_requirement = zynqmp_pm_set_requirement,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index f84d700..c7a7748 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -40,8 +40,19 @@
 /* Payload size (consists of callback API ID + arguments) */
 #define CB_PAYLOAD_SIZE (CB_ARG_CNT + 1)
 
+#define ZYNQMP_PM_MAX_QOS		100U
+
+/* Node capabilities */
+#define	ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
+#define	ZYNQMP_PM_CAPABILITY_CONTEXT	0x2U
+#define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
+#define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_REQUEST_NODE = 13,
+	PM_RELEASE_NODE,
+	PM_SET_REQUIREMENT,
 	PM_RESET_ASSERT = 17,
 	PM_RESET_GET_STATUS,
 	PM_PM_INIT_FINALIZE = 21,
@@ -223,6 +234,12 @@ enum zynqmp_pm_suspend_reason {
 	SUSPEND_SYSTEM_SHUTDOWN,
 };
 
+enum zynqmp_pm_request_ack {
+	ZYNQMP_PM_REQUEST_ACK_NO = 1,
+	ZYNQMP_PM_REQUEST_ACK_BLOCKING,
+	ZYNQMP_PM_REQUEST_ACK_NON_BLOCKING,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -255,6 +272,15 @@ struct zynqmp_eemi_ops {
 	int (*reset_get_status)(const enum zynqmp_pm_reset reset, u32 *status);
 	int (*init_finalize)(void);
 	int (*set_suspend_mode)(u32 mode);
+	int (*request_node)(const u32 node,
+			    const u32 capabilities,
+			    const u32 qos,
+			    const enum zynqmp_pm_request_ack ack);
+	int (*release_node)(const u32 node);
+	int (*set_requirement)(const u32 node,
+			       const u32 capabilities,
+			       const u32 qos,
+			       const enum zynqmp_pm_request_ack ack);
 };
 
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
-- 
2.7.4

