Return-Path: <George.Cherian@cavium.com>
X-Google-Smtp-Source: AB8JxZpJTC17LahnVKQg2wytdzXmk19Xrd/h31fUsBNx/911LHrpGaL5K78vmf2bl4YNkBVx4PIJ
ARC-Seal: i=1; a=rsa-sha256; t=1526454036; cv=none;
        d=google.com; s=arc-20160816;
        b=aX8IO9i0WQmlcuT1bD24U7RVsBuF9IqH/GqQlDG7uzVwY1oi92yBNZJSH3L/+7Efvi
         vaoCTIbmR2JfL5aEa3m2vSBokEV20lcsD3RpFps4dB2C+Lv72df8/aq/bFEkKrmz5FrA
         QrRQ8jhl5/X3QGDSSlvnvCZ2Jl9jXYAG/prv+l/t1XCPTRXghDXy3SOtr+vu5StvGB3f
         exwypu1+97S2v7WFCuycGqGoFN/VYQ5Lj4vaYOPp8Hv1WgRlMqMAX2blURMP3yWn5Y9U
         awg7FsAwj0zmqNlMErPKy3Uiwi4f+uf/sQpcmZXqUXUY0WLaikHWOfachvYuIK7x+/gd
         HvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=dffzbig12QqL5xhBTw5dcCvV/luE3SM4rRfHlUa+Fas=;
        b=U2Ylhcb36KhUAvuYAUXk5H2qWOQwgCSHiwV9kj1rQaJibJsNgmVTC06yK9XnkbdYeg
         CN4UtwRQKpFayPfUs2f9LmJvusy+oEUGoUY1LfW84nFLUO8AVzHL/rIYD5rY9IdRvINk
         aWswlOzbGrkf4LvKIcfKc5GMgCyCibpAt6jaNq9wf1BGO9KjrEHoZBeRq453WKBIfjd+
         +E57iUxXUVCwYRVreP9HQJaxfJugvw5jSkJ1YS/duyHHniAM9NuCN+FVUaNM/KZjuYME
         y+i/x1nETtGevEftBPVRyWm07U/++AX387+Jb0i1UhY7aPR77LV3E7w18f3sRp/Zzwon
         IfGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@CAVIUMNETWORKS.onmicrosoft.com header.s=selector1-cavium-com header.b=P7S791+m;
       spf=pass (google.com: domain of george.cherian@cavium.com designates 104.47.38.79 as permitted sender) smtp.mailfrom=George.Cherian@cavium.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@CAVIUMNETWORKS.onmicrosoft.com header.s=selector1-cavium-com header.b=P7S791+m;
       spf=pass (google.com: domain of george.cherian@cavium.com designates 104.47.38.79 as permitted sender) smtp.mailfrom=George.Cherian@cavium.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
From: George Cherian <george.cherian@cavium.com>
To: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de,
	jglauber@cavium.com,
	kamlakant.patel@cavium.com,
	mchehab+samsung@kernel.org,
	davem@davemloft.net,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	linus.walleij@linaro.org,
	rdunlap@infradead.org,
	george.cherian@cavium.com,
	Jayachandran C <jnair@caviumnetworks.com>
