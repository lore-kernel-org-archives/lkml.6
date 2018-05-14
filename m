Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpMFa3G4B6gFUl7AyXmDhmMMupDbvCeCfdEL0E3wDLwRgJruqmu4dVhwBwrqf+wSnSYKxdv
ARC-Seal: i=1; a=rsa-sha256; t=1526280660; cv=none;
        d=google.com; s=arc-20160816;
        b=Nk4+ZiPY/yqHoGP+whZUW8Hue02mqrzRfkqULWoxKF8f+RjmdYr+VLJegRMbfhzaXW
         mfooxEFERPe0YYEj/fc7NRQLyiFlQWUaMne2CFS5I2/pN/uXHjQIO+uSo/02p1OLLsK9
         7z952LCiaHoU1V0TO+i0F5Z5P+rH3T0c+p/oe9QqpNJgspddNK82UXJ+ZR+NUczp0MKL
         C2+OS4zWcPupYA228T7H6i/DUWWsqfZnIAQ0CZE3mp9oVmA9QHs8RrX90VqFrTQmmIed
         +kk4O6AITcXmcVm5aZ2Jb6Lzf4w2kB+vccsK8xgsw1C9uEOWMfGuNlP8CcIdENVNwOBS
         O+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=4bpoFyvsKVejTAK8I0RH8f2hTvLWdLc61EGijFdqck0=;
        b=teY4KM5UFSZehuT2HWN6Zj2Eb0ykxDcHjsf69nYwyYheAWC7IHaYSA3x9/7q3zp3FX
         x1pg68+njok2Km+AZS1x1F+9H9RnI5Cl059FHlxUts/nAWHQ0izySh85T9imRhZT4hRh
         MUJfj7Db+glu8jJzbGjA113XwcpoAITjppt12C5t6SM7AKks7Fm6qY/WGBMDMWpSXpSw
         qS/O3G5QWFdnlvCFUPTQUSpHc3hOD6/3jpws/azO3DboFtrlCtfo3DvdRJvRxdfz9GWt
         AzycugLENpUobFToG5oU4qawjzXJGgIMVLar2lVjqCsIca4MvGmDH9NYe25uDH3qMatY
         O3Vw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XciqZukR;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XciqZukR;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Markus Pargmann <mpa@pengutronix.de>,
	Stefan Christ <s.christ@phytec.de>,
	Han xu <han.xu@nxp.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 4.4 10/56] gpmi-nand: Handle ECC Errors in erased pages
Date: Mon, 14 May 2018 08:48:15 +0200
Message-Id: <20180514064756.042499971@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421270063918783?=
X-GMAIL-MSGID: =?utf-8?q?1600421270063918783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Pargmann <mpa@pengutronix.de>

commit bd2e778c9ee361c23ccb2b10591712e129d97893 upstream.

ECC is only calculated for written pages. As erased pages are not
actively written the ECC is always invalid. For this purpose the
Hardware BCH unit is able to check for erased pages and does not raise
an ECC error in this case. This behaviour can be influenced using the
BCH_MODE register which sets the number of allowed bitflips in an erased
page. Unfortunately the unit is not capable of fixing the bitflips in
memory.

To avoid complete software checks for erased pages, we can simply check
buffers with uncorrectable ECC errors because we know that any erased
page with errors is uncorrectable by the BCH unit.

This patch adds the generic nand_check_erased_ecc_chunk() to gpmi-nand
to correct erased pages. To have the valid data in the buffer before
using them, this patch moves the read_page_swap_end() call before the
ECC status checking for-loop.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
[Squashed patches by Stefan and Boris to check ECC area]
Tested-by: Stefan Christ <s.christ@phytec.de>
Acked-by: Han xu <han.xu@nxp.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   78 ++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 5 deletions(-)

