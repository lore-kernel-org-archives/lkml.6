Return-Path: <George.Cherian@cavium.com>
X-Google-Smtp-Source: AB8JxZoUoLMjyjwvAx2V96EFxG2PFyB2LpkHitH8DJkfTUWZLL+PAO6e8VlsQdb5mUhPQ1hJ/u0z
ARC-Seal: i=1; a=rsa-sha256; t=1526454037; cv=none;
        d=google.com; s=arc-20160816;
        b=kq01dEcN/5jmGn+/MEnjD81rMID/nCuz05UxTQ8hYKZUry8y8SrD60+aQMGcfDhDon
         +/SG7BmbVh4EiRlqdi4QDW//yook4xqnGiLDEAJdB1SQajXmEMMnRAjN1quFIhf+o3a0
         Rb+lKzxIfTsZZB/5rrjGvLSEQY1kgbTPJOrwTZSGqWz8oI/ivh6h05Ww87iBOwhijXH6
         4WNNEUY939bV3Tgx2UyELFrBB+0NGhdqlnoM088+X1zfuKlHjhjFYt5wD2jm+0xlA0nN
         nIgW22Lqrg2dzq86LfFZ3PELSf7fs2T6t5CDmNyYwpJ3C7NNvxzyirE1Onim70FZSwiT
         /Vkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=S470/0nQlB6DEgPiBwVPQAb1IOYF+artCcN5xslRfBg=;
        b=WIpWLbTfMmBOssUc6ia+HXFBkuVThSsmKrZti2qjm7IK/nAvtn3hhFPemMLlY8AxtP
         BqT4TxU3vk+cOZGIRLTXF2eeIPmc3AsEwmUOBxq4hHPxCcaW6iz0h8O2fQfXivc7qRZS
         qj7hy1eaVCPFkO7VmvwBfwLQL8oakImPOEynxLDrVjq9PqEahHyeAnDzCWiXnYb/zEC0
         D9W72qNGe0vLJ+33/UN5KtvFDTBf/aCfPh2aGcvBmFSkXPYIJ5hCNFDtmSt6Cv+F6r5N
         crtbf3+t/e6X52sJl2CO7etqlrNkEGU+vAhu95dFTl1ei+GA9o84bcpzSK1GPl+k0O91
         zE9A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@CAVIUMNETWORKS.onmicrosoft.com header.s=selector1-cavium-com header.b=lTVbMmYY;
       spf=pass (google.com: domain of george.cherian@cavium.com designates 104.47.38.82 as permitted sender) smtp.mailfrom=George.Cherian@cavium.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@CAVIUMNETWORKS.onmicrosoft.com header.s=selector1-cavium-com header.b=lTVbMmYY;
       spf=pass (google.com: domain of george.cherian@cavium.com designates 104.47.38.82 as permitted sender) smtp.mailfrom=George.Cherian@cavium.com
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
Subject: [PATCH 3/4] i2c: xlp9xx: Make sure the transfer size is not more than I2C_SMBUS_BLOCK_SIZE
Date: Wed, 16 May 2018 00:00:18 -0700
Message-Id: <1526454019-32714-4-git-send-email-george.cherian@cavium.com>
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
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;3:sXf4ZqHmpqhl4t8iHvJ9rI/Yo2zOd4oFmfUkBFkHLnPqpyBY0aGT57MwOqKFm3++8uLV+kuWZlZfWHZWXBCPBEEkjNLKuUbK2BQCZrTdooz2QLsUemtVaV3oVXshAj0dXC92om/kBUMJQMPrUHNyxut5uVPOzWdoeyyHu6DUIZQvJwu/d54QjpVoJG2otMX2g9owcpvg1zv2AHx9px0jfllbgfieoEs14z5GtAESWpDZyP3w2zbloy99JArtAQHN;25:Nzeeqm4PaGY6wVX6OgwV7lSkwQIo9VNRci+cHU5u/y0vQBFnbOQUxnBjugPpc3Oo18LfvhSVzB/dIgWzNJ32TGLMPRK+2xL+dS6N6Q23KQTDvwCFR5zniCwqijN+yjH9vg7YEq4utR4Hy+aeiFHpYJl0AcrRT2XEKbOD3l8EYUgVHtiJEQVDvQ+u5SHj85DkEwd705K5fD8BcsUwSWprxrgygfk7wlTYvWs8JRX2CAvdy0Bp0qRi+gtsGW1AKMlPTY1OkelehMq5voqgNqLqb6JDsslopuNHo9KtMbH90bUwBlqe+j1mr71do1FIi2gbUxWj8J4Qx+69i/3Eah1b2Q==;31:p9E0HO0e959OT0fJ3B8tuvle175tLc7LU4gkjqLNfj0DdPugnW/zZLIHZNETtlVCO7juBbVl+/iTSXomQFLJ8vlvvNlUOOJyfbFZQSfkrY2azCZeVHJl/s7PPcpWE2F6c4/SEdBbUOsmMLSj9dJdCcLreRc5h8wrqUY90SsauIyvi4z3hiZPQkrSD+mFpXnN7YagIyu6A+xhes1ZbpyBMo81HFWEztkkyfPMYCTT57Y=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4926:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;20:WpMvuYl/V0PqJHEhWqbGuOPIDDc99F/C1QcjMsIt4G0x83/GcQ9SfJPJR1G9FIdJwjlJbsArS0jlujtAZbQexWcpuMjR0lbcXj9Y5sph0Nrn6aO/D+XJcllrRu0ZxEze4p7t9JooSHSCuGgzA7GOzVoqc4fnPkBGq1Xk4hyxvMEoLOJyrXDV7EwNGMAV8UDkYeNM/scRbxMhUK/pgZW9NcBvcaJqQXbd7yT1ATpOUaMTJKfUKadrQiivRJZ6oWcWiIbJfd+MgOYSaTGSOkOYLKHFSKLTdSOhopBTokBDg/HxbGj9c2BR0QAlRd71rawFiy+705yUvVoCiZpR9+FLjghoBsJr4E3tTji58SLp9sqh8OLqd+3DNazTM/7tvdXxK2BLZmyYotnBPt3SsVQFbdLuJy1COYX1dS5Wk1zQNVjhkUYeqleZ1bzC4zSzgu2RZ18NSGoXdtwOBrqV/mI9chdg6LnxBVfe8Wz30PR4DPOeNSdwdOsh8eZAmgQshM41;4:DhW610k2L6J7sWLs2OIGK6rtOzjhilcDa+rvmxuraUxsIfNNnEFzydS5o6D4fIuDSGtp4qTTJ1jos5EahYhFpsbFEUcqunm64DzhxoLZQ4TEurHzCpjSlGckxsk7/xcQ9ChBxZS7jW1Bqmtu+O3Dlk3ysEX4FhueGcguL6Gz6vxeKXVBCQKgBIiMbfM/wHQcuBJ93SIY+4rRAg5+hDf6uXvI9QUU/onwwuSLVr04GKdSSnTLclhlq8OMd+meP/KwQIcFiJaN5AV4TAKqzP6WXQ==
X-Microsoft-Antispam-PRVS: <SN6PR07MB492681C9AA5D5DFAF1A25BE6F9920@SN6PR07MB4926.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN6PR07MB4926;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4926;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(44832011)(50226002)(7736002)(50466002)(105586002)(486006)(53416004)(36756003)(8936002)(106356001)(5660300001)(186003)(48376002)(316002)(6486002)(25786009)(16526019)(16586007)(305945005)(4720700003)(68736007)(446003)(6666003)(72206003)(478600001)(476003)(2616005)(3846002)(6116002)(956004)(11346002)(97736004)(4326008)(59450400001)(52116002)(51416003)(76176011)(2906002)(26005)(66066001)(47776003)(6512007)(81166006)(81156014)(6506007)(386003)(15760500003)(69596002)(53936002)(86362001)(107886003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4926;H:sbr2s-28.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4926;23:PtK7pkNP7x2pT0f5XCc5aKuwjW62nwupqQEfH/fBM?=
 =?us-ascii?Q?8iQ0CeLLgeo6N/AShT38b1wPplrt57YVPHOPPwHYLSljp3JYXqH5X6A1hkUo?=
 =?us-ascii?Q?h7Xjgt/q+sFYaqzupEMZQVr1BCsY4ehLT247F/oTp+K4/Pd8vfurv7ITC208?=
 =?us-ascii?Q?wkjUDRQDbt3D2ZMDhu4TIUOYC8hxcXErnON2D6JRKvjIFR9TwAshOhbHbl8N?=
 =?us-ascii?Q?NqptlvZua7U3Iu9MuUs/wojqBdrmejtEbqxubdpcE7SUKfAAO5zn5MM3aJIt?=
 =?us-ascii?Q?IIqWj7bcauj2/DBX02aLcL/xhaSn0T4pUO3BhdgL5uwG5OC8kwvEmnTzB2/l?=
 =?us-ascii?Q?izb14MpqeeOqN+83y/Z+a11wW21/n9mxV1oEB5kdk3oScN2o043h0JsIBC0Y?=
 =?us-ascii?Q?xeK/xQJFaXBdlUDO/B/d3JliT2kxNHNC56ceavp7SAkF2KxXpnariymRQn6a?=
 =?us-ascii?Q?DLLDFbdRGLSKIBliJNYem/NhJaSAwD9UwBgQTdC/pZB/4eI68TMhqj9CKoGk?=
 =?us-ascii?Q?E1h1fBsPaRdjgWdV87ISk75+mTHGUXoT/Vw9Lja3FhmoouoyKat+6uP33s4Z?=
 =?us-ascii?Q?qwdCtCByBwg+nO3GxkZKBQEeQ5Ktw/L8updds+ciD0rAoxgT7iXY6ohIst5O?=
 =?us-ascii?Q?VTAnzqqF23Ile7KN4pdgDiTo91BsGuDelymUW35SquDGmwmp2FzT4S3jNdgI?=
 =?us-ascii?Q?1oefT0mWsUWBB6lvx0DS7DJs/LUhc7LJtNJHJRbbF6IEtNkb51l1J8meI8QF?=
 =?us-ascii?Q?I5QNbWGhNhmxKaZHBJptZHKX1kvkNY1+w9bQJcemREOLRd3F+9ci0isYo4kg?=
 =?us-ascii?Q?bgXhhvo02r+qG99lfW5SKIVZyNDWJKCtiJHk08GwXGv/Qv9ju2kDCxF1HJc2?=
 =?us-ascii?Q?RuEYeg5Jzkmdj6lghSwxCSiGxJIkaq5eNt6IdDCI8Ipi2Va4VxLIAAoE8FYH?=
 =?us-ascii?Q?/74UsjoHuumWhXxty6i0p23f6gCgTb/YBbdUKGPTDfuJhZ+O+B6JdvFLO3Xo?=
 =?us-ascii?Q?CTSQANZNbZOlxr9dXa1EAI6YZ7SxNgAVt60o0wdWg9Nl7oTo1OZ01fuFrPU2?=
 =?us-ascii?Q?0kRSeBVjhIDEeOnRfPoUah9/5uH8QeGisEv6f9J+ejb4ToPqyIIZDGwy55nd?=
 =?us-ascii?Q?5HQoMOlpYQw5q3NdnLee4ODMj92ICgviRCAd9uMySfWi1NrEyG3zPyOHHFpQ?=
 =?us-ascii?Q?OwfFGd3GRoE12+yNuj1Be7BukENKt4mFagpsXk8JB34ZxsSDCQnIZdTT9WQN?=
 =?us-ascii?Q?7uca5o7X+TbxMSSdoEyQo3ODIVufqn2FdxZPzcDpNZR2wA5JixyM+kEknkwP?=
 =?us-ascii?Q?34woLmcRTLUgNiq8KuM8orbbYBqlzkkd2h8g5oKI+jV4EH93hIQoCS+42HYx?=
 =?us-ascii?Q?lJABA=3D=3D?=
X-Microsoft-Antispam-Message-Info: b1EPZg3S6gGzZ8Rbz5UJXMLEQmol3Pm6o+d1UTyYgyAJ4Ur6fEY+uUluMGYaUOk9aGoSKCfXRjH3MQnvOo+9wkRT/fLawR5/ts1B/JDBxiMB1rPpv2hm64SNg/R4YNlMN2e9QuaFBF1M72QXhTItjLtR+S3P3IhiGlCERqTlLDzAMVOgqdjOXhSUxAwUwvPi
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;6:qDAKsL1AOrjposTcwae7wMfG6yXvn7ef/T53mArzWPx2fU0Yq1Cw2jW14kzlB5k6zJuPL9b9dfPP08bYU7ZECybs/c4FTp58rMWUz5KThN5VcwkT8sqb9ZAEXvJbUH6qp2cJmjRc7W6ZdI+Szk1oY4D+88AUxBjk4BZHbRTQ4em3d9moQcZNLD8c1+CJ+oosUKC0b+o3QxZlIZJmafiA4zMlA15xlRNNfNpa51EzHB9T+NyqMncOB1HzLchNRfVRMjFQ86rdqCwjGoDNjoFBiIkesSQtf/zQCgnXgCKHylhGXfIeWcdV7fu/YOVDbZJmIkzV9BNnhTo6rImvy56QBBbMtwTkqz5djyI0sb//BXH1O9al7EcvbrRFNoZV4hV7yQP9qSzVpWBOd9rTzhdy2/S+qRGbIpdZaEljRUZe1xbaK54D+usy4bHVce/eXckWHCLIFHelP5HZktqZz2N/iw==;5:IRldvgdWlbRqgaFYrbnGWAoZeNmAvmHgxMgbWXPoRkV4XJc/Gh1PqqoTkZ/5F0Tx1Kc9TFloZ9Lr8y24YXS/IX5pCxkzvzzpX6qDriCLk0ZhVOrPpZz6cFSm2h5mYXzY/WbxwXWNpPsaGfAeX7Lkr8mvAePx59Cqb8jLBR/c1Ic=;24:lPGGRPlcwaEHdQjibQldWJ6QK0LnYTvKlU8C8nnf4ZGFsz516uWSbeVSv9lbKEs2g8l4XeeR1mNzPe9InH2kEu504T8Hh8/tLAXsHMbRTws=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;7:hCg5/L0bGyUPb8HPU31Wtldd0W8frCwdVPfCRrbk5qsTOz05SdnOEm26GNsG7JVXjDzKELHd4kueGD0LONMrP4/Gzr6TS4t8J4TPetKzmyUBODP9/ojN2q0EeHvalLesUXNKztqeMhL8kqIka/xG4EL0xTv8VzAs295fxlMJPM+SQVNgxNpYYxcU2/BFcy7MhLssCx3U4W6Q6jA75ja5ZIKDG4iZj5TQhsMiuNesqBmvT64V/bUm2kTROkGmK8a8
X-MS-Office365-Filtering-Correlation-Id: b6b4a8db-15c4-48bb-02dd-08d5bafab986
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 07:00:35.4527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b4a8db-15c4-48bb-02dd-08d5bafab986
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4926
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600603068971402571?=
X-GMAIL-MSGID: =?utf-8?q?1600603068971402571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For SMBus transactions the max permissible transfer size is
I2C_SMBUS_BLOCK_SIZE. It is possible that some clients might
not follow it strictly occasionally.
This would lead to stack corruption if the driver copies more than
I2C_SMBUS_BLOCK_SIZE bytes. Add a check to avoid such conditions.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index c268fde..1f41a4f 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -172,6 +172,8 @@ static void xlp9xx_i2c_update_rlen(struct xlp9xx_i2c_dev *priv)
 	len = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_FIFOWCNT) &
 				  XLP9XX_I2C_FIFO_WCNT_MASK;
 	len = max_t(u32, priv->msg_len, len + 4);
