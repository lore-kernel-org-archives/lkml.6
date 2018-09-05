Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D186C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970392075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DV2+BYw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970392075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeIELig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:38:36 -0400
Received: from mail-eopbgr680062.outbound.protection.outlook.com ([40.107.68.62]:1974
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbeIELig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sV4GUXGLm8O7dhTAay3RyA3PVaF5nB4dR8dK3GsYyZ0=;
 b=DV2+BYw8nBI1eSQ0lJD2M23BlR0KRrGe7O+n4gHgc3rGhJj5BhLGQZtRe7rhDkQgMJLFk3ur0COZ3lboiJFVP9ofJ9x1sqh9hhv26AQBoUWGIaPuaOCpZctHQHH44nJiDLgnqsvSSbA+RWPiqWHGQKCF1ilFQjfxZWR93+YzHbQ=
Received: from MWHPR0201CA0005.namprd02.prod.outlook.com
 (2603:10b6:301:74::18) by BL2PR02MB498.namprd02.prod.outlook.com
 (2a01:111:e400:c2e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Wed, 5 Sep
 2018 07:09:27 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by MWHPR0201CA0005.outlook.office365.com
 (2603:10b6:301:74::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.17 via Frontend
 Transport; Wed, 5 Sep 2018 07:09:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Wed, 5 Sep 2018 07:09:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRwL-0000Ae-Dh; Wed, 05 Sep 2018 00:09:25 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRwG-0000cA-A4; Wed, 05 Sep 2018 00:09:20 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8579CdT024285;
        Wed, 5 Sep 2018 00:09:13 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fxRw8-0000Zf-C7; Wed, 05 Sep 2018 00:09:12 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <p.zabel@pengutronix.de>,
        <nava.manne@xilinx.com>, <rajanv@xilinx.com>, <jollys@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 1/3] firmware: xilinx: Add reset API's
Date:   Wed, 5 Sep 2018 12:39:00 +0530
Message-ID: <1536131342-28041-2-git-send-email-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
References: <1536131342-28041-1-git-send-email-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(438002)(189003)(199004)(36756003)(106002)(63266004)(76176011)(14444005)(356003)(47776003)(5660300001)(50466002)(48376002)(110136005)(8936002)(305945005)(16586007)(77096007)(186003)(9786002)(50226002)(6666003)(336012)(106466001)(81156014)(81166006)(26005)(8676002)(478600001)(36386004)(426003)(11346002)(217873002)(2906002)(316002)(446003)(476003)(2616005)(126002)(486006)(2201001)(51416003)(7696005)(107986001)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB498;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT022;1:9phwTYhN3kY12gJHrLwtcbfAPCH10vOmKfebjfjCDFThPySJMoeRxHCnfxm55D6sjrQX8OyI+J8euQoc1HSrY7ats9ZkwERzH0cqyif5QAVqwe5yDyOLNsxnL8fbEcVr
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab8b92d4-7c8c-4ee5-6c11-08d612fe83cd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL2PR02MB498;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB498;3:PDgyGPu1kAPJGY6dhQa2D9zmwJxSddXJ2Hv9jlIi5HLvEEWHDziAMs9sBCeqBsdSqkPldpns1//eoGEE2YvHMQNi4huIFRi1eUuHxafngujhPQy12jPx/QD7ilz2t2AghIkvq5R0QBNHTPNw4G4nJ5NKGh71GDJPT85Ht7nawNOXeqfrb6NiFSgdx9NsbCoBUQugyBx/WrmCmgx1EkrFXC7l8AgWyh+tLQ81rDAd6QOfLAloMgA/xtFqVwzboYXbY1gPNXknPSxOk84W+OJlRWcIAqY59N3AWtk1ICQT/BDXt6vwAq51q4ssdCJJhFUzFSPIzDvjqKpYAYHIG9abGrgkMn4EO2FlXU/piuDZ83M=;25:x4PSKNVECb+/GWIC3vsSnE7MLCGiq1jos9mDe7rnU7kGNqmc5tvEDzVAGej1YO8hpj+kZsGr6H8Fd2N5is7YwSt5WxYEeGqf5dSprCs4cfDA4cpAzggEtmvSx1TFM/N43+bO97DrMj+hbD37OdQwXH1ozvQz1ZFiPamvdloIj3oA3sCmOmGrObiOnduwvX0nas4iMrJA4AaUyflMsXDeUAylG36uBdlvKf55/1d6oSLCTIsUfeGoD4rg1SLxtedHFVrWU7O45SziG7H8Z959Midg/ZrxL3lLuluiFm51nsNeEhsFP79r4Qkl/Rth3KpcmRw9JkfltFSbaVaDl2WrqA==
X-MS-TrafficTypeDiagnostic: BL2PR02MB498:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB498;31:sBpKtDr60TJ0GIb3KpIgz8Ir60S458LC8z3ZOJm9ombLka9TzcrRchvPliG/KOIvjD4nkNwi2J9/iGvMNEsyc7v3DIPuWoiBCkfSO96eHCMXLATZ1te7eClcDe3xwQTIVuBbNu8pFyiHvWxkw4jADZ8WSRnaluo+n2KtKaolbDzCnuvQnjguMSJjPp5JdwbSJtTMToB/zoFgGQ8++WSanFXD7mW4ch4gRKBcXez0SOE=;20:VloiT4/LrZ5K+YOIH5HMFz9qEHXesqEu4ee4DzpYTN9GRfGkbm8Ek3raHQniwBj4IokchrrjD2tBeoKVybdbATUUj81ClcVY4E0nkVZTFxP9GXPlax3ciud0n+UdMWEO4ptUwox0zS0I7icGOHlGbZySrM+vpKCIXyzxmleoL9hj7yRHU5UdAIwh73mDibMG3r/3I9NSa6qz/0FmK30w/5d8BJuhhWONANnaXcKk5G5/m2x7bFjmQVgA+QxTIHmjVWFIZyvsQgy+MwEiyRx719nt00W73huKA6ELoztQDqUT0z7jssQBp1f9PugAuFUVy9EwWNilg14TTgfUm9zOXuSJbz5LNBJiioqSeL/JjgjI0vD4DUwaC5sBnisyuWoXFv9jMa3i/JCbxMPUsL4UVmC78U7Tr1uaQd97hp7GoiY8yDVg0pr89FKVz8IIpHUl1AhPMBwZLnGK2SBe2mJCmi+NQIHa+qthIKrcsDxZkmZ3Qx4zJQfjZADo5x0r/d8D
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL2PR02MB4986D6CE16F462EB7082AAFC2020@BL2PR02MB498.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:BL2PR02MB498;BCL:0;PCL:0;RULEID:;SRVR:BL2PR02MB498;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB498;4:RSUqiGgDP6umiZCbOdQfgHO8bLcQIPlDVHWKUpUmjeSD+XiJcswALZ14q6t/+Dxj5hYEOPBdjqLe5tbjxggZgk2LqRKQ+LFMTJIq/RiKjv0oFl/N4y5JaegZZWeZPKjZRjWta6nmXux79dbPxR1vsHUst07F+wS7i+a8XWNBr1XtI6cR0GFrXBGpl8SGXlee8aI4iyMI7G0EoA8LRcFl6ZJN4al29ewvOdjW15EU49Ge93VEhLPJWiohrOyBXQRUVabvIVPMZ8RXWxuyFVVMxGeF2CrT4RqEsRdj5TsROjs5ApdTcZDJnlA+c0YdMeb9
X-Forefront-PRVS: 078693968A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR02MB498;23:XQTkFsUFpPJnMXt1GMEIdI98YP4vr4LI1RFvvpr/kC?=
 =?us-ascii?Q?YfYi3yPFnLwvrJLvveEmF3CCS4fKEi/KMf/EVn5QkIp7/sQVDpvzR7pDkIUe?=
 =?us-ascii?Q?pJWxrEOQv97/a++mKc5VD0jKYVcQ1GJ8tCA+sf+kcLYA1d1VeXVzIZnqvw/J?=
 =?us-ascii?Q?HjruzwoahuYJDumWjsVi2mF8k14aiqoj1Pnnpd/V7eLea+oL6XtTmgSC8Tc/?=
 =?us-ascii?Q?ThdOqgn/3QBMm5v/qG70J0Y+4SZ5dOo2PqKhz7RF2M1gorN/XRQXmxRoGuzB?=
 =?us-ascii?Q?/Kk3omvskEMlWid5r/Y7rvFGQfUAIGGT/g3Km0BQmr2QY+fP1I/9rU8uh8K1?=
 =?us-ascii?Q?loRd/YLWTbpTSNlbr4od+ogzMKsq7hRnphBZMwQKItNoBrNHkLoee+QnfoIU?=
 =?us-ascii?Q?P635pgPIXIraIrGoniIXDD4uuyNv9QSawOHYTzDWcZyAIE8tjZufUzUlRkn6?=
 =?us-ascii?Q?QajS4U/rdcXSyTrmmM4ostRezTIloyYiPmQHYuEPMAmud01/WxxR2Ssomzru?=
 =?us-ascii?Q?VKOKB7mCoyUdbVoRML8ugL45Uj/iMkuaIxDsUiLfwo+Vfq6DrUe0Pl/0dbez?=
 =?us-ascii?Q?HWr5NEwx7tbKv9kerU9N+KORNZ00Sx2boWE0TZR3edsOFElSRi9k+Lmqp2nI?=
 =?us-ascii?Q?0Z/miRz/iWfuSV9WxNAnhJxEtlF0LbKYvlyhW6JkCMMy8DzSgTN8z6oHFLPr?=
 =?us-ascii?Q?Td7cwtTtAAYfxa/mVS2hD/g/7SWXyO2r2UxFSTGfeikyDAx87y8bH2S2/t09?=
 =?us-ascii?Q?t8Kd2nOrwgRNC/XwD0eWT3GVL9k3XY1ftl35HakhpXTxIStGpI0jPkOFn2Zj?=
 =?us-ascii?Q?5Rs4emSGsd6OLms80zayBsqPkJoHTbsWZgIriKSaT05xYQX/LYBhXjc6STcs?=
 =?us-ascii?Q?N+d3ucqdxuXzZIgEXIHqE3tcJyqJva4OK4R7lTymIBb5Wc5OluM8h9TuLEKg?=
 =?us-ascii?Q?OmD4OzjMv1KdrC5OfXoxiPIqkMvj8gQP3XO5nCRitxO6GFFsBx/FOojVO5wG?=
 =?us-ascii?Q?WlLktvtCG4M2N9S1V/9StfXuGLcHyZ1JerV2u+u/T1qxPk/HQs82wfqQn+k+?=
 =?us-ascii?Q?FCjU+wrgcT5zvOtyPHOVQynRN3Wrfe9SxcCQjkCyYS7y13LGXoqpU13Ln0lG?=
 =?us-ascii?Q?+YFvy1kpipY6j1ia1AKIz65vsSou59SNIlqmXPGWzFvXJW/NYyOlZ77wjJr7?=
 =?us-ascii?Q?WFf8u3qzYfQes=3D?=
X-Microsoft-Antispam-Message-Info: d0xcILZO064Oiq0AJVaGzvecPw/YV3HGyQePVPdsMTw2ZlhKYux1GwsmJ2mJ2hlmU6S3Y/w0sMwcUwO599/3DtkPgwVK3KqaPhcja/I4m+DkzV1NrRWj0KKxfapqEz+xWNtUjKgtfptb6jLcVlQsaeOPNm/E0NzrAVe033nx9iZBiy8MruvwZ2GqYh1JRMy+N3WGAXyCTUOpSOfjp0rsFkmvxiEgDu7JNuOwGutB+NbeZ3iQMprwa8cKxj9u74LHDfSt75AS3JfTZT6E9agyQ/fEN1V4FITslb2r/GIR0w5n8qgzEupgGniup8f1B6vXEvIWTOeFqqI0PG2KjfZBkVBvCF6mMa7e46cmbv9XqW8=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB498;6:M4iCRZGaz/pWhVM5SKoUr7I5pQR+eMjJiDoq75bx5VSxp/BK/luN7te9YQ50N3zdhTPvI1g3BADvNvseOaNy7B4qFUrvD34EAkB7bBcm+wSeyOl3V/940YZyLvHykhGxk/btD+7iW3IhNjZoswzr87FH7TG7dR+VLyjIufWA3td5Qf2IP8kqQ0BlbCCkC5GNUdUIDwF3QlaJX9M+SFfrkIOwYgJy5oLZ0tNADgdW/knRJdZbrGl73x5iPWY6+aXNRbFnzhhfoEuKiO4eSUFWhJtTnipGu5NnMPCdkGXuyCeHB6uEI/IyjRzuc3nQq1ApAMqh/4i6qTQh+9WgE3TGsodiURlDVQaerdA4fDFkdxS6ur8owDoZXVllHbwIiV1bEGNnjOSoGSlWLQLbpf8saKC+iHSBicRymaRIA0ohaCAA+vEsSIMrsHtqEFk7sqoZXhmddJMaDDm8xW9OucWQgg==;5:vSar141Gexn/9VHXEkgsY8BQ+c7Cl6ht0GxrvGuPprpmeFkRLt7w2bpH9cJK/JXlZdC8WRRd+lC5ESSV2OAd8bANHnipeNmHOdLb6odaLWlfiqz6d0o6UzlcNUiMi+qDmuwM+GZL1IgpgcX/pzV/u7Nqk4xsKVNBJUWLiOTqo8s=;7:HqFKYUtxqSch8YNhWpNBoxns/oKXiX5kFwN9jB8GETQVbbg5if726aCXl/3DRj6oyb++Bof4AJkx2zO4uup21UZfTGdPG15v+HZWP4An0BIf7B0ZJDhQLxlFY32E+OH8qyMRH8UXTqp6MiMPYgSKwSFObxjFZdCIU+hK1dY9YPFkS+SZ85HwEraP3w9fMe8J+MuhbDVdBNynmQB1zNbWs59XOKouZjKS7vkHRpug70Reyn4cknCy7rnnrD+NB1QB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 07:09:25.8649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8b92d4-7c8c-4ee5-6c11-08d612fe83cd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB498
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch Adds reset API's to support release, assert
and status functionalities by using firmware interface.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-None.
Changes for v2:
		-New Patch.

 drivers/firmware/xilinx/zynqmp.c     |  40 +++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 136 +++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7ccedf0..639c72f 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -447,6 +447,44 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
+ * @reset:		Reset to be configured
+ * @assert_flag:	Flag stating should reset be asserted (1) or
+ *			released (0)
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
+				  const enum zynqmp_pm_reset_action assert_flag)
+{
+	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, reset, assert_flag,
+				   0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_reset_get_status - Get status of the reset
+ * @reset:      Reset whose status should be returned
+ * @status:     Returned status
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
+				      u32 *status)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!status)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, reset, 0,
+				  0, 0, ret_payload);
+	*status = ret_payload[1];
+
+	return ret;
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
@@ -460,6 +498,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.reset_assert = zynqmp_pm_reset_assert,
+	.reset_get_status = zynqmp_pm_reset_get_status,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 58a7478..93decf5 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_RESET_ASSERT = 17,
+	PM_RESET_GET_STATUS,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -74,6 +76,137 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_ATTRIBUTES,
 };
 
