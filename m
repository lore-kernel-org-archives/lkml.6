Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CD5C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD3B2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD3B2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeJPSKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:10:08 -0400
Received: from mail-cys01nam02on0067.outbound.protection.outlook.com ([104.47.37.67]:1376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727071AbeJPSKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:10:07 -0400
Received: from MWHPR02CA0010.namprd02.prod.outlook.com (2603:10b6:300:4b::20)
 by BYAPR02MB4678.namprd02.prod.outlook.com (2603:10b6:a03:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Tue, 16 Oct
 2018 10:20:20 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by MWHPR02CA0010.outlook.office365.com
 (2603:10b6:300:4b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.24 via Frontend
 Transport; Tue, 16 Oct 2018 10:20:20 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Tue, 16 Oct 2018 10:20:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQl-0007Kk-Me; Tue, 16 Oct 2018 03:18:27 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQg-0002Bz-Ds; Tue, 16 Oct 2018 03:18:22 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9GAILB7005739;
        Tue, 16 Oct 2018 03:18:21 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQf-00028h-9j; Tue, 16 Oct 2018 03:18:21 -0700
From:   <shubhrajyoti.datta@gmail.com>
To:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <jacmet@sunsite.dk>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [LINUX PATCHv3 3/9] serial-uartlite: Do not use static struct uart_driver out of probe()
Date:   Tue, 16 Oct 2018 15:48:02 +0530
Message-ID: <1539685088-13465-4-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--6.018-7.0-31-1
X-imss-scan-details: No--6.018-7.0-31-1;No--6.018-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131841588197546808;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(199004)(189003)(16586007)(83322999)(336012)(6666004)(498600001)(305945005)(51416003)(76176011)(110136005)(450100002)(2906002)(54906003)(4326008)(446003)(76482006)(2876002)(55446002)(86362001)(11346002)(486006)(126002)(77096007)(73392003)(476003)(2616005)(426003)(73972006)(26005)(356004)(48376002)(61266001)(50226002)(81166006)(87572001)(106466001)(81156014)(63266004)(8676002)(14444005)(50466002)(8936002)(47776003)(36756003)(105596002)(5660300001)(9786002)(316002)(86152003)(107886003)(82202002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4678;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT064;1:BUog6i+3mSuWoj8wn7mce7ns7sUGv4xiMR3dZslMKynlaCV2MdbIv2OxRQVtGLamURFSSMx4ZsRaNrdSwEWkgD86XY/mTxjmxiM2QhGQArP8Prd9pStc83a2pPwLmfGr
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e577018-e6c9-42c4-d1b0-08d63350f990
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(5600074)(711020)(2017052603328);SRVR:BYAPR02MB4678;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4678;3:8Mgq9IsmKeQYrBmsQdpt3p+1NZzQL0Agzf6ZoArz3XUXQNfGaO5fRxtLHGdAUo2HR1r/2R/3Bq4WzBAHROQHB2mknigdpkOlMQCA2QlgGrb2846jbUv7fJ2HGMq5cVBwfzA24g3uG+wlT4H7/PFNzenKvoX6bGvGkxeRFdkpRlNuR8dUY5zSKGzeY8rpaxE3NrbrxTGkpxfoOtFqkrzAMPyYXw8E3vBFYSFbmWWOY2+EdI3NO32jvoJ+SMnTdqZ5z8PJgoVPUjWNKAqQl5JiElr4SE+WI0KPkWxi3reIePv765sTK37PqeGky6lFK3k4Px82DdvyqNFHI4Wf7bpx9KMR3OCWCDo+JWfBM9jiqPU=;25:Whu7IBYqc++T6txQ7flCkots7m5jbdoXiDgmitbsibSz57+cbEbNbyR56dNOFzjesQVzxiSWha90CLG6s98RXUQj1KpHRwie1awk6ZGSQxP2v652nJUj2AF0SgLtQrTXo8aaHGYgFx1kKFsFpOUMhbRQMZaT7YvzfHj0QRcl31ko2ikV0OujKuOgM6lssl/FJG7KALlkfpmCYf5+DH72lnthCPzzxfbynNzEyGjjQCkXzyCYuoXgBHFVhWWybFuZObvgz/TGhkZ/l4JogCK8hoNUVwfThisAbqj1NFDg0gPK4zbJLJ4I/sCsanTQ1V6fXy+EZzZulrrMPkLtF94Rch5GS5JFkBJIqazcb9pjUqE=
X-MS-TrafficTypeDiagnostic: BYAPR02MB4678:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4678;31:64XEwFDHhL3IqGOnK7VjxpeZIlj4dMCz1RGDZX6qQqF5NML9e9HdgSziqcl2au6bT/Rc4jThP90IyWlL1jQCJUb+bS1yAb/go456iUdHqD1wdAg16zYp08PKFmRrP/w2q9Bd58lZ0e8eSSCVBA8p+NLX+1y2rXTcYM19swWt9m58XTMpkPl1Q2YZ2Da2piEr79DAnizfVdRKTZFjpU4AMuAlojPovrlBCwYAxoYOSlE=;4:QcBUAWLvlC2aU6/esJZLOxFPMaC2QdArHihA8NSNYiEoFwmXYsBygSJU7LxLgha5Jd71lG6CHwe3C9wrW4dVDo9iKl13fi8rAdNd3PLZkIYMjfrSh/S+a0OkCRec42fXPrez0yDnILiqKtspSd9z68XfgI/RLDGfgiiI48Q9SUwxbalOQWnlXgvapz/GrdVPtDBdx9sjiBBAgr0O9aM6X/l6S0Q6QLPIX+SA1FQamj7/Q/feKIW9HfixATsF4VxjGk0eVS/ziWhZbvbDxbJOBT5PuzKbrmRB5hoRMpbn66Bpscq5LUAVS/uN4AW+uo+P
X-Microsoft-Antispam-PRVS: <BYAPR02MB4678D8D8A114F7019A35039187FE0@BYAPR02MB4678.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(6096035)(20161123561025)(20161123563025)(20161123565025)(20161123556025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011)(7699051)(76991067);SRVR:BYAPR02MB4678;BCL:0;PCL:0;RULEID:(400006);SRVR:BYAPR02MB4678;
X-Forefront-PRVS: 0827D7ACB9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4678;23:iwWajhovwBHlMdeBCL0qqOY06iGhkNF0mT1d8OOis?=
 =?us-ascii?Q?B0VX5Vt1GuMaE92JeOeqMfGPuYeJjJQm5AtpfF9/cwHf4RAdR+r+9puuGgoC?=
 =?us-ascii?Q?qt4huSt3Vy1MkiVgifRmNDfR25bWrpnEO3Fzi+vHbqI1qL0vjL6OR5nkaisG?=
 =?us-ascii?Q?p7TKKdyP4rojgnpIjLJRGaiP6SgWy4+ktj+NqdFW6xAJ6PkE0cA+E/uMbfLM?=
 =?us-ascii?Q?AVaeM/SeJX8FWMm5cwfcrMR+Qg2zT3JMrLU4smzec2Gyvnb3bEbSJdpRNmpf?=
 =?us-ascii?Q?/U4XulIPcxxs1rqrf6b93rfU79OJYmYoctpSDCMqkt3qCdBFkZsnENEd9YVN?=
 =?us-ascii?Q?zEs2hbshTvS89fnQUIhXISQAG0+htQ52qRDo7rSidvcD3K3eojD27Es0K76H?=
 =?us-ascii?Q?CeNiwKaWlfZUxTsk8JPgGkw50wwZe0rD2uPyI9S1DuR3295AjgUR6Jx01SYm?=
 =?us-ascii?Q?0YPMRuUZzuWK9SAs33MpSVE3uOTAiH0CL8+fZKvEjD9+ThXwDLLXalYud7Xp?=
 =?us-ascii?Q?AoKTebyknvyHPxRrK5HBHMMzfIOfnPmXDK726RzuPabYcRm5WNTBNerbIVrR?=
 =?us-ascii?Q?sE/lhL+YOO1ZBDiPQ/l0WVzMg07gQOLmt21eLWfmmuEWEnRxTs7pXvjEpYSG?=
 =?us-ascii?Q?G4iJMFb+q1j9v+VRBvJhefn5njb7ja53wshZwg4Qz0xVHCihnTWgbi1vU3DP?=
 =?us-ascii?Q?Pwi5uVCoXarNwGbi8iqg4rifyNLOGu+uNUr64qsL3+ijyDawCkFAIx7dTN/v?=
 =?us-ascii?Q?c3UlySLZz8HutVd41kNVOzlSBjLM3FEbir+ZHdh3ToJRDm7yq7z0kat1v5B7?=
 =?us-ascii?Q?oq61ak8+h+gyQgsaJsKjmZ+/xfLC7NNKsnApXaLgCt1fTw6wjtQAaLr+6L3R?=
 =?us-ascii?Q?rJ4n0hQy1H9MXNgasgEKh4MBkAhsVSS1Zyhz0VIXJk+DwYH960rBBwDZ5b9P?=
 =?us-ascii?Q?AkEKz9pMRrCj99pNH+4zNh+5v8tu9JTj+YNPOWGmHE1b/X9VQwqT20FTh5Jy?=
 =?us-ascii?Q?mNV1zQEvyhTKD2uoW/dIleNWmCM+LC1Qw2Kk+yJUVKAy3gB7tmn7hWvIM0Cy?=
 =?us-ascii?Q?2ipEMfdtrJ/wb8kYrDxR7PAbtCWCPL6XRlx1N8A3e/ztYsc9Sg8v8K+b8AxE?=
 =?us-ascii?Q?elV7cL3WPS1HPsrlPEHQqxqe0SuqdUVNQnGwJpRUZJ81dTlKRWJ/W+DAmiJp?=
 =?us-ascii?Q?0OowQCl2UVybM6KL1tlFZjt2UTCzFJ4X87bML7YEjjiXrtMrm0CA2yDjHmJT?=
 =?us-ascii?Q?o5z5ec0CyR5jPiWeo8wAX+IXvls0cxPEi9BUm7zYieGCsYH883OBSmFWtuw5?=
 =?us-ascii?Q?uU1qSH0pW+ZQM1At7bVaDs=3D?=
X-Microsoft-Antispam-Message-Info: UGW/cUgrcftdX0/oY+C7ekqaGea8UdY2oGBfv4x4IcCKFy9z4hJ34B8bg89ipFIg15bcPfDjdXB4Sm1K74tnpxSnwJmbXzx4XG1YXDA0jNpE+zk3xaZ5Jjz1k52AYb53vmEQp3UP6ch3fEUxLkVbn18BKdzGg3KPSG9hep1Zheixnq87/FUddTx4lZZvDM0SAaJBKn+8ZA3NEW8+qEMVK5guCHcghMIKy7ErZ3XR3izDX4GTOk3BPfjJ1OUSxbePErpE8sCiOs9klGhiQ6Y47F3yyMf9efdG421qwJe0vPmpIv2YDZ+kGpMMl7sAtzycUfeLnoxjNwK8HHzvXC5PPE6xoqhVnNEdXTyeB7UZh+c=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4678;6:VbBt6rYFAjx2XRVYT9Qwx1IjoBi/yhi/0ljsFpjoi6Hh6RYKhoJ075sSkzeqAQIXebOQ619hvzhmUOUnuc8kGprJcRXvzAwOFVZwEqOfGO/77t1cJCJ9Abi79fkzBIY7SiUCu2mtI6M9E1ZZJtt++wozG9nnzyLjZS27aap82ik3SkVn8Vs+FAc3ZXjWzzd8mI8ErcHolQb194wfuUgl4efaZkZngPVCLT+hA122qk2fLWbTPFLVunsZ6ZikkSQK0laqdSuToQbrfiR90cIEFR8o1ohTZ32OAEQEZlpLHw+F2sK3PAP+fTCSdAo8cUQDE/DGmvXvPpdmdk7NeJPzP686XUuqax1L488CUyWHiaOsRzusyUdzUc0UQTgRSJCWwe7MCG40touph5zZOq5fkrAWPbs6CMMXcaNHAqMHFp9vNuA3wapJ+zKlFi9pHjh6i+Dpgu8XnUe7WEDIw/rsHw==;5:G4mnwG/tyLafnxZXHZKwm++LVLwK+VXO5zeAmFNj0fkevoyAcLfGu2QN4Og2mhRXR/ULsTA6yfgZfkgV1SQS7CZfLmKXbFzhabvD0wyEzMna8HnbSUA54eFd0Brn+HPzM4ejsAeaRdg47GAUvI3vIqfWrgJKj91ztLPRCXOMeVs=;7:+8xQqbI8Bk6ZHQEL/mU7Purl0H/Af1nFDPY2eUHOb42oOc3B+zNdH2FTr9pzd6Ls4ATt82+eMkomwc4dLWKrhFAnRpr8NEG6A7eZEGBgxqyPtiqkLK/3sPdMTcd8jtYQhl9g8daWeLgRn2ym9WBU6mk0QKKB2bsDggxV0klf5fJc0LDfu0lMMDtKfU2l1LCqInLWEOPSfKBstgXl078SZLQ1Nn7iMH+QrhGT94uy2Woh4mWfq2B3GT48AyBMzaXK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2018 10:20:18.8952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e577018-e6c9-42c4-d1b0-08d63350f990
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

ulite_uart_suspend()/resume() and remove() are using static reference
to struct uart_driver. Assign this referece to private data structure
as preparation step for dynamic struct uart_driver allocation.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/tty/serial/uartlite.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 441a216..64c7248 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -63,6 +63,7 @@ static struct uart_port *console_port;
 struct uartlite_data {
 	const struct uartlite_reg_ops *reg_ops;
 	struct clk *clk;
+	struct uart_driver *ulite_uart_driver;
 };
 
 struct uartlite_reg_ops {
@@ -691,10 +692,11 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 static int ulite_release(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
+	struct uartlite_data *pdata = port->private_data;
 	int rc = 0;
 
 	if (port) {
-		rc = uart_remove_one_port(&ulite_uart_driver, port);
+		rc = uart_remove_one_port(pdata->ulite_uart_driver, port);
 		dev_set_drvdata(dev, NULL);
 		port->mapbase = 0;
 	}
@@ -711,9 +713,10 @@ static int ulite_release(struct device *dev)
 static int __maybe_unused ulite_suspend(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
+	struct uartlite_data *pdata = port->private_data;
 
 	if (port)
-		uart_suspend_port(&ulite_uart_driver, port);
+		uart_suspend_port(pdata->ulite_uart_driver, port);
 
 	return 0;
 }
@@ -727,9 +730,10 @@ static int __maybe_unused ulite_suspend(struct device *dev)
 static int __maybe_unused ulite_resume(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
+	struct uartlite_data *pdata = port->private_data;
 
 	if (port)
-		uart_resume_port(&ulite_uart_driver, port);
+		uart_resume_port(pdata->ulite_uart_driver, port);
 
 	return 0;
 }
@@ -804,6 +808,7 @@ static int ulite_probe(struct platform_device *pdev)
 		pdata->clk = NULL;
 	}
 
+	pdata->ulite_uart_driver = &ulite_uart_driver;
 	ret = clk_prepare_enable(pdata->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to prepare clock\n");
-- 
2.1.1

