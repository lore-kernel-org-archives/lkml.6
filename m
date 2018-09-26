Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3900FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BD021537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Gn6UdoA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BD021537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeI0A1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:27:43 -0400
Received: from mail-eopbgr700067.outbound.protection.outlook.com ([40.107.70.67]:12928
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728382AbeI0A1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vCzQhuRHarQbbE3PXhCcPtrd6OcslaCWvAzyxXFERs=;
 b=Gn6UdoA93lM1UxBSCx18grRcqihpriVVn94WlasdGXZ0CFbt9zqCW65oLUkUPhRT97X02kcGIZKiE7pz7F5yE+3PrhFyFoz2mC/6XjUXPxgaCv46I1TBzd0dAyB1kdFArK0d+Y+RvLZPxsbwsBeSzmYGWJFworxbpPpHIs+3YG0=
Received: from BYAPR02CA0059.namprd02.prod.outlook.com (2603:10b6:a03:54::36)
 by BL0PR02MB4754.namprd02.prod.outlook.com (2603:10b6:208:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Wed, 26 Sep
 2018 18:13:22 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BYAPR02CA0059.outlook.office365.com
 (2603:10b6:a03:54::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.20 via Frontend
 Transport; Wed, 26 Sep 2018 18:13:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Wed, 26 Sep 2018 18:13:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5EJM-0005K3-J2; Wed, 26 Sep 2018 11:13:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g5EJH-0001bP-FL; Wed, 26 Sep 2018 11:13:15 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8QIDD4t003393;
        Wed, 26 Sep 2018 11:13:13 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g5EJF-0001aj-MC; Wed, 26 Sep 2018 11:13:13 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 3/4] dt-bindings: clock: Add bindings for ZynqMP clock driver
Date:   Wed, 26 Sep 2018 11:13:00 -0700
Message-ID: <1537985581-32164-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537985581-32164-1-git-send-email-jollys@xilinx.com>
References: <1537985581-32164-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(2980300002)(438002)(199004)(189003)(336012)(34290500001)(426003)(446003)(11346002)(26005)(77096007)(2906002)(2616005)(476003)(126002)(486006)(14444005)(44832011)(47776003)(36756003)(356003)(63266004)(106466001)(2201001)(36386004)(186003)(4326008)(9786002)(316002)(72206003)(48376002)(5660300001)(54906003)(107886003)(110136005)(8936002)(81166006)(8676002)(81156014)(50226002)(106002)(16586007)(51416003)(50466002)(6666003)(7696005)(76176011)(305945005)(478600001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4754;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT027;1:4dg5qN0LTsjfYvt2aKb0WX5PnYjEjuUxaRwh8SLCnVIfmOiyau1nDg9FKZDeLVdFebjE8BOrBgi+QCqCAbWowYY0xG+NqDgsAC5/4wLdgcG5Rtayx6e/ya9BDE1ldln+
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab9af401-6f30-48c3-246e-08d623dbbe15
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4754;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;3:77aWlrC+DcwQ8WxlHgNbrIFIpfGyc8VnqGkX0bHIjiwqi7+YqXzFgdjW/ZE1VRRzAxBZ1AbtG5jE5QhLt6vEFeOmt89cDuiNWJe7SHVYcU4ydEBS7zzMxV6JCOrOYfMNXtnjYH73GZKs9QRu5LG8Noru8OY731EXnWdhPXv1dnKkHQHyl3sLG6ZMq8G/wZtpdZWaFRcGyWFQE+LvXBQYhu+YmyBI2aHdDta+acQK/GaV01irqYPygJZjrCVsOaygKfwnyS+NRiWhWU1+gC0cSYaCdK/e+lRUkD1L2GNmNFQVxeOzlv2Bkydm0VU/RYJBxJFTJuJc16apTTtyqUFr7BI+Ewonfkqm3TNhD9PSHXY=;25:asuu4axNsdTDEWFYYNu4eotX27Nqd2x3ebfP6EiYRhX1/Q7wv02rrMNW54EgtqerF5H1Z8eA/PUZ35QSWVOKnEIE1JWI1jVQO4ah4rldQeJ5uGVr8F4GEzhqxbq3euIo5d4CNfMSdXYe0Wx9cwFh34t+2d1ugF6PoGnTv3UW60CDHgSKw2nzn0nycMWez1YbdTbkLVaYe2N3uRQbpfPHrQsB9+rxMtBI5lZTKXuRyC4D0IC5TjlRyIsyVMEypbFIzRZcX+5IL/W9cHCvtrzjnwJ6nU50smaPoa5WJH1fhxOmSjH/Y7W5+tv2RBLwg54msYUAGHTw6wDpHrPhs3FZKw==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4754:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;31:ZUK4VO8+yr8X3tNaRKuKGq+lY/J9AorKS0bMBYnAAcgrdwfhsHEYY6XVSniLCneNaKMlR/IiqOc2tCnl3m4WsVtgrMeloiYVQparn+mxi53yFymI/0a1I8zAAyWZGyDEJGIqEm6m5ieMfpVW5b7oyXgsS6WKLnaPiu3B41FQAbCJxH3bk0NT7vGcYPiUos5FaJBksbNMJ8xgIhn//3G7yrVycVy2VJJWH6kH9xORmqw=;20:boTtS8we7vuneT+jLcni9YDrbwtBqxWNBBRHJdGR+7+OsLKjuZNTVDZa7jMiOfLgppa9e2E1DbPgasjYfMylpHJd/u7rhvyjttxIZmvgDqHCLBnPDjn5CeGcbkHbvsg/ICoTXR6Pz0yCDeSqZgZ+uh6N7oDC88a4mOGR/anqU5Ng4qxmCkKvOc0Gsi72ZeJk9FNupcV1ZrDxuXgz6ihx+YQS36LSSCeLx1iqNomZmmmAwWnrVC0M4yTv9uBgiRT+0EujtsB4jPsWED8XzMjuKyLUMoFITTy7cyFyjnZiGsy8Ej5+OQJDWcRooAKVALn1jyZAMQJrpUWXCmjcyvev8ZnN5dgu1qFKAlAICqT7cvnAjFQVOQnBrG89c8csFSKTdfb1fXAcuM+vIu3Ak5YQDxfdo+5enp4KKp6/hiRtE2vw/Iec/ZgM1neOdHclJYPmCzSkpsjJoqCtVwvsR5yhtZD21veZ4T3/GrcsFrJo5flENgmsn2UBrGLP0syqJkAD
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4754872414187EB96B12000EB8150@BL0PR02MB4754.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:BL0PR02MB4754;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4754;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;4:w1VzGE3kRopHQokSOlbSw43mouyPQfIWl068y7pKeJaTu/enDMOFfO0JRhHC8SS22I7wFuEmYpzRxKUvJnuBcVGQ6P03OnTW7GljJmou6QyThzPSO6jCS2IlCvHjEvFvEcXbBAhO5zVyLYQCi9WkpyTValSJSAFa8zda5d7giLYxWjOfozzUdGrjFro3i6sFyVlngUjXsDq8qKByWzGFtdlZw0hJjVnz3Pq8FrNKGuKoVTtS7mXfm8qyJt4/JJcRt2OYU22L/tbN+wexDICI/JiGSaZCwv/KOwWHHBInqrX5sFwc06h4zPMnaG825zlv
X-Forefront-PRVS: 08076ABC99
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4754;23:uQYqWyzeDemsHBfTP6gihhcDkGnsAFkGjjsfrxKFr?=
 =?us-ascii?Q?BvtR/li1NSyKrZdoWxS99yyKa0JGHQfQoRmEDRIXlMlhBF479UE6KH/VDyJe?=
 =?us-ascii?Q?kdY6j4vMnrHrOUNQG7q37L0s0ND8LmQkVUYnj0uSubyKGG2Vh6Pu6jOnc/j9?=
 =?us-ascii?Q?b/sjfc1CPhZsg6BrVpi0GVe1phpvE/rg4PFFw3vg5bpRWfaK+kyYIBKTZ98a?=
 =?us-ascii?Q?BzG72mD9Zz8jlE1zwlXp43KdNr6y7ukoX0uyspryrlPcLqO+HpmeMXMxtUIM?=
 =?us-ascii?Q?xvc1YK5bZ9aXTrneRKYENn9EowoNuIhi/cJWf1/ksnlXy/NYqvztLAG5STbY?=
 =?us-ascii?Q?hPQsbJNB2aDxNW67HPlfzTM/gGIIX1KgIVHSJboom567QH18LTS3dRrdU2Eq?=
 =?us-ascii?Q?WoC3GRqqVE7SOKVNePWT9uOG49jdza7KR2lZhmm8iiVT5ZNABgMO39CWtDdO?=
 =?us-ascii?Q?QomRWH9uxC97Pmt0PXtK6xORLjuBjgnq/BdRh/5Fsv6lzWdrjxVGpXisZlvI?=
 =?us-ascii?Q?UaFplf9k/YJMv0a2zipJHPWCN5ifQ4EsRAw0dUByT/AIXeaAul2H7YpTw9F5?=
 =?us-ascii?Q?07d2/NDEIVc+AVbtIJXJHzRFDte++qo9kCE97aIdk4N2BW0kKZqSXokZwswr?=
 =?us-ascii?Q?+ohh9S/ghtu7ZWN1jk8Pf16c5oDrXof8Aplj+aWPeZkPpDAHk1kmwMj3+ONT?=
 =?us-ascii?Q?5uPiaSbfFvcVu7JdPvDkWpLtzLvjuUhZcXzVyyOKiP1F+VCQxyieU+zNlti5?=
 =?us-ascii?Q?G/eTQYPQx7UFpM8/njWOiwvaG6LkVKyfWWyV/DVUDhfbcWJOJci1XRTgWqpU?=
 =?us-ascii?Q?GscLRDravWoJiChbih9XCCve/xgEOFScYYS1myzYPopLRsaTq3xtC3Dilc5M?=
 =?us-ascii?Q?16Xibj5apJWf88T7YFvag+H5KBYn4AvGHPVywvwnD1aNdokKIv0/AollXno7?=
 =?us-ascii?Q?l0P55CJAKHUvs1KIhICaAA40WLmR3DI85sSu5R0fMawkcFswAJEtjmV/Ok7L?=
 =?us-ascii?Q?H79+n5nQzb7ATDxZizfxRa2Omm8VBRAba6OIUQjqgIl3C3DBU0dmbceBnuCP?=
 =?us-ascii?Q?ldf67rr1HcL0QVg4P3eAMys8i4HSZCrM6BCTS9avq+dECPjF9/RywoIb9d2d?=
 =?us-ascii?Q?0JWd/BD5x98xCcjXGWdn5jbCEc+3bB0YOA/LmOOFK41bkTQ8W0V/R/13ozv8?=
 =?us-ascii?Q?LVpr0XvyXShPs45PwPtz83NsjYKpnc+kQCz?=
X-Microsoft-Antispam-Message-Info: h7SrzNzHuNltZtKDIXeEziXqtEfbPC4LeDH1RcCIX8Zt8i/YgNm3WC56s9fDw+MNih/15jnIYWMPDCYzT/fRczStSEzAWT4ofh7Cfzu9Yd/mnOtsRhAxdD5k1FXGVWrSSTPfy9Kt6k8McUB6G8teTN26RwdQFgOV54s1Q85YXePLIh+XFuf/omE1yDuhfZ/we+vSpdU4Pn4YIolzy4FMl+/lYp0ekCkgKo2E02ILJmgRIoCd7Ua+5c1xO89ZeFqmM9Q8+ENpn9uwa217W1uCNP/5KjNsWQefSSaTRR/tKha7mLUhwUo83GmP0sI5FJwgNwWIeYgqXJwmc8Dwk32HWxfmL9fbYP39MoZgWQ0I/Ws=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4754;6:2qh8mQe4k7CfnW4MadWf4MaBNrtlkauMGRDJB2yJDbeSZWwBVPzVVoNJ3cdOGW/vVNUzEjoV+zn/ogpLh0f5klngehX6RmAZwHAmUxX9icobYfFl9udugaa22hPWTe5ORA/p8EETQ0Thc4pPc/QsHnn8XJq4vUyXfEryna4frO81ImO5EPA2gXbAmv+Ug/PoeiTra1y1f/OvwrxvHk/TOQfPAoT5dKSQMrqEcm22/af0aXp8JXqzIcPx8ai/DPYs6+mcio4fLMXBIzeylxTJptkQwIEPzEbpTaqIq6gzko/NYKjQe0Wao8p+zQGaRdNGl34tUsyKzZtWiBWVh9/gCjR/7GmUMXGY1UYHwDs7qATC6EcrJ6plEtT7xajFTu5Ct54DzaNkPZp2lSSZsmfjiCwxV1/4f6aMvOGS6eVfw//Ciw4TTh/Qaav6qE/RIfQ0880ycSordHpMjKD9mUjPVg==;5:lZgeGEDys8LP2t7NHvWh5K2s6WDgNvEMylgKJN6BhAM4HejlrpFDgO9HsrcurQt7iQcERRW7viNXFep1iVJbhe/sMgF6M1Bp/ukFdyfXenBe8zKg5FMxgth+wQzuvDjuKu+8cdw8Mq7/8mx2zQXSFH+v8XV32EjjaTGph9KuOOo=;7:Tx5VIL/IaUWy1dk8DeFajRaOkP1WYCXx8x+jHaNXUS1I2lgGEtNwXK4LQmtjW2kNLXyL2+tiCi0Zvbh2f2SACL+1qV+hu4lrf3rrkSSzzcBqiL86OikrcPF7TnIKB+uvCgSpEcFYbU3HF0mf0YmL0dW9zrn7zYCwxa4JD0qr7hwdZNls/VKT2PcppvgxE3JWPvEMui9p/c1D6LLKFsPSyca8Dctys8FErmWgjsrAchWx6tsfSpIQpk70dRiRM7MN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2018 18:13:20.9776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9af401-6f30-48c3-246e-08d623dbbe15
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe Xilinx ZynqMP clock driver
bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 +++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9..614bac5 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,6 +17,53 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
+--------------------------------------------------------------------------
+Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
+Zynq MPSoC firmware interface
+--------------------------------------------------------------------------
+The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
+tree. It reads required input clock frequencies from the devicetree and acts
+as clock provider for all clock consumers of PS clocks.
+
+See clock_bindings.txt for more information on the generic clock bindings.
+
+Required properties:
+ - #clock-cells:	Must be 1
+ - compatible:		Must contain:	"xlnx,zynqmp-clk"
+ - clocks:		List of clock specifiers which are external input
+			clocks to the given clock controller. Please refer
+			the next section to find the input clocks for a
+			given controller.
+ - clock-names:		List of clock names which are exteral input clocks
+			to the given clock controller. Please refer to the
+			clock bindings for more details.
+
+Input clocks for zynqmp Ultrascale+ clock controller:
+
+The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
+inputs. These required clock inputs are:
+ - pss_ref_clk (PS reference clock)
+ - video_clk (reference clock for video system )
+ - pss_alt_ref_clk (alternative PS reference clock)
+ - aux_ref_clk
+ - gt_crx_ref_clk (transceiver reference clock)
+
+The following strings are optional parameters to the 'clock-names' property in
+order to provide an optional (E)MIO clock source:
+ - swdt0_ext_clk
+ - swdt1_ext_clk
+ - gem0_emio_clk
+ - gem1_emio_clk
+ - gem2_emio_clk
+ - gem3_emio_clk
+ - mio_clk_XX		# with XX = 00..77
+ - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
+
+
+Output clocks are registered based on clock information received
+from firmware. Output clocks indexes are mentioned in
+include/dt-bindings/clock/xlnx,zynqmp-clk.h.
+
 -------
 Example
 -------
@@ -25,5 +72,11 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		zynqmp_clk: clock-controller {
+			#clock-cells = <1>;
+			compatible = "xlnx,zynqmp-clk";
+			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
+			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/xlnx,zynqmp-clk.h b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
new file mode 100644
index 0000000..4aebe6e
--- /dev/null
+++ b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ */
+
+#ifndef _DT_BINDINGS_CLK_ZYNQMP_H
+#define _DT_BINDINGS_CLK_ZYNQMP_H
+
+#define IOPLL			0
+#define RPLL			1
+#define APLL			2
+#define DPLL			3
+#define VPLL			4
+#define IOPLL_TO_FPD		5
+#define RPLL_TO_FPD		6
+#define APLL_TO_LPD		7
+#define DPLL_TO_LPD		8
+#define VPLL_TO_LPD		9
+#define ACPU			10
+#define ACPU_HALF		11
+#define DBF_FPD			12
+#define DBF_LPD			13
+#define DBG_TRACE		14
+#define DBG_TSTMP		15
+#define DP_VIDEO_REF		16
+#define DP_AUDIO_REF		17
+#define DP_STC_REF		18
+#define GDMA_REF		19
+#define DPDMA_REF		20
+#define DDR_REF			21
+#define SATA_REF		22
+#define PCIE_REF		23
+#define GPU_REF			24
+#define GPU_PP0_REF		25
+#define GPU_PP1_REF		26
+#define TOPSW_MAIN		27
+#define TOPSW_LSBUS		28
+#define GTGREF0_REF		29
+#define LPD_SWITCH		30
+#define LPD_LSBUS		31
+#define USB0_BUS_REF		32
+#define USB1_BUS_REF		33
+#define USB3_DUAL_REF		34
+#define USB0			35
+#define USB1			36
+#define CPU_R5			37
+#define CPU_R5_CORE		38
+#define CSU_SPB			39
+#define CSU_PLL			40
+#define PCAP			41
+#define IOU_SWITCH		42
+#define GEM_TSU_REF		43
+#define GEM_TSU			44
+#define GEM0_REF		45
+#define GEM1_REF		46
+#define GEM2_REF		47
+#define GEM3_REF		48
+#define GEM0_TX			49
+#define GEM1_TX			50
+#define GEM2_TX			51
+#define GEM3_TX			52
+#define QSPI_REF		53
+#define SDIO0_REF		54
+#define SDIO1_REF		55
+#define UART0_REF		56
+#define UART1_REF		57
+#define SPI0_REF		58
+#define SPI1_REF		59
+#define NAND_REF		60
+#define I2C0_REF		61
+#define I2C1_REF		62
+#define CAN0_REF		63
+#define CAN1_REF		64
+#define CAN0			65
+#define CAN1			66
+#define DLL_REF			67
+#define ADMA_REF		68
+#define TIMESTAMP_REF		69
+#define AMS_REF			70
+#define PL0_REF			71
+#define PL1_REF			72
+#define PL2_REF			73
+#define PL3_REF			74
+#define WDT			75
+#define IOPLL_INT		76
+#define IOPLL_PRE_SRC		77
+#define IOPLL_HALF		78
+#define IOPLL_INT_MUX		79
+#define IOPLL_POST_SRC		80
+#define RPLL_INT		81
+#define RPLL_PRE_SRC		82
+#define RPLL_HALF		83
+#define RPLL_INT_MUX		84
+#define RPLL_POST_SRC		85
+#define APLL_INT		86
+#define APLL_PRE_SRC		87
+#define APLL_HALF		88
+#define APLL_INT_MUX		89
+#define APLL_POST_SRC		90
+#define DPLL_INT		91
+#define DPLL_PRE_SRC		92
+#define DPLL_HALF		93
+#define DPLL_INT_MUX		94
+#define DPLL_POST_SRC		95
+#define VPLL_INT		96
+#define VPLL_PRE_SRC		97
+#define VPLL_HALF		98
+#define VPLL_INT_MUX		99
+#define VPLL_POST_SRC		100
+#define CAN0_MIO		101
+#define CAN1_MIO		102
+
+#endif
-- 
2.7.4