+	if (len >= I2C_SMBUS_BLOCK_MAX + 2)
+		return;
 	val = (val & ~XLP9XX_I2C_CTRL_MCTLEN_MASK) |
 			(len << XLP9XX_I2C_CTRL_MCTLEN_SHIFT);
 	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CTRL, val);
@@ -189,14 +191,20 @@ static void xlp9xx_i2c_drain_rx_fifo(struct xlp9xx_i2c_dev *priv)
 	if (priv->len_recv) {
 		/* read length byte */
 		rlen = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_MRXFIFO);
-		*buf++ = rlen;
-		if (priv->client_pec)
-			++rlen;
-		/* update remaining bytes and message length */
-		priv->msg_buf_remaining = rlen;
-		priv->msg_len = rlen + 1;
-		priv->len_recv = false;
+		if (rlen > I2C_SMBUS_BLOCK_MAX || rlen == 0) {
+			rlen = 0;	/*abort transfer */
+			priv->msg_buf_remaining = 0;
+			priv->msg_len = 0;
+		} else {
+			*buf++ = rlen;
+			if (priv->client_pec)
+				++rlen; /* account for error check byte */
+			/* update remaining bytes and message length */
+			priv->msg_buf_remaining = rlen;
+			priv->msg_len = rlen + 1;
+		}
 		xlp9xx_i2c_update_rlen(priv);
