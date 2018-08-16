Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E90C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9C92147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VRlhjDeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9C92147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeHPWIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:08:47 -0400
Received: from mail-eopbgr710040.outbound.protection.outlook.com ([40.107.71.40]:51580
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbeHPWIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIeyD24xu5AWV9RMK2Hf43/WkQEUzScoOS1xTcRuVLU=;
 b=VRlhjDeEvQ0ia6DQHFdX1dOKdRDnhDoQNq7C+CM/JWuFt1ANY6brJ72gaNV/0D6RMn48QRnQjJPxc397BCAnCuVnyhAcpTrs0Z0BWXyqUtjKf5XRp83b76uAq/VJpqY7Nml1czt9LiWBsNF4J+akX6x4cX8q5ruZ54qoP9IS3K8=
Received: from BN6PR02CA0075.namprd02.prod.outlook.com (2603:10b6:405:60::16)
 by BYAPR02MB4328.namprd02.prod.outlook.com (2603:10b6:a03:56::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Thu, 16 Aug
 2018 19:08:27 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BN6PR02CA0075.outlook.office365.com
 (2603:10b6:405:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.19 via Frontend
 Transport; Thu, 16 Aug 2018 19:08:27 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 19:08:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46023 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNdC-00047i-EQ; Thu, 16 Aug 2018 12:08:26 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNd7-0004An-9Y; Thu, 16 Aug 2018 12:08:21 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7GJ8CZV012298;
        Thu, 16 Aug 2018 12:08:12 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fqNcy-00049q-Ih; Thu, 16 Aug 2018 12:08:12 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v2 0/3] drivers: soc: xilinx: Add support for ZynqMP PM driver
Date:   Thu, 16 Aug 2018 12:08:00 -0700
Message-ID: <1534446483-12156-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(438002)(189003)(199004)(7416002)(36756003)(8676002)(106002)(81166006)(106466001)(81156014)(5660300001)(305945005)(966005)(6306002)(50226002)(356003)(6666003)(72206003)(478600001)(48376002)(9786002)(63266004)(426003)(36386004)(50466002)(44832011)(336012)(316002)(47776003)(476003)(16586007)(77096007)(2616005)(126002)(39060400002)(186003)(107886003)(26005)(8936002)(2201001)(2906002)(110136005)(4326008)(486006)(54906003)(7696005)(51416003)(107986001)(921003)(1121003)(5001870100001)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4328;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT007;1:n6gIMrjvVS+K6iDzMnfLAkplCFP+T2rTfO4VtFpN8KT3vGNkWqQXGOpu0OGQ/a7Rx1rMP8xt3zKXGmAgbQ81Rhh3b+kEafTSnzfdBpMRusuxHIKE792T+O40jkHI3srb
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d35d78a-6f86-43ab-21ba-08d603aba5b8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4328;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;3:puu3MSw6n2ijZZxIWv/JS8ocmqNPL0kQRn0/x7lg30lNPHN4TLHgmextKR+q3sLrDywALjj9m49Cq+nklfuM4VxLqy6tDGu7AiklfZ6z5aP8zoWOei7q2UF3SKFp7m5hxMHgMGvBWLqJ4T1Hl+o0WRV2IDSdwi/gGVkAoy7S7UNMq+xYyYEgALIs9Y/AJYZQ/p28nUCR90pDhGp4TEpDSRJ+NefiR+/UzGBpb/03ExnVlYOScmdCyYnrnHnOOoaUo957/0Jao7egsKO2ipKp2mZrqIy+jT6zRRb6BvNpKpwe6QvdnJggguJW/ryu2hhpS/CDks4OUcVP8NXYS76qyyCgrr8VOIdexp4UDUMLaz0=;25:yCCho0gUMLL97vxlu/Xn41/vddrZcDnBwz1yoacptRHK3qCHITULX5MSTjzLpgsPOF6UJXB1dc0c54CkAFLUANCrb3PupWM/P0DlEILhMgPQM+rKzrt438r4FN5jzgvgbQnefKWoQbIbkWF7QLeykP5dm9Xo8FLpLDfKaN84VuoUu7v3NKC5vr5tn7sY3F2xFWYeHoYev0uE6XsuXCZ0eYeMYwe+D7yRz1A/0VG8F2M99tkXCfu0qGJv+jthq4GWEnqN58cO/nTgGKMOGZ58RX0QD8Qe326zWEyWBwbN+lf5hyOKdopVJYvgbsqjZKWpdGlcDWGO4TeFoK9M0Sgvzg==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4328:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;31:+Idfyq7JP9EvKHZqKUIukCobXdQLzhjGVEiby86+CAQprOjvYVNy9hcwGNh56fvqt3WsuPtwwPSMmIgsfFHn3lSZvHeqtjnKGfKzFm7H1LJNC+8CHrGdnKbTTvkudzGc2LFC8ZE9YdBZcPMjI3eJ0HUM9+iSQS6MYhLNSuJ9CquSIxZSkfkjTzvJZK0mGZhqwg7wFpaKPSObqh49XC9x0OgA5DnY6hC1PnSzjXsEXSc=;20:eeawVshKQ5bieHUeCG9/Y0DAB9yPKkDfg0R32E6JZcUGD3kAo/2Sldjbcu02kdqoMrK01KjSvQ0s3NBoIItDp10h3K/JZvaHfyumUhgwXWHQxOd/P3Tz5r6OiBSZcQdOocU3t8Je2HkBZU12P8Xp9W9ccAGlFXsmRYHbmrpYpsdl8S2/BKqQjg58vWGUo/bLI62nvD5Yp2c4PYF/0tYj5RX5w7zm4QYlxR3avEjlH7CqsznC82lAofymdmcXOWPmCAvxv74r1qfjjjVtt68P1201HP2wTxDLwGNhNR31cPxDMfn4Gir1CQzzdtmFjfy8xQU0KNIDJSM3fb9vgaVAcymLXChQuOGKMUEl+SpaOnXsvrtQKLNK5c9qyF7fTTrFF/I/Qd8wbJxl7nzPmLuZDsl+v+ldxhfJ8SDccl+RP1urtEG+o6K1CGZxaG/vd6r/1lll13bFHYoUaow/8OHaNu5meCAH16I6TXByBrYRYkmHZlReftVcZ6cWDxL6b7dt
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4328F286523989B03F4F7342B83E0@BYAPR02MB4328.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR02MB4328;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4328;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;4:oPrF7Pil2g32OQpHaegVFQBQVd91MJbt1TwR+AEoj3Go/Hu+6oXviAmB1elxM8ylncJR8A++OZHhpZxhtawY840RgCSCJNq3Z0KmWBAK4QTqdxLf+UCJBxCUc/VxZfwRRifGPdem+zkKDwV8e8LiB+YRwU4Es7BS0fa1GeZ7+8VvgG8U0HCM1ryMx++qZFpGC1Fy8H8OaGpEjImcRG3zKtYah6/htbkDBthHPwa+LMkQ2qp3nJadwjLVDB8KBoaZjk9Qphd3w8+70cCv487djQ==
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4328;23:Q1ah45KpVKTQ0Tg0HeYQjP3pW0c/4GPGzPzb8CgU1?=
 =?us-ascii?Q?4iCcQXQlo0E7ysf32KtZhdjnZwKDDaAAwSNpYcR8Nhxu+F1EGVeMFxTYBw9W?=
 =?us-ascii?Q?rNJt3xDxB6n03UbXXOYo7pqKEHGPHWc5kEbg08wOIvlA/T23Lg6l6XJO3iya?=
 =?us-ascii?Q?c1UtZn2HGAr8iSe6ik1MCXd1ItEoqifmLwvgKOsEsUFlFgvc4uS+FRkYmiDR?=
 =?us-ascii?Q?k2IuPsB4G3GQJyuIT+lOPywZYI/spvIxNi9SLa8eoz5AEyWYxMS6RkEvqg+Y?=
 =?us-ascii?Q?3o9fWgy9CfRKreQt3jdk72/mhnKyqgKq5Syugoaih+B0SiLrMuhz5thVw+xG?=
 =?us-ascii?Q?a6hOJWxfC0tl06dpet/loMCv7sE52unSyeLwUXfjOdTQAQWIs+zCBdE+Qwp9?=
 =?us-ascii?Q?ZludTsW/MY5Mb68q8v4FVUm5KBI6C5eSCFZDbpD/WzqKt6atY6JpICIyO07/?=
 =?us-ascii?Q?h1GtjRxXKs64ZPzr+tMg7jtTYc6CX1xhiEWsC7551tT3OFXCeKpMxE5K2qNX?=
 =?us-ascii?Q?GIWUBe/QbthBuEnnWPd5Pu76/vySJ/Wgo2g+rcGGlKyQXVkr2UEcT7g1yhwh?=
 =?us-ascii?Q?trCqx3hKxNPUIKzZ4FbbdcG4sWVp/u1pz/3s2ZGbmgrpZgyC8vbidtbxauRe?=
 =?us-ascii?Q?+n2+Jm47kSglIapibDdHHMyVy/xcQDIvhdxqykjESIWlKx9kRltx93oYAAML?=
 =?us-ascii?Q?XOIjSbZoHksBmhhmvUGlX74N74BXWC+PTL7SFFT9JbMIcGQR6tkNFWnY+cKP?=
 =?us-ascii?Q?ZDvl6plmHkdLRfRCQShnl/cheJY6GRqZObR38DG8cCeizhA0O6QbEZ8Zqa1v?=
 =?us-ascii?Q?l0VCQJEIg85btpoctal8TkUQ6qJ/EA1XiXzUxWtuq23+H8KLkv8eIzOdWux0?=
 =?us-ascii?Q?0UPBsyaKcyYWiC83iyf+0ikh8ZSeWR8rTbGrvVasxO0cy8Oz3GiOK0MzfPC1?=
 =?us-ascii?Q?unTi7HiOkhqQ+V+YNvuHrfgAOtILzHzkkcFghHus4iBejZ/4GWgQwDlUlDDc?=
 =?us-ascii?Q?Px7OmzY4w8Q1tzZIXNIEbh1mRQj1D8QZqvasaQjxk1c5rswyizcmbgxcXFtL?=
 =?us-ascii?Q?4y+u/gXyUN1OrVC6cwAo8JN5eOzUgoWDKktRIM7gmsetCwhaCWgZ5O8bNxQg?=
 =?us-ascii?Q?MDRURg+EMwCm1qhjPv9mcX84UQem0rRdtX2+j8cNELJy9pvFAlq9rQ/nWLtm?=
 =?us-ascii?Q?sGgRjeP6NAsbQaRuY1XVzIk+XhBGr9/JbUAZhN7ZzExZpdc1hy7Uh6JCZ43J?=
 =?us-ascii?Q?U8/eOW62YCWZ+kbwJ83IhI9tI/zfoCMwV8wxizyQKgS25mQY/0T/L39jIQB5?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: ci69XXmuqqkKkBsiJJd5oTBzxGsScjvtpP5Qqq7sQQnU0ESAIw4n7csheVcWHoC8hONOhZ0r9boPpq0J9e1qvTEpOIzambid6MJhsAJ7WLdaL27MAdJZvOIXCCmFD/fR1e8SwiRTrGcOgXuXHuqqgvdH/CYzsxmrcWlexng9ejoN8Vn7Nto2Z+rPBF4E7QAafO7GEgqy83uLNc5d+4Izmh9+eFjkr3lyUzGSMOqi7uD+lAAruH7F3/FRB/AQ6cJa/Gp36Gl9x32hXzyXUX93nOcLEJUblEiNaCLpRcX2QUvWcPGlbVgxz+ghu0egoM9uq9z9/V/LwpcJ2BpRjlE1wXMD7IZ5RbPDsCd9ekLX49Y=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;6:N/V+PJZIMsJfwHrpNqwab5i0vdfs9mMVA+VvvyLdJiuaIiZAXmK1qoMK18qt2NsCdxnKdsHNcDMF1s7Vdq6S1vPXG7vgMHtvdPJDxEVq7A4I0mkwUHAxWd10o1mv5AHX1nzwcH+6wyifj2EHmPi/bJwO5lPQ08DyKfB8UedGfLks6D5oJn5SNyfn6uMP9C8k9Z+UBox5EFbNeDpX0KYDO8bhGZYe4lVs2sgoFXX1vK3kzBw3YII0fvxm2yj2xNXnjwm1XWu8jQDE6XFBQEDiPambXFjoZUcoFcB5nUKVboHiHdchOXX9HIRPm56Wasrg3WVC4LFqy1UVM45VM0j0LArEHRuwtUCm/vMwYSrh0+5EaP5sEGzLGxVuV5Gz7MxfbTElj7uMOoBAgaB6iJwNa4aFGS11AksKGjLyXLE+FYrKgGu+daIXxGl50qqrvLXYppuryCi6tndARRTwBTzJMA==;5:rY4lJorQ/3gVXfozLWe4JGCJPdHo3yC70NMIsawwsN+jSygFoAi2g8ywb3Uu9XmHJPmyxA2hp4DmijHa5bwACH5BdzH8YGyxuGiZyAoB7SDtwmKCfkdmzIYja+l3eMzcxmRQFchHDOiBGtKPabtNYYTcV2sxT+TxdYR/oKIeCTs=;7:cLmDG5/h66YDmOwz6ih0nCdxMWnkRjP+gPPJ4ImNGJeaeAyFTfDFRtmn3Ug+GsEPoSRyGCAJAYaWNBFW655RkM/cJV+VPn1UrCC6RwdPg4wNy4oeJvNou3Xg7LlZIOWi7xCTOGKYECuikFe8l1AfD+GCz0Zf209DJ9E9AZcZsN97RtAOMA/DEn8Z3rVpmygSs9RlNdNYvKicevCtBkMpIVfZKHnIwGNyhr9xueSOWb0iLocTL0cbQU4O16k/T3Ww
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 19:08:26.9571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d35d78a-6f86-43ab-21ba-08d603aba5b8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP PM driver. PM driver provides power management
support for ZynqMP.

This patch series is based on top of Xilinx firmware patch set:
https://patchwork.kernel.org/cover/10555405/

v2:
 - Rebased on top of latest firmware driver patch series
 - Updated driver to use shared interrupt instead of mailbox
 
Rajan Vaja (3):
  dt-bindings: soc: Add ZynqMP PM bindings
  firmware: xilinx: Implement ZynqMP power management APIs
  drivers: soc: xilinx: Add ZynqMP PM driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  16 ++
 drivers/firmware/xilinx/zynqmp.c                   |  29 +++
 drivers/soc/xilinx/Kconfig                         |  11 +
 drivers/soc/xilinx/Makefile                        |   1 +
 drivers/soc/xilinx/zynqmp_power.c                  | 230 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  20 ++
 6 files changed, 307 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp_power.c

-- 
2.7.4

