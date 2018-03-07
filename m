Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELur3/nlmuchM4OZKhb9uLtcVN0iPkuaLE6L/vubZAaMtiU8yKrbnUe1maF/rAPr86E9rwfO
ARC-Seal: i=1; a=rsa-sha256; t=1520451889; cv=none;
        d=google.com; s=arc-20160816;
        b=kfbnGGpL1oCuCaOZYdqh7ZFJ8j1XfV5zEmGAcWArH36hJXipj3VMxFox+nTZ6ObMy5
         YlqsA1XttzWNuj+btnF7m3p8aTV+PQ3Tad90dLgOrKNkPXp40hrAakwW2KHinweqB2I6
         6nHfwFB+49rvcN5PiO+v6x8Z/p2M8SaUP6Agx/qVUR3nfSORWMMEZ0xHe3YS0q+SSE3z
         OE6ZwIX8KG3XKs2kCIpchccmt6EcKmishf22acs+G2aWQsOzN1+UW25ClKTIdoCuIy9U
         X5VHORGjln529MtqfDE7NDB5gN4NsGmI+bMdjN/mVsviHExWcqveiEcuJOkcJqrVwHHs
         HxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VfIz+Ok6XdIqvvnuFq2bWf1MMScaYO6Y1POzcvm7tUQ=;
        b=z64Dbr53nC6LlKVIFDkRPszaFHkJKk9d/zRtFCZHHEv+/cdfNuSiAdUG8hvHiq8Y0c
         unGpJKVXlMfDxzIAJ6+mUtyrwHHyRU2fZGdotyn96/2Rih/Iz5xta6ti91kidYfq0U/V
         m+bzQ7jKAg4xf26VynsJZFBxE6ErLK6d1l5SxA3PrnO1x09yKopmT0LbR+bgyKiw1npH
         d/jPaW6LplsLCc4ezLCXeV+I2SpfBSlN4x6/NGhepxbywarBIpEt4M3ROThswow9CBcW
         z+KnpwE3eI2yn+Y2hLihRG8J8QcjAX9o8Znv0Ok1eUo/wNEXpbd1f2MbfD7zEgK54h4m
         jK0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.14 008/110] tpm: constify transmit data pointers
Date: Wed,  7 Mar 2018 11:37:51 -0800
Message-Id: <20180307191040.818351912@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309360359900468?=
X-GMAIL-MSGID: =?utf-8?q?1594309360359900468?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit c37fbc09bd4977736f6bc4050c6f099c587052a7 upstream.

Making cmd_getticks 'const' introduced a couple of harmless warnings:

drivers/char/tpm/tpm_tis_core.c: In function 'probe_itpm':
drivers/char/tpm/tpm_tis_core.c:469:31: error: passing argument 2 of 'tpm_tis_send_data' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
  rc = tpm_tis_send_data(chip, cmd_getticks, len);
drivers/char/tpm/tpm_tis_core.c:477:31: error: passing argument 2 of 'tpm_tis_send_data' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
  rc = tpm_tis_send_data(chip, cmd_getticks, len);
drivers/char/tpm/tpm_tis_core.c:255:12: note: expected 'u8 * {aka unsigned char *}' but argument is of type 'const u8 * {aka const unsigned char *}'
 static int tpm_tis_send_data(struct tpm_chip *chip, u8 *buf, size_t len)

This changes the related functions to all take 'const' pointers
so that gcc can see this as being correct. I had to slightly
modify the logic around tpm_tis_spi_transfer() for this to work
without introducing ugly casts.

Cc: stable@vger.kernel.org
Fixes: 5e35bd8e06b9 ("tpm_tis: make array cmd_getticks static const to shink object code size")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm_tis.c      |    2 +-
 drivers/char/tpm/tpm_tis_core.c |    4 ++--
 drivers/char/tpm/tpm_tis_core.h |    4 ++--
 drivers/char/tpm/tpm_tis_spi.c  |   25 +++++++++++--------------
 4 files changed, 16 insertions(+), 19 deletions(-)

