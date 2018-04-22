Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+SGg8J0bWtE84qHLuLyagH0SWSSBNsETky5Y48D2b1aE78Z+tvL5Rr+pUQNCzMP3FOZwqU
ARC-Seal: i=1; a=rsa-sha256; t=1524405332; cv=none;
        d=google.com; s=arc-20160816;
        b=t/Uog51004H7k4yi+1RUKsSvLmwherBtXDp7PLiZp2M0t8jUxvIHl6oyfyVOfh3JU2
         HNV9/n2k6Oeq9AJ2OyLMNOT9TAUexZCSpy9t23Vw/JzIEk2lMG58joDan2miX0U4WRJo
         dGLVXg5r9fLP+LrV+bHlQCFzYJBDt4RE7pARgVsik0aSd28fCevEhRYdelFWZEOCt9Di
         wOEJ99vHcutuCyqBY01W5wb/iluzeEn1acAtidrKDjhDHnI7odgdDuUtzqQe6qiXfZX9
         npWGE6YVDCpuRpMQICq5xajBkK7K+zGjJ1mLNqmtAhdYFHE2KrUdnFmwGZxEERxxzaAb
         oSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jiPDKOiA0dIH4aNGVEGGr4FgrTwOzVXF1YmpIFNKRAk=;
        b=qtJX4DiAE/IGVotrdnWpOTXLGCrF0BUiXylrE5BRXMelWXr1JIMngTHp1xeHGrUiEf
         znyIIuhg5ig0CqdMXgccqtL8v8zcxMRXLXc1hSGLj7gesb/DOiqoZIxte7oHhWuF1pt6
         wIsV4rPzJ5kEY9s3IQka0RvCQ4DODMUl/JUS5kqfKrncGsNkA/vq99qCzvTpuSN1a5PZ
         3hGz/s8F5VYiI1EXMV6XHZ7lWPWv3eBcenm4LLJo2Oy356r3CEMjVuTrgdVo5sAQWUOl
         ASlBVN84tEauxX8kuPptBVft1ZFERdA076hSS3BafnjGOKBgKejF/QuHG7rsheUrnMDf
         DnSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eugen Hristev <eugen.hristev@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.16 027/196] spi: atmel: init FIFOs before spi enable
Date: Sun, 22 Apr 2018 15:50:47 +0200
Message-Id: <20180422135105.523241803@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454845634881024?=
X-GMAIL-MSGID: =?utf-8?q?1598454845634881024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugen Hristev <eugen.hristev@microchip.com>

commit 9581329eff9db72ab4fbb46a594fd7fdda3c51b0 upstream.

The datasheet recommends initializing FIFOs before
SPI enable. If we do not do it like this, there may be
a strange behavior. We noticed that DMA does not work properly
with FIFOs if we do not clear them beforehand or enable them
before SPIEN.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-atmel.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1512,6 +1512,11 @@ static void atmel_spi_init(struct atmel_
 {
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
+
+	/* It is recommended to enable FIFOs first thing after reset */
+	if (as->fifo_size)
+		spi_writel(as, CR, SPI_BIT(FIFOEN));
+
 	if (as->caps.has_wdrbt) {
 		spi_writel(as, MR, SPI_BIT(WDRBT) | SPI_BIT(MODFDIS)
 				| SPI_BIT(MSTR));
@@ -1522,9 +1527,6 @@ static void atmel_spi_init(struct atmel_
 	if (as->use_pdc)
 		spi_writel(as, PTCR, SPI_BIT(RXTDIS) | SPI_BIT(TXTDIS));
 	spi_writel(as, CR, SPI_BIT(SPIEN));
-
-	if (as->fifo_size)
-		spi_writel(as, CR, SPI_BIT(FIFOEN));
 }
 
 static int atmel_spi_probe(struct platform_device *pdev)
