Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06B1C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390CE214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bW6RGJME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390CE214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732899AbeHIR2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:28:47 -0400
Received: from mail-eopbgr730073.outbound.protection.outlook.com ([40.107.73.73]:18844
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732597AbeHIR2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fPXB5MUSZyK8RegFXg3Zcb+blcmzsfQDqznWaNxcNw=;
 b=bW6RGJMEXG+mes0D6tl29/gPv3o2SfWTUgaLv+TMQHuFgSORO619yAUl+jBjHD3CPyqz3AmLo8edBLSdh7ptm2lxzgDIRY9Z+JaIYBLZXxXKcEWSrLnE/mQw+Mci1SERwMkB/UGpdsohy3hkT7OM6o4GY/Qqh/TgR/Kq0qQuSJI=
Received: from MWHPR0201CA0082.namprd02.prod.outlook.com
 (2603:10b6:301:75::23) by BL0PR02MB4323.namprd02.prod.outlook.com
 (2603:10b6:208:40::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Thu, 9 Aug
 2018 15:03:25 +0000
Received: from BL2NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by MWHPR0201CA0082.outlook.office365.com
 (2603:10b6:301:75::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.20 via Frontend
 Transport; Thu, 9 Aug 2018 15:03:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT050.mail.protection.outlook.com (10.152.77.101) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Thu, 9 Aug 2018 15:03:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:35726 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fnmTC-0008EL-PN; Thu, 09 Aug 2018 08:03:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fnmT7-000164-L6; Thu, 09 Aug 2018 08:03:17 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w79F39mX024529;
        Thu, 9 Aug 2018 08:03:09 -0700
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fnmSz-00015H-8t; Thu, 09 Aug 2018 08:03:09 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v2] PCI/AER: Enable SERR# forwarding in non ACPI flow
Date:   Thu, 9 Aug 2018 20:27:37 +0530
Message-ID: <1533826657-24552-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(136003)(396003)(2980300002)(438002)(189003)(199004)(106466001)(63266004)(47776003)(316002)(6666003)(4326008)(9786002)(186003)(107886003)(7696005)(2616005)(476003)(336012)(575784001)(126002)(486006)(26005)(77096007)(426003)(51416003)(2906002)(50226002)(36756003)(478600001)(36386004)(106002)(8936002)(48376002)(5660300001)(16586007)(110136005)(54906003)(81166006)(8676002)(81156014)(50466002)(305945005)(356003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4323;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT050;1:oHWwbupgHokdTs060g9F6B1+8Bp42ikfTcDXfKVxFTHF7VqqjZZ8RVYDHjJbjQMl8VAPRA5nPHQSzLAyOGzkah+w7cKxzOje5GzgrIxlSX51lQI+U6dS5Dyl2c82dwVw
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc5e7b12-f456-458e-a090-08d5fe094172
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL0PR02MB4323;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;3:IXZzhJJcTpf+2ofgUN0Xsb/bOSgMmmN96mK48QO/uDMxUkmYchekTpJfzF7n0Xjf3kaJXcg6HXawJeFyu10hCsZ+u6s8dklGOVpoT5rAu6m2o5KHoiMlHKwL4LpydgKqnSH/DxmkzALTG+AusPZoePBNaIUintzhAD49vz5nERT3rD7uPkXLYEBqPWFy+09S338UfbrHjNNO+xMgkANH+DspnYvp5v+MLRfKs5PVtO/iwr+Ad73LSNkj6t3A8JKFwZOOl2ufkgB4YmQ63cp+tCG4QNMqKQBKsoOpYZF7xoMp2Vnsrr5smDjs03G7QsC86ZrbIRVsYlj+Ula6WQTttUNZGS6nQ/4wYGfGv2unPRE=;25:83yDU5lmziT3ANBVjtdlhsUGlg1np5sPy3VBxJAyeXX8uxbQAPrx+2SHb4c7gavz84z1G0QmlJzC2hkqgb0kNxQG2ruut5O+grRFGneAs4PIe1hHBkR3KmyVdqLpM41LEfto/wdL/p60FG4JeVDy7I8UwvcBhbfbSHUpZLc91gn2nCCvx6Aye/9X8Q7pUfhkhoU7WqbBD9BMRZD8aiBMKqfcXXByg1Gw9zQv9qzsce8GI5Zu1OUFbxi2l9WA7GTA9ncEWrVB2GrTlv0AJt3mOBypNRfDd3jSwZgG78Ph4yb9Xf1vjVoK+/kQZ1iu3i3NZCvj2ycfA/16MLnyDYK3zg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4323:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;31:IUZ2VKWqIe7BlML7H/FGp3+5ncv5xnk4I6B5C3IK5DJpjiHKQcRNcUajeQxhD/9i/9JlDdvZ5PuwWjWko08783kYlg/axeO/HYA9bn66Wazgp2NnF97Y2hp/nzrrTmk4pPw/cla+HIic1jkUZiHszTlW5Z++ux3shqKcu3r7Ig7SC3JM3YTd7pp39reofagMECSzl0ACrYiI5g3apQ3M+5Eyduj8C8E4vhqXcGaMBBg=;20:dVMERBOoib3ndMQLC1Bjul01Lqx/TnJx7tl4fwdq/4Wiu2XeydP3uGIqVE0YYroYiW+aSzSBuJC2aCwRRdWmXG6CmrsB6Dj0I20DYLtrxrQ7qARDo04RlK0q5fO3iLk0gjTNeqtgoW1pINfky/mH7oqvsTVlnnFTsTE38vB1MdWWnfRhG9JX6n8bq4Ff8JJYERzZ6prVumvPpKbPeliW0wqFOMCCi6HJr9xtQn0AWPcYRtffrUbf6+Zggj12WM3tooWXVtdrHrb4uAesvX03gHNfwXZmgZBQYMUCUwhAdtYbfZz0aPcIF2LE/7hOVFJRXzicgSQRsbsRguw1pxS71/JnNs5FBOQfw4q6F5tSl49NngqQFUfhU7MWgxk31bG2RVJiKq+dyv47PlIcV0KWNKR+cwueG2Dd0yh1hPAOHoxxcXnS+4qUoQBvCXW92mWS0DxzsyDn9shQL60CSEFFS2tFl5TaDBy9T9bsdww3ZCEb4kXNsoqf4idQhMsTw/ii
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4323B212B79E308594588572A5250@BL0PR02MB4323.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4323;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4323;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;4:jBSW3m3MncE6G3O2tasTtgxeFzpmcUz2qwtyrjUEwq/FW7Qz6fDI4/wGP2CpqfEUo+awP4dkcQHXnL3cdswY+1992o+C34K1antzPJ7GYBR92iWUiDvf2lYeNtiWKKKVPd6oG1NBKj/ndep3cywj4p/omS4QUrPP+qgHwHbbzTkzD/V5EfvOkcNGMQKQAPGKAxdwnOdxhHGQz1Ov8+Oao+kZI/QoefU0sYbUd+45CYlLffITbcfmf196cycCV6O2+hbM0RYcbViJtAgmNNmDfKZUNq3e9zWM4DLFSCUp8KqapPNSSSHnJKkgSoiXjjSP
X-Forefront-PRVS: 0759F7A50A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4323;23:U3xwoIckq1VH8RHHHjGrkkqN7pmCKg2yeyhasCLCy?=
 =?us-ascii?Q?yYCGFH8QRcOhhCR/CeyjxbRBJ2dxaJ5lICdVVxSsDze8ki4f/2B9u9OerHci?=
 =?us-ascii?Q?eAeP6tvhS2qnutQupSZ9vGasBihzlreqj1CJJhWZkUaHmpAlesxJwv+7BCzP?=
 =?us-ascii?Q?7Cs7+BK2gGJbtZA3/bd3ZtZNqIf5iNTARyKZF3pnH+UYc1uvNcYy3RJkZ7O3?=
 =?us-ascii?Q?W4lXcQ+c8AakmvGCE58GFiKDayWIOzU7F1iJSZtbe8rikR3eTHSEEqN1WmN9?=
 =?us-ascii?Q?n1A2gAVqqGBn2paRCqk0kYJDiVYXMrbg2zuEUKCTCznT4M3e1vsK/7GmrSer?=
 =?us-ascii?Q?0SlPa+JdVIMq8jB9j6g30lbB2H2eqHtP3GaxNpDy9DEz3bWAnTlZcG623WBp?=
 =?us-ascii?Q?6w8mvw917ybdEKD0Lc8kW3j8nSGSJ8PzfuzNRH0X1nW5jTBhNsXppCCaesRg?=
 =?us-ascii?Q?a41l2cPAh1Atu5z2j2VqcENd8bGk0oOn3iMs/ICkLcvtcKspP3/O8wHCZTvd?=
 =?us-ascii?Q?zH66LFbP9TXGYbOchlvuuhw31HZH6Er5h+pRCmgEa2ixxN3LUEVvwcyNQ600?=
 =?us-ascii?Q?FDCnliMfJ0IrinstY6KqAiD+DzXC7Cfsbe/lEGaXqvLW8YSaWnSsoGVhH3+f?=
 =?us-ascii?Q?Dg/Nc+mZKVk+ZQ47Ti0+CuYWPxUPW2PY9rEszYX33YjVV0NuRUxSjeU2mbwe?=
 =?us-ascii?Q?Gvg7hVRMiKlJuj0FePQmvWx3rcuvDwC1sKAWpDJZ0WTCpFTsDthmddsXu0jN?=
 =?us-ascii?Q?D/w3asDX70cexWoBIEYXmHS7GktmamTiTCoiGU6gwui4FXAJNVBv3WJZF8BF?=
 =?us-ascii?Q?ZP8/kxPbcaxh6IE4OmaWWEawtGfw8rJXyk46A22L1NfgL1tBen3FWGxJMxtJ?=
 =?us-ascii?Q?zOqGdgZMn10nJfetP9eA1Chy7xeITMVjIZznVwEtLQWjw+i6TMc4wrLJcmcw?=
 =?us-ascii?Q?OXqPapBzRehyhwUA8XLNleUoiLoWkRPRSgWAM313w+v6e8zUGllJ3laSoh+4?=
 =?us-ascii?Q?zHv4nVRAT9jrp0H1oXKoVtuuQ9x1I6l/VtWn8cMQoH9yI62KMDBMCQtzDfTb?=
 =?us-ascii?Q?9oUnIps52FoDo9XF+kQ4vJ0VAzdlNCRVZEa1VATVjUooLpCBg=3D=3D?=
X-Microsoft-Antispam-Message-Info: Y/yUjsPJuUt517DAIiRRyXnd9R4BF0mK0YBjUyFY21SM+jyNtaFj4J7LIdn36zMapnSg0DRSM9efIO5dWRiuna2VjjqBo/vU6i+YPnuMsU0dEnDoko/R3k5c32l+5UsRJH7phizcLbqdMzJiINfdmx4XslVZwMNDFYLBZvntA+W7O2yBWY8nrP1StqrniMT8UemBLLkIMLIoRw3Wlfi1C7XV03wbPIQZnvLL176+33XZJZ2Rw2PqsVZPby7POtodjuIPeJXXnDWo222TE0Cn/Jhj39RmOUSZRbEmZnW4Fio9knZG4O12UMCkqwopkVUgEPYtTahJEUn7CQ6Jst17tka1KCmD/F2nI6hXMH4RMXU=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;6:J6/bXaISTXZAmxwveFVc3+YEhfoNRuHnIgULiWpLnO/GUB7Idtfka38QiQePsIC1QtjMtW4qPod/u7xR9RcOkIGMDj8weM75zpJiifDnKU8p/Xfq9Giw6dZhHKstAFVNOAGhuYHmp7fUax4sWVIJmYbv59dwuatRadqxEU5avyBzBnSCkBfQ4IBPEmi7rw//6ktjDxGrRvdu6vh9I8iH545LlqxHvAX8QOLeMUi+20eeiFcsdmelSxdkd6+LlNx188IsFZwDtYgVsTIl6+YYpqmTOO3tJhU1+2KUE919GQKNZeZURUq9TZ9cdl9ZNloAX+LVzdAqpaZbYTSqtSx5TKgwZ2SDioXv0tW7Ij+uoWQrHo7+GUjRkDMuYOS3e/cF5D1kOYbyXjgMxLI6JpkUM5XToi5PTU26yYJTKrnvmRYW5nAhDtAn14OAy1YEDfZSCEay7dqUqe4TYrjDEK2Gyg==;5:jNevm4lMk4lGpnW+BxTiAM8OBJJm45fqVMOmPOLPy3CrfZFy+1UEOgazxzXh1lfbLVa9WFaYJuMKplxq7b+davJ/99KhqGCkRaqJxf4xub8tGolpqPYerAI8QpyhYlFOA9rhAKDPne/AhA1sb7CcOUi8zy7ld8JmqrLW4N81gUg=;7:UmLw2UMppuEVzaDfk+gEY6OutZ1T+NDZoZG0Vfkq5BrGbrIwV12iZafoP7TyNKMA1Q6KRJT4vgwDH/T9bcaBrvjLZf6lvJLP2Sdfed2ecXDC0VcwOxoOwoMN4JrFX0x6R8IeKNap9ceEzBqrjJbOoFt1QzBcs2s9PTPcLHN0+f6B/esn7J0eXcpBorZ1Xtj+MqLBU0vzBYOaOjWFnOlC0bhh51fMivr+/3ncQMC04BM4Y9aJur+2VejUcM372d6l
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 15:03:23.6797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5e7b12-f456-458e-a090-08d5fe094172
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Figure 6-3 in PCIe r4.0, sec 6.2.6, ERR_ messages
will be forwarded from the secondary interface to the primary interface,
if the SERR# Enable bit in the Bridge Control register is set.
Currently PCI_BRIDGE_CTL_SERR is being enabled only in
ACPI flow.
This patch enables PCI_BRIDGE_CTL_SERR for Type-1 PCI device.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/pcie/aer.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e8838..4fb0d24 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -343,6 +343,20 @@ int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 	if (!dev->aer_cap)
 		return -EIO;
 
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		u16 control;
+
+		/*
+		 * A Type-1 PCI bridge will not forward ERR_ messages coming
+		 * from an endpoint if SERR# forwarding is not enabled.
+		 */
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
+		if (!(control & PCI_BRIDGE_CTL_SERR)) {
+			control |= PCI_BRIDGE_CTL_SERR;
+			pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
+		}
+	}
+
 	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
 }
 EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
@@ -352,6 +366,15 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		u16 control;
+
+		/* Clear SERR Forwarding */
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &control);
+		control &= ~PCI_BRIDGE_CTL_SERR;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, control);
+	}
+
 	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
 					  PCI_EXP_AER_FLAGS);
 }
-- 
1.7.1

