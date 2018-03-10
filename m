Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuOD/ltf4Pt2Ij9DzlVASnvkeO75a3/zLzkHMSqth4jJmJ8G9Upnc7/XJRjJio9lRD5qDT2
ARC-Seal: i=1; a=rsa-sha256; t=1520641294; cv=none;
        d=google.com; s=arc-20160816;
        b=qnW6PMsUBQflf278IO4AVUINSn42mH7ToxmG/VAOkP8Z4mobF3vrEy3PJDPqhZKjQl
         XMV84bAu4PbLIYhCJ9NZpJmjJoS3BMj2Wu4Tp8/lesOcCQU6LDZlZzXzDNxGTchAd1Lj
         Oq6Vhvqu590mAh3N3+vWCUvaCJylmSFGE3Pelz2T09TMj1+W/c8KiqqRfJHdn2vz4s6/
         gfz1ht9NMioWO7nksIz/VkIG97eIcR1eNit1NsCgreUur50qfc8v85Wh8aTLBwoo7Yvk
         Bn75yCUO+k4WikNw+mm1YQin1dFJsB4MMwyE9m1YrmwFkfdP50FH/9Cb5Jgc2N1uVLWe
         eu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Y8dvhkHF0JjPTZ911vmBPmvHAZKfD3hJSVVtubd24C0=;
        b=KlfhWYEVMvMBfzty96iebUUXnX6B5S/82bKMJEdaoNJNL4YNbktUy1sl0yLwihw/rT
         OkownswVX1U8ke4tDCLCPHrWlrv204uYQJVv/u7SN1J2t2IVfw14V0OzUd8HfbTjZP58
         hkNt2HaHoqjAubH+VKl2WO+uJuPgGGZg85lsxB+U11yQJGwU82rLXnMixDvzt6Knw7po
         CJd3Z4A0mcIa3ihgROE62/8qE/2ndU4yF5mhU6v1i2VKK17vuggP5Mz6KT8DpN95/SYg
         HHjFTuZI6U57yDWldTxWOkZgHmdq+FD+gGn5jrLqRgWd1CVF9riaBNqgXrDfZyp4k0qt
         wlLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH 4.9 06/65] tpm_tis_spi: Use DMA-safe memory for SPI transfers
Date: Fri,  9 Mar 2018 16:18:06 -0800
Message-Id: <20180310001825.441937872@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507966072032310?=
X-GMAIL-MSGID: =?utf-8?q?1594507966072032310?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Steffen <Alexander.Steffen@infineon.com>

commit 6b3a13173f23e798e1ba213dd4a2c065a3b8d751 upstream.

The buffers used as tx_buf/rx_buf in a SPI transfer need to be DMA-safe.
This cannot be guaranteed for the buffers passed to tpm_tis_spi_read_bytes
and tpm_tis_spi_write_bytes. Therefore, we need to use our own DMA-safe
buffer and copy the data to/from it.

The buffer needs to be allocated separately, to ensure that it is
cacheline-aligned and not shared with other data, so that DMA can work
correctly.

Fixes: 0edbfea537d1 ("tpm/tpm_tis_spi: Add support for spi phy")
Cc: stable@vger.kernel.org
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm_tis_spi.c |   45 ++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -47,9 +47,7 @@
 struct tpm_tis_spi_phy {
 	struct tpm_tis_data priv;
 	struct spi_device *spi_device;
-
-	u8 tx_buf[4];
-	u8 rx_buf[4];
+	u8 *iobuf;
 };
 
 static inline struct tpm_tis_spi_phy *to_tpm_tis_spi_phy(struct tpm_tis_data *data)
@@ -72,14 +70,14 @@ static int tpm_tis_spi_transfer(struct t
 	while (len) {
 		transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);
 
-		phy->tx_buf[0] = (in ? 0x80 : 0) | (transfer_len - 1);
-		phy->tx_buf[1] = 0xd4;
-		phy->tx_buf[2] = addr >> 8;
-		phy->tx_buf[3] = addr;
+		phy->iobuf[0] = (in ? 0x80 : 0) | (transfer_len - 1);
+		phy->iobuf[1] = 0xd4;
+		phy->iobuf[2] = addr >> 8;
+		phy->iobuf[3] = addr;
 
 		memset(&spi_xfer, 0, sizeof(spi_xfer));
-		spi_xfer.tx_buf = phy->tx_buf;
-		spi_xfer.rx_buf = phy->rx_buf;
+		spi_xfer.tx_buf = phy->iobuf;
+		spi_xfer.rx_buf = phy->iobuf;
 		spi_xfer.len = 4;
 		spi_xfer.cs_change = 1;
 
@@ -89,9 +87,9 @@ static int tpm_tis_spi_transfer(struct t
 		if (ret < 0)
 			goto exit;
 
-		if ((phy->rx_buf[3] & 0x01) == 0) {
+		if ((phy->iobuf[3] & 0x01) == 0) {
 			// handle SPI wait states
-			phy->tx_buf[0] = 0;
+			phy->iobuf[0] = 0;
 
 			for (i = 0; i < TPM_RETRY; i++) {
 				spi_xfer.len = 1;
@@ -100,7 +98,7 @@ static int tpm_tis_spi_transfer(struct t
 				ret = spi_sync_locked(phy->spi_device, &m);
 				if (ret < 0)
 					goto exit;
-				if (phy->rx_buf[0] & 0x01)
+				if (phy->iobuf[0] & 0x01)
 					break;
 			}
 
@@ -113,8 +111,14 @@ static int tpm_tis_spi_transfer(struct t
 		spi_xfer.cs_change = 0;
 		spi_xfer.len = transfer_len;
 		spi_xfer.delay_usecs = 5;
-		spi_xfer.tx_buf = out;
-		spi_xfer.rx_buf = in;
+
+		if (in) {
+			spi_xfer.tx_buf = NULL;
+		} else if (out) {
+			spi_xfer.rx_buf = NULL;
+			memcpy(phy->iobuf, out, transfer_len);
+			out += transfer_len;
+		}
 
 		spi_message_init(&m);
 		spi_message_add_tail(&spi_xfer, &m);
@@ -122,11 +126,12 @@ static int tpm_tis_spi_transfer(struct t
 		if (ret < 0)
 			goto exit;
 
-		len -= transfer_len;
-		if (in)
+		if (in) {
+			memcpy(in, phy->iobuf, transfer_len);
 			in += transfer_len;
-		if (out)
-			out += transfer_len;
+		}
+
+		len -= transfer_len;
 	}
 
 exit:
@@ -192,6 +197,10 @@ static int tpm_tis_spi_probe(struct spi_
 
 	phy->spi_device = dev;
 
+	phy->iobuf = devm_kmalloc(&dev->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL);
+	if (!phy->iobuf)
+		return -ENOMEM;
+
 	return tpm_tis_core_init(&dev->dev, &phy->priv, -1, &tpm_spi_phy_ops,
 				 NULL);
 }
