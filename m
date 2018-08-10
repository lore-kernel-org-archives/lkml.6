Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836C4C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A4D22414
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1RHVjlIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A4D22414
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeHJSPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:15:49 -0400
Received: from mail-sn1nam01on0055.outbound.protection.outlook.com ([104.47.32.55]:19140
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727539AbeHJSPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7tkekGIa17b1q0GEbZGGQoiXNe1EgzmuXzI5rXfVMA=;
 b=1RHVjlIVHlfX78WcIOQnGvAOJaAwYKvyNzGO/W1yKgO5j/h5hMlRCk/6EEoVO+884kmRlD6NbUn8yu2cu420Jeqq3fVJbzcHSO6ycqZ2vK/Qz5Gn/GGQno8lc9wgV0XcWWgCWyEe43hoXY6c5hDvkuQWV5lYaqZ2XzMo930/Dx0=
Received: from BL0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:207:3c::23)
 by BYAPR02MB4456.namprd02.prod.outlook.com (2603:10b6:a03:57::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 10 Aug
 2018 15:45:18 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BL0PR02CA0010.outlook.office365.com
 (2603:10b6:207:3c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.23 via Frontend
 Transport; Fri, 10 Aug 2018 15:45:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Fri, 10 Aug 2018 15:45:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fo9bI-0004wH-3t; Fri, 10 Aug 2018 08:45:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fo9bC-0006uk-WE; Fri, 10 Aug 2018 08:45:11 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7AFj4lF025241;
        Fri, 10 Aug 2018 08:45:04 -0700
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fo9b5-0006kA-Jw; Fri, 10 Aug 2018 08:45:04 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 3/4] PCI/portdrv: Check platform supported service IRQ's
Date:   Fri, 10 Aug 2018 21:09:39 +0530
Message-ID: <1533915580-31805-4-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(356003)(2906002)(2616005)(476003)(486006)(48376002)(4326008)(186003)(63266004)(77096007)(36386004)(26005)(76176011)(426003)(336012)(106466001)(6666003)(107886003)(126002)(11346002)(446003)(5660300001)(47776003)(8676002)(81166006)(81156014)(305945005)(51416003)(50466002)(7696005)(50226002)(316002)(8936002)(106002)(36756003)(54906003)(9786002)(110136005)(478600001)(16586007)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4456;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT064;1:BQkeLGrUnitluIFbh1tp58aA4haPQqd2X06CeMyzBSZbR1XZ1f/sdckCxVAdxUArKzfRH9jsebHkjWTjh4pu/SBBDU2lTJ4chnamE9QcXi/v0ZO5AS0JGjDypvFCWdx+
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 392f49fb-780c-4bd6-9c77-08d5fed845c2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4456;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;3:aGmVR4edfcgBo5YRDQlCikkl/v1BEGrkUcoxCOY99NQYJrqB7TeDSfsD5wtl2r8AQaZiayoqr1IbCzNkMBtdFG0zOOA0UqeBpNyIiV28Da0k7DTzjciD9v5W7xM2cm5euUlb+Vu8NRpCV8MOzTpnQwxy3e5KF3UoqGZNxa9rU7m3Y0AB/1Md0mpX88aQnS8VONOaxkBeslN5FZfeo6A231SK+T0dhL7mzFugYUGx1K1S1Ykbv78pqn42qvS5DlpKNlKmlORzr2v1PlMYYA4Y5AdWQdlWsM0ly2uNHmcqrQpgJkUcD39FTs+kUdhgDidVZL90vQTh2p2HPOp/0xZUteKjM2PiD+CG+SUxDBIcYBk=;25:r+PZr7KocN8ngVf7nJ63ZXx1uiSwWvxqZ9ZxnTBB+KAZZRR9GIXwgdE0WWX1SBnFnIZ6IeGI/zZa7xM34inbllmhg5mZB3DUUldgak0qKitL5OTJfweyOMPzsFCoQHYHWhsT6nGJ1VyUnFjfIxcZIv4ln+8cwAsJcBvH4UOFDLC7tovRIY1ylzg7Fd0jptMHll2KZOS9acTZOuR2bhviYUx46Vv/YzLoj0O2sIEATAtAOX3FXqKNaXjxL6B+IyYGv4KFYOc0sYE2aDwvaggRPnC05oyL2sgzaq01W+2/dEjjsgce1S7KmynS2lwyav/EqzIQOt6gMHaBuOVBkWyy4A==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4456:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;31:TYu7X6PEQLdDKpe3tyC4+rDgCUzNXSGBgqVsYdh9gLDbuPM6E3MI6wQBJIA7kkHQ0UNpYk0zktPUVGtNjrKuhCGlT00vuaRhRWzYk5KwB1iy55oFDD+AbsdIvpUiomJi42UhkcTTfLyZgc/37RuTdxsy2em/hGO+nRk4lRmmbW2k9ONwjViLLcxy6x+VqcWygA+RJcP8Q8CpimDH2DM/e8HCLIt9KvygdPc+EfiPeeg=;20:JSCi5cIROIa39VJgteaXD6WFvMQKDXWS5UCCnHXGuRKn1OZzBp6FvD47XmHv4dwvmo77TQ7NZndTHjNC5VzZvI+kxUlyvpgWj3noMkd+B1mG7QPbJtH0vZFoNQZZSwfKYQ4bDKIHeG3tQujkFSNj0sSB9ynXJ9Go4mKgywKDXgmiueNxb4MseL8Ul6vGZnTB1oRWkYh7Sph6DZE8bhkujsW47hVl2llvv7HSby/EEcAwmFMFLL4Rfm1QRo9MimP/cTqP5HCi/VDp6W9TdIeHQvPMGitEP6OD9BPDws45ECiMkwbSvLHZfTWhJfibJZNFXSKrlB/ZezyTZdUzcXT+u1tPrvx+4cYvAewGorHyDQ1qBqg0En98wgojyUU8kacqtHm1wp7yhKwaEDdL8vrrqwcbiNwdsXdcEYoiJvPKGLv5wdIYoHPxqor89y+LM39/kGMXhC+TOAmoVmeZvSod1Pz5gWRV4RQJzqI11fEv1/IF2VAsUFVg78P9Foy7s9aL
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4456A77F63A4F8DCBF7AB8CDA5240@BYAPR02MB4456.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4456;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4456;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;4:FatQXnkgkDfXtMa60f2Eju7dWPddBGh+FmOw1w4SV8lGrX6Qix9fO1BnxRv52MFaR3vdRBn4SQdA+lcPAseLEb5HNqfTO8Ys88LDBNsiod8ckm4MFP0n/RVTZku1yK3un3oeo20G577IeIcreMAukUO63963rVWnTbibwz89oWqGZn8EgwXZZi9vEbuANvcoOl+Fa/Rj19Kt/5IiHUGVMQKxSZF3lnqsRvjfNDzjLEAOI6eZBU/d+KcV0zBYMIKjxetQOWSKwGToPbim1LZuHVzL0ZZWHfEwWPp4T5ZhtnmxPb53K1uLyMzR8zj8Vu3T
X-Forefront-PRVS: 07607ED19A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4456;23:PjXmMaFIjXC/q5Gf9ldz4xYRCOUM4ltTZYSGOmKEJ?=
 =?us-ascii?Q?uLwZ859evdS2NNUoXn5KuoeaaFvYyX0TCNUSa3MYDag/7f0hK8+VTrAzLDkU?=
 =?us-ascii?Q?8YOXW6FDwuqGuGWclMI7YABFGZHNASCNOQx2H8rbTBiRfX2y2oKFjyZN83/Z?=
 =?us-ascii?Q?1OW8xDL0vQIcHxISVaLFsgYCAFvoTKkBA0sb9KjtWpHU/BJaMdE/LdAWt2/+?=
 =?us-ascii?Q?ssdgKrM4K3pFl5dOKAH2Oc7JqVJScRMqRWjTbBs9QHjE5dJ8oE8W/psZgyvB?=
 =?us-ascii?Q?Jdb/y75ppUht7rgmhqCZGbFm48mYB2bqu8fp+3OnlocZH+tdK8skzu5+Gl1L?=
 =?us-ascii?Q?CkXn4bDwjUEZWEy8MIClWHjEAffvSQWToYmW5A09R2lxC/ZCsbJNCU1Hj4NE?=
 =?us-ascii?Q?8axonBx4Sm1Dyc/UodGaOgoELGILrOech92DaHnNlux/FDf+NCPKlK1+CHNx?=
 =?us-ascii?Q?TOGRfQnG7vNeqp15wVWBgOWAyYa6eH51ql5T5fjVEbX+a4XJNosC6msjeamE?=
 =?us-ascii?Q?UE9Soz8myuYT4+oWQlnF3+4KpCn2jiaKzJBUkf6i6N9OekieAzF987Vx4DGa?=
 =?us-ascii?Q?XhnJn4oKDpO9cTBYKZJwO6bmFrO6LtbI92v4/ZYGBo3Qnk3VOZ19w1TpLRXx?=
 =?us-ascii?Q?STqFGyoQDJ+t4TzoHp+EYoD0QrKOMu1q/qgdGY1gkjUpu5ZtGif0jAHzP8JD?=
 =?us-ascii?Q?zvQU4N7KsjQknbzCXrh1TQQrln1iWvjpjxPd7lX3q7M2IDDRDLvmeqwrT7jG?=
 =?us-ascii?Q?VpMN77yieNf8Fn5KAzvPnQWjHH3DBe07tz3X6VWe9rc6fb9aferVI2yJEy8z?=
 =?us-ascii?Q?xbJbm4rV5HhkJKG96SIbPT5TDimyt8VWFNs6CCMBPJq8MPpMyo62hWSCeL+m?=
 =?us-ascii?Q?0x3qew1iLFqHKXNyxcmSJVncHqEG84okG4UbYKq+dfjpLRVCRWncOIMjFgos?=
 =?us-ascii?Q?iodE9upvk3rOFgUcvxX6eyZZM8Vaol/Bw1EOuzcOJ4mYyOUzKcq94Fzpss9p?=
 =?us-ascii?Q?eZRAJcANDwDfHi73qAOJbwfn30qxkH5H90O2/krboUXezJF1YFN8f05L0INU?=
 =?us-ascii?Q?4MCZpwYVXvl2gY9OlFA2WgytMrfUoRNl7+nMgJxvuiyO3gUeA=3D=3D?=
X-Microsoft-Antispam-Message-Info: DtjrdhXfJ45QW6j3xnfKp6Y1T0ztmKw/6H9dfecy9UYmGXY3W1LJuqyk/if7hn3SNSUNq1FUDH3HuHyhxc1PiUhmfL79AlbfCZe5ZDNjISfgoapt7Cu5uQS0lDvB6dtmFS610mJpVKXGw4dEH+oMd9YI5samt9t+UqC6Hokm2rfBP05vi3XazSxQpOEQs0bcqNIjnkRgE83/B64Cuek3iQqymWe2y8YAr9HmjMARGJ2qfZyFcmEwFHYtG5v/zV9CjXicoa0yEllspdsLZ3dWrTL8B/6yX4/Fklby0mIrNaWrapekZ6Row6fAyLp/dvLVVn3w9RwqgEy/fI3O2ZvlDFDhWSu1nM0avzLlWbeCVLo=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;6:gVlx5u5kT9J3lX7JPXyeVQQbOshukkF6W4in0TbHsOf1cTu33iJ0yXAR4hPt8EMsaujPrShUlzxpmuTkypYfJbdQGeo2aFPCFWNpvMPSotNFZubQVM4alPakJWEWipzc35Hu/OeGPI9OakLOOGu5Txqs6Wb5p0zGLciHLSgqA/53pNC5BenZ9v72QgsAvIWmfdosILDXAB7H3sn0u4r4mxm/Ggj7DVMdlWCrtUjeqTewbG11To0njtiiyyXFFU1afjIabucUT88475+4fX7TgiButpwrFKVyAlJz0lSgvBZNkPlJ7nGuml7WjpS2drMDBgJjv77gnVTKG7l43oyVfgj283eadjO2RZJJ915WGZpdcqWvBkrfXazLF1WZ9KPR/LrilgM/CLH4Ia5gna1V5z7FPGoOkNxBxlhjJs8G+TxGucnYcxDUzSMXIMfQSfGL1Bu2rqjNrwYTiefzu4ktew==;5:GCzvIbwJznjXTU2q7DxEZwhrgN+j83Hw1Hkz8DwGwbFjWJ+Sb9j8Z1kdUfasSF1GnC/Z90FkJu/DubgndHItUCaTaAyCls7Dz3kZxjrnWKPivPwnrKaUlaVQQwOtEMw83nfv4AZKgXapUuLQyqa+W9X6b6Cqh+Y2m1DCxgSOpzw=;7:sooqOuPLyCXJ5SFg/XNgFqHmFdfrXW/5kE4Zsm/MQVkh6W8U4sBrTcYhkhEUCB4MdJh0Esqt5Ml5oTbPFPp1Qh4VDS1Id1IH7I4tS3a8ITt16o+Umd4JUvp99GrNx5ovoqVNHQGhpLSuxFaIaE0gK15I+bSGTg8qHtoVAYnk0SpbLmxskDl5QVl5SJ4mIOZh6i6PCao9WaHCTu0oBRigXo8UZwVqSW983PWwHkDENByGT8Xni8o3pzvO57XgHrNo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 15:45:16.8003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 392f49fb-780c-4bd6-9c77-08d5fed845c2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4456
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platforms may have dedicated IRQ lines for PCIe services like
AER/PME etc., check for such IRQ lines.
Check mask and fill legacy irq line for services other than
platform supported service IRQ number.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/pcie/portdrv_core.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e0261ad..a7d024c 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -166,6 +166,19 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 		irqs[i] = -1;
 
 	/*
+	 * Some platforms have dedicated interrupt line from root complex to
+	 * interrupt controller for PCIe services like AER/PME etc., check
+	 * if platform registered with any such IRQ.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
+		int plat_mask;
+
+		plat_mask = pci_check_platform_service_irqs(dev, irqs, mask);
+		if (plat_mask > 0)
+			mask = mask & plat_mask;
+	}
+
+	/*
 	 * If we support PME but can't use MSI/MSI-X for it, we have to
 	 * fall back to INTx or other interrupts, e.g., a system shared
 	 * interrupt.
@@ -183,8 +196,10 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	if (ret < 0)
 		return -ENODEV;
 
-	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
-		irqs[i] = pci_irq_vector(dev, 0);
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
+		if (mask & (1 << i))
+			irqs[i] = pci_irq_vector(dev, 0);
+	}
 
 	return 0;
 }
-- 
1.7.1