--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -223,7 +223,7 @@ static int tpm_tcg_read_bytes(struct tpm
 }
 
 static int tpm_tcg_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
-			       u8 *value)
+			       const u8 *value)
 {
 	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
 
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -253,7 +253,7 @@ out:
  * tpm.c can skip polling for the data to be available as the interrupt is
  * waited for here
  */
-static int tpm_tis_send_data(struct tpm_chip *chip, u8 *buf, size_t len)
+static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int rc, status, burstcnt;
@@ -344,7 +344,7 @@ static void disable_interrupts(struct tp
  * tpm.c can skip polling for the data to be available as the interrupt is
  * waited for here
  */
-static int tpm_tis_send_main(struct tpm_chip *chip, u8 *buf, size_t len)
+static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int rc;
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -98,7 +98,7 @@ struct tpm_tis_phy_ops {
 	int (*read_bytes)(struct tpm_tis_data *data, u32 addr, u16 len,
 			  u8 *result);
 	int (*write_bytes)(struct tpm_tis_data *data, u32 addr, u16 len,
-			   u8 *value);
+			   const u8 *value);
 	int (*read16)(struct tpm_tis_data *data, u32 addr, u16 *result);
 	int (*read32)(struct tpm_tis_data *data, u32 addr, u32 *result);
 	int (*write32)(struct tpm_tis_data *data, u32 addr, u32 src);
@@ -128,7 +128,7 @@ static inline int tpm_tis_read32(struct
 }
 
 static inline int tpm_tis_write_bytes(struct tpm_tis_data *data, u32 addr,
-				      u16 len, u8 *value)
+				      u16 len, const u8 *value)
 {
 	return data->phy_ops->write_bytes(data, addr, len, value);
 }
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -57,7 +57,7 @@ static inline struct tpm_tis_spi_phy *to
 }
 
 static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
-				u8 *buffer, u8 direction)
+				u8 *in, const u8 *out)
 {
 	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
 	int ret = 0;
@@ -71,7 +71,7 @@ static int tpm_tis_spi_transfer(struct t
 	while (len) {
 		transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);
 
-		phy->tx_buf[0] = direction | (transfer_len - 1);
+		phy->tx_buf[0] = (in ? 0x80 : 0) | (transfer_len - 1);
 		phy->tx_buf[1] = 0xd4;
 		phy->tx_buf[2] = addr >> 8;
 		phy->tx_buf[3] = addr;
@@ -112,14 +112,8 @@ static int tpm_tis_spi_transfer(struct t
 		spi_xfer.cs_change = 0;
 		spi_xfer.len = transfer_len;
 		spi_xfer.delay_usecs = 5;
-
-		if (direction) {
-			spi_xfer.tx_buf = NULL;
-			spi_xfer.rx_buf = buffer;
-		} else {
-			spi_xfer.tx_buf = buffer;
-			spi_xfer.rx_buf = NULL;
-		}
+		spi_xfer.tx_buf = out;
+		spi_xfer.rx_buf = in;
 
 		spi_message_init(&m);
 		spi_message_add_tail(&spi_xfer, &m);
@@ -128,7 +122,10 @@ static int tpm_tis_spi_transfer(struct t
 			goto exit;
 
 		len -= transfer_len;
-		buffer += transfer_len;
+		if (in)
+			in += transfer_len;
+		if (out)
+			out += transfer_len;
 	}
 
 exit:
@@ -139,13 +136,13 @@ exit:
 static int tpm_tis_spi_read_bytes(struct tpm_tis_data *data, u32 addr,
 				  u16 len, u8 *result)
 {
-	return tpm_tis_spi_transfer(data, addr, len, result, 0x80);
+	return tpm_tis_spi_transfer(data, addr, len, result, NULL);
 }
 
 static int tpm_tis_spi_write_bytes(struct tpm_tis_data *data, u32 addr,
-				   u16 len, u8 *value)
+				   u16 len, const u8 *value)
 {
-	return tpm_tis_spi_transfer(data, addr, len, value, 0);
+	return tpm_tis_spi_transfer(data, addr, len, NULL, value);
 }
 
 static int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
