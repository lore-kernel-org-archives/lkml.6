Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01D1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3AC21582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GFJMwAOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3AC21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbeKOBAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:00:06 -0500
Received: from mail-eopbgr710058.outbound.protection.outlook.com ([40.107.71.58]:20821
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726295AbeKOBAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzpE6mzNFNDfrK/zVpNY0yWMSCgtrI2lIGbkObS8YpI=;
 b=GFJMwAOq8bU0cSwYS7RbDEgyMgk2pwRMqmox/k11vq4lGoGkxU4M2PPuKGcieuiDHfpAus8rsVXc+5ucsUiT3yH5cNAF3lVCrC1WJvvbw8STQl9e8YSv2PggJo4ttZ02L1txTasJhf62WzkBxikoUkLgThzNJvxSFsGsMZGVTK8=
Received: from MWHPR02CA0019.namprd02.prod.outlook.com (2603:10b6:300:4b::29)
 by CY4PR0201MB3507.namprd02.prod.outlook.com (2603:10b6:910:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.25; Wed, 14 Nov
 2018 14:56:31 +0000
Received: from CY1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by MWHPR02CA0019.outlook.office365.com
 (2603:10b6:300:4b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.21 via Frontend
 Transport; Wed, 14 Nov 2018 14:56:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT037.mail.protection.outlook.com (10.152.75.77) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.15
 via Frontend Transport; Wed, 14 Nov 2018 14:56:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gMwak-0004kh-9U; Wed, 14 Nov 2018 06:56:30 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gMwaf-0007wV-5f; Wed, 14 Nov 2018 06:56:25 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wAEEuHJ4014628;
        Wed, 14 Nov 2018 06:56:17 -0800
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1gMwaW-0007nP-Nc; Wed, 14 Nov 2018 06:56:17 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v2 2/4] PCI: Add pci_check_platform_service_irqs
Date:   Wed, 14 Nov 2018 20:17:56 +0530
Message-ID: <1542206878-24587-3-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542206878-24587-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1542206878-24587-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(2980300002)(438002)(199004)(189003)(47776003)(6916009)(305945005)(48376002)(36756003)(5024004)(50466002)(4326008)(476003)(486006)(186003)(77096007)(126002)(336012)(26005)(11346002)(2616005)(2906002)(36386004)(426003)(446003)(81156014)(81166006)(8676002)(5660300001)(106002)(316002)(51416003)(478600001)(2351001)(7696005)(16586007)(76176011)(107886003)(106466001)(6666004)(63266004)(9786002)(8936002)(356004)(54906003)(50226002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3507;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT037;1:6uBet27iiwg2S4oOpl2vsvA/+kJUQ8DzMCYkmlALx9nz4a2vdghMNHJA8JjbYgq/q+MtDM9Rw8PWuFhNLkH68IPOyaIE/SEBCEebdwggNM8h2IsZWSixOdCkQSex03CX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36be6bde-9b24-498d-bb96-08d64a415cc7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CY4PR0201MB3507;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;3:DB4hr8zGI6920E+5anUqc4jxTO2Unzgibpfb4TruEAmTE3F465YVkkpz1crbPMuB5Xy6MzTkWMAdnSsd7uyXjRYEw1jFw/qyEge+WjjQLefKPJCMOBpXRTsgjbXW9sL7QayCu4HRfGwHHzY3PUVrEou9sAHYyITyXWyBvyiHp0MSSl7mOG2JjE1CLbGvY7gCBMr316yByUZwL5ATk2E3KYmzFk5C8H10mIpySoKF8ru7N4wgwtZXcyBvJFPoq45apznW7SJ3vsLL5Zw4kXTyn2W6qEkg0fMOvIczqreROrBRRItY92rhOy9NEmOxfCvZSqyCJXr7Lrv7gvD0Z4o/9F4QHibx2sVQqdNkK9a/dfw=;25:c7xs8basq4OYgmqtqWlwSqwsrtsgvaWKBvoFZzcp6+Ea0JW/7/0Kw9Jpkzp1cYsDBByuH5ctv2i1lCpeRzyNRxPtK0w6dAMFZ9U47kSq/lhIyltK3pzH/XjbUP5dFD8s3vkmaJbHleGgS4xh9MM5dHtU+sLO1pBzEKbObI/05jEpjHGRckq4ysPNpWO+5dhp23X1PtEDRLJ+XTYS7gSamc2KF/8jRQI5HuKCy3XM8ouNqylakFpgXZRtwUnkzpbDkUxFPb46X9ykXuA3TmQ60mbDhzTh12sn9X++v34b8UBcWVIelSuH+sA/CNyMNUKqpI071Bn9z1cZpW4lqOqobA==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3507:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;31:xHpMpV8b3F82qm3rtTy5wMUQqcIUKVMIK3NYzVNioRwMHhFQDDdU3tIYZ8m3pnX6zC2ejQp/HvBFt+w5lWtn1zcsCTmPfQx2OnI2oo8Pw1gjDC8sZBlUZ7lAqxbFJXM+/LG459QFSEgnO24KaQHfRWe8iqa6qJktGoNnFGHAhls8B/F1CU8mzCvr4ADsMMy4itCCziL/y/RLHF6KAGgzTN4tbh9yj8qPFP49Zca4zoY=;20:uTyXdiuy2EMpcDr6+MJ68tQX6z1Ni3+SUtFSm9QHW1dvdQgAJnwkcce+Bn4sym+OYaiDHYUyG4mmNI9htfXnibe+RGbt+JpbefPG9kmciVziTQwJblG//AuHGC2aX8ulLKwBkFqz56jNjByDAZmNtH3BfwlDR1Q32MMLc6nCZO1HrM2FuOJxl2MNv7j0J8X3PM2RtWYWiK8nZaS5RSAU48zg2qAWNmuAfliClMCSmhlm990vPfOM+R6nXMa9xGv872TJVL05iSdaybB9tZLGNbEL0ZHPxv4YGM4ip418SLQ8KrYHJcYinp2yMuNkoQUgcopBvuwn3TspGLBXMILJkYrkeuXolhRNV0i5DZEepG5Wrk5cmhs8F/pwPBrx1p7eCV/NlUez4dF/wK9adr77Hf+lp5zqkbjOt4clJg4r28euwkNrBxg9BiRSI1kT9pxGl7IqAOqSvCDZJW9HYajmvGwiINp6lwx3I7DK7cNykmZaEnQPilqCL0fGKkXtA17Y
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3507A19EC05E10BA17211172A5C30@CY4PR0201MB3507.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231382)(944501410)(52105112)(3002001)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR0201MB3507;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3507;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;4:w3L852Ww8RaYoAcMSIl/w2TpQOSJ0YAusM49l0q/6W9hLP/doIw4neUu+S514fM9xoGgFrFxpLwKbGVD6tE1PqhxKKTnZn/QK9aJsIJJgILuzNMKopxd5gV0SPMYc87blNHLWeZbfYVOwIRLvGpq7f1c9Q/PPDqs7VQU8cAkFoXGFEq9xSCyhfd+Or1pI1q9Zcp9nkLV98OEWz6FXfhnrXaavy9CputF/9qc+LeH1NNAxis/WPvGfp8zOzUYRV59SOsoAQZUSCmkeVLVnIQNQmGF9CFMlPaUaRq5k+hSmGX8wv5QK7xATpkdkR7fayZF
X-Forefront-PRVS: 085634EFF4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR0201MB3507;23:3qiBRJsQUP85aK9OZmUP/mGH2z5yw8jv850ziY8?=
 =?us-ascii?Q?QLOHPQMYzZWfnRtTprWjJTE5AB6DEEFMCzkbRf7/uyyFQGqNafQPqp+tIuHO?=
 =?us-ascii?Q?uGk8zBMXbA10GelVzjrobEi9gDk8SyS8dCJL5hId7v4FpssFcIkHFoPKWG6h?=
 =?us-ascii?Q?Fgy0550hIA5taNmhffHfC142AogH8Ea1suleZKEmiD4FlcQeo+PcRUxT2yW3?=
 =?us-ascii?Q?5vqJJwrkfHF/WiHpzGGhBwAG/6nCSBU/gTr96YLdbBdjU+Dlblqdx8bWmFHP?=
 =?us-ascii?Q?dpE+0HEcFvMoYF+kpmAezZaywkpM8RzYxzuc1nrTI8DG1sP/EE5aOcoBtVGd?=
 =?us-ascii?Q?sxpqGw21Hx13jXj429y2PEo9TTgdMkOntB1MDG5hAisYPbHOBad98R+4OTQv?=
 =?us-ascii?Q?n3qLHE3f6XPhN574QaJYCRjsOCqti04GKP0MVoYNKNN6qqzK6Md0ojb9fjEi?=
 =?us-ascii?Q?z5SmW/N+MjNiH7L7JlXhfOpdLrrJzt8K1+bJfj0E7QAirdbrBLzJps2LNrZG?=
 =?us-ascii?Q?3HuDdHKV5+EG4jL//1GIu7TXj5kRukt8Pi4UqjUf10Xdw+3bHrUPNr/W1R0Y?=
 =?us-ascii?Q?et0umtSg1R1GxFCPaV8Lphw6Fyw+mXYVL8gVfJZ3lznC6dA58GreIqbb8UVS?=
 =?us-ascii?Q?Q9c6Cc9eAbxwU8vorviYToow5O0L5kUKswEbXMQ35XFNM+jRT7LBlBz5s5WA?=
 =?us-ascii?Q?GZ5ql+eibSitnBq3NPtYePv2gw4xtYj3nGuaKT1E5khMK8ejfN5UG+9PGs5c?=
 =?us-ascii?Q?jsVDG+tk6ybl6uwqsxXcddIOsEPMSLcunLXqJYpUXD/B8RtePDiesa6DNodJ?=
 =?us-ascii?Q?ed4L/MtKM3+zBURBMN9wIRDSco/wZAhf/OpGLUaizUHmkIOCCGq1TfaTM6Cl?=
 =?us-ascii?Q?1dv0izxXZLDHADQCMn34tNgkQLSnbDyCXr1fndaXdtqi1++Y2TBVp7NRFIOQ?=
 =?us-ascii?Q?8nrQ60QJyEomSBE5fsvfw7AcDt83VLKmikomSQ5FPilqjxn04NmEcdHkcws/?=
 =?us-ascii?Q?GoQ+5GwYJWVDJITwcXT9JCwEhFIbtjSZurtqiH0tf1e84pckwGtyzDPasdlI?=
 =?us-ascii?Q?ugpfG11Xeo7jcRnmArslR+evjsSROxg6OOOqHKboiyjglFpMCcgxI/p4dG5A?=
 =?us-ascii?Q?w1O9mClU5pD3IPfxDuZfthnBuBlZywiWS?=
X-Microsoft-Antispam-Message-Info: eJ0gnxNze6kvqbAAx/aKW66nXsuBPy+S9DS2BG4iC95srTira6OZNNDwz0qTm1vQ2CvykJh8w/z0q8SV2K+VanYuLldBumjA16xKbzDa5q7bqDDteW+DcG+MQfzWEP6B0p8pDZYaOW+Gs9/L37ORQI89JEAYhULrflCv8BKNzSYk7PiXjJVVJVKl5+9oh+gIzfyNR/Bw4I37fAM0Dm5MlcIShtzk+dGrYNfR5VtG4eFV2RcR92u3GVa5o/ZZtK8KHw05bHsBDPd599gMQaYwIVjEXheuswp1QcDPni+LeyONg0Gjg2ERpp1YAjz5qVW7G9JjxEozk4e8l9qMI6SAILgiJgBN/95a6MZn8nDJY9s=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3507;6:AJPGRkUMFZ489bEVC3ofC1wdL02afANkQ2LbieVyNqX2exKlJg2R7hksPQx1p1wK3mMPc4NY1BHlNuV39zzkTR6nxRx+TBM2lZKT9u+feEqIApCbxC7aIEIZ/7gZWEwc9y5chlN4WdLsQ1tbt3fmE1FFAPOqLGBOre3rwy/S8YWTuTIi4tiGi71C0iVYhGwADhqf0XNEcxR9FQAz7JCOFxh8CNqUPnbzAf3+x5NNlSvKOBpVeY2ZReLPf74zRHM2PqM1S/UshjAwAi3B/A7MErokfn1QvWQBolGF7uaFn9hX2FqJdmavmNEvv91HbCIuOiyDSq2DA0tw8wEW6fTsNm18ljBTiijXQ3M9BZVAzQxkR9eQNOvGoRdKKt8Ug7bv0UGKuLyjUbSQs8Y4ElRShtNAyztDsPc+naAjonqVkSrB3OmPPIkuvTfZ2LZJFEwSrfIwK1ZIorQN45GKDW0rKw==;5:UCgE4BSZZSk3vMqs4/dLNw9IS30LSB7C9IQBAiFexTzm7Y0RDxNEwod1nEazM/Nka+GbpBSf95l1CbV38CPyAVKF6mkMZlL1duPjTaWUChRj9xKJQsuCVmj/KETNi8fpPZoUHlrFWr6pJ+75+R4pr68ye8TX9EqE1meCLIHj9P4=;7:F0HPnmNLgLnNtRowfl79u6CgqVBWQESgyn6+lcEUqW68+zJ5a9FTOPjofEzA43ohHq+y6stagbX1xZY9iMc2UTTj3Jvwszp4XmRV6XdmrVpX1bcQBdL9mVmrmapQkctzCw5I1HMk5s6DxPzlWCfRIA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2018 14:56:30.7708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36be6bde-9b24-498d-bb96-08d64a415cc7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding method pci_check_platform_service_irqs to check if platform
has registered method to proivde dedicated IRQ lines for PCIe services
like AER.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 include/linux/pci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 28e5e06b..4fd54c2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2307,6 +2307,24 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
 }
 
 /**
+ * pci_check_platform_service_irqs - check platform service irq's
+ * @pdev: PCI Express device to check
+ * @irqs: Array of irqs to populate
+ * @mask: Bitmask of capabilities
+ */
+static inline void pci_check_platform_service_irqs(struct pci_dev *dev,
+						   int *irqs, int mask)
+{
+	struct pci_host_bridge *bridge;
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
+		bridge = pci_find_host_bridge(dev->bus);
+		if (bridge && bridge->setup_platform_service_irq)
+			bridge->setup_platform_service_irq(bridge, irqs, mask);
+	}
+}
+
+/**
  * pci_is_thunderbolt_attached - whether device is on a Thunderbolt daisy chain
  * @pdev: PCI device to check
  *
-- 
2.7.4

