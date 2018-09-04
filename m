Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10956C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F57220867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hJrqzQit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F57220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeIDOR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:17:28 -0400
Received: from mail-eopbgr720071.outbound.protection.outlook.com ([40.107.72.71]:36032
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbeIDOR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Yf1c+vouwmerOljVfaOdP9r9MiY0raNlrtpOIKxVWc=;
 b=hJrqzQitEZJH6PdBOKSzTKqK5AjrgD6ZhNFqVTvu140i36TljgXTWUACbroNFh+HJxsOirUEi8vi2digS68QPGQVGM9TJdpqheyc0V0ce0A5fIbUTsWP/Z1lPciApLrrUQ0R5LNVm5V8RkPPL4n5+8mM/Z5P5JlsPrzL1BJ2oMA=
Received: from MWHPR0201CA0024.namprd02.prod.outlook.com
 (2603:10b6:301:74::37) by BN6PR02MB2675.namprd02.prod.outlook.com
 (2603:10b6:404:fa::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Tue, 4 Sep
 2018 09:52:58 +0000
Received: from CY1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by MWHPR0201CA0024.outlook.office365.com
 (2603:10b6:301:74::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.14 via Frontend
 Transport; Tue, 4 Sep 2018 09:52:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT059.mail.protection.outlook.com (10.152.74.211) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Tue, 4 Sep 2018 09:52:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx813-0000Sb-Ej; Tue, 04 Sep 2018 02:52:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx80y-0004vm-B7; Tue, 04 Sep 2018 02:52:52 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w849qj12018790;
        Tue, 4 Sep 2018 02:52:46 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx80r-0004tv-Bh; Tue, 04 Sep 2018 02:52:45 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <srinivas.kandagatla@linaro.org>,
        <nava.manne@xilinx.com>, <rajanv@xilinx.com>, <jollys@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 1/3] fairmware: xilinx: Add  zynqmp_pm_get_chipid() API
Date:   Tue, 4 Sep 2018 15:22:32 +0530
Message-ID: <1536054754-3119-2-git-send-email-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536054754-3119-1-git-send-email-nava.manne@xilinx.com>
References: <1536054754-3119-1-git-send-email-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(2980300002)(438002)(189003)(199004)(486006)(476003)(63266004)(305945005)(8936002)(336012)(14444005)(48376002)(50226002)(81166006)(81156014)(50466002)(11346002)(2201001)(446003)(356003)(426003)(2616005)(106466001)(126002)(76176011)(2906002)(106002)(6666003)(7696005)(36386004)(51416003)(217873002)(77096007)(47776003)(5660300001)(36756003)(9786002)(316002)(186003)(8676002)(26005)(110136005)(16586007)(478600001)(921003)(107986001)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2675;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT059;1:erebQ7iTKXxBN6nTt7NL37hWtVuSuiQbThw3mk0Wba6LG05pG1lxcXqxO6onVS2Kjs/Y3rLrXtLfZIe29XI8R4bsuDAZpnqEOhZWtWtNcEEBsLHvbIgGhHwylmRHzkRW
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77b47596-02a1-476d-74df-08d6124c31c8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN6PR02MB2675;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2675;3:43rh+jJMfH8qi865KFkxY0SsBEBlORbWL4iseIGLFKJaIeRLSRXR12A7dhF5/0p11ah6iiXCQ4cy7y27jFSUCrpQ/75+3yRMyuZPTJgM3XxbPJi0pWx3lM56XSh9zYYt2JmfiNOsd5S4596KrtPvpwtHnESOfBOrOrvemPaSIwKaQRcFSTyYSgVzWRMKTWBCpUa0ZL3CK5+JFtDawZe7KAbXJz55m5UHf+LuZ5LJfMrSnxJ2AQo4OpUU+mA/2DYTckI0Y9dSBNRpSsEvnOqTNRb2Av0zr7JzVpkZH+S7T07TGl0GpFvxfWoPhTde8x7utz7O5NzOytkh3KGvsbEp3Ny1nFKnHLBP5/cRLPtfyE0=;25:m4FldkDXIJycHKTIcopDDBDpoeOGqe2hqQAhMOaC3NWAbZ3Ud0MzM55FpJ4TO327NFSvgubIOMn3TCPj1bN9V4i8PgsaH8BGNADNZo37GylIfpeMLkOyXoDpvLk8IDU5g8pGM0op9MuzcSSwMU38yTki3JQQI3Y6n3sK+Eahb35UfpJmYKy3DqccKT59G7l1N7fK0P8U7Upme5pM6YECDF+nkh7VQ5+1rdtz7nGRGORrt3Hu+9LP7v7P0HdfUL1QACgafga1+h6kekqK5b9Ni0MbDiBDU6CHAbe0DvCO9Q031AwhBX3A/kvdEMezzUjlipfmDF80qp14tolBiPJPPw==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2675:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2675;31:mcgT/jgvcnVbt4p+lU7nRPLUeyXGMn+oxLIkDrZBIrV6QHRpw8CGl746YBcJzqaOn4Xz3W6P339HUOl86Iw/fjO/qDbeH/5yNF10DuG+mBJePlUFviGrwnls6GhFm4+JMPOElh1qgkrKq6zQ/IR2QlOBhGIhH6jDWAHjfioJBKAps6N7kXcXlWMdOhVZ3SfA4OK304WH4apNeKFve/3RTE1uej+2XUuLXcaQMOonFis=;20:FgbuRzrt/KhPRWYgUFInVG4WmSXrlkklNUvV6Wr7YrPXgXRicVNRpf8y0yqqvJ4S4JsNbIeateDqxEfD4Edubz17tVgfAdGTsWgGPHQ0qTv3Yusn6CzU7g1a6okfRvndxdl6De8PfNM2X9QwwW6GS0Ut0zcheobfhMidAXfuKgqCLKyqrPg8c6v1M/aPK0maNCgHgof75waenKhZgQ+lkZOebuO4LVWqrF/HQbLs3VGG74qOIRWT+xV0GxhMruAEe1BNsZEZlP8V5AdLk7AstxQtcy/CdLwMBt8ft+RjTDyRSmd/uJrC2CN2cvcAINMUbi+lT0QOpg5QtEIYaM0/fXQN00Vjg599+vp5EqaogYFj48M7TzBbnUhoxrVv8YjeRyEocpowiXG7ur4EuLUD80uqN87lEn7sYaHcDqUrYyKseJznz8Zuq2GABr7NBZVeDGxwEYoyJ7a1uCHJ49B90lvZv/O2aMA3MmO7ecB4Mk6cvoD87kFCYAe4Bu0PV5ys
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB2675C3CFD2A2A3B28B672466C2030@BN6PR02MB2675.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:BN6PR02MB2675;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2675;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2675;4:8dW/MOIVueIuvDJGEJOzkjOx3GdI+6zpYRSZ/CY7AVt/EN1DoRP9jzaYqp/5rvb95xsaTuzCi1KeNm1If7VGhp76crgCpz9XVKbkquLmpVCP/4iGv3pTAw0wuawGL6UVV5N/tzjlOFWG4y0WYxWd+MjU0P5yrL1Y59NksswoikzMixE/HdM6I/ivz4VVLz0JGkIEhDD8DQcO7It9ltfns4p9E8B+eTthUszeaR3XXbC8xMs4i4xwi7qJ7VSh+jMnDelCxhJ7jNg1iQYd7y5xWJMRHL4cKsQ1rDiHajoOQCC8+W9MmGp5UAb0ZEIv3o6I
X-Forefront-PRVS: 0785459C39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2675;23:8ovM7+A/8r3rlWUpvbMuADahJTS+2LSZ8JJz6WIAY?=
 =?us-ascii?Q?/wNWXdzQdL5VypDlFvDCfZusV8uI3PpkDLZM/JVwo+oZBQnDlcraUkQZjats?=
 =?us-ascii?Q?KL58uDUF83k5R/gPy2mAGZHE5jFQSJdEXkOXy0AUwwiSRhAUZ1IkYzqHfHcM?=
 =?us-ascii?Q?wr2TFr8Ycnx/FpwtIV9/soF/j/1JBgLj97iyujoXeDdtpf8gBJuZdj9yDwkh?=
 =?us-ascii?Q?LkXsJ59vYdbK40SjcuwWUKXzrGd5TW5k8gpKtSeeNpImczUoKAVQXAijQjeG?=
 =?us-ascii?Q?4YSpxXuMWNFgBaKjkvcCT0mVybUM7+yzdJsOB6uvr/vdl7ikAH8mZlJRyIzd?=
 =?us-ascii?Q?Jta9rHa7iuN+X3ThmN+pu1kp86d41MVC7hPeBYzRGtmvm/6c7uhmL0YferUh?=
 =?us-ascii?Q?1fYjLHYCERIijsRZGhPbrWIeaFJBbVrxTIWgV9/5rjE3kmwyRMSJ6ZzqQVUO?=
 =?us-ascii?Q?yMOo2FwHdGRgWvKUp4foNPgT8CSzSJpbHE29NcLPV+cI3LiVb1ZysiT/b9jn?=
 =?us-ascii?Q?X9esBsl31U+Sz+sRXIUG/3UggM1wi0wssPr9m0XTJp+JNvJUPLbv5MAKeK6o?=
 =?us-ascii?Q?gKp6si1a4zFQeg385vtU0EMlmbTz1nDea41JfncpwTGYy1c59WaRzocN/tGc?=
 =?us-ascii?Q?qOWGM2KIUKuH7GEZZz5yp6AU3wMcbKmdG985KGDErewfPRfRBUB27TZLii6o?=
 =?us-ascii?Q?1661NPdfQMp0wZi/X7hqoPhRerPu/sOi1cg81JQQEFqU4N0yjJgRTCb9JL4s?=
 =?us-ascii?Q?HPMnJuWyIuqdXsXgkq6LfvNMs2AUTcfu9do9IRsjZPANXjBrLmRKDC6v+avI?=
 =?us-ascii?Q?PM1hI8iXfoZdCV/1ZON0Wi8DEhTQh8dw+YRAps+/PQVTYKq5LJOqOBLN2DTl?=
 =?us-ascii?Q?+PNkgCMJqo5w0rR6sEYDT9N8624eaO4ugNVQynpkb1xsWeBDKgBOVuGYZtcb?=
 =?us-ascii?Q?68MP9rh7qwPP3FkWxyg8oVdbPG3vegxuVFXay/uAtJQjBNR+2p8VHrBXEFZy?=
 =?us-ascii?Q?5HbMp1+TR/88C8SDn/DjwZKbxUiSFgRJOKn0j5fzise9HVSGSAl1uUVG/uyt?=
 =?us-ascii?Q?XcRt2BiY2mc8maIOEOI/XKIgPyJ8Z33i/skaWC8UZFNtCveDGJEXA2V0xRys?=
 =?us-ascii?Q?F1d+PFBNehEjVh02mjvdFc0GfMPLSwlZFUEojs+xCqAnnvjx1Kea/d2uinqF?=
 =?us-ascii?Q?lpMstLfkjcvR30=3D?=
X-Microsoft-Antispam-Message-Info: zG0IEtfb0+awCeyENXRBItbhKkR4CenlwgQfZDEUIHE8LDAqaP6uT5ilY/yIJKWioJdyrR7oPFKbqT78UsodsIa9hz01KQHF/lnM8z10aIOSf1XUuBDgUKdOZapLRPXdsfOUI8r0lDDRRzz0wM7WNQxF3RcjcCi5LPeBfVqVawA/uJJJpdtGJ7AczV39egu1MbO8zCr+xGmF027bAARuHYbZEBflzuIo01FuQgNrFxsHERlf5xkiQqJoGgrrQU+YwApa2jZ3QM3doaycelowefyJ/iP62VuNvyubmxL7mItjrdIZcgVN25mx+eP51Qmbu27mzFPh5ymwmiK+MgQnoVPPiQMgavraCVxo8x/xHf8=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2675;6:pUQlj12jbRRZJTNVHig5tgt8+mhFn677htDsskyv+QemE/u52KcaTtdMAYxCgLgRSdOZja9fAV3xgSTpGaQQjUlPLfAnkJpXhfsaRV1Myr766MV3CmUCuzIolW/pliTXedihKWL7XFRbjucGPSSjxWapKj/9uMMqaL4wWtDKsLIREqA7uaiHoHnSVSQZJyudIrCEkueiZtKs1CURv3KcBwyPM5MF9pGV1u6RrdnI8B7CBp8NQakVMwyqupmoKC7vGQApPKC33wqaUREIm4DNNLTYLfBpDD33xqKjE+KNuI51raaZDoZDGGC921zYpEw2RZ4WnKBgSjnSOH6XRVr0ALiBxclS1dI/AFAHbLRLA8OG80WOmd1IcBYSfwQSE/1hIoK7CpwJ32qjdyMknmHbUwFqJCAbKQzUwidrapSLgqKrx5dwq75YsJZMij/CxcDhjOYx/x/JLFMb8PGKrqC8fA==;5:pL8VZABd1i9N127LxnDCdZ9OfLn0f3x+xbAuyRsGpnKYvkqC8yVq4QeKkcph4aSBDuM6YglzNxrJ9SJ5hVWW0aoA6l87tD+62uQDU7M60Q1XN3TfXgPb/+XmEvAP/b3yy2q5w/MQZXuJMnJsqojyJdVPpjyMoHDVQwd0n0bXbDE=;7:XnJg7Xsa4z9AV0RhFvZ5aoPbS1hwWmtp30ikzlNmkdFx9217d2KnnMjRlI9mcZQOB41QORm1L5nVptcblgp60UC5RLGukAEnGLpa53Xt+xo5TbuLJkBkvC/222cW/1sYIsl3InHwD6vGEWXThN6/BYg6ib6N5Vi3SKGTTLrte4evbhPg75QRO5qLOmfBzQD4PlNNLZcB/YuZ1SStGiHK36wvOV3OpIXNYRBOLNCg3c3dgx6VMUTHgwCsMLJ6Qgv7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 09:52:57.7627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b47596-02a1-476d-74df-08d6124c31c8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new API to provide access to the
hardware related data like soc revision, IDCODE... etc.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-New Patch.

 drivers/firmware/xilinx/zynqmp.c     | 24 ++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7ccedf0..7a33f93 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -447,8 +447,32 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
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
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
+	.get_chipid = zynqmp_pm_get_chipid,
 	.ioctl = zynqmp_pm_ioctl,
 	.query_data = zynqmp_pm_query_data,
 	.clock_enable = zynqmp_pm_clock_enable,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 58a7478..5a49d6f 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_GET_CHIPID = 22,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -90,6 +91,7 @@ struct zynqmp_pm_query_data {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*get_chipid)(u32 *idcode, u32 *version);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 	int (*clock_enable)(u32 clock_id);
-- 
2.7.4

