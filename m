Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBDDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E9720664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rnNQcFMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E9720664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeKZSBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:01:31 -0500
Received: from mail-eopbgr760054.outbound.protection.outlook.com ([40.107.76.54]:22608
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbeKZSBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BR7DilGbkN4N7b0UEYBXNGSLqzrCz77v0nMojeNa1o=;
 b=rnNQcFMubco94tkPfStCbCEPdpzPyVWNWXs3QvmgYGPngYzUwlkD9ipaUTBnAPjcsF3BHHnzKSci2F+KUEoYX7q7k7DYmrNPdo9ZGBrzEGuPMEmgMvtBDkTejRcJL5+6FJxvUjizk60onD9q8e4GxQ04/0pL4ChszZIOZH6jHNk=
Received: from BL0PR02CA0041.namprd02.prod.outlook.com (2603:10b6:207:3d::18)
 by SN6SPR01MB0032.namprd02.prod.outlook.com (2603:10b6:805:78::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.16; Mon, 26 Nov
 2018 07:08:15 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BL0PR02CA0041.outlook.office365.com
 (2603:10b6:207:3d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.26 via Frontend
 Transport; Mon, 26 Nov 2018 07:08:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
 via Frontend Transport; Mon, 26 Nov 2018 07:08:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gRB0A-0005r3-3T; Sun, 25 Nov 2018 23:08:14 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gRB05-0007FU-1H; Sun, 25 Nov 2018 23:08:09 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wAQ783IQ026352;
        Sun, 25 Nov 2018 23:08:03 -0800
Received: from [172.23.37.92] (helo=xhdharinik40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1gRAzz-000758-6c; Sun, 25 Nov 2018 23:08:03 -0800
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <nicolas.ferre@microchip.com>, <davem@davemloft.net>,
        <claudiu.beznea@microchip.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>,
        <harini.katakam@xilinx.com>, Harini Katakam <harinik@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: [PATCH v2 1/4] net: macb: Check MDIO state before read/write and use timeouts
Date:   Mon, 26 Nov 2018 12:37:49 +0530
Message-ID: <1543216072-9623-2-git-send-email-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(8676002)(305945005)(77096007)(8936002)(106466001)(36756003)(81156014)(5660300001)(2201001)(81166006)(50226002)(36386004)(2906002)(7696005)(51416003)(186003)(63266004)(76176011)(476003)(126002)(2616005)(486006)(106002)(44832011)(426003)(336012)(356004)(6666004)(11346002)(48376002)(50466002)(446003)(16586007)(4326008)(54906003)(110136005)(316002)(26005)(478600001)(9786002)(107886003)(47776003)(39060400002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6SPR01MB0032;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT020;1:6xI2X9DFllkuWxUgB8ABq/U1GxAqT9vNnymSnXo9ZOKG/l43UkISppwHNf1+yYErHsZkmJqT1GK/doLUcOM+x006TBDGEvA9dyjT2dP8ra5muwErMMON6TwDqfmFR2H3
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8caa49ef-0d80-4177-b901-08d6536def36
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN6SPR01MB0032;
X-Microsoft-Exchange-Diagnostics: 1;SN6SPR01MB0032;3:c4PYBKdgAtkWXyvgBj2n8jNM/XI+qMFGpYjfsVKTKvyirD2dBev8OQfKGjB1pQ+K/RUw5E6oz3bd5z+8x0jTiNDlmPm91npqUejx41Ddq50+N7ZkJzQPXzvTpjbgOEN0Z9F0i3REl14svV+kuLvEje3lNnTQaBe3aL78omHmwFlj20tTTd/xdbXLIbt5VklrjRKKwBDct4OVsbXjSvQzeqfWRbl2kZfn3dDT30PG/cFsOKkZ9o9ukiO1HWAgeed9f/hA0y+xbG/ccrlXnjEsPnmbpFI+Ta3o0TfOB5JXx3kCKkpuNds19OJvphfiZiS2ErCpf4fvJJ5KOyQoX8zuCas5U1SRiIJFj3E0KLjEgOQ=;25:RJlUeIvXiJolHZTyXFO2MnlK5CEjKHS0P+20Lb5gGj9GoSJ1/MjJXIEKUwPIiKfeFFWD0S3zW8t5ArX8p9MNs3itM9M1M6/rE4tsCOJKroG1fe0U4qWOmLvepabKAzzaM0kkC5psfMhtmq4nPyImk3iEn+WOx/GskUXWwpP1g1aCCBcmq79QquDCjpzm38YoBgfxlSMMor0RKw+JF/IGoHvlzj/g6W5V/05tQuPNC4EwK/jE1ghADJLryxyvYNrDIgHB8x4LSktJxtCfHwr/GvWtyuS9tyaSGjvHKnsdnO3xiF1FwVX4LkY0Q8ihDCoGxEqHUuYOfVen60SpDuaydw==
X-MS-TrafficTypeDiagnostic: SN6SPR01MB0032:
X-Microsoft-Exchange-Diagnostics: 1;SN6SPR01MB0032;31:bESh5kzpOBzabMO4BJqLUsuet/aa8d9nTfxV0j2tf2c4X2nCN7GjUuntaV3gopM+81bvNuUkYCuyT3KhisOYq2+vq1BAr9sscC4//fJOfGgKouyGoZiHaekDFDv2yJySTPsKBDUF+twvtJra+1v4XpyrrrqfoWRdUkJ55c/teAw39sg/07ntxfoS6xL2VP/q09dCqOLJ98lEvDI4wn3FFYFgiP0Wl/QYNUAzzh3FW5c=;20:bGvmwD44XekffXuo5II4b5Lev+0Qe81slYNr2+ICOtRO4FVdSML4RQVq7BcESSkhlQHN8Kq4+023mIJ2zLJVt61YxWRPoYtJ+A5dYWu4322LeikESAvtiieSPztzbec0SwcGzGD08J78kfP5KEliqFw+hgV4Xs5/nRYQLBuyOS8i5bdMhZ/cUTAUtodXDH0qpiiUnBY4+du4ETIXE8RCsVymzFdp5dCru/J5fBoUpMQQRlOs6tE1+JpKzZHYmfAkd0YI2Qy8BH/YmbYbgVso0SHf0aI5pMbd82CjCvQxIRRY7WD6y5R6VwmS//0fFO+mDmV8/snO+HhDEuMbGbwTEMLP2iv7i4kS39A2fi1grnHeURnke4Mjm9JCqsSGICuh7cBwdEctKQnMOotB6CfYdlm7dHsXWRL7Qmx8VXU31rPP136pZgFMQneSnFTffDk5DsKvkFranl2JYQbP1NckRRxkDhICAEMQR+xg193HYuYPXg1m8Wl5PKsUDf63Iard
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6SPR01MB00325CCD2386583E1C80821CC9D70@SN6SPR01MB0032.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231443)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN6SPR01MB0032;BCL:0;PCL:0;RULEID:;SRVR:SN6SPR01MB0032;
X-Microsoft-Exchange-Diagnostics: 1;SN6SPR01MB0032;4:YcLxlgjS5XuwoExqWkkj7/Lm45qORV0SEdlb3+HPPcTnJ9pgGX2HN61INQNWKO6Nplmka696zKVKdGPUI94cFd4uNDcs6oQtqngAHqsaFA6ok0BChRzdLHMJsdrDeY9O0i405L7OFxd8lBVI5DPoPWDMlcrt87DS36KtwduSK5Ufo5x8ADsCeZgSGTxG80SvUdd7GGNAIm3BAPwG8hOWikez+MLDjo16BDCZUVgrSREEhJSZGDv+w6Gua9SOI3i+2j40B6eBoWjaFfQDJlNLAA==
X-Forefront-PRVS: 086831DFB4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6SPR01MB0032;23:CkdDYZ6DDg2Kou2ZTicZTngvwt3B2p53xTeIcWF2?=
 =?us-ascii?Q?Mrfu/MGjZ5XQcI9ZVw3L1shA63WKJbiOoNlWz08mFMC/GuqU+km933UR/X1i?=
 =?us-ascii?Q?a5qMgUyE8OBcHDwNhoqUU22Coj0pyvAUf5YUZ9Eav/PhAmxMYx7ZlbneOIDX?=
 =?us-ascii?Q?A9xp3QkaHZbNGOGNx0kXVrrzG/r7JyJDqGbK9rtrS0DtJm1n9fiV8xXrrLo4?=
 =?us-ascii?Q?3z66y40g0c4tkdwsyzZMEB2eMcf+9KvDf8MaFcUgyhh+yXUnIVSyqaFzPvbK?=
 =?us-ascii?Q?RQnqAK5jSxANbO3lWj6Q6G8qywYi9Rl8i7oGfLV6lzO30QmGhQTVB68hjMtu?=
 =?us-ascii?Q?OkMoLHsgyRXWVoqJGamHYSHDgvSC34qVILovGqq3w3eQi3yRktUrxnblgmrg?=
 =?us-ascii?Q?Ye7LlJS1GecdhRJexLwaQ5s1mYbtm/89IuXn02SJnv33iB9ilYLEqKO336Da?=
 =?us-ascii?Q?jKUKCiZ9s1ZN77IgeyRrtZKktqfkNO1ch2Xtub1mFT1aoJ20yl13GEkc+BIm?=
 =?us-ascii?Q?kZFP9T2Asntha0DJSE0dLUKk6v3UQxRCeHMao+o6PLa6NDAF0oky4BFsTvZp?=
 =?us-ascii?Q?Qw0UfIvlt3k9B59mMOCoAgdton4Rx5c0Deyy1mz7wJLs908RdHkxnfjiZEQK?=
 =?us-ascii?Q?t7aKwvupmuivaP/c0QQu49z/6mIOhDMB/+NzpUIB8Liui8+JbmwcYa4aouzc?=
 =?us-ascii?Q?6fn8RpBDYOXSBupB1QWY76WVHyG/gHdlZ/w1teEOn75gQ25cJwWAiAEoP/gB?=
 =?us-ascii?Q?+X0Yo324gjiPZAYc1Ia3HB6nNTQoIpOiP6tcG0BFXPmlBp0V7s5or9g0V4RJ?=
 =?us-ascii?Q?UqmaAJrDjgrKDAzylM6kFUrxWWhZ9JHrAj3gWBQfh7fsHopTshuVSw/CjzeZ?=
 =?us-ascii?Q?+2z9TmQMfudMZ4BIXTK0n/MHdG+crHPPOxbkyWn8UTy0g/A+f36atl79uOj8?=
 =?us-ascii?Q?jXU1qyqByd4L134FLpJSbUH9oiYSFWyyrc/JUDM3VB23vOGFnl5JNqfqQf0M?=
 =?us-ascii?Q?TjO9rHwXzxozg3ieLPBEyMr9qOcTpo48s2ax+ojbXgl1tBLJfQen10BH/SaE?=
 =?us-ascii?Q?b8nzKuKl28nTN2j4o4Grz6os5oGSH21Y/MFSbt6AzyLezGjzyqcttTU1TZcH?=
 =?us-ascii?Q?KLmYY0y1xauFieZfFyg8QReQnkbpBvw0agbAkAJx7c2AdjebiejvMw=3D=3D?=
X-Microsoft-Antispam-Message-Info: FjsUWKar7vd2tS5CD3RocPxbnm54bf9GzcV7wELOyM+/rxZN9CQjga9Ts/4eh14vx4j1aecr7owEGu75LHNFgD64dSf2wE06VWclJVwSXii+wOcT41490WlOxGXaDSioxOFES+OOhmrYYAXLGyg9eGG/mDZMXgvmOL3oy9IE78RrHtV+UxPnVatooG01IgHygy5W2aVf5Bc6eIFpxCvl+KqPRtfD7sF6nhdlrGE4FQ39r1xq47EOIzt5AIs/KOY7kDXVxywkrinZFatoaFwAk0CamOH0pWK4SNZ9rw593pU64jvYTGjKuj08gHeg34RFm/LkC46kD+LnkX5vrWOi0J2lxPnykpu6vx1Wr7c886o=
X-Microsoft-Exchange-Diagnostics: 1;SN6SPR01MB0032;6:HJk+IfRq6u94GsaHpa09pVyBUdVUr62yq/iOpsDfcnJdOM7FjAxxp8wTOBnII4M3/jDSNA5zLPGsNvABfXr1pcRWGd/htrRHjgzHd51qN5DTLaxH33iYoUwpyUrgyi6SqhG4ZO04N8Y88WZkMJ4oC7/QD7QejJE8022ADjx6aP7FXJ6w4x22etGgCseADeyl5HT8M2XuCwrWkv0EIbieyng4r4c1DZDigUtXAT6MW51KLARykv0gGqE6Mj6zMYelI7wmQKmyne6Fj/MXuDCfEIhJdkCpNN7km/3dfsM0b6dL2Fg7FQMQYh8EnbzByuiJkdrLvCSPKS6AnxnpcPrV/NelR0Pc/VqXOj8rkKaGG6JJWbRd14ncFdGtkcufgTubtIoEJNoMKtc+czfOeeNQzOERk3+cP3Xor3TLzhxbgK6EsR/qhP6pTP1qK+mRxmfPD2AYpnL7G7wtZS6xBOjbeA==;5:81TI8SSZuPfZ+uhelSBru9Kwq29yF34b0uB6VS4vaWR2/sjo1Go0DJKqK6f2xfpRnqz4FObubyAc9F8bETcSApKDxTsB5KIw6HxbKdQF2D5TmA/lsT+QHlzJoBIjUI8rfJn9oDBzbSN/4C5P96VgxpowuwHCPqv2QKBUynfoyv4=;7:oKHY/1lFltcji1/NMcftFaPv4wgOEBzDuLeF3xre7MOkPqjdzJ7LU34uIbTI+OQMZGkSbKg/CBfSliI41jY09ocaMvrZmHSdC96tulbC4pHcHsHrm/zKxwbZqLDUzDpp6WFRZiZdAq9ehRf6P+/Bfg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2018 07:08:14.5010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8caa49ef-0d80-4177-b901-08d6536def36
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6SPR01MB0032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harinik@xilinx.com>

Replace the while loop in MDIO read/write functions with a timeout.
In addition, add a check for MDIO bus busy before initiating a new
operation as well to make sure there is no ongoing MDIO operation.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Signed-off-by: Harini Katakam <harinik@xilinx.com>
---
v2 changes:
Use readx_poll_timeout

Changes form RFC:
Cleaned up timeout implementation and moved it to a helper.

 drivers/net/ethernet/cadence/macb.h      |  3 +++
 drivers/net/ethernet/cadence/macb_main.c | 33 ++++++++++++++++++++++++++------
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 3d45f4c..df7bee1 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -714,6 +714,9 @@
 		__v; \
 	})
 
+#define MACB_IDLE_MASK		(1 << MACB_IDLE_OFFSET)
+#define MACB_READ_NSR(bp)	macb_readl(bp, NSR)
+
 /* struct macb_dma_desc - Hardware DMA descriptor
  * @addr: DMA address of data buffer
  * @ctrl: Control and status bits
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1d86b4d..fd86ece 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -36,6 +36,7 @@
 #include <linux/ip.h>
 #include <linux/udp.h>
 #include <linux/tcp.h>
+#include <linux/iopoll.h>
 #include "macb.h"
 
 #define MACB_RX_BUFFER_SIZE	128
@@ -79,6 +80,8 @@
  */
 #define MACB_HALT_TIMEOUT	1230
 
+#define MACB_MDIO_TIMEOUT	1000000 /* in usecs */
+
 /* DMA buffer descriptor might be different size
  * depends on hardware configuration:
  *
@@ -318,10 +321,23 @@ static void macb_get_hwaddr(struct macb *bp)
 	eth_hw_addr_random(bp->dev);
 }
 
+static int macb_mdio_wait_for_idle(struct macb *bp)
+{
+	u32 val;
+
+	return readx_poll_timeout(MACB_READ_NSR, bp, val, val & MACB_IDLE_MASK,
+				  1, MACB_MDIO_TIMEOUT);
+}
+
 static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 {
 	struct macb *bp = bus->priv;
 	int value;
+	int err;
+
+	err = macb_mdio_wait_for_idle(bp);
+	if (err < 0)
+		return err;
 
 	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
 			      | MACB_BF(RW, MACB_MAN_READ)
@@ -329,9 +345,9 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 			      | MACB_BF(REGA, regnum)
 			      | MACB_BF(CODE, MACB_MAN_CODE)));
 
-	/* wait for end of transfer */
-	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
-		cpu_relax();
+	err = macb_mdio_wait_for_idle(bp);
+	if (err < 0)
+		return err;
 
 	value = MACB_BFEXT(DATA, macb_readl(bp, MAN));
 
@@ -342,6 +358,11 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 			   u16 value)
 {
 	struct macb *bp = bus->priv;
+	int err;
+
+	err = macb_mdio_wait_for_idle(bp);
+	if (err < 0)
+		return err;
 
 	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_SOF)
 			      | MACB_BF(RW, MACB_MAN_WRITE)
@@ -350,9 +371,9 @@ static int macb_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 			      | MACB_BF(CODE, MACB_MAN_CODE)
 			      | MACB_BF(DATA, value)));
 
-	/* wait for end of transfer */
-	while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
-		cpu_relax();
+	err = macb_mdio_wait_for_idle(bp);
+	if (err < 0)
+		return err;
 
 	return 0;
 }
-- 
2.7.4