Subject: [PATCH 2/4] i2c: xlp9xx: Fix issue seen when updating receive length
Date: Wed, 16 May 2018 00:00:17 -0700
Message-Id: <1526454019-32714-3-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
References: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46)
 To SN6PR07MB4926.namprd07.prod.outlook.com (2603:10b6:805:a5::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4926;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;3:1vqif8eycRs7xlfej585gGXx37NsePBaWLlj7Dsv/o6LXlPb0UxSsOiiaYcADhEuImkek2OSLUDig84GzlGEfJPQYIDaW0S5+S6SrJVWA56aYD4bzAQBp0KYruRLigB9731ly0Rp0DRpYOQIq5zL1wDKXe1g4b+bEyQpNOWL9wlKk0T3vVepGWCWYr9EWxnGURllUDgjVsCK2/QabFgeaxZ+U5HveaqdFp8VzUclwqkkwY935mMGiABTTsqFbHgV;25:SasKzskXyp/rXm7an+kerqvHULEJC8/dOw0UymI/eSOyzmjk1NJekUHSRB6WW18DJRm+l4/1EAtYG2dVutZX8C0bhA5+/oTQN0AxSPQDQKh1L/zixzk2blcQF/XQn5AWkqAw0EEMGu8Kg+g8JP2Sp00eNTLd0L3LBvMs0qgCRbamX6N3dx/j3h69tsrVBGTzKjj2QyJoNwRNQ4I9TogrrQHihi9CrXT+iNAOjl6ltsD88y2r5xHn1AnqP1NCSibvTCwSXerOOi5FbkadSG3qciXFeGpKTkeA27hraWfkGhxlXGkji4BIcQMgzyUmLmrrKN21xmOpK+pSGV6Ga88NYw==;31:1K6aSyn08XDpEwHHOcJTwF1B3P+01w0WOawzaW6v98be87uJ06cVVV9KlhHU4DzbXOdq9SSOPNVm/mtDrwuUF9buA5ALBqYI4sxAqdR0RiP4F3uktqPIFbNxVBHXs738wEtzboAgKrEtZBnOp9cOHU3ebXnIupJ08v/zPtzE9iO97Ova0emUKeQBi/ncVB4Z/mG4yQWjOjPecLAnJu+/mJ4e2DdC+74mKo13LmjjnY0=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4926:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;20:0JI8BdjONDo0RrsAXyl7pjgycscCZULNvZPsqA6YrxUGvSQpyZhtbWLOCW4iGcMOftPfWO9F1F/5izERkSvVkAXkO0qY07Fpf4V/kea/4nkQrtvRmN21/MdYeimIUSiW/HlSgjSKTyxdGiEEwV3kqxjKEe6BccbXeiFf4FWJh9+OveWdyhhbORy/SkDffa8gIZk5spefmcl9WPVwBJRYwiozLneWgmeiGkNTboAVRLpq7ASOoCq5MkxCEcKnpfyOKDpel+Fuam5tCFAlVEGu56/jNVJU3/Y4GFrFLB24EnxhywczHEsKHzYHld09D4FGkAAA9bEC3fUvOynmI34jriGQDrosB8ZmAr5UpE3/Xf5Zf46SBhN7yTQO5U3AB9wwka+I64yrn/D+ZgJqXfw/oAlNjt6qoZtp/3ffdgivwNRzO16b4Rkrt7hkTpRNRkjRZmvZFmfi+P4cHKomHgSJwiiCMdMzvgAgzY4BvsrSgTpfgLn6QoU5LIqdmROtO/Nr;4:pntmqeJ6epOYL6ttojXf+SVZ95zN3UOTg6QavYLzWyBuWWMLQrjcq0oEFkcZG2LWjed7N9nghlPSSN+NH76nHVNYBKDf0Q7yGiIobN9ND/OCZnQw5rXpb4mzNVuW1peI0F87NITqqm2juxRIF9QDBgajN+iZPqXAW1wDTD8/13+Qu2jt62faX6N9Hdj1NK4xDTZT7Ah46m4Rr0JXLqJ8Z7yNBpkwPttziO+fqMW+2swXo5fNV2oVZ2Z3QgAS8U8+izI2/IeF/Y984VLNvCoVCA==
X-Microsoft-Antispam-PRVS: <SN6PR07MB4926633EBF394D32A24E26ABF9920@SN6PR07MB4926.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN6PR07MB4926;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4926;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(44832011)(50226002)(7736002)(50466002)(105586002)(486006)(53416004)(36756003)(8936002)(106356001)(5660300001)(186003)(48376002)(316002)(6486002)(25786009)(16526019)(16586007)(305945005)(551934003)(4720700003)(68736007)(446003)(6666003)(72206003)(478600001)(476003)(2616005)(3846002)(6116002)(956004)(11346002)(97736004)(4326008)(59450400001)(52116002)(51416003)(76176011)(2906002)(26005)(66066001)(47776003)(6512007)(81166006)(81156014)(6506007)(386003)(69596002)(53936002)(86362001)(107886003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4926;H:sbr2s-28.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4926;23:dAii5f4FDj9R4MOs/NxvQPaLYqLsYqLBijmzt0FnA?=
 =?us-ascii?Q?plIb1nrSmtm06jVzTVt7duZ/E5LlVa6+Gb+BBPY4garfPCodd+hfwvjRVjbl?=
 =?us-ascii?Q?PKd2+5nHA/9PJD+NvVyT5lrVmCb0zSJKTLuLPM92bgS3bGHBMmVVA36rl459?=
 =?us-ascii?Q?2/SdvLiX4l8GHpYAQwLaVXFFnmIGRxlq0MdhTfgJVyKacO4biSyyQHb7a8u8?=
 =?us-ascii?Q?dpJpRFhuOAIld6GrdFpcEg6T/Ruf0zcAaoADzKeXz8B1kHRSbyQ3utEHVx4A?=
 =?us-ascii?Q?zFOGKk8py3gfKG2dM8HsYqA5WJjo9ynS8pU0UOGEW+1DMbjG8ucT7xAp7VsE?=
 =?us-ascii?Q?p99gn3eDpCP19CUVDyuUawquCXEfN8S4EDRD16r8JS9Gwyf9hlY6UoQG3SxD?=
 =?us-ascii?Q?buKKVSiZ8llghOgFSdnJlFxD5Lb/okkz0OsIRB6QD0YE68G1v3eJ9C1SbCK8?=
 =?us-ascii?Q?f9blEEisVSzIMe9r63Y69juq0Ewi4OZIiMzlgCAS4R90SckpDQr2R6CMgBpr?=
 =?us-ascii?Q?WI6Q2qWaPGSDwptVAZBceb1HFPg1W0PamDMFsBAPzIUwmbFmHgZEiDXGAoD/?=
 =?us-ascii?Q?ivKb6odBEngTOxhGjY4HbucBxh6QvLHFe0IuBaf8BMAboaNHZAsIAz86ge0m?=
 =?us-ascii?Q?3MYKXutP0ls+x5XMaQK/Y7xEM48CIhCsJFyyqtD90F7grmTviCs7P9M9wpoo?=
 =?us-ascii?Q?0/AOvRay5skA9NtxNN2V3KS4kqtXy+wt52iaz5wLTXTpcf8EAyb103fOWdtg?=
 =?us-ascii?Q?vDAd/RNZ6V27n23aHhvURExg986JcOufalu9RGPD2ykYn4c2BOopx3UOn+14?=
 =?us-ascii?Q?if8XH6atWjka2BBDGA1MBeGammvTwIoVEEp8JaPGCSYa3ueo25GC2oaITjID?=
 =?us-ascii?Q?u4N+dah8XcsJaNtUW0Rouk9tZGjZkXv8gRIPAUhDv2lVBKuZ3qL7f4UYcCzM?=
 =?us-ascii?Q?H9mCINpLWmj+5o+0LvMJHTKrIAV688rydtwX6wSzhn5wr0c0VcRQSu+Wqtme?=
 =?us-ascii?Q?rlYn8SpO3xsikNaWG0/ewH6XcQRGgRsYX9+vt6PnmnhccPJrU/OphiY6Caq+?=
 =?us-ascii?Q?RLCS7/l4rvwD9Uz0uNbBxY71RAkAvM/Zb9NiIQZlOAKVv/Wk0SAlHZQcVht3?=
 =?us-ascii?Q?tooIYsV0HJTWx2z5kc8u5tqKxUxsOpsLCdHRWJQqBbS18Eqqmp5g/Dl+4T0B?=
 =?us-ascii?Q?/pBG5ALyo1FgbP3gbTkaXZXiHL7WVcEJGzPmI/IDE/u+cTJuHfWXeFvvV35n?=
 =?us-ascii?Q?k0HSYQqYTKbwNPwyWdtG1UaIWpNptv5y5O5Oqef+Sr2yQxVMmHHmy+zZLGx4?=
 =?us-ascii?Q?aF/2M8KVj+jsZHKseb774XT88neuk5ULuPb6K1KIgle?=
X-Microsoft-Antispam-Message-Info: KWZs64eQ0YMf2zeFTZq9rYkQLWeejga7PgvQBRvnzfFwVPcrMwOkXMKTRlnX8TwbadLwN+Tu4nzMjAqSfl9rfqIAKIR/IuEJAtcDpFzicaKgVIB+udBpGncF4w8SMs5DlOs9VTkgGW2q7bYZrsRHPx7fK6binJpw8u8rVTRsGuRWT6K3bC8er8Vn+J5Tu/+a
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;6:WmSMusM2W7csy6cm4jhdYin6MqoRkSxg7dvEgXHzY7Ixxnn0006llcKNTqg8aoSFISsUc8QuL6QCHdMUXH1X4Q1VY3PVeWgBkz2HvMDm+vZlh1p4W7/8AR5qjWXbJCkvClDfd9RXL0c9jht8x6xSJh/79dIc963Q1BPj/MQCwQoiJqE1bHRxLgyCKbQhdvw0NKLwOFh4+GnvMX5/3SRtMFzBUxaCxLMP0uaHePjm5y6QJggO1u+SvimVlcdt7LXYuSIayTmrxP/i2Bjxe/sykElzWMe0hoZ2okO5QLZO/K6YZqcFDR/SnyQBSKKFvi6wxeieNbXsl3XlVl6sTZpPy78/rGzqIFHm/61taRIwUM1WuVYMKa4YUoll6hpeYX8oDN+/SyQg1ngDcTCxzJIwbkdWkcfZ52bzhGxaL7jUHENw5M1nBOqkeY0je+ax4qREZD2IptIz/Kku8YqCvJZuxw==;5:7mdTizOoy4yi+FeqOoY8bIi8Ggy4wtbhIm7/e74gzcjtZPhHaQxuc+aqtZd9Yary9i011w10kUb3EobvLlBAdIwYgrml+8jVuztrCSfjfQ/juM+OgEr6J1U4upZQQTntQ7ZEjta2TfA20294eBomOUANgaEFuoQ4hMeUZVopATE=;24:aV8EQumZS8dmtwXiQnnFTCNyJzB8m4oVBQuSJhUtOq9pw2TcdrKAp/n4yxcGXRTWVABtBKNlcyUe9WUvfGoQi+dBbQ5JVSw93nWIpsSM/oA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;7:h3p5L/i+paFF9V//1pmWXJvwZ3kQAvuyCHzSyWP9I+SFZVacriBYlgKobqvy49Le1eMbdr7p/aHdb2tc+IHnjRE5uhqEkJKS64herKLQa53Wl9GI9iqB0M9AdxaniCpRcbTuGrhVszlTTlWM4unHqUbCLerGvWqW0mnkuCoeDH3zbNLwDEGJoRpYEcLAWq9maZF8JWdZwbVaBms2cPtX0L12MjYdU95Br07BwLbPGpiGafA4SeS8BV+qtrz/MhSg
X-MS-Office365-Filtering-Correlation-Id: 0da17c57-321b-4bac-b1a0-08d5bafab902
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 07:00:34.5911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da17c57-321b-4bac-b1a0-08d5bafab902
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4926
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600603068000428517?=
X-GMAIL-MSGID: =?utf-8?q?1600603068000428517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The hardware does not handle updates to the length register gracefully
if the new value is less than the number of bytes received so far. If
this happens, the i2c controller will not stop the receive transaction
properly.

Fix this by ensuring that the updated length is ok. This is done by
making sure that the new length written to hardware is at least few
bytes more than the bytes received so far.

While at that refactor the length updation to a new function.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index fe54512..c268fde 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -158,9 +158,28 @@ static void xlp9xx_i2c_fill_tx_fifo(struct xlp9xx_i2c_dev *priv)
 	priv->msg_buf += len;
 }
 
+static void xlp9xx_i2c_update_rlen(struct xlp9xx_i2c_dev *priv)
+{
+	u32 val, len;
+
+	/*
+	 * Update receive length. Re-read len to get the latest value,
+	 * and then add 4 to have a minimum value that can be safely
+	 * written. This is to account for the byte read above, the
+	 * transfer in progress and any delays in the register I/O
+	 */
+	val = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_CTRL);
+	len = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_FIFOWCNT) &
+				  XLP9XX_I2C_FIFO_WCNT_MASK;
+	len = max_t(u32, priv->msg_len, len + 4);
+	val = (val & ~XLP9XX_I2C_CTRL_MCTLEN_MASK) |
+			(len << XLP9XX_I2C_CTRL_MCTLEN_SHIFT);
+	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, val);
+}
+
 static void xlp9xx_i2c_drain_rx_fifo(struct xlp9xx_i2c_dev *priv)
 {
-	u32 len, i, val;
+	u32 len, i;
 	u8 rlen, *buf = priv->msg_buf;
 
 	len = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_FIFOWCNT) &
@@ -171,20 +190,13 @@ static void xlp9xx_i2c_drain_rx_fifo(struct xlp9xx_i2c_dev *priv)
 		/* read length byte */
 		rlen = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
 		*buf++ = rlen;
-		len--;
-
 		if (priv->client_pec)
 			++rlen;
 		/* update remaining bytes and message length */
 		priv->msg_buf_remaining = rlen;
 		priv->msg_len = rlen + 1;
 		priv->len_recv = false;
-
-		/* Update transfer length to read only actual data */
-		val = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_CTRL);
-		val = (val & ~XLP9XX_I2C_CTRL_MCTLEN_MASK) |
-			((rlen + 1) << XLP9XX_I2C_CTRL_MCTLEN_SHIFT);
-		xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, val);
+		xlp9xx_i2c_update_rlen(priv);
 	} else {
 		len = min(priv->msg_buf_remaining, len);
 		for (i = 0; i < len; i++, buf++)
-- 
1.8.3.1
