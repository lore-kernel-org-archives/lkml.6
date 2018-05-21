Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqPBSUibtNFtau0yaBGbxN+vC8Z0bvaeo8P7Heq6+1ktJNHcvaPsn7qy5/HqzHBHwEqRxfL
ARC-Seal: i=1; a=rsa-sha256; t=1526937481; cv=none;
        d=google.com; s=arc-20160816;
        b=izh1jECw5IAEJ930sY8KIf9U+g4aE8Vo2quzpRNcq3tMixXmYOimyJAFQc5ujAez4a
         aLAvl5MhAPxrFv5gviRmMmWAMU3cij2tj1ruOwTBoABLA94H0FSevaVA0TPvVQg69Elk
         yNVsRCJIrGSJJNUn6tqPMSDxHNzjHDGq7xLNgvvmhcCOR8FICT3N1MN24rHImty0jIMR
         3lcIELYtV2J0pFq63qhvztSqhpRbrjxSeu8KB29tvKG4slL8ON6CN+dQR5IoSI+iO6vW
         GLO2pTd4XebcVgygM9jZwhGTFUSJrvuD0lBOhxodOwsVLXB50u2BxCEbvw/YkWS/XBB3
         9V2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=jKsIrppvaE1iG0pQyTkbD+I1iO+AThMLRTeSTK9azRE=;
        b=P2KeJoW46AhemXFU9Sq6H/2WibgryGlE23nujIqrB1ZTwF7vy/aHus28bveVCWRxhe
         3MANkiddHHrYEFBjTl9PnEKgPvkJ+7jMV+YN/SZXpz/WKGdJKf9GcAaQpdsd0X/C8xh3
         qfBDxMhnzXiYYrhF1xszd/6nrx7tVWNX6pmk3PQ9XocNlAZuCFIfnK8WT4lzip3J4/8W
         umX8ERwyKoyorgasB4wEdH0++G5HCCPqGwsHGI06HIYbf53fi4s0yYJuePad9j75sqnF
         iIdV3+w0zUM5+r1tgq3vLDKY7IxxEANhwyqydKHZJtd0YYyODtRatVfnKEojgY5b1hYq
         kxVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=KCtHccv6;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=KCtHccv6;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kamal Dasu <kdasu.kdev@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 10/95] spi: bcm-qspi: Avoid setting MSPI_CDRAM_PCS for spi-nor master
Date: Mon, 21 May 2018 23:11:00 +0200
Message-Id: <20180521210449.522980733@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109744177472829?=
X-GMAIL-MSGID: =?utf-8?q?1601109996073523411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamal Dasu <kdasu.kdev@gmail.com>

commit 5eb9a07a4ae1008b67d8bcd47bddb3dae97456b7 upstream.

Added fix for probing of spi-nor device non-zero chip selects. Set
MSPI_CDRAM_PCS (peripheral chip select) with spi master for MSPI
controller and not for MSPI/BSPI spi-nor master controller. Ensure
setting of cs bit in chip select register on chip select change.

Fixes: fa236a7ef24048 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-bcm-qspi.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -519,16 +519,19 @@ static void bcm_qspi_disable_bspi(struct
 
 static void bcm_qspi_chip_select(struct bcm_qspi *qspi, int cs)
 {
-	u32 data = 0;
+	u32 rd = 0;
+	u32 wr = 0;
 
-	if (qspi->curr_cs == cs)
-		return;
 	if (qspi->base[CHIP_SELECT]) {
-		data = bcm_qspi_read(qspi, CHIP_SELECT, 0);
-		data = (data & ~0xff) | (1 << cs);
-		bcm_qspi_write(qspi, CHIP_SELECT, 0, data);
+		rd = bcm_qspi_read(qspi, CHIP_SELECT, 0);
+		wr = (rd & ~0xff) | (1 << cs);
+		if (rd == wr)
+			return;
+		bcm_qspi_write(qspi, CHIP_SELECT, 0, wr);
 		usleep_range(10, 20);
 	}
+
+	dev_dbg(&qspi->pdev->dev, "using cs:%d\n", cs);
 	qspi->curr_cs = cs;
 }
 
@@ -755,8 +758,13 @@ static int write_to_hw(struct bcm_qspi *
 			dev_dbg(&qspi->pdev->dev, "WR %04x\n", val);
 		}
 		mspi_cdram = MSPI_CDRAM_CONT_BIT;
-		mspi_cdram |= (~(1 << spi->chip_select) &
-			       MSPI_CDRAM_PCS);
+
+		if (has_bspi(qspi))
+			mspi_cdram &= ~1;
+		else
+			mspi_cdram |= (~(1 << spi->chip_select) &
+				       MSPI_CDRAM_PCS);
+
 		mspi_cdram |= ((tp.trans->bits_per_word <= 8) ? 0 :
 				MSPI_CDRAM_BITSE_BIT);
 
