Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A88C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE9422408
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="M4232uix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE9422408
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeHJSPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:15:54 -0400
Received: from mail-eopbgr710081.outbound.protection.outlook.com ([40.107.71.81]:30597
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727381AbeHJSPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNum6DxRgPi/XX+vqssE1NGKMZ5L6M7AwuE1KSq7XPw=;
 b=M4232uix0wOS5M8/khL/rFbYviF/xmlqq3n6cLz5eh28puLAQ9eJyaPhj1ZCj/vjreBs78epz2W1ZDzFJEXAvWHagjjzWySscd6TDXbOLwZCdgNRCCr3Sv9BiOByQJTiXhby9CWP+WP2j84pVa3uPH7GHVrWR9ffRpkrHytcVLI=
Received: from BL0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:207:3c::32)
 by BL0PR02MB4321.namprd02.prod.outlook.com (2603:10b6:208:40::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.17; Fri, 10 Aug
 2018 15:45:08 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BL0PR02CA0019.outlook.office365.com
 (2603:10b6:207:3c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.20 via Frontend
 Transport; Fri, 10 Aug 2018 15:45:08 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Fri, 10 Aug 2018 15:45:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45986 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fo9b7-0000H8-Sx; Fri, 10 Aug 2018 08:45:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fo9b2-0006lu-P3; Fri, 10 Aug 2018 08:45:00 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7AFishJ007776;
        Fri, 10 Aug 2018 08:44:54 -0700
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fo9av-0006kA-UZ; Fri, 10 Aug 2018 08:44:54 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 0/4] Add support to register platform service IRQ
Date:   Fri, 10 Aug 2018 21:09:36 +0530
Message-ID: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(336012)(6346003)(8936002)(106466001)(50226002)(5660300001)(81166006)(9786002)(26005)(77096007)(2616005)(63266004)(8676002)(305945005)(6666003)(186003)(81156014)(48376002)(50466002)(476003)(126002)(486006)(356003)(478600001)(426003)(36756003)(16586007)(316002)(4326008)(2906002)(110136005)(54906003)(51416003)(106002)(36386004)(7696005)(47776003)(107886003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4321;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT064;1:beRqHYfVL8xfOqEDpKdh4cVdw/1s8gU3nQ5v0b56XIyOA+U2doRKZlH4EhTnZ5dPlVG4XPVtrXYeEPz4JmGXdI9f57W5z0UQ/c6lPxl5wEl2ueZ2HZ+Clczrm26iJhaV
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4577df80-1361-4692-ebe6-08d5fed83fa8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4321;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4321;3:yTUP5BwRlIsNxuyyUVQJkpbWX79mafXHelJDmqCYMwv66PUQEERiH9VW/woCFTAhvp+MhSilQp1YJhKXhaYlusknWWQ/lhc/eGXoIPSgNBvRb4cAKKbiJNAROpjS9AJlORWpT5pmVW/Wc+S2Sxgo7ylEppHcLC0t2JIG6072gmBSb7TUJI6QSgN1IN9+XRVqbY339Pia3zVgIqyuY7hDjzhtjM6rf/N9LIkwSCq2JYUyAY9zOPtsCg+FEA2IW2ZXGO6SUeedvfJnidrYzRJm0mRZVme+TBJZQSRiqqY5UwatV/Yb8sv4HjJj2MQDjK8sco4eufHm4Wbt/uYvO0Qed5SxNOMk3GCQh1p1IIOSxjI=;25:k0nd9eYAmVFUAEVWouOJahvythGk8OM4MC44tbUpjarwvphNzGRYVxYFvYlJkLEVY7brslGf4nfyw8EaYQ+7yLSyczdX/6Z060RqyEhO47KkgMMQRLpUl4GCAyMRs1ev8+PkGC6hzCALlTP2T+wSlRsiSRyinpJxuk9lEWnyPLzPpevxURcyZGh5EZay5K3EUo8WwK5woHTrKtlf0neq+1wkywMg0C/v8/ZbrPsOpu6Y83ohF866js1lVpHwJNomzmwqkJELM8cP4Gs2+H0XusJzdSZoiqUgg+x6deAo6KslS6UE33Iq1b06LGBpGIvxPmv7kTWf7+ejgyUft3XnAA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4321:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4321;31:29jy8y/7UUNtj6scoQ9woql+SyFFLl5uBJFqslpRMzYr/e5XWyEkWX925jvUfQL9vXQa4wXDYTR9WLUJMl+7UJxBNyJ8ukfe26i09aobIEB0xQLK1rmn4+scuEU+Ro9lEXsa5OkAyPn2piRGxorcK8DzWzI/QbmFqV42dO/m4v9CTzEgjJ7QFvKOY9YcG/cjyfJVYLD175+XW8nvJB62pBTVLDyWXjDibGPFYDwkvq8=;20:10PytHAPOMrRZsPzE7MMSWWSXYSjudJnybV2FvKwMSvV2q+N3nvNdscmGRlXIKJEsRBPGPVVwTY4hDxjbpGDmYCnKVma77A2khGrQBVNaaajqcaG6NPkj1cSF4No/sC19m+FPprDCQjsML7YzShQigZH1RBOSS5e2MzEObYUbULX53MXciOs3ou664BGA7S17JPjNF/OhhyL3/fsu7Wg8Gr69iw5s+qZ6v6Qn3vCdmzVISeIv0sIRqenIJG3MWnXc5vLVqleHsiE6MAB8nH1ULNf98l0trR9DS9yPmUr1iGle2zjOiFYu0eG42yqO3+8UTtuUSkhYVx5MH7WK9Cn7lM+A/YvLfGezRlOCTaTVnKCERjl2/Ecq5r5i1d91CMs4tPNN+v+5tlwKSZSlMDDM2aqRD5EurFrvmZvuQVKHaifDd1z3dtdyZTS4V5p2oR3rbJO+4p7CcAgZNJwwkEVaoEQRDzo3XAW9JsjoeZmVH6WVDxq/CjKZ6SU1U3d/6h1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4321EBD283E1BC0D59065F01A5240@BL0PR02MB4321.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4321;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4321;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4321;4:yz8Nf2xBrn1LJ3Ga66EpbyGRwyGIVgeeCDnhdt2UVDRdN1SgU1zjEhgDidMaLXMIJRscE2C8hJ1VH5EJ5Za1GAdOknWpprA8/24qcC8P7lMgPoszCrs2aXfRWu8jkCQAdzg8g1FqTXrbaA9X2XN5CvllrgPqtaibX60bJOO4bCc+BmAOi7sVMBAxEiqawCvnZsIUlDoAS1Fcvd9voWjYypyzaBKK2I1uyugDgMoRNCufN3NIHy+Gj/6Fel8pbu6WI1XyineRdqp3W4XAeloMmg==
X-Forefront-PRVS: 07607ED19A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4321;23:ZeMGJqYH4QousHsg3DAt6Bm7UG3CRpgu/riLB7yY2?=
 =?us-ascii?Q?enBHyfH06/Ti0NOnLpgEld5itcuWhkWDm7uSPanEIyWpKBo76qg8acwQ7Fok?=
 =?us-ascii?Q?ynBaYKOc8cCgdIdZcY1wI9xO16qBaRChlCGVWWGmYq+KRp1K/jW9/OdLxfY5?=
 =?us-ascii?Q?MqmO+V2Hxfn4JclDtylLkSVle2UuE/MwCz0jhEh1l+bkvykdcXuhhEi3cLhD?=
 =?us-ascii?Q?Za400+GKHVy/5D0TSYwzDPRm+BbSnIb4mqlfgjq75oWFNckxzdKIsIDmf+lL?=
 =?us-ascii?Q?ouNlVvzga97aFQL8FAzlu4yTYT3gI1nE2leemL9VfpAGz1AdyLewVIpiP3Gm?=
 =?us-ascii?Q?Qo70p8nejilpFxi+oZjk/bfq9uweENmsTTxifDpw+tZ6GPBO1Na9oMNZZsrZ?=
 =?us-ascii?Q?PKt30p+EwUGu+yAMDS/35NaSeMrueGR3W7s9RWfIywHwFnC22qqMmEqLMX0Q?=
 =?us-ascii?Q?EAhFVx26v3TI1Kc8EgbT27wQ/WDb890hUF0NuD4jAmEVCrr9Dm1KIK3MB/OA?=
 =?us-ascii?Q?7dZ/yec1K6+C1mLLEB5p/L/NOZzEm1RiC8ZlkfL5vK2U+urxivIOdDFnqNad?=
 =?us-ascii?Q?23i3CAjDMrNm7C6r2CnCWzI8OncKHWmLf7SVz1PBqqbiAKu5Tw//mnpV77lg?=
 =?us-ascii?Q?a0qqxNuHcRTqu20olHYZU/sJRKpnnrVN/nnFUZRJ3tGLwFAWOULLVY0SteRy?=
 =?us-ascii?Q?/Tx3+OOtfsWd5M3okiPA5iX9WMBt6VDm6YJw8wsJ17uGMHK/wPxFT5udvKz1?=
 =?us-ascii?Q?A2mF2xPNLN3O5JMEnP4LhkbGv+diL3xVvs3x1Er4OABGrb1ZZea0tuA7jhyC?=
 =?us-ascii?Q?3SRJi7/bpuq0wrTDRg3saVt8dYSOEyCg2h4aPh7znoCaXrvnhllPZY21GzG+?=
 =?us-ascii?Q?9ado7S6+2NqPyWhD94HqO92M4jHSwKyJqh7Q8x3pd224i9MiiDToj0fhl3wK?=
 =?us-ascii?Q?ZO3nNCVJXMyHqprFqCRYpMhP3M9oi3n+deF8U0tQOWG1Soo9xg4OwIYMkysc?=
 =?us-ascii?Q?KaLrLbtgJbPq+i7OXULnBTwHacI+IMlkKm+BjL6fRBEO8NUgcM4f9F2gKjb6?=
 =?us-ascii?Q?tXnkruQCxRKs9Qbiu2lGt4QiG0UOb+8NPw/MvCXFg7RfP3n4w=3D=3D?=
X-Microsoft-Antispam-Message-Info: F6mLLZNxdRSK3GyywhQuGixQFke8qIxRRm+90x1mPx5mbnH9k/v7XaRFA/99mRXsM2ZJv+1rzzE9QYbKN0QmtFPvCXcuP/q6vmql8H8yKJaQFWIIvpjXcLZryAEQqa+zEH8eVMf9i1/TkTBJYHKkRvZlKkNBptBio5hciUkn0tajZ5+B5Yd+fXskZ40wcyM1BcfGBX01z5G+90o6UXhvICuqrot6g9R5UFrypG1IY3V7qx02EgeHxEe+tV7L5RdyYlmFj7oLc8uHebw/x9t7huWxaj8ghDADLvKbFNlxMC6pcuyhfH/vNuXoenBSxZ1TBdEJ4fDJeYPKYYccjfLzL5++GaT8fXmvFAD1e0o7sTI=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4321;6:nb5AOs3cQb/UqbOUzRfCbeVb2WSuj9auxtQRHA63CYDE0ElZpPXXvhNRpqKcp4S2mDlI+U94sPlsbrnvCIhrBUW+pbcpvDiJIM3YbtomY7U5rUK6w1H6byjywV/OVe/O7DnpMGTrSJfl1KRQcTI63lC7/2X4+sHFFpfvdK2B5WwO7YYLXewWSKYUCYypDfadW+ous4Gsv8YGY7EUNmsx+XlJCUTesmLC8fDT1F+LiCU9NTKvcSiPDo9Y6Zrhy8AQeSwNuGB4LIpjtM1BKb2A0BjqpceutbTdJdlj0XSZ8IeEBtTrB6EhxYjkvfJRf3IzMad37VTndu/SXtNdKQAQPUvHG0aWFQ5LQ37I2dlCILYic1LBVstBGnbQKstENriMDv9SOA92WEv1D+FX4L9RriON2su3KyE3OHfQBU4POccDdByqbVnz6+IWVBtsxnx629GBh+7gP1TKop54Vnk8rA==;5:gVmbjJvWfECiuUp6g9eGHkGCr1a58iXai7ICdDWP0OK884TneMq5II43IDNzDV4FLwAv2jrTsPx8chvQzriqc6o0qpwprTu4PQo4rDwFlosSsTDuShc5ojVDTXtrZobSF9HqoGqPYX5ECMGopJz+zeIYYNq4SqAPnaBdBgwHSPU=;7:EykJLeA2mc5QSBLFURmhntY5tCiqnYgSHt1N26TchrwIqyJZMeQ6pS1pvr0jRQki8V29X6sD8Hm4KCma+uCzxi8A6vgeLaQseoQc8zBhJxE/1ilCWvaJLkJh95qcXkIZABqQKsp9KrMjJWBytrBzTUgiT9zQYqijExia6PsMd1pf3TkfjMYLZBx4oMECidST7O2TVO4K35sqRsDcoLZd2aNFxJjiZ5ecuKgcMWjoW9qBFI9xpaAIjqr0XKU7YEht
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 15:45:06.5656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4577df80-1361-4692-ebe6-08d5fed83fa8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4321
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms have dedicated IRQ lines for PCIe services like
AER/PME etc. The root complex on these platform will use these seperate
IRQ lines to report AER/PME etc., interrupts and will not generate
MSI/MSI-X/INTx interrupts for these services.
These patches will add new method for these kind of platforms
to register the platform IRQ number with respective PCIe services.

Bharat Kumar Gogada (4):
  PCI: Add setup_platform_service_irq hook to struct pci_host_bridge
  PCI: Add pci_check_platform_service_irqs
  PCI/portdrv: Check platform supported service IRQ's
  PCI: xilinx-nwl: Add method to setup_platform_service_irq hook

 drivers/pci/controller/pcie-xilinx-nwl.c |   16 ++++++++++++++++
 drivers/pci/pcie/portdrv_core.c          |   19 +++++++++++++++++--
 include/linux/pci.h                      |   25 +++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 2 deletions(-)

