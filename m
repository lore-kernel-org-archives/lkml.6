Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA32C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8CE20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="r4AyamjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8CE20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbeJ2U7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:59:41 -0400
Received: from mail-co1nam03on0060.outbound.protection.outlook.com ([104.47.40.60]:34030
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728416AbeJ2U7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BEBQkTbKIC6WULO2ZcmsOAUy/MV62p4YDfj/l45X6M=;
 b=r4AyamjTxOKDDH+4kh4rJgVhkwOV0idaGn5FPmzySrlUmGKbgSFRjLto2KMPJsccVkADpjIWL+yTaorTJjO5yRjYE/9RHJdwzgi/UtO1+qFWWDdYwsVk8mxMYvgxwg4Zo+bA0uFTDy+BqAMJIaADTa9OA+GCBLgoNSa4gAwpmhU=
Received: from SN6PR02CA0027.namprd02.prod.outlook.com (2603:10b6:805:a2::40)
 by SN6PR02MB4336.namprd02.prod.outlook.com (2603:10b6:805:a4::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.18; Mon, 29 Oct
 2018 12:11:11 +0000
Received: from CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by SN6PR02CA0027.outlook.office365.com
 (2603:10b6:805:a2::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.19 via Frontend
 Transport; Mon, 29 Oct 2018 12:11:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT011.mail.protection.outlook.com (10.152.75.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Mon, 29 Oct 2018 12:11:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gH6Nx-0001MC-1r; Mon, 29 Oct 2018 05:11:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gH6Nr-0007q7-Uw; Mon, 29 Oct 2018 05:11:04 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9TCAtwS007854;
        Mon, 29 Oct 2018 05:10:55 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gH6Ni-0007mM-V1; Mon, 29 Oct 2018 05:10:55 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 24BB112147A; Mon, 29 Oct 2018 17:40:54 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <manish.narani@xilinx.com>,
        <amit.kucheria@linaro.org>, <sudeep.holla@arm.com>,
        <olof@lixom.net>, <broonie@kernel.org>, <arnaud.pouliquen@st.com>,
        <eugen.hristev@microchip.com>, <linus.walleij@linaro.org>,
        <vilhelm.gray@gmail.com>, <geert@linux-m68k.org>,
        <freeman.liu@spreadtrum.com>, <rdunlap@infradead.org>,
        <tglx@linutronix.de>, <baolin.wang@linaro.org>,
        <gregkh@linuxfoundation.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
Subject: [PATCH v3 3/3] arm64: zynqmp: DT: Add Xilinx AMS node
Date:   Mon, 29 Oct 2018 17:40:26 +0530
Message-ID: <1540815026-1012-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1540815026-1012-1-git-send-email-manish.narani@xilinx.com>
References: <1540815026-1012-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(396003)(346002)(136003)(39860400002)(376002)(2980300002)(438002)(199004)(189003)(36756003)(5660300001)(7416002)(305945005)(44832011)(2906002)(36386004)(106002)(81166006)(486006)(8936002)(126002)(2616005)(426003)(336012)(81156014)(8676002)(446003)(14444005)(2201001)(52956003)(47776003)(50466002)(26005)(186003)(50226002)(48376002)(476003)(11346002)(63266004)(106466001)(6266002)(39060400002)(103686004)(4326008)(42186006)(54906003)(16586007)(316002)(6666004)(110136005)(356004)(51416003)(90966002)(76176011)(478600001)(72206003)(107986001)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4336;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT011;1:Feod9+NQX2deQ7TJIvzTw2wkwat2tLg3vylaHjYomzbMr+3lw0EWY9xSLrRaDGZwSlKWS/yDOOETaPIumjkN1d/MIXQbCXa00ML84uy4iCFUo0i5fctDu4qjVDhrdMGb
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2c422e1-6144-464f-fa11-08d63d979d6e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN6PR02MB4336;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;3:j7ncgKQYAhZyKZQtfkuUpDlq87FiLV/e0nRtu8Bt0+khvUuVO1WENPI3GrKiVjyn5nT4JTRrub3Hm4pwhElxJYpJDze9E5lNqio9Aad1ZAuNwEesLHalRZGye6XiJK2V5sO5xWr6hTTub1LxoMtC3tn4wDQ2IaruQiMNv36vgAf4G3XbrZoDtvDHHox7oQ0wcleiA1Del09Ibm1yxl0uU2nCfIi7P0Je/+6jftE3Pqemmiz893G5PaMmP4fMZqZP6JRwIkQSfGQpDAUgmwKjJSxtadSvyiTyA+jhI83F4/HRk7JS9CvFPYNtA3eBrkOQJsDwjDNbF69cfydwo2o0E3F8oD00Xh9OShSZ6gLvS2I=;25:hN+Wkpm4Tm8Tph91OzlrD6/1vQNW58u05XaR/Etnjk55ccOeF/gkdYvcaL2Q/RN5W+MK+FWIisitYTLquzJnmlN79P3Nd03F0dRPdah3jXCPZHO1B1ZuvgyRo/OkXGVOW8TjoBM9QwwUcwOnewH1g9VCriqHbDA7VibFwrtpzrS9HlMIWMZ8U19kbBUsVgJOh3Ou1ipJqawO3kJD6yt8YepjKWXIqw/r9zZtoJAyywXj3fALuD+WR3BwT1xJdPEZqSrMouXTbHVCeowjo1UoO0tcL5biAs6P3qgzVdTRS7tvN1n3zf2SqJO2YUuECxIWGjGK5hgr4V5wBdgTwbnCnw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4336:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;31:ugLqeVSJpU74TwlT6shTWToSajrhcbgkDwWzVrQjomLOPJBYcoaVd/wSiQmmsNnxOdcx4c0IlPkfKglbaobtNf0vH0CWOnjTWDRyqIGxm3NVgOhe0SK6cKa55nMzyCbv9UT+ClNkm5Y5LHqIP723ohd+CmMF1lvNpbZ6BzxBjsQ48z35r3Zkyb0ME9ZP2IKNn3O5k06JLFAsgdZqk6Fn1l4HD9zg2IMOXsBhKCSi4oM=;20:IgiHPh4z3f9nRgngIkuxT6g6GFUZRfTKX5eMbsMY5MciBI+F+0hNlFThqa1ZWr3QGhfDnMX4Q8L9DCun/WM/LdNC/oxdlweRg+fZv3ykhlGQMOPSiF55RTSQJzH1wFvha6we3eGaFH63mrogkeg2VOq2sBCYn8ydW3D7EzFre5G2Kf+RNoyEVXaemM4uS6RzG/Xn+ahBzozUAm5RXOr3p91wOECqABHJveOyCAyDJj6PWqGJ94zUtyebU0kPyHApXk1F8Big9Y0lq/y4vtIkp7VVrZTr8xHuHK+UlmXNQvLvXPawA7XIV7/+Zk8K0xCzjGqEri0godujBELiR8J/Iiusbcuph1DokntKMmMPqEvoCz+e84c6h/gX6JlcfdeB1D2pymrBd4+LHWPLzzpzKSLTpoNef4ibdAxhneVLE4ufc+buT5ZqemlWZ9JFlYhz6vkj4k6LbfSdSHD6Kh2PtUZtEitRNYctEwZDfaBBjdO/lpc1imfVmiPcfopP3WY4
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4336807B5B542EC3FDCCDA6DC1F30@SN6PR02MB4336.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB4336;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4336;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;4:OQ8ikuDOEX8uzOKj7afWxIFLiRgfoRaKh42E5qd/8BjT9X+H8CzggfLczWubKu7XzJvC6aJ/0O62h+AFl4xdsMP/M+2VdpFoB/8u5pSPjGQljoUXA+pZBXHfBdyGh3qbt65hY29xLMD8lPQoaDUVEcOmXZwdO3proeFl0rwXM5vvrvhGfwOHp0UZ0pcrkp3T74BT8tsLn8kX1SbxzZc7z61KaIMXYreKknK48J0eUJ8QN3vUK1PZ0kKvxMm7YeMMMxll4NNLRwCQwnzkb7Auw+GGd75tOnnNMe8TX7PCVUyuowXHxruAVfalJ3mcBYd1
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4336;23:QWOGzQEDxy0OlDeLm7Gi4pNbbLCLJ5LpYBcluuJeb?=
 =?us-ascii?Q?4HE7nq5faEVZX7DJPsaQ5AWmNns1pZSW2uTLXesJlwE1yKGwCg/Nl9kRkIm5?=
 =?us-ascii?Q?yHiNIF2uiegVi9dCq7tf9Tm9oApneZof9Bav4n5NCzUbovBSO8VzkvtSUdZb?=
 =?us-ascii?Q?cObGtI+McXynBHKLxJPjbEgcBRzFhPeIlLom2/CJjSO8fxvaDiBzmUkUXWjr?=
 =?us-ascii?Q?yWapuuUGLNQdR7e3o52/lAxTtWg0sJpaxCLPZ4X+NLH5Upy20+XLD6la1J8K?=
 =?us-ascii?Q?di9isehLd58tX1odBkywV60Ei5ScxeHlenM2LPyjtvCuKa/2cqC+q7BxBP0S?=
 =?us-ascii?Q?U9ayWCA7X80h76lYX2/ER5c8LV5ssU8al/t7vu0Fj2nnjMGB5F+uOFfMc2yq?=
 =?us-ascii?Q?f+jvLJ3Au6ZYDLqDyANuz0IBBQUgQA82XJoY0bXEX1D1Zd/gwV8i+XQRq7P2?=
 =?us-ascii?Q?IarkWOQaKrAdD3g987M8c5b9sB9k3jQTFZMlPuTb8IjXQAVn5JZmdBImIJXK?=
 =?us-ascii?Q?kc5/4O7GLCS+LRsyOf+5cfFDsls92cj7Mba1E0Fk5KFLfMUxJyIoJCjVIMgC?=
 =?us-ascii?Q?f722Oy+LhJFc16pONVFB+RF/bEhFHEMXuH5bhfmXK5Ucy68FngxfnPfrL+sW?=
 =?us-ascii?Q?s7f3tYJ7tlqdMxG53a4+I5dUIMx1+lUYGO4VK06RhsmFz4tBnMzKystwX3ON?=
 =?us-ascii?Q?POy+PqwoTzECrNl7nfr1wL2Lkn7fZlf49RQZ2z/XMslQG0UJJHsy34XB1aLt?=
 =?us-ascii?Q?lrSgTqNlWCml11N4ARR6ShsWg3FzjmgE33qMTZxcc5PGkHJUL/8e48MFM/8N?=
 =?us-ascii?Q?tAm+9mHUkEnNn68GHCCPOZ/Cr9IN2hqDjmD1zJ52TqmFUFxR4KKdlmAQXbpm?=
 =?us-ascii?Q?Ob4oM3mdGVsZZ3Wvv2Tp2PxDx0wlopFf+webnk1F9qHsFUzBPAKZOoXTk2Ot?=
 =?us-ascii?Q?VFnePfFVoAqoD3tcYS3+rjk6OdNyNonhceN72b8Zs01l8CI2wOf6aYEl5/gw?=
 =?us-ascii?Q?cezklEqOxpJBcCXGZiSrFOvb2UOnyKOKh1lr2DKkUsyXbItzgVHi1iWwAW+h?=
 =?us-ascii?Q?hDyrOgWvvxB5atYeUE19QFthJs8cqqsNkVB7cpG3nznF1sClhLn4SOcJZmdi?=
 =?us-ascii?Q?Sw2Qb8cGYfS33KChn8C2P4RfuyM4dFzzzXFDrH8bVNC9Dythk5/kLz5FDjsU?=
 =?us-ascii?Q?h36xXTrhwmk05ftBF9/FRhmc8Mt91yybsAT7ZAjccbzoJkOHvEh6F9xyFuSM?=
 =?us-ascii?Q?6d+hn8wN2nWiXXkmYX9EOUoXGStWYWAMDIiTrYjoAVOFcnQuwFdwOKGpawnm?=
 =?us-ascii?Q?eBk5TRyJWYso08NunuOtpss60gAb02Uhvo1XN9V3eQRdvPpGFAKLzXCaenHe?=
 =?us-ascii?Q?JV+CQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: cn39IRmophFAUJVWCltXdSfhw6A4PvR2t+OOCdGS+VDPGifV7/KmSOqVatwgJGqnHp2IBwWEV+N7TTk/KiFMEOlKiMF/4f1Ow5JziR2S5yVhAQouecQmDSRtp+Fr8GDOR94rfkKKa00MuxvLzWmGIS0Pf79PCOXuC6WFU6d7eilCNWceY2fibLPKTQ2fWK5x14mfjOFrgEpbnZc6x0ewbP19bL/42n4uL95d5LJP9WXWXNTk4XkYF4B6KdzRXISG3lb05gmgbmzkZrYWpm1bU3SJoskou4D7aOBtK7N//SlMCSVeE7iC4S9buhPQ4QZvdhDYMV2BrNb/hpC1uGP6rvDfD/JX0UsK8XpV2dEgH9Y=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4336;6:5bbnAN4NGVKpgYT8pm5gH+mNMoTlUzcnzoFq56RoCW54sS438SWppIuyx2a7qnUYPJy+0EWmmkyTOkWYSTMJU6We91yCcqteAorXyQseQmHzDaPk9SZxp5eTMG+fyhxif7yHq9hJuad3D3yr6EsUvMOnD4hSecif3iTlr43C65I3y7fJVHZURVApZTh+LQGQWn5XWrpY6Rfsda4Gnjl53QROdoa9Cv2lYeE3eFOOMrPRaVrYl0nD1cjUrSKeuU6FtSf53IVjmCoVK5DQiAdvO1DohWDRf2stQkgPac4JwVYdo4j/of0v95AvXsjjKsQT4cmr/fYa78aLVYYkXzzbQqflk2Q9jABDcU7GDBAbqt793r0yypZrUrlvl/UF7NKRZy4nLyINwRrnTaFG/3OYxY699bokOOI44kVHMcQuCzLjYvQjoSUajwJSyE48sP1YlVNvhpQ1Iyqmu4Epx+Uuzw==;5:61ck9gvGsK1qyjTTMyysht6O2vBZ4uxhUB+fans/b12fMP5F++IXOCKFhyGWJbHM4wH3imD/gqzbjyewJkwrkNU+Lkj9l06MIRKEk8WuQy/O0r4gcOpayjFMUPP5lp+CbUSkCW7erA/OZ0Lh0404EhB0vRp3pAawvfaIvIiTk7Q=;7:nYiOnVluGb6ENB0bncW2g4me5e0QVE430zFX42+QfAj+iduBZqoVu0yJzheJEZr3l9GuLjN1IByg1zZhI94G/vUWJBk4kIZEq52nsLXC7fBvIlrD5NeC39G9aKNQJJEgaGgAHNoQMKLjrxiatUU+qQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 12:11:09.5624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c422e1-6144-464f-fa11-08d63d979d6e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xilinx AMS includes an ADC as well as on-chip sensors that can be
used to sample external and monitor on-die operating conditions, such as
temperature and supply voltage levels.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 29ce234..e5facd8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -617,5 +617,32 @@
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
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#io-channel-cells = <1>;
+			ranges = <0 0 0xffa50800 0x400
+				  1 0 0xffa50c00 0x400>;
+
+			ams_ps: ams_ps@0,0 {
+				compatible = "xlnx,zynqmp-ams-ps";
+				status = "disabled";
+				reg = <0 0x400>;
+			};
+
+			ams_pl: ams_pl@1,0 {
+				compatible = "xlnx,zynqmp-ams-pl";
+				status = "disabled";
+				reg = <0 0x400>;
+			};
+		};
 	};
 };
-- 
2.1.1

