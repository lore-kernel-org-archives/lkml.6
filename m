Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZogTj6Qkm0/vw0vhHJJjQgJM6RgbPLdeVUhRrtnfsIySFge/EmpkD7hobSqFkmtJnFPPZeg
ARC-Seal: i=1; a=rsa-sha256; t=1525116501; cv=none;
        d=google.com; s=arc-20160816;
        b=xLNGbe411FzjOP+/vamAI5kuaVOKDEk7VtchCn07QeQ3qLxN5ZF19q2N9yqrzfn16b
         LFKKmIJMTzJbx0jxf/ZeEpZ0F6ub+eotRSKJnLLK7ru4vMkvtFgLOG/4ujDfY4boKiY2
         ErQY/0p0JKopypjcSHRZppq388c2VBeWM/K6Gj3dSVAD2nF9lbR3jQUPcS0R7wC6Ifoy
         n/x2vCWJIHwvTBreZ0st1wkOz3UM936a2GM5mhBNFDvDmPg89C0mTn0qz4B+zcvvezdL
         90IqnZyulcQ64KbzqoSZT1dEMOk+mUGay5oM5sNPu1/NlDD/yJ/rwp0/788771Muj7LO
         LINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ianx270AN/l8UszCWfMBt/b/cDsMdQd2EPpkhiYGyZQ=;
        b=FhTRQCsb1uBmxz/VCEobY8+c0vL5XatxLtSeevp6UdQXDW16FKpUIt8Quy5FUkRDq5
         f4QLF8dX/f3qLGA+knBbRxyKwnQOVa0l8zgzSYz9+XyaBGIbuNlLLTrkqRMxk80qRbZu
         iiQVIvwbb4GV2+pTWbpAAaC6+VF3KKUI3OE5TZBRLB8ldAeAHALcVWuIjgXS5YfmbhQt
         p+KbwMAxVyTamjWmyX1w2ow2cMMkIVmp8DJ7IYvylDTPy2l3elCcElxyk1F8BizWk4JE
         zh1g0ORZ+l2ll1UZhiJcsbFYxlJbCEO4h81Dhehbqm1q1xNUjXd/P4Q6xjJnXhvnVREO
         3kuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CDD22DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thor Thayer <thor.thayer@linux.intel.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.16 054/113] mtd: spi-nor: cadence-quadspi: Fix page fault kernel panic
Date: Mon, 30 Apr 2018 12:24:25 -0700
Message-Id: <20180430184017.343577956@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200497469699470?=
X-GMAIL-MSGID: =?utf-8?q?1599200560315066477?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thor Thayer <thor.thayer@linux.intel.com>

commit 47016b341fc3b3fd4909e058c6fa38f165b53646 upstream.

The current Cadence QSPI driver caused a kernel panic when loading
a Root Filesystem from QSPI. The problem was caused by reading more
bytes than needed because the QSPI operated on 4 bytes at a time.
<snip>
[    7.947754] spi_nor_read[1048]:from 0x037cad74, len 1 [bfe07fff]
[    7.956247] cqspi_read[910]:offset 0x58502516, buffer=bfe07fff
[    7.956247]
[    7.966046] Unable to handle kernel paging request at virtual
address bfe08002
[    7.973239] pgd = eebfc000
[    7.975931] [bfe08002] *pgd=2fffb811, *pte=00000000, *ppte=00000000
</snip>
Notice above how only 1 byte needed to be read but by reading 4 bytes
into the end of a mapped page, an unrecoverable page fault occurred.

This patch uses a temporary buffer to hold the 4 bytes read and then
copies only the bytes required into the buffer. A min() function is
used to limit the length to prevent buffer overflows.

Request testing of this patch on other platforms. This was tested
on the Intel Arria10 SoCFPGA DevKit.

Fixes: 0cf1725676a97fc8 ("mtd: spi-nor: cqspi: Fix build on arches missing readsl/writesl")
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/spi-nor/cadence-quadspi.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -501,7 +501,9 @@ static int cqspi_indirect_read_execute(s
 	void __iomem *reg_base = cqspi->iobase;
 	void __iomem *ahb_base = cqspi->ahb_base;
 	unsigned int remaining = n_rx;
+	unsigned int mod_bytes = n_rx % 4;
 	unsigned int bytes_to_read = 0;
+	u8 *rxbuf_end = rxbuf + n_rx;
 	int ret = 0;
 
 	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
@@ -530,11 +532,24 @@ static int cqspi_indirect_read_execute(s
 		}
 
 		while (bytes_to_read != 0) {
+			unsigned int word_remain = round_down(remaining, 4);
+
 			bytes_to_read *= cqspi->fifo_width;
 			bytes_to_read = bytes_to_read > remaining ?
 					remaining : bytes_to_read;
-			ioread32_rep(ahb_base, rxbuf,
-				     DIV_ROUND_UP(bytes_to_read, 4));
+			bytes_to_read = round_down(bytes_to_read, 4);
+			/* Read 4 byte word chunks then single bytes */
+			if (bytes_to_read) {
+				ioread32_rep(ahb_base, rxbuf,
+					     (bytes_to_read / 4));
+			} else if (!word_remain && mod_bytes) {
+				unsigned int temp = ioread32(ahb_base);
+
+				bytes_to_read = mod_bytes;
+				memcpy(rxbuf, &temp, min((unsigned int)
+							 (rxbuf_end - rxbuf),
+							 bytes_to_read));
+			}
 			rxbuf += bytes_to_read;
 			remaining -= bytes_to_read;
 			bytes_to_read = cqspi_get_rd_sram_level(cqspi);
