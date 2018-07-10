Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F89C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DE02089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="L+vikuW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DE02089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbeGJDOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 23:14:40 -0400
Received: from mail-bn3nam01on0057.outbound.protection.outlook.com ([104.47.33.57]:51373
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932813AbeGJDOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 23:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNwLLXouCQqRDSxmN1kdJ1vceBdIffPALUZBAlOeCpQ=;
 b=L+vikuW6A8W9OrxS6olEwuYB/KjJYiFi6esYEAHdAjCtcTiyQ5ZvA+NP+4/A603n7PMG6J+36iLjZdwsJz0DDjfCaW9j7LoYQY4gW2C0c9LEQww8UKJw7NKa6pSbFJ9dwbGie7Ybr64rPP5sR0ziDQ8hLy8HWVcnK2kTK4oqeCY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY4PR03MB2631.namprd03.prod.outlook.com (2603:10b6:903:75::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Tue, 10 Jul 2018 03:14:25 +0000
Date:   Tue, 10 Jul 2018 11:12:27 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH v4 1/3] serial: 8250: introduce get_divisor() and
 set_divisor() hook
Message-ID: <20180710111114.4794ee85@xhacker.debian>
In-Reply-To: <20180710110942.5b0a016e@xhacker.debian>
References: <20180710110942.5b0a016e@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: LNXP265CA0080.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::20) To CY4PR03MB2631.namprd03.prod.outlook.com
 (2603:10b6:903:75::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94ab706b-749d-4179-6214-08d5e6133f84
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2631;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;3:3gLrDSegTw6ONBHMWZxiANM7/fR/bLOw2RPhyZ1yVfjx4t0ovoqyqubdxtAtHdUMzOpt0PPobSzxoaux700KfB7JiojlDYjb9Nc7popC9/uOTG/GXtlsxcsQ+hTlurUsWEPHscomsjeuuFlWfMbyPwk0dvHPq5TNKADATQlI29ikzFruC7oatB3yF9qvcva0v2pVc18PjFiXzH2py7zeiXxnb54WGj0ihlfZTiIfLqiA4Fp36/A6IT/g+TRKHlNT;25:ZbbPQ7Q+grm1rVI7dvpnlNqHfnlIN5oOK3YrM5Phwk2u0pnSobMSecqSCJD9Ee8voZTM3B1WsmwNTviAvk4GVpKzVydcwqeBMIIvazDVAh4uxAlm2FId8eubdW4Oz3zDPd4EXN3us1/rbczGwsVUWYzki4jIY+U9Rc0FGa5nq7Z/WUM8nW/8vGYEt4vw6c9WqAo3gY5dN2VIkY62ds716iv2uTQDL2jROVVmCZjxiMOGJVjYLwXJZeYcl3fcDRv7XXEgic6hDzUkFQ1FvHoJEsTINkYGYJyQisDkiqd3vm4vOQyep1gzbV4suSfixXjW3oo6hAwJYuhTJdYytzMLKg==;31:DhsLXNFwDi44suS3S4mJV9TEY+24tMDl70NDfQ81oDakjZBBv4r2d8RmwDWPhLovunniSRnnk88Z4WamVnvaPevNdYrvInlBO6/eEQpWpDY5HjCB5ooAAWvn8wkwwMV1AK5tZK0esQVgAOJBgpdi5I2LOTzF0Uhg5ZZk2v4O1S4vg8UGthAIwH6X9fpYO9wb6UZweIlGRFECRofVm1dISNDDocHR6jvX6rHqUL1ua+8=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2631:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;20:+PJczAjJeYmE0OP5StOSaDpReN5B/1TJndykaifowp7Vh0ep8clRyIvgYKBhwkrs0IMqeJqnyCoOst4iB8u/be3EybxtbBKpN1ZOxV4BIFuRHawB/8rUGzgfx+eLuEOznlPH5mpTQoGBNQnJcrBEldaj5pz7PzHb00nl+6mRRQYyXXEuOtQbyj+MaucVqyxYr0CllcVsPp3fv1noUmm/mex2y5AQbcEajcsmf4YAz1OQ2x69k12+dQ8Tvrep0ix300oM4+1222+ZjLYwvTJe1cKJNtctjL79ribapw5qRvbxL0mdt90gAHoKddBkIFjDv+cmg2zYXHMeBYSCUZNyTXn4XK9suB0kZ9nHPM9c9A2l0xZ4a7hSc6bsX2kbs/bgdVZAMQwfg0v3pVjH991Vbi3BnxQK90+TV31Za7fB8iRSC0vj5CwuBFcqVN+AvK4zDN6CCQn0nKPMop93HK3Z/4zARUbLFxp4rkfh9xGzAfLj6gShy/hRLIzyigszk/qU;4:nbpSll5YlfJL9z3L4z0mbSN2eM3z0fLqasL4gXiYGzKyQK09GRrck0DBEVA4bv8NofR8jEoXmrt++Ts8t6jnBWVwOYvVSF/WoFv9SwAAmofUc1FNulEBV9gIIDtvOxJgjOxH+sRgAPm/37H6/Sj8tePrtMImYMuswD0tsOf9LaRgAOY8z1rnG2vwU2nJti0RrJeNgpFEly4lSPKq4Xrz14DH1wxLeiBQux1km+Gk6fLXLVx2DMH9yrs+UiJsp6rbTPsf7DJ6JEmCT2fLExH69YWE2lvInqvb8gwdnKBHW/IoTcGlaDddUT2EgN8IFTtT
X-Microsoft-Antispam-PRVS: <CY4PR03MB263177619CE463C356F7BEFCED5B0@CY4PR03MB2631.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB2631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2631;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(366004)(376002)(346002)(136003)(189003)(199004)(186003)(26005)(16526019)(55016002)(9686003)(4326008)(11346002)(7696005)(33896004)(6506007)(386003)(52116002)(76176011)(53936002)(486006)(956004)(7736002)(476003)(305945005)(446003)(86362001)(575784001)(25786009)(106356001)(72206003)(230700001)(3846002)(110136005)(50466002)(54906003)(23726003)(1076002)(6116002)(8676002)(81156014)(8936002)(81166006)(2906002)(66066001)(316002)(50226002)(47776003)(68736007)(105586002)(478600001)(97736004)(5660300001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2631;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2631;23:W0tpNnKHmQAh/fgW7q9IC7uy/cJC9IKoyA5E9QxCc?=
 =?us-ascii?Q?NLfk2fDaDc1T8krYrONMqHnNBIzEhkhis6yMZoEt5IAIJnZvzNhoz1xUOuJ7?=
 =?us-ascii?Q?lw9sQZChCThzG/uysSts7M0iYfQDHGAe15nfR7cUMkgMv5igoHmb9LEto+X4?=
 =?us-ascii?Q?AAmqWZ3qfPcjZq+PhI0euV7wAdYOQJ9Ca6NSGQTJuI1kGXrI+V0FcJ6/XFia?=
 =?us-ascii?Q?ve/qoHLdXcIkq3I2EW3AsTrOJkPmanNcFoeQxUNIExYgu0JE4gYLgPTuvrCv?=
 =?us-ascii?Q?hLn73Y/WW164tIr+Ha4DbSwJ9eyOKU3hD1tyjMqL9+/GkCV1NAq2cDm9Tlg0?=
 =?us-ascii?Q?/5CaZKvvfRdldmOmq1AYwRAlweaU6+2PRJJ+iGG1qshkmv3B7M9q/T5JcSpn?=
 =?us-ascii?Q?71BMkGIWGQPDGHXkczpWqemodZc52QQnwpbSyaSOXCJnq/JzLG0xHrWASzHy?=
 =?us-ascii?Q?e2SiB0lS/J3/QPOZPyO+QCPNaeFuimNgr3HLxvoSFFaenPUv16Dtb26Lh+rM?=
 =?us-ascii?Q?2Y8Ifc5VZvZF3Cx+zPW8o2dX3vQXimzU5Erfpuvgse2/WF1/epg9gi9hvCdy?=
 =?us-ascii?Q?iPBIPAUn9nEPkk4WiOdBVfwY+BmAiCkBuMZ9ieTyq5zxEKJr/buKP+qKM2wG?=
 =?us-ascii?Q?nDXg73TCLAO/nWq6ha+ciOLdSF+Ly8QIn6OvGcE2lNoFhKLZ2IZE4tAhlZ7C?=
 =?us-ascii?Q?nNkjb6P7fYwYillWbrizf2fcSYNYpyjCgmoEUZaH0p4qFyWOojmu8kOT2M0L?=
 =?us-ascii?Q?XiSQCuVcuGEXxs6x/Wh+fNG+6QcXoRMtuARl2/FVZh5w6ajaLgkvSxw3Syeq?=
 =?us-ascii?Q?iwpgCu5GuExHnHirmzbdJUPGwHjvcEMqmIxWCEaw1Mp5DtxLYbhz/Ww9CtMA?=
 =?us-ascii?Q?XhbssHrp+Jh6gD/O1THMYqnGVq7dc4Mfy0Jr50sLA1l+6Ces64FlsnO/gtu3?=
 =?us-ascii?Q?vQCZfqCMLCMzsb6H/ryOePgCsClUHeYhdhTOnonhRrD8jLefJ+o68oLVRnKw?=
 =?us-ascii?Q?wqhIjJ8mthhwYYH52Z/p2mgea5I81FwEm2K/EHzcIv0bu8oKlwfGANFEZPH+?=
 =?us-ascii?Q?1rbBN3dhoA4t6M0yyT3vs05pBRFv13GhHAshoYGTcyShvQKpXDC3cz1MwvMe?=
 =?us-ascii?Q?sZkwMomhSRpaVJLbWhD0wYB5lbKbqFP4AKhWzQhW9Jm3tam0i3GQ8cQbeFJO?=
 =?us-ascii?Q?B56EAIs+LONcHqzQKjxMrNDNXQVDpLEa0wmXzIcL3eDgxijW5snzgIig6dpZ?=
 =?us-ascii?Q?xbdMt67c4reCzMj4mI=3D?=
X-Microsoft-Antispam-Message-Info: qQg8mlToHU/2DQl4uPnWvBN6uVOEMMOLYTKDMct/zvncK6vg8pN1ugzHoMS8vc3CMW//NneSfM4zTcr7yuAMdEAin3dzytC2DY+6BAK2Cbw9D79Tucb/NyXcyRpPkJOQkvrghcPvMXQZ/TLH0nsDInm3RGlAMvUZQuI+l5xQ7DDVpGPTI5XB+T1HyVQW84oER3/TzT38BUR2IhZqq3eE7Xqh2bbCJuTFINQpsAMri434fz8DM+tvXLe1tedy2j1ze8Zec97czuSgIPHVimo7HcSo08aqPX4XmnMmHfjC/hnakTMDhckzcUo+bgY3nkAfEoYfecnlghPB6ekuQRYnd9PGJfUTLC11F0XemP5HrDU=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;6:L4Cft1Oy04tHkq4bS5KsmbHOO9cNvY1bLsJbWmMnOtKyXLGUK8aZmYJaX34CKPSgq4i8CNjlXbmB5+l7pFwLfP5nFXyv0MNXkDppnkLoAV0e+WocuJb71pDl6Ez7nfhA3SssRoVIzWiTXIlg4HsS3yHm8aSxYNpVdqu9LnAhoFmJ3lbjzyJ9jRUcukGcDXo2mk2Rx1w3SpBj7+xANa7qqiHg3iiVuBDXXKW/2vFaQfL7CHTv3k7KqN53zfhP9EdDh/HwMF+2L5G5YgH7hkgXLVWEguoHQ9g99HIjmvPHWn9esQzLebdZLVpNoUs7eWd+axtTvMs2fRpZjLzOUTXpFZaZpEjr2ewbf/tJxDKiB/0RkDbcvsNyi0GhAZW8Qve96HJcFaKg4lpKdXSjNXITBwQHug2RmhtEYpRD0uhOkJ3ncle15vcvCXhQxLdWvpijcwBb4DJAN6g8wUz6mE5yQg==;5:FKWQ+9w0ueymw+H1wvmtZpuJ4aPooQdgsXNXlE6wlLK+5uzfmVTW8ehZIwAhwreXfv+IhzGR9z+Xu6rMCwtJvjW3YcbiFf+hVhlfLTOt+Iurq8Fiz0R2tUCtAAojuzu0GY2L9AzJxVZyh6XyCDIkaBloXGeo8uOcIHCvWhNiFdY=;24:9OkIEU1+gGtVCpa6BYSIvOMoe2XqgLm9DhNwkqnyRK0Azh+SkT1hMJeRriu8BCfICaRj2dKXbCClz23Xnn4EwlI06yDuE48bxaQvwy8UaLc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;7:QuQ0vTIVelGuAgsMOGA54LaND92K6Ln8MjvhsZELLTjmeWY3ckQ7+l40bq72bCX44MIHb8iOfZIQ/DLA5XARojqJdlVeRjKgZqUn05/7rrvBBMRnC06VNxAxIes6+AKI+biMQpfNpZSVQwfpGRCLwENaYdZsj6ssEauM8dZO+hSgecihyfLR8n5Ce/GlNVpqTEBi/QkAi4cVh5onRpNZuvRqO/JvSsCWjc9nmhs+1Z+rl+TLgIkopZosaUP/Iqe0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 03:14:25.7476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ab706b-749d-4179-6214-08d5e6133f84
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2631
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add these two hooks so that they can be overridden with driver specific
implementations.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_core.c |  4 ++++
 drivers/tty/serial/8250/8250_port.c | 27 +++++++++++++++++++++++----
 include/linux/serial_core.h         |  7 +++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..a0bb77290747 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1023,6 +1023,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 			uart->port.get_mctrl = up->port.get_mctrl;
 		if (up->port.set_mctrl)
 			uart->port.set_mctrl = up->port.set_mctrl;
+		if (up->port.get_divisor)
+			uart->port.get_divisor = up->port.get_divisor;
+		if (up->port.set_divisor)
+			uart->port.set_divisor = up->port.set_divisor;
 		if (up->port.startup)
 			uart->port.startup = up->port.startup;
 		if (up->port.shutdown)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 709fe6b4265c..ce0dc17f18ee 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2498,9 +2498,9 @@ static unsigned int npcm_get_divisor(struct uart_8250_port *up,
 	return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
 }
 
-static unsigned int serial8250_get_divisor(struct uart_port *port,
-					   unsigned int baud,
-					   unsigned int *frac)
+static unsigned int serial8250_do_get_divisor(struct uart_port *port,
+					      unsigned int baud,
+					      unsigned int *frac)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned int quot;
@@ -2532,6 +2532,16 @@ static unsigned int serial8250_get_divisor(struct uart_port *port,
 	return quot;
 }
 
+static unsigned int serial8250_get_divisor(struct uart_port *port,
+					   unsigned int baud,
+					   unsigned int *frac)
+{
+	if (port->get_divisor)
+		return port->get_divisor(port, baud, frac);
+
+	return serial8250_do_get_divisor(port, baud, frac);
+}
+
 static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 					    tcflag_t c_cflag)
 {
@@ -2570,7 +2580,7 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 	return cval;
 }
 
-static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
+static void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 			    unsigned int quot, unsigned int quot_frac)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -2603,6 +2613,15 @@ static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
 	}
 }
 
+static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
+				   unsigned int quot, unsigned int quot_frac)
+{
+	if (port->set_divisor)
+		port->set_divisor(port, baud, quot, quot_frac);
+	else
+		serial8250_do_set_divisor(port, baud, quot, quot_frac);
+}
+
 static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 					     struct ktermios *termios,
 					     struct ktermios *old)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 06ea4eeb09ab..406edae44ca3 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -127,6 +127,13 @@ struct uart_port {
 					     struct ktermios *);
 	unsigned int		(*get_mctrl)(struct uart_port *);
 	void			(*set_mctrl)(struct uart_port *, unsigned int);
+	unsigned int		(*get_divisor)(struct uart_port *,
+					       unsigned int baud,
+					       unsigned int *frac);
+	void			(*set_divisor)(struct uart_port *,
+					       unsigned int baud,
+					       unsigned int quot,
+					       unsigned int quot_frac);
 	int			(*startup)(struct uart_port *port);
 	void			(*shutdown)(struct uart_port *port);
 	void			(*throttle)(struct uart_port *port);
-- 
2.18.0

