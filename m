Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5FAC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD372084A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="o2oDj1Ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD372084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbeGIIZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:25:18 -0400
Received: from mail-eopbgr680061.outbound.protection.outlook.com ([40.107.68.61]:7573
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751321AbeGIIZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6lzufrgKpSWwls8YvcvBETwmqRFtlqVC6eFjR/rF0Q=;
 b=o2oDj1MlXKWTvyUwiP+9fYBDYybC1jEGXsK+faSZ3MrArryiYBdOhashk3/Rs0goVnzF5McTKQ8+TalwPGSDa67jD159LMYsEcwFGTm9LacbcakDQXtmMYy5WaQqyKSt96h7CtRF5xWRbi2FkXZ3cH0EbaaVvyxHMxMY1qJ+ZPI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 MWHPR03MB2637.namprd03.prod.outlook.com (2603:10b6:300:46::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 08:25:09 +0000
Date:   Mon, 9 Jul 2018 16:23:15 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH v3 3/3] serial: 8250_dw: add fractional divisor support
Message-ID: <20180709162315.7f53eb9a@xhacker.debian>
In-Reply-To: <20180709160942.11a74f7a@xhacker.debian>
References: <20180709160942.11a74f7a@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:404:42::13) To MWHPR03MB2637.namprd03.prod.outlook.com
 (2603:10b6:300:46::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b7fb0c1-2e7a-4027-1e75-08d5e5757ca4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR03MB2637;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2637;3:VTu7onflysdTGmuaNYbIKZdge93m/xX91tqkvuoEiqaW4nJ9TnvqDsHtBZ/uiwGoPhrC6SrGBuXEPH34iS/6tBmIu9Ldk7QKBlGdpVWMfML/5ksLL2BEN9cN6GY/PPzYfXcUokuC2oVxNqBT0kQbtfSnQIvXb9KfcbIYHweum8xh3g3XD3EWGjxnE1eQy0Jc9BVFKhjn6LQdRm3W95vKvI6LqZ61RXjUyK5IkmENC1/dkOWCvZxeVH7e1KPuHhQt;25:huAWHSarEXkbggZxhaOo3NtqeWsllNivlAxHGx2DVeR7ruu1olyb60P67fhMItWU2baCS21tkXoZEDC9oF2PtACr4jlGwP0bB4LlUcS7LWmXZbClBVw+Uv7jNkOifSHmMIrSvmNfC/aZ/pf7lj2zK+LkL5QHqmHAwOlFn+xt5+j7A+9/5dtPSOwq4CLsRyjelBHCdzhcrTmBWLBKX5B8SJvOiB9NBPVL7RCW7lYRJ0Vc3RByqK2z1jO8SN/QdJlE+p6HpAbPLz2+YEAj00T+cVf03VxrMRl1VVe3U9oi16maAXOcz6njh4KJcIoEoBtctvFYWwKoUvDU1NCDXW8w9g==;31:WUStQ/rF6z7j/TTzrDRclxuLhkLCbjJPlX1cfmfL3nVVQTJp6AJOHIxmdLQr9GHXQrpLvLu5qLTBwJuakPHpGOBssnbUms1QMKEC4yspRWS7p7O+2OxeydKfhTJWRNeFDAxjGgcD550RYpDa079Ifsk+wqyIYbvbWfZQMckNIlvpunc5AwOjecN3NXNUwsu4tmgnKVrJ4IdvBrXthJPhdet8py28S2DTr7vKlTy4r+Y=
X-MS-TrafficTypeDiagnostic: MWHPR03MB2637:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2637;20:wvPoX/NUrsMv2KLwdDFY2H34CzxHsQVaD60kFTBm/Z2NaIo0n64I9ZCHdC/q/oQeYVjcFdZ1PtZs09a9hz7JyQLYeifdyMTwmDa6coYWJ5zf1cUYirjaP1Nr0YAnPkFaz4PCfVAVSZRnd8DSr61Q+KRJH45VoK174boA4xb56BBut4KJ2B5uQA82pbAWCDoqOtVkb6mfMaoJymOcfZndc4zaxe0zc09/tqDQb794d7YaAPJ0wiqt0F0NNtHV3Al556nhMicUim7aIWHmjPj9Qe7YjLG/Irf0OZRvTssOeiL44P/f/9mLe4U6eYyUc1MmM5DN0IWW3oN4rA4Y/wovcbCpEfR6RhJbVD9Q/Zl8ORsiO2Q4BLvtkbZ+e/mIMRPlG3KQNrlyU4PrhE3XuTqK+Y2pWRhPwbSZr9lYkWMOfJ9OoN1scfhCDZc8yRZ0eT9c9+saCD1UhGp5awOV9ccFITQ2U5WQDTV6ri4zuXUmN8WzvrC8UBnffLBMsLxG+OfM;4:44MhRNWSNoUfYr1/C7K8ONBxgGFMQ+iyd2inGVBJkc7leXA2hU5xuzC1aJC1hzEoVe6Oh8nYZweq0XvTLKa09Zc9Di4iCDbJkudD6Y+dz1jWrAjdE1wD4bDl+Iu2IW2ggtIah8DbhJF7lqMe9XIUpgPmc8xBo8T/TzOOJGa77YcqHkOfBbCx+aVD1TmHxuO8Q+Dn6ImS/51MWM7JDgXg3tbWiCmaG6b0W0D6yIQ9tGjc+D6jSOzq9q+bGBI2WybJ+Qt4p4uo7X1x8gvuOLfXlg==
X-Microsoft-Antispam-PRVS: <MWHPR03MB2637A726B2792D01185A1561ED440@MWHPR03MB2637.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR03MB2637;BCL:0;PCL:0;RULEID:;SRVR:MWHPR03MB2637;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39850400004)(346002)(376002)(199004)(189003)(33896004)(5660300001)(2906002)(26005)(386003)(4326008)(25786009)(97736004)(52116002)(6506007)(76176011)(9686003)(305945005)(6666003)(50466002)(7736002)(55016002)(7696005)(53936002)(6116002)(3846002)(86362001)(66066001)(8936002)(11346002)(230700001)(23726003)(8676002)(16526019)(110136005)(68736007)(486006)(47776003)(81156014)(316002)(54906003)(476003)(956004)(446003)(81166006)(478600001)(72206003)(186003)(50226002)(1076002)(106356001)(105586002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2637;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2637;23:nSfnXRbFrYzJ0o2rlk+oMd/41oA7T+V4LxmY7Yl1J?=
 =?us-ascii?Q?zak0+28L56T6p/Rpg/oaZ27I6SRYWLzEvb8c0jg2KWm8MUYBLptmuIMsxj8S?=
 =?us-ascii?Q?Wv/5+0lsBaT1Dsl/GOIAbLWpkYv9Ki+6CRo9OQnI/QBKYSNjYDJARaapBVsV?=
 =?us-ascii?Q?a536lGitKD22ZQ2Q+c4tIQitk0ZRRJsZUsU9rL6+BrbbedDs0OONzMP+16eL?=
 =?us-ascii?Q?Y89K/nqP3r4mfEfZ++N5pEDpyp4tqCcKyS+9vi/tspzoBWjl9G65iL4bXPMv?=
 =?us-ascii?Q?R+0OoP6TeebmnCK+BZer8TKVbuLQ/9U4JU82XIknWiusQ0LpLXI1arG9sy1v?=
 =?us-ascii?Q?l/FTVIo+v4oBmQ/0j8IDn7Mavx0iF1oU0xT4VpCo9Mp7YHw7o5QNUwJ8QpD+?=
 =?us-ascii?Q?IeUreukXbtvvlxzsA1A4mRezlTgmuS7I6dtj9z35em4DxzF5HCCjlTvk3JzF?=
 =?us-ascii?Q?M1TDS5Wt3sqmyUBk6ZTRc3H4GG1Dew0MmeYragxgpHRxZYbJWUm0YdtXGHdj?=
 =?us-ascii?Q?+NkGpPfO2av0A8SMhhEObfHohx0clUJ3xks2Qn5MCv/8Qz8VGQSyz2OBnqPc?=
 =?us-ascii?Q?JAjTxmjH970bS1yqc7oA/qfyoscGgkmj6PnH9tzchsLcuJji6fsVkDfSirWC?=
 =?us-ascii?Q?suM2ZhGQs0THVEg2jks3QGmrKtLTVE97R7CB6sAIkRzU+bK9jdzeKQutJsrC?=
 =?us-ascii?Q?NbPmSMWPx8kp63/dowyLP4Uej9glYKITgmBxH5VntKvZZ56wzuj0D7E28YRt?=
 =?us-ascii?Q?AmMvnfvOL4HbOYiRqSciC6mRACbHl1hRI1FVcvWmZEvqdjzi4mC3/NE44yFC?=
 =?us-ascii?Q?iPI4gd3pJoF2SkM121KwogSoOeTcDIsPZE7c5+7Ldc/ML+OC2OeiWFDPvQHA?=
 =?us-ascii?Q?u6fKVH1ZUVMT4iMRDfYThYxR0Lzt6ug6PtdpX6he2NHmba7cL7wOe5TGAkXl?=
 =?us-ascii?Q?VRyud8h4XmeRB/PwjbK738U2uVcsLkEG6rtRD9mnOvUbOD5Oo9ZiUcoeRHyH?=
 =?us-ascii?Q?D6l+AzU/ANufdqKhAAH+y235pLWdrJ4QZ9Qhzxu7N8mefpaLXDzlhuywo3uD?=
 =?us-ascii?Q?dDOh9rP8aCofSz1RVrzJPu1zF97ocf8aszVyo4vrgKOT9J68RAo8muDldTG2?=
 =?us-ascii?Q?yCjzCCm7fKvJWNKDdZM32kMYe3UD+xE1esOSCsIO0LeWZLJXkeNPvsOugGqv?=
 =?us-ascii?Q?hXkF0IxooLmutmzxyIAk9B2gZPkqJ0ztWYscaJxWRZFYnon/AA50nxEOoUnY?=
 =?us-ascii?Q?BpkBEI3yTy8iwwVJqM=3D?=
X-Microsoft-Antispam-Message-Info: IECj8vdF6gKd9pv//bXVzjtZxFCsd1kOmtcL9MGR8CklH1vAN0WKI0qvYgnziKiBEyoPJMugi8L1SWOLNHHIfVaRQO1UyubNb2A3m1Jczg1uoJWAsSoYkC7KSsUOefp6HDIZ+HHy/Izz3mEIiP63Bc74Oyfo9782gf/cLqsPiTikFnHUBOEOAdaZB4xQkmyDJHykaZbVOKZFM0cjH5aaH/oL/CGBjZ3qY+r4Hyz+Oo9kutOqlDE9oarUlDGGDSmVRZyIMkt+9rZUuU97j4pS5ZXtU9+U7k9rap0SjVYfGiaE5f0TH89M1ybkrDA5OtlHrDhbI97hrbncJt1uNxc6gJjIGKHhHAfJJf4ZCjufje8=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2637;6:xHEFdylW5FnWrRpZ6OXoR2skq7q9C2RZyo1pa4044DYBX0qDvmMmeBkuN3hCcYS0tAYJ/id0AXN7FARN8qZn5d8+8cAIKexule/I3mcTvcf2NVZfsrszRohXHMGlMH1j8W96tE2N2iteCJtjPKBWhpgZviTkZnS/gWvLWpormOMTwoMtFPZqZ798l3kcv83/x3EkaU5OReNtZx1Q7A814K3DHZZigTdyS6Cp+PfOrLUlP30I9MbAnv4I2HY3zyq149tutxmxTciHVa+WHEtmFqQHjQx8+6tGY2XV97HlVuGSfiuDLzBEiTI6LOINs2b2pkgMNS+13ULHnyQ5iwL8w7zd9G/PjN27ndCKyGP8YHonmIwTKm2dXEoWKq/RCZkzteJNTupg44oPkYnq+cD2vBARaGmgLDZ+6nO49WP40s2x4C9lRUWVkN8FQVqgiSkl2NjS3j+WEe/4embgFbNNog==;5:msd1FIKm45CDVKGN3pUwoZBNohIgeRDGJrCABrGq3A/ux2MytpkylwtIQKDSpooR2YuOC7laDbku7i2CFqeHixRjMzh+nJT7RR1gZw54yrDaS4NuL2/gWVivpt9OxT7IQr/Ksx2wV/iYbloxgtsNV5oJz1rf6ScT0od8HiZ++1Y=;24:GlQek4X0IU9AwWjV4EkgYHIXM8nb85rjIvC5f+bzQBcd5EhBv71SaPJlLObgFJ1lqvyzDqHKWPvNBdpRMpaaqFl43SREdcrjDj+dilTXn3U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2637;7:ZxysR+BPzNLqUfZpq7kP0QqXQoaoDYjiKpNoG9AHj4CJDtZrjmI7tDOSVKzZHkhZ2RPUKmSGSdMWTDYuyt4x/ERgEN3UzX78a7kwM22g5UkPsYTUW5oymNkaRSsdnlMqRKphCYRsj5eJiXVFMUDJ0q4DBaJgYZ23RzvVQhY7h/jRtVTizGUWOEtvAQoHxpz50/lG7UXCKWF3IuiTRvK+C5lmlzzpZvnQVYoS5XFb1vu3ivFhSB0rSnCKchcC2phu
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:25:09.3165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7fb0c1-2e7a-4027-1e75-08d5e5757ca4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2637
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register. The fractional divisor width is
4bits ~ 6bits.

Now the preparation is done, it's easy to add the feature support.
This patch firstly tries to get the fractional divisor width during
probe, then setups dw specific get_divisor() and set_divisor() hook.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/tty/serial/8250/8250_dw.c | 45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index fa8a00e8c9c6..e90c3d229f00 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -31,6 +31,7 @@
 
 /* Offsets for the DesignWare specific registers */
 #define DW_UART_USR	0x1f /* UART Status Register */
+#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
 #define DW_UART_CPR	0xf4 /* Component Parameter Register */
 #define DW_UART_UCV	0xf8 /* UART Component Version */
 
@@ -55,6 +56,7 @@
 
 struct dw8250_data {
 	u8			usr_reg;
+	u8			dlf_size;
 	int			line;
 	int			msr_mask_on;
 	int			msr_mask_off;
@@ -366,6 +368,37 @@ static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
 	return param == chan->device->dev->parent;
 }
 
+/*
+ * divisor = clk / (16 * baud) = div(I) + div(F)
+ * "I" means integer, "F" means fractional
+ *
+ * 2^dlf_size * clk / (16 * baud) = 2^dlf_size * (div(I) + div(F))
+ * so, (clk << (dlf_siz - 4)) / baud = (div(I) + div(F)) << dlf_size
+ *
+ * let quot = DIV_ROUND_CLOSEST(clk << (dlf_size - 4), baud), we get
+ * div(I) = quot >> dlf_size
+ * div(F) = quot & dlf_mask, where dlf_mask = GENMASK(dlf_size - 1, 0)
+ */
+static unsigned int dw8250_get_divisor(struct uart_port *p,
+				       unsigned int baud,
+				       unsigned int *frac)
+{
+	unsigned int quot;
+	struct dw8250_data *d = p->private_data;
+
+	quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud);
+	*frac = quot & GENMASK(d->dlf_size - 1, 0);
+
+	return quot >> d->dlf_size;
+}
+
+static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
+{
+	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
+	serial8250_do_set_divisor(p, baud, quot, quot_frac);
+}
+
 static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 {
 	if (p->dev->of_node) {
@@ -426,6 +459,18 @@ static void dw8250_setup_port(struct uart_port *p)
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
+	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
+	reg = dw8250_readl_ext(p, DW_UART_DLF);
+	dw8250_writel_ext(p, DW_UART_DLF, 0);
+
+	if (reg) {
+		struct dw8250_data *d = p->private_data;
+
+		d->dlf_size = fls(reg);
+		p->get_divisor = dw8250_get_divisor;
+		p->set_divisor = dw8250_set_divisor;
+	}
+
 	reg = dw8250_readl_ext(p, DW_UART_CPR);
 	if (!reg)
 		return;
-- 
2.18.0

