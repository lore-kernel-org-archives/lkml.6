Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643FAC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6E420821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HcjECgMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfBELI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:08:58 -0500
Received: from mail-eopbgr790052.outbound.protection.outlook.com ([40.107.79.52]:12512
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728155AbfBELI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypFHdbhHTMqcLgbWod8+jJ+v08eECAN4ef6+EswcbkM=;
 b=HcjECgMZvsdLKR8RjjPdWKG9OGqSnLjXXyT/QwAi6M/nkSsQwUKpnR09vLpxsjvqjXqg7U4rJN7HtWaoJ1blmRJru0y67qTUYzeVIcxMJ5FoEvLueG830M23D1hUEsmgQiiT6r/8k3tykw+3wYAb1N0uYL7Cq5j69/kJegEggbM=
Received: from BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29)
 by BY2PR02MB2152.namprd02.prod.outlook.com (2a01:111:e400:c506::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17; Tue, 5 Feb
 2019 11:07:14 +0000
Received: from CY1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BL0PR02CA0124.outlook.office365.com
 (2603:10b6:208:35::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.23 via Frontend
 Transport; Tue, 5 Feb 2019 11:07:13 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT029.mail.protection.outlook.com (10.152.75.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 5 Feb 2019 11:07:13 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:48476 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqyZM-0006IB-Om; Tue, 05 Feb 2019 03:07:12 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqyZH-0001Mi-Jj; Tue, 05 Feb 2019 03:07:07 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x15B6vuL020333;
        Tue, 5 Feb 2019 03:06:57 -0800
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gqyZ6-0001EM-Kv; Tue, 05 Feb 2019 03:06:57 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <jollys@xilinx.com>, <rajanv@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v3 1/3] firmware: xilinx: Add zynqmp_pm_get_chipid() API
Date:   Wed, 6 Feb 2019 16:37:19 +0530
Message-ID: <20190206110721.27765-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190206110721.27765-1-nava.manne@xilinx.com>
References: <20190206110721.27765-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(376002)(2980300002)(199004)(189003)(305945005)(81166006)(47776003)(8676002)(81156014)(106002)(50226002)(478600001)(110136005)(16586007)(8936002)(316002)(2201001)(51416003)(7696005)(106466001)(76176011)(50466002)(63266004)(356004)(6666004)(2906002)(446003)(9786002)(36756003)(126002)(11346002)(476003)(2616005)(336012)(1076003)(426003)(186003)(26005)(77096007)(14444005)(36386004)(486006)(48376002)(921003)(107986001)(83996005)(1121003)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB2152;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT029;1:PB/tkEB67ecSF9lYUjZSMA52LE0cqhXwR0gprpeklTC1LB2VGY0lvV8W++zv7XAm4LiAhK2KnCBaChj4lGqCEf78F2Zk7Q5kQb5ws0fdL2AJjs8weEb6IP6qUBOa1aL3bG3uiTQsR0tX3WIsEw3gj9dVkdK5FGuY0My6VeiRy/A=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ce15266-3381-460a-51de-08d68b5a1505
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BY2PR02MB2152;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2152;3:O1AnYwRpe4bodzcN7T4UMkfHZRLa1dgZTibuN4yw/y5gwH4LdIo4fUJa7ueEpfLMXkNoHIhAPKuM3qZIAoxrVe9Us9/jykoK42UvsFZ0uMGhJfJURIFPBN12LgqIDiO7kNN50e1H5fGEI5fMgAPIBoBluJkisVHYcku2vLUl2IYQEDQVRnZ8rpzHqrTyctsSPBpJETzQ/uwlRgbmvSFJYtEsxNHfyXtZmJ1dg2xpWZU283gVu9y0Nj82xt8cVLpXxvrYGWU5MKVYYcV3WOvG+RIUAj8nM7BqDFkUcDYBPXGc5JGP9DdOObKWfoSvilV+97Z8b/R6es/4lUXHLbCbmAVFJex6Ez4nITw5ANfpNQf1MB9gj+6NCGs3vFhsWnDF;25:QiGkZnsvQArWAnjsFuk1WxLVAR6NY9r4B9vmUuM34ozNLPViiPX3ysAnv7wYE7sT90w5c314ZJrz8s+WT7/epyu7kH+1eoMTkflX/2fp6xbtSbugT0crIwhxnBFXHIpRUwGrWBUJ/HnGPNuKFEeqHXHPkacT1FlwfFSuCjgDPtJPfM8NiTcfyEMyHQhyrInTjxMagCSI8h6Zn0ST5UG1erxrCskriTjcLq0BRRaJD6hyvWrSUZToI7OoFMXUaAFjywLt8bVlklcRrKV/C5bnFcfiWXZaqQoDPf8bWiJO3lnicZFErnQkCrlV+FdK63LvsKHINM45YVwdWejBhFXx9Q==
X-MS-TrafficTypeDiagnostic: BY2PR02MB2152:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2152;31:sciYFB1gZN6E4nwuhvntwCEoaurEkXK12LgC8hwjAmVxYVxe0rKDYZ/ATEMiKVWeoyXmyoNo8KTAeIHq7kz/yzrscJwxcMR/TcxTZkwiG6ugK+Lg042TGirK15VEf4FRQKvEWx33Bqm65BHjQhjBfNy8Qvtgfoj/a/+dMRzSVIbDBcNMd1iZglLhLMogPfS5Nbjh12qll4IwANPUaZZmXef5vrqzWYA7ziV7pyHIC4Q=;20:Tb/v8sNgXx5r27EP0vU8dfoAjJS+eI4R+y7+16zHyXSaIXfyhczCWl1soc0usEKPmXYeCeLNYEl+57gL8IK4RBQGSPfQ5+0LbJyZmhRkJ80IaOSDQGod3xyYf/HkcQRm2MKgeohds1ceC2A1Uima74ov79wkf5qJoI1TaerNuLRtt0Zw5ZA8i4+tQQRJ6951OQ6g9BjQRnDOw9MUDGecNJnObn3p4hH/n6cUz81a+szwZAGDQQKNGtiiw4KNI0ggJtBdVTymT+pL20NXV4U04ycmjuRDfcoHT2f3OiOQPQjOuwE14jwPLm+ioqbCsJtcei7v5LWzc9iKD1EyZg+3MW3HoU4XjtUXMWyPSV98Prp2UiQhqog2ucWGpLYMYAtR3Z4R7zCGu4nudmBmLufEJJQKidaoUm7+rAR/KUyqIJX610QZ9ju8RPf3OeLxAKahq3taP+DOL+nsJjAqfQx3zTAmDigZZROkQxkDWvVRBnX4XfLmIYpBQvx7r3ezjI6J
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB21524D9216F9B0367E341651C26E0@BY2PR02MB2152.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2152;4:QBGk+d0iBOIFMqTOjP0IIGdzif4OwKnF/8I8iAH8JkA4BJaHI2Qkp2exjiIEcsgZz8pqZBqWVxwEX4FIQ7PsEh+m5CIx1KlOmWJPHUX4x86gSYrKix4ZWXURaYWvebT6pbRU6KyOWUBj9DI2MatUmuzgJsO6TRuJ0/GeCpns6fi3sjofv8snxfBaaZphf+AeFEp775Cv3ssHBd3gQIZJO145B3XWMuwWp4A81wrS+wxX/r2g2/vwUyeHimRnI00czzW/e8WHj/VTgPfH4okOkKmrpIgxIIKh132IE0CAGmleNxg1DqiEhn+ozyTPI1WB
X-Forefront-PRVS: 0939529DE2
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB2152;23:iFRRXld8MwAWzZcSMozFUk4GPP9DewTnggN/q6FHB?=
 =?us-ascii?Q?lnM8I+XRYyP8VcytwPdh3+g/PN988wYV4irwp+oFlTzbMcBjHBF4kEiqkArJ?=
 =?us-ascii?Q?50AQMI4E9dQGA4U3YoUjMF41lkfPtxG3vq+NVNfV6odNUMuq3v+EeDWytevE?=
 =?us-ascii?Q?dtNkWZfwLl3W6DES1+wsHkzYvUQYqEEEgxwe6gvYupn6JdQyqPW2IuMcP4w7?=
 =?us-ascii?Q?dD9xAYuGSuRSZh+HPs3PoODCJbG5rC13XO2auZoQviGDGH7QmP6apXF1rVhT?=
 =?us-ascii?Q?otUerE4rmyhqhx2zEPqPxdNN5ubiPvsSRJrbLMmGnyUyr7uRi4J/e67iuUTB?=
 =?us-ascii?Q?3MdJqZxAcaWhRN0xtfuiXB+AEB/q62e+6GB+O4sND+iX302OraTQNo5ynuzT?=
 =?us-ascii?Q?BPdyKFg8R4LBMndkpqjf4C/QB8IP8FTiVkezGBrpD4IcmtaD1bWoKtKJ0TLf?=
 =?us-ascii?Q?2HggBwvkbs68uhxEEOr1NV57NI8g5tD1g9cTPuzngSjErtUFkA3pJxaYENTy?=
 =?us-ascii?Q?IzSW4EnmhNTaHwAQCXDm60lSRXOHtvWbYTVZ2Nq+dRu8qErIA3eqFyEmRCD/?=
 =?us-ascii?Q?uXlHpcYlddseI+ftTWp4ksJzvlMOIEvgIMxZT8CEoq06B4StsNu9KROHC1rr?=
 =?us-ascii?Q?EbuCxUvC8BNdyIY5hokxrUXSVtrr83hOvrA4Rpl3TRYX+Nq6kt+x+RGZAziS?=
 =?us-ascii?Q?3y4TcRdC3IOHx+NcS1zqPOY2pcpw+gnRoVkxtG521Vv3dlLUReIj6a29M2YS?=
 =?us-ascii?Q?n6FMNePcYYW0YjaqjL4I8/EbOSkKAiJLjqXtFAogR5zeZEwbvR9YB34dimSt?=
 =?us-ascii?Q?PEvZWrAhYIcNhEDxBwpLk0MR5GODMCtqJDQPSoqzKl2AJYBhxexbk1C+RnsB?=
 =?us-ascii?Q?oBXasenutWeS3jc8vEO+gkG3ONvsBjuIfzmTRP8TeFMHbg9e8HdzqFZ6iUuW?=
 =?us-ascii?Q?VdpodlHKaTZHhePi36xjE41OM/1jEjvKeRvxwM+AoMhrvwB9RAY9sEBI8F7I?=
 =?us-ascii?Q?VaKzhelXA20WlgZESRq/H25jG82d8m3ziviL1KBl0OcykhSwZVf5MhviCNyc?=
 =?us-ascii?Q?xDH0gVYMRYrmnxpsunFfc64xYnOwLAjtWubbtIBIl2XqIRABFxBjSQNKEYqq?=
 =?us-ascii?Q?vxAwXyJnuo++5wfaHcTOGyu7LhqvwtmVBVSMUOx9b5zmLjtTTaY+A=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Gtrm/iaNebtlPOaf/8wts4rXfToGdAv7cOse1/lmZuyCAygMb58sKIvJgH9BcfZFALHkM+819txTOj4/tOmtMM33DVPERNWySycryaeMDb+pEN6ik24na7Mx9xPSpsKLAyoYeT+gc4Izyv+6m7+AIO7IxnCOgnswvng+wf2YJ0jVYDvD1YXA5Okae9FzAdI61dre1PcRpheUPX3fUJRSzgv9r+LXCC135T1CkibKx142gsa0tFrpdMLKWFHdMRzi+3SK8H/23NcqcdFUqrn6Cf7fjY77rAgDyvFbQjzTZ+91ULWUfLFptX+EGXmX+Mhobp/0P0gQp8eDFwmV9+M3zmr8ZWEETNd7QaSnVojCOh/45tXg/aG/DOzByhE0vvbFDOn/30HBFtQKixLjcAvk0YY0Za2mNC7aWyD3CzO//Kw=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2152;6:o2QLeEqpgJYX0650xPiSJk3Lt3GhcK3JNToppgBIK3wieFQvP8YH4Qqe8P9dWWfhmNxXwuhiFWH6K9arE+Bo0WOjQZX6gv/GP3b1xNxth2i/X64CiAj1j2zQgdw2yrkIjeYRHAQmiMD8ksgN37neG2pAOvlLlB3Fn8/TeDZ5JHhiheN2kezmFgIhYSTjktPL8pKfl9txjpRVNV0k3tc08wALm3tN4V0EEeXsq+PuiEIjnHVxiRgdsw93y5dOZwsEwUmfKOD4iqPw9qMLAaP5VPShZaovRbjqxbEpQ+Ify7aQTeFkQuRyCF2082sWmT74xzdZrcGbG8KIaIreVTI6SWs+K8pi984Na3NEYflHb4P61G6Np/VSPRInj1j5eX6nOydyGZhHPcoP0t6q4ZSU5HucyrF2svB+I8n8vchtatU5rWsSFkSUh/YmnAKzQYcTg+bQjH/pMOvBrwlRW/ILbw==;5:5h9caWgXubyb9omsk4TB5ZQz4AQsTMudn1FFYXEcO6oyXt+2SCTUxOoWgmxraXIp9FGB+HwYOE6azwSGrYuxSd+erGPV6qCnYllcrzJQrHApwrQK3svP2RgEf4KurqfT6+Mff8B2GUAnADUZQZFu6Q5iUMWGx80VkUOCc/QjzIJrJhNpuvw00zPE7rHCJbOka1PPp82r9Jvwm1wB/GH78g==;7:EO3gTV8RBXko2G9I5IKvMguEgVArMwKvOhUgOhUA9bSB02A+r+F0umj+JYH2W3rL4xQ0V9fTisXs0+H1LxF8htUBGGUPdxZ+q9FPSwe9sN1/l68qH1sppu94Tlhgq3dIIHFV+e8h1NobQE1+hRAk1w==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2019 11:07:13.1718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce15266-3381-460a-51de-08d68b5a1505
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB2152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new API to provide access to the
hardware related data like soc revision, IDCODE... etc.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
                -None.
Changes for v2:
                -None.
Changes for v1:
                -None.
Changes for RFC-V3:
                -corrected typo error in commit msg.
Changes for RFC-v2:
                -New Patch.

 drivers/firmware/xilinx/zynqmp.c     | 24 ++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 9a1c72a9280f..af2a209fc2da 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -186,6 +186,29 @@ static int zynqmp_pm_get_api_version(u32 *version)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_get_chipid - Get silicon ID registers
+ * @idcode:     IDCODE register
+ * @version:    version register
+ *
+ * Return:      Returns the status of the operation and the idcode and version
+ *              registers in @idcode and @version.
+ */
+static int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!idcode || !version)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
+	*idcode = ret_payload[1];
+	*version = ret_payload[2];
+
+	return ret;
+}
+
 /**
  * zynqmp_pm_get_trustzone_version() - Get secure trustzone firmware version
  * @version:	Returned version value
@@ -471,6 +494,7 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
 
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
+	.get_chipid = zynqmp_pm_get_chipid,
 	.query_data = zynqmp_pm_query_data,
 	.clock_enable = zynqmp_pm_clock_enable,
 	.clock_disable = zynqmp_pm_clock_disable,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 3c3c28eff56a..c435f4b35adf 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_GET_CHIPID = 22,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -91,6 +92,7 @@ struct zynqmp_pm_query_data {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*get_chipid)(u32 *idcode, u32 *version);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 	int (*clock_enable)(u32 clock_id);
 	int (*clock_disable)(u32 clock_id);
-- 
2.18.0