+		priv->len_recv = false;
 	} else {
 		len = min(priv->msg_buf_remaining, len);
 		for (i = 0; i < len; i++, buf++)
@@ -315,10 +323,6 @@ static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev *priv, struct i2c_msg *msg,
 	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_MFIFOCTRL,
 			     XLP9XX_I2C_MFIFOCTRL_RST);
 
-	/* set FIFO threshold if reading */
-	if (priv->msg_read)
-		xlp9xx_i2c_update_rx_fifo_thres(priv);
-
 	/* set slave addr */
 	xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_SLAVEADDR,
 			     (msg->addr << XLP9XX_I2C_SLAVEADDR_ADDR_SHIFT) |
@@ -337,9 +341,13 @@ static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev *priv, struct i2c_msg *msg,
 		val &= ~XLP9XX_I2C_CTRL_ADDMODE;
 
 	priv->len_recv = msg->flags & I2C_M_RECV_LEN;
-	len = priv->len_recv ? XLP9XX_I2C_FIFO_SIZE : msg->len;
+	len = priv->len_recv ? I2C_SMBUS_BLOCK_MAX + 2 : msg->len;
 	priv->client_pec = msg->flags & I2C_CLIENT_PEC;
 
+	/* set FIFO threshold if reading */
+	if (priv->msg_read)
+		xlp9xx_i2c_update_rx_fifo_thres(priv);
+
 	/* set data length to be transferred */
 	val = (val & ~XLP9XX_I2C_CTRL_MCTLEN_MASK) |
 	      (len << XLP9XX_I2C_CTRL_MCTLEN_SHIFT);
@@ -393,8 +401,11 @@ static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev *priv, struct i2c_msg *msg,
 	}
 
 	/* update msg->len with actual received length */
-	if (msg->flags & I2C_M_RECV_LEN)
+	if (msg->flags & I2C_M_RECV_LEN) {
+		if (!priv->msg_len)
+			return -EPROTO;
 		msg->len = priv->msg_len;
+	}
 	return 0;
 }
 
-- 
1.8.3.1
