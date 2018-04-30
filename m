Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrGaVBfHh4Ui3OdXLhsmoRdE29zJx4tQUrgCHZ1ugEaICa2rJq3Ca0Z9nFuwDQm7RtCpWeS
ARC-Seal: i=1; a=rsa-sha256; t=1525116441; cv=none;
        d=google.com; s=arc-20160816;
        b=a376O+ulah7vZNcsHFgsNlc4MQB/wVkcrlPcuroelunfnNq8KiaFkSLvLkzkrpfRH7
         XEskZ4xqb9/HEC11W+D5w1y7ZnogPYQl2MY/m7FDTN/ICyE9YKs7vds3avsy4kpcp3IB
         fDNfjT/5ZcoSGv8KplKNA+pqsvu9Sy+z2lZRA5ybyvogHZIcxPb9qzE0aPmrh39KIUd0
         vH6xgnxxK1JcqoOguqS4zoo4qKSO7mt+0Yh5LEkXTbHwlXLZCnFbYm3qiB1l7VYBMfdD
         69t5qSZ9UeDziRpTqzysC8D6lXxuny77EMJtCDMKYHw3nhmZ8nlcWwj9o6bkywyBy/q2
         6vjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=YaVp98QCZezH7UIQVSegWVrd1bs/PO4h0aeWlmTdpX0=;
        b=Uh8MJ9sydv7WSiMjzRPMX2VhfTwBVOhyqfR3naECf55JNY1bie9r2Q8zfku0TvkvkQ
         46vdxWcwE3mgCKkylhwLFxaHq/Z2QjiLcdJ7pKNIdjT8YuV1UjvwoAYUlyE/kynBoQIP
         dWP+KGJakVNqz5TEWeAikj0KUSQ5d6H/ZuiLHOSAVwxDW3q26kZjYN049tIoVYcFAIrX
         Y/pS5EV/473mhnV48sSsNkVqwyOtLCAAva+PIpqku987xAVmpVFHRhe9W3ZFTGVO4nfP
         necKMMfk48esXOskiZCzdgZnM2CV7yRNC3G3H7tASn68vlI5Uai0dOggo3UUA/3Z+s6X
         x2BQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC53922DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thor Thayer <thor.thayer@linux.intel.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.14 50/91] mtd: spi-nor: cadence-quadspi: Fix page fault kernel panic
Date: Mon, 30 Apr 2018 12:24:32 -0700
Message-Id: <20180430184006.796020072@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200497469699470?=
X-GMAIL-MSGID: =?utf-8?q?1599200497469699470?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -495,7 +495,9 @@ static int cqspi_indirect_read_execute(s
 	void __iomem *reg_base = cqspi->iobase;
 	void __iomem *ahb_base = cqspi->ahb_base;
 	unsigned int remaining = n_rx;
+	unsigned int mod_bytes = n_rx % 4;
 	unsigned int bytes_to_read = 0;
+	u8 *rxbuf_end = rxbuf + n_rx;
 	int ret = 0;
 
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
@@ -523,11 +525,24 @@ static int cqspi_indirect_read_execute(s
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