+enum zynqmp_pm_reset_action {
+	PM_RESET_ACTION_RELEASE,
+	PM_RESET_ACTION_ASSERT,
+	PM_RESET_ACTION_PULSE,
+};
+
+enum zynqmp_pm_reset {
+	ZYNQMP_PM_RESET_START = 999,
+	ZYNQMP_PM_RESET_PCIE_CFG,
+	ZYNQMP_PM_RESET_PCIE_BRIDGE,
+	ZYNQMP_PM_RESET_PCIE_CTRL,
+	ZYNQMP_PM_RESET_DP,
+	ZYNQMP_PM_RESET_SWDT_CRF,
+	ZYNQMP_PM_RESET_AFI_FM5,
+	ZYNQMP_PM_RESET_AFI_FM4,
+	ZYNQMP_PM_RESET_AFI_FM3,
+	ZYNQMP_PM_RESET_AFI_FM2,
+	ZYNQMP_PM_RESET_AFI_FM1,
+	ZYNQMP_PM_RESET_AFI_FM0,
+	ZYNQMP_PM_RESET_GDMA,
+	ZYNQMP_PM_RESET_GPU_PP1,
+	ZYNQMP_PM_RESET_GPU_PP0,
+	ZYNQMP_PM_RESET_GPU,
+	ZYNQMP_PM_RESET_GT,
+	ZYNQMP_PM_RESET_SATA,
+	ZYNQMP_PM_RESET_ACPU3_PWRON,
+	ZYNQMP_PM_RESET_ACPU2_PWRON,
+	ZYNQMP_PM_RESET_ACPU1_PWRON,
+	ZYNQMP_PM_RESET_ACPU0_PWRON,
+	ZYNQMP_PM_RESET_APU_L2,
+	ZYNQMP_PM_RESET_ACPU3,
+	ZYNQMP_PM_RESET_ACPU2,
+	ZYNQMP_PM_RESET_ACPU1,
+	ZYNQMP_PM_RESET_ACPU0,
+	ZYNQMP_PM_RESET_DDR,
+	ZYNQMP_PM_RESET_APM_FPD,
+	ZYNQMP_PM_RESET_SOFT,
+	ZYNQMP_PM_RESET_GEM0,
+	ZYNQMP_PM_RESET_GEM1,
+	ZYNQMP_PM_RESET_GEM2,
+	ZYNQMP_PM_RESET_GEM3,
+	ZYNQMP_PM_RESET_QSPI,
+	ZYNQMP_PM_RESET_UART0,
+	ZYNQMP_PM_RESET_UART1,
+	ZYNQMP_PM_RESET_SPI0,
+	ZYNQMP_PM_RESET_SPI1,
+	ZYNQMP_PM_RESET_SDIO0,
+	ZYNQMP_PM_RESET_SDIO1,
+	ZYNQMP_PM_RESET_CAN0,
+	ZYNQMP_PM_RESET_CAN1,
+	ZYNQMP_PM_RESET_I2C0,
+	ZYNQMP_PM_RESET_I2C1,
+	ZYNQMP_PM_RESET_TTC0,
+	ZYNQMP_PM_RESET_TTC1,
+	ZYNQMP_PM_RESET_TTC2,
+	ZYNQMP_PM_RESET_TTC3,
+	ZYNQMP_PM_RESET_SWDT_CRL,
+	ZYNQMP_PM_RESET_NAND,
+	ZYNQMP_PM_RESET_ADMA,
+	ZYNQMP_PM_RESET_GPIO,
+	ZYNQMP_PM_RESET_IOU_CC,
+	ZYNQMP_PM_RESET_TIMESTAMP,
+	ZYNQMP_PM_RESET_RPU_R50,
+	ZYNQMP_PM_RESET_RPU_R51,
+	ZYNQMP_PM_RESET_RPU_AMBA,
+	ZYNQMP_PM_RESET_OCM,
+	ZYNQMP_PM_RESET_RPU_PGE,
+	ZYNQMP_PM_RESET_USB0_CORERESET,
+	ZYNQMP_PM_RESET_USB1_CORERESET,
+	ZYNQMP_PM_RESET_USB0_HIBERRESET,
+	ZYNQMP_PM_RESET_USB1_HIBERRESET,
+	ZYNQMP_PM_RESET_USB0_APB,
+	ZYNQMP_PM_RESET_USB1_APB,
+	ZYNQMP_PM_RESET_IPI,
+	ZYNQMP_PM_RESET_APM_LPD,
+	ZYNQMP_PM_RESET_RTC,
+	ZYNQMP_PM_RESET_SYSMON,
+	ZYNQMP_PM_RESET_AFI_FM6,
+	ZYNQMP_PM_RESET_LPD_SWDT,
+	ZYNQMP_PM_RESET_FPD,
+	ZYNQMP_PM_RESET_RPU_DBG1,
+	ZYNQMP_PM_RESET_RPU_DBG0,
+	ZYNQMP_PM_RESET_DBG_LPD,
+	ZYNQMP_PM_RESET_DBG_FPD,
+	ZYNQMP_PM_RESET_APLL,
+	ZYNQMP_PM_RESET_DPLL,
+	ZYNQMP_PM_RESET_VPLL,
+	ZYNQMP_PM_RESET_IOPLL,
+	ZYNQMP_PM_RESET_RPLL,
+	ZYNQMP_PM_RESET_GPO3_PL_0,
+	ZYNQMP_PM_RESET_GPO3_PL_1,
+	ZYNQMP_PM_RESET_GPO3_PL_2,
+	ZYNQMP_PM_RESET_GPO3_PL_3,
+	ZYNQMP_PM_RESET_GPO3_PL_4,
+	ZYNQMP_PM_RESET_GPO3_PL_5,
+	ZYNQMP_PM_RESET_GPO3_PL_6,
+	ZYNQMP_PM_RESET_GPO3_PL_7,
+	ZYNQMP_PM_RESET_GPO3_PL_8,
+	ZYNQMP_PM_RESET_GPO3_PL_9,
+	ZYNQMP_PM_RESET_GPO3_PL_10,
+	ZYNQMP_PM_RESET_GPO3_PL_11,
+	ZYNQMP_PM_RESET_GPO3_PL_12,
+	ZYNQMP_PM_RESET_GPO3_PL_13,
+	ZYNQMP_PM_RESET_GPO3_PL_14,
+	ZYNQMP_PM_RESET_GPO3_PL_15,
+	ZYNQMP_PM_RESET_GPO3_PL_16,
+	ZYNQMP_PM_RESET_GPO3_PL_17,
+	ZYNQMP_PM_RESET_GPO3_PL_18,
+	ZYNQMP_PM_RESET_GPO3_PL_19,
+	ZNQMP_PM_RESET_GPO3_PL_20,
+	ZYNQMP_PM_RESET_GPO3_PL_21,
+	ZYNQMP_PM_RESET_GPO3_PL_22,
+	ZYNQMP_PM_RESET_GPO3_PL_23,
+	ZYNQMP_PM_RESET_GPO3_PL_24,
+	ZYNQMP_PM_RESET_GPO3_PL_25,
+	ZYNQMP_PM_RESET_GPO3_PL_26,
+	ZYNQMP_PM_RESET_GPO3_PL_27,
+	ZYNQMP_PM_RESET_GPO3_PL_28,
+	ZYNQMP_PM_RESET_GPO3_PL_29,
+	ZYNQMP_PM_RESET_GPO3_PL_30,
+	ZYNQMP_PM_RESET_GPO3_PL_31,
+	ZYNQMP_PM_RESET_RPU_LS,
+	ZYNQMP_PM_RESET_PS_ONLY,
+	ZYNQMP_PM_RESET_PL,
+	ZYNQMP_PM_RESET_PS_PL0,
+	ZYNQMP_PM_RESET_PS_PL1,
+	ZYNQMP_PM_RESET_PS_PL2,
+	ZYNQMP_PM_RESET_PS_PL3,
+	ZYNQMP_PM_RESET_END
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -101,6 +234,9 @@ struct zynqmp_eemi_ops {
 	int (*clock_getrate)(u32 clock_id, u64 *rate);
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
+	int (*reset_assert)(const enum zynqmp_pm_reset reset,
+			    const enum zynqmp_pm_reset_action assert_flag);
+	int (*reset_get_status)(const enum zynqmp_pm_reset reset, u32 *status);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