--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1032,14 +1032,87 @@ static int gpmi_ecc_read_page(struct mtd
 	/* Loop over status bytes, accumulating ECC status. */
 	status = auxiliary_virt + nfc_geo->auxiliary_status_offset;
 
+	read_page_swap_end(this, buf, nfc_geo->payload_size,
+			   this->payload_virt, this->payload_phys,
+			   nfc_geo->payload_size,
+			   payload_virt, payload_phys);
+
 	for (i = 0; i < nfc_geo->ecc_chunk_count; i++, status++) {
 		if ((*status == STATUS_GOOD) || (*status == STATUS_ERASED))
 			continue;
 
 		if (*status == STATUS_UNCORRECTABLE) {
+			int eccbits = nfc_geo->ecc_strength * nfc_geo->gf_len;
+			u8 *eccbuf = this->raw_buffer;
+			int offset, bitoffset;
+			int eccbytes;
+			int flips;
+
+			/* Read ECC bytes into our internal raw_buffer */
+			offset = nfc_geo->metadata_size * 8;
+			offset += ((8 * nfc_geo->ecc_chunk_size) + eccbits) * (i + 1);
+			offset -= eccbits;
+			bitoffset = offset % 8;
+			eccbytes = DIV_ROUND_UP(offset + eccbits, 8);
+			offset /= 8;
+			eccbytes -= offset;
+			chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset, -1);
+			chip->read_buf(mtd, eccbuf, eccbytes);
+
+			/*
+			 * ECC data are not byte aligned and we may have
+			 * in-band data in the first and last byte of
+			 * eccbuf. Set non-eccbits to one so that
+			 * nand_check_erased_ecc_chunk() does not count them
+			 * as bitflips.
+			 */
+			if (bitoffset)
+				eccbuf[0] |= GENMASK(bitoffset - 1, 0);
+
+			bitoffset = (bitoffset + eccbits) % 8;
+			if (bitoffset)
+				eccbuf[eccbytes - 1] |= GENMASK(7, bitoffset);
+
+			/*
+			 * The ECC hardware has an uncorrectable ECC status
+			 * code in case we have bitflips in an erased page. As
+			 * nothing was written into this subpage the ECC is
+			 * obviously wrong and we can not trust it. We assume
+			 * at this point that we are reading an erased page and
+			 * try to correct the bitflips in buffer up to
+			 * ecc_strength bitflips. If this is a page with random
+			 * data, we exceed this number of bitflips and have a
+			 * ECC failure. Otherwise we use the corrected buffer.
+			 */
+			if (i == 0) {
+				/* The first block includes metadata */
+				flips = nand_check_erased_ecc_chunk(
+						buf + i * nfc_geo->ecc_chunk_size,
+						nfc_geo->ecc_chunk_size,
+						eccbuf, eccbytes,
+						auxiliary_virt,
+						nfc_geo->metadata_size,
+						nfc_geo->ecc_strength);
+			} else {
+				flips = nand_check_erased_ecc_chunk(
+						buf + i * nfc_geo->ecc_chunk_size,
+						nfc_geo->ecc_chunk_size,
+						eccbuf, eccbytes,
+						NULL, 0,
+						nfc_geo->ecc_strength);
+			}
+
+			if (flips > 0) {
+				max_bitflips = max_t(unsigned int, max_bitflips,
+						     flips);
+				mtd->ecc_stats.corrected += flips;
+				continue;
+			}
+
 			mtd->ecc_stats.failed++;
 			continue;
 		}
+
 		mtd->ecc_stats.corrected += *status;
 		max_bitflips = max_t(unsigned int, max_bitflips, *status);
 	}
@@ -1062,11 +1135,6 @@ static int gpmi_ecc_read_page(struct mtd
 		chip->oob_poi[0] = ((uint8_t *) auxiliary_virt)[0];
 	}
 
-	read_page_swap_end(this, buf, nfc_geo->payload_size,
-			this->payload_virt, this->payload_phys,
-			nfc_geo->payload_size,
-			payload_virt, payload_phys);
-
 	return max_bitflips;
 }
 
