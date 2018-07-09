Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0D8C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25672084A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="TWb8opw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25672084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754547AbeGIIYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:24:34 -0400
Received: from mail-eopbgr690080.outbound.protection.outlook.com ([40.107.69.80]:26752
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754515AbeGIIYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkvLDubnQoXKOsaraEE5tysys5NXbGMIcBYWCj1zUZw=;
 b=TWb8opw4dDCJ97rCUT+kT29yY6IYX1uU7qfaPP7ZcfL4SaTCJjR65ZpC4U+HQcoNRU/AuKLPnHTLKCV2JgygL6eQPf9X4HUkOpovF6s6e07j9SjbZW1v9+i5Smy9LbDYC3xN+NB+9lX0r48+HX8oo/7UO+fOYWLHe0IR8iPUZlA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY4PR03MB2629.namprd03.prod.outlook.com (2603:10b6:903:75::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Mon, 9 Jul 2018 08:24:26 +0000
Date:   Mon, 9 Jul 2018 16:22:30 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH v3 2/3] serial: 8250: export serial8250_do_set_divisor()
Message-ID: <20180709162230.066bcf66@xhacker.debian>
In-Reply-To: <20180709160942.11a74f7a@xhacker.debian>
References: <20180709160942.11a74f7a@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:404:42::34) To CY4PR03MB2629.namprd03.prod.outlook.com
 (2603:10b6:903:75::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4de5fef3-a7f9-402a-409d-08d5e5756386
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2629;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;3:7+4XeFvoYBCA3F0ts7Fiwq5RWmZyLTX92RoyD9s28/Dm5SlwLkL2iI0XWIv4S3PNPQK1vj/VC1F8uo7oObd9p5A0XT0Kmgip+x/MyZj56oIgYpa97bRzt0jDZUXyBZSHtWeznB7cKqAr9IF3nEsVDQdT8FrTT4tp+3gZPfe6wqBN+0UVSrLzf6mKZpsdW9v3O0qPpylUNN5XP9GGHz+5BBMcSJYfzRIsxLt9+3lTHsoqKyoPc8mHI3iESY2zmJvG;25:V0/l2Py8sXl2EHkxvZivV9JblPy1fnnoPvKDPXA1AQ66w4KrY9Sc6FpgXMXbQUMy/R/DybRgLFyiPq4PT2lGLwa8Qk/H29CI3A+1LW43vA6AlslQIbx8yT7OklGB1FIVS3M4WqiyG0zV6MlNAa2TKN5adnvt+m2KmERNhFGcZxlNYxTyAEbXYh/nan8czOQuzIsZkJPW+/nugc9fPJKM0ZaxTjHjSBYp0a6jimSW8rkGnLoRu15eHvWHrhe2ZmTT8jDM+BIb2vPoOJAt9X/g+6k1QLHWf5/hXLpv4kn/tcxk4euhtT1eiIS1xyquEpmESL0sUZTjs3+/QokUypOt8Q==;31:zJ2P9pOi25cblS16rj1T6kMlHUjWnJXkGb36i8xDhu9jfNgjmuNDs4aGSyDHRi7ddFtZeykph4wUDJoijp/MWjb/Cyz1G7kpwz1o8FlN/eGjIE2EzStTddaofhB9VxbHnbGu3MzGuQdIXo2kUghLiBNqrjprpMPUBLAikeD/CZA/K10aHnKBet8+eSFnfpeThXkOml6MXxGGmvSRf8dC1xr/ZIQ8J8M7RtsRIqjp7CQ=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2629:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;20:lhl1IrsMySNGSxGG9xfCdUTPvGUUqFCC5eUf4R6+WF4QXqAGfnO3oWWGgju5ZOcz3XYnNM8/dwtyqIEqfrA5awUPB8aV2YiIaIJQnXmOUTLLp+YYCIFvPzDUozTXpBCnkToMxKLBsgOcExTGVIWZ/KHJCKkUYt94y1uCUDJPPcIbtEWhntQpYZJT43poqwtDnQNnJ+h0wWjG09y+y0cVm+NDc0XNSeudfV8B2n8cRHbPXaF5LzFEr/iv1WBVELAPGzxEIhKPUH5gJVEn8oYIYoVchPb/o5iBTb5jzApdl9l3TrPcO1g77b3qZGBM81Pl7SV1oJRc352LPRn3fMxM5lUmcRqJ+wtOqlVpjogPfYX/Xw10tx1L6v6bBLxpLF+ZJcK5VogalBhUwnqp7qfsZy+KjvrFAu3fJ6epuXUeykxOornvzkFLNxAYltSK95YEqrKHp10u1ECxbE3gAGIhblpkeOIHE3/HaWnZcpcIRk3EsluXTDG7bOFvqmb0QD1W;4:CMwweWw9SFrnAqTTNyH/hXHemMvxR0wUS8Ue8BMB75Wi+UdAskVogpuRcIbIPtjO2NkXC3TqIPYJxyeLZ6SxRNYbL2yphaoLyHQTYc3lpdZ+vFcmdoqwzKpKJbfvS08AGO1HYdss4/2Ijr3ffzC2VI9sTwzbYydcj0HW9+bmuubbRq34i2ErJWe2dJN7Pu2XJL1SKDu3MAxI8PqczJlugAIL5vWa7BmnQRZ+OllHY0OBeSKSKJ1IAKPRnhwbA+LuCrRTfGwTLUVomVVSCInU/g==
X-Microsoft-Antispam-PRVS: <CY4PR03MB262913383E9C0C60B3FEC63FED440@CY4PR03MB2629.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB2629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2629;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(189003)(199004)(956004)(50226002)(8936002)(5660300001)(6666003)(68736007)(50466002)(81166006)(81156014)(8676002)(66066001)(386003)(6506007)(11346002)(9686003)(76176011)(52116002)(7696005)(33896004)(4326008)(16526019)(186003)(1076002)(25786009)(446003)(2906002)(53936002)(47776003)(6116002)(3846002)(55016002)(230700001)(476003)(23726003)(15760500003)(105586002)(26005)(486006)(86362001)(110136005)(305945005)(478600001)(97736004)(575784001)(316002)(7736002)(106356001)(72206003)(54906003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2629;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2629;23:UzVlgrLV+/h9FA+Ia0DSIHRXrR15sMCeSy2RMT9Ep?=
 =?us-ascii?Q?2XhyJkmqBOYnOGWle8fOEz+zmtChQlGcjShYq8SPW0KoY4Mpjq+Vxq6WnG7e?=
 =?us-ascii?Q?FdMmxOV03iEnRpOC2q4wAohwU0HbvNfc5vKGE8L42EPLnIQGIZG/mbFkUmJW?=
 =?us-ascii?Q?QF1Pp72vfgK7358DUKs0KgmTi7lOf2hWpNWft0PeRNkmvs0fDi+0pPnZArsI?=
 =?us-ascii?Q?crA1aUkWC47J0fV6ttS9jrkm1HpbE1Q/H7b9NNvhmE6sI/D1QwxL+pt/viHZ?=
 =?us-ascii?Q?648KML4/xRm92j59ONstbTV+59vSA4q3GUkFcPKbDC6/fW2tZJEaVjm6elCj?=
 =?us-ascii?Q?ltJRZ01D+ikd8FYlRB2YQ5D5Y79HTky3Pg64YMvPbkpbXPqZWtPGqSVraeei?=
 =?us-ascii?Q?gOJ5ling2pbbFypGRZx8ZaivpPSSjFeYNxnUgMxSDzy9TIOKH7YNt4DxGFF6?=
 =?us-ascii?Q?6SNDEkQ8O4/FY6IfCLq7EXbVqlYzl1rMAN91Ta5+V3JkJbxQE2yVu/q7B6wx?=
 =?us-ascii?Q?PD1afu5bSbLdPSARD2crdLgJMBJaKa+i5CtZISQOfe3yb2ivD+a5Y0HUvWsn?=
 =?us-ascii?Q?FkcSWcEqpgs5SZ4oU5AaDVVF/xaOnSDuCChgAWnt2OhkE5O3KM4eOnbcDvFJ?=
 =?us-ascii?Q?vGAoTeB724YUHuARcBRJzxJNovJQchO6NQrTDzWlhd5KzLaLN5TfMD+YmDQu?=
 =?us-ascii?Q?3P34fi2sO/XzIkL7vrWS3PIoXe0ygJbixTfceSXgy4ZtjcYSvmoQOpsL0LD/?=
 =?us-ascii?Q?V6askArs4o6sKYLSAK+av3jKjjiX7jU7jaT0skTescclq/wWm8g6eTLvcwrQ?=
 =?us-ascii?Q?XtlcuGmWfcvQ7Oft2lQ4M5EemclrjbNhwTgBDvk0eVWl+8ShwucfrehVye06?=
 =?us-ascii?Q?k0vJw3b12lPxFaxbNFCizcLr0k1TQCASpYdaNVwNAM+JXCar8gVZODjc2la/?=
 =?us-ascii?Q?Vpgl83Op9Rh6pJ7Ct7wIQbQf4mCiys4gFyNXXrduJhD/Z0mk2ZLrcvaSxPWE?=
 =?us-ascii?Q?Tw+yubjbCOmgmv/hPWWm28E2TRdGZfrCx/JX6QxoRN0McnGeeXkBOkXD67SN?=
 =?us-ascii?Q?o6qsIxJBX8mXnVqJ0WO4B06tFtQWAS8w+vI5a4BeKcKaX4DeCs0e5YdUcled?=
 =?us-ascii?Q?GrVVreDu3/zFLErNwA0qQkQmnQ8EK0xQT+Zg0vjcWauyYKyVd/m2QzwAtb7h?=
 =?us-ascii?Q?M2n2yHU+e2V7YkK3EL/9rLvlX7ZFjgMaTrnbVJODE6NqtIDpihR0UCm25r7/?=
 =?us-ascii?Q?xWcQ6XTVCf+wR2Fn6rFnkk9jqkYn33fPqlgPRSjBIQEGwtIknlqfzPYlvEtB?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: 840IgnxPsIkJSJbsEEIXaPwMVDiMtQL5MSOaMtNuDzeJAAt5zuAgOzX+XVjaUMiiANA9SStSQs35xOi+uEAFK2l588DdT0iLgk2Wutp+MHLjWl8Ir2RIVZ0+yQhrumo/2TkQc93li8ZWfyDTSMNFt7PV7HG/mvTYB8ZiSp8Uy/hw0bE6gLQW8mrmCsNXgqngNX63YLo1kQh8uBeiogArTyw8cdxf/yQaW0eTVh/Op/BeTWg4K13B658iIJE3VXpYEYKrGwp7rH4V+WM+05iNNHMivKQuzPYahwR5II4iiwmLf95F7POdAH1VNswZRzya+SHtSNSulJ/o7UJqYErsc1opolaIVGIv7GlcKE1fT0s=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;6:ZvXbDCRWRRTIxzOmopziUqDcnFC8CC9seA+D7lxkoMYQxj/N8CsFbSMMvZ5GHDhLPr9XJP0mQHHjRP6MvienaYzXFXs/PadVUIW9po/swlB7iP0YcNt1chyu0qkfVY3Q2Wcxp3NfvMyT/n5iZICkm/iLwdT4AcYSd//ZOaLApiJ5sIvoqqCx4yLu8k7DISI2rwywf24pFJJXRbtBRUeb4ZAceYgC6q6gXsPXnkwTykdpDBWzZ+VQWchVnv4Oy6UMYam0erVX4M4+KYHDMwX5LHG67XfNfwD3bLVSmqdDg1P+AebYp8MkURp5GFMZWTc+69dsu/a3KAMd0QQ5zE/EFsQhdZ+C5fDVNdSdO2AKbSHyPwgUSGdO/YgVn1eWfkvjnbThq21uem0Oye55Wn5YGFsOUVtDHcq4a27AjoiCFDjmKjok6jPkDx2qELJ8Bnhjclvp75uuqeYfMiY6ztoeog==;5:QDYHu+CGV6qZi9f2b7f1bHnPGQdTUD4nhFT6a1y8XCZGFTXdygPfmdWhXStRniJm1aYvGZ4J5ORl1B8ik5hnbTTkQzb8WZ8KMY/giCIi6q3z3UG2qplw8bMooMwSFbSIchq5wekLeLC9yktr1HBLjRp/Ti78GI5aiZQj37AjGpw=;24:vGP2SR+/9eoYgaDhkqBIZJ/MaLqozD9uwp8GQSWSuOhyPfkua3Nj1j4Wljvee7TETcGNBQY9SCEbmN3Wz97suPGXXm1UDfJaLRd24FvenVg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2629;7:cvgSn+kqDoS0P8+Yagk3VJs73Mwu8/Iw/bTx3zKmAcWERBSg6c8lq2HFq4lCJ24rJAwtswrA5M9won7Y1ckF8FWmzifIO1on2xlHONdUrn9bxx5qqQbX5uJXAg3qLkdwzKfikUKWrDuRLVThuhvQPEJXKGHooWZU38BljMac7AMN1QznEJr103iHCGvzYo5TzZHTy3yuN9OL4Pfi7yvESDfKoPzeZwqPIe7yb5qiV8jgoX4HCPdD8w2V3p5Z6RBA
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:24:26.9936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de5fef3-a7f9-402a-409d-08d5e5756386
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers could call serial8250_do_set_divisor() to complete its
own set_divisor routine. Export this symbol for code reusing.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/tty/serial/8250/8250_port.c | 5 +++--
 include/linux/serial_8250.h         | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ce0dc17f18ee..945f8dc2d50f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2580,8 +2580,8 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 	return cval;
 }
 
-static void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
-			    unsigned int quot, unsigned int quot_frac)
+void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
@@ -2612,6 +2612,7 @@ static void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 		serial_port_out(port, 0x2, quot_frac);
 	}
 }
+EXPORT_SYMBOL_GPL(serial8250_do_set_divisor);
 
 static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
 				   unsigned int quot, unsigned int quot_frac)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 76b9db71e489..18e21427bce4 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -160,6 +160,9 @@ extern void serial8250_do_shutdown(struct uart_port *port);
 extern void serial8250_do_pm(struct uart_port *port, unsigned int state,
 			     unsigned int oldstate);
 extern void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
+extern void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
+				      unsigned int quot,
+				      unsigned int quot_frac);
 extern int fsl8250_handle_irq(struct uart_port *port);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
 unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr);
-- 
2.18.0

