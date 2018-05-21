Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqzOea1PYt4wPRMLE1sqwUOg7VHLVezE8gObE+yBDVak68+ioaH8VrXF/Rkbwr1PBTDlcVM
ARC-Seal: i=1; a=rsa-sha256; t=1526937240; cv=none;
        d=google.com; s=arc-20160816;
        b=zw5BxyAjbKRpF71soiwX7mHXZf5/LsV5I6NFpGnZOWngdp5pagU1tlQ9Ln/qNLPLQW
         +TJ+nEywUi/KfhZ5FyiLOH02hjPpdNl0V6tqfujS7O2Jmm0fMW+zC02/HPi3u/YZoYFH
         nXZn9mUUusO/rPtzAu7dn6cmXQhSDrTnXu4mqx5pnbW5HsJrEn5mKYbX4DUZRzk65vE6
         bypQqkFmt1ePAbar3bTrWZfGNXc2/K8dXbTDQIIqg85NkjrnfAlqNkMezHFg9feL/2pz
         TiW64W+TGaCNQe2GBoZC7qVHrVcaEjWKOS8vlofy4Ej7dbBwanAs9b5CGF+hCILTsTtO
         Cz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=uV9N7pjYK8uJjzwfMXYEGMH+80ZYQlUlB7qx8kgS1qA=;
        b=tFuFzjBVxVhPcWMcgskjT2xcv55qr+oKhRyfXCtJ4NUQeYExx7muNWHHorcUfcFeo0
         7IO5xKeF8qqFUDykgc7U4zHmOEE80uFhpyBQbKY4a5Iwle3+wOkcjDCxyHsjoeJHFmRK
         10OfgggXeZEh+rq0y7XZRS4C0Vp/cCRepHWZQihoH8NexfqJr/NjGhGL3QIoRkhen/LF
         IyDhlfFTtg6G2xAqJRJ222oMv1SMXIFlpzxwjwuV8t+Ja1Xp53N1a035zfRNGPO6CouX
         znTPAzGzC91cfnqEdR0Q2HucJc0RhKCI+abRr/L0F4ekYZD39p7pyXi79M79aJArE3g0
         w6CA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=F7GCuFSL;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=F7GCuFSL;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kamal Dasu <kdasu.kdev@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 10/87] spi: bcm-qspi: Avoid setting MSPI_CDRAM_PCS for spi-nor master
Date: Mon, 21 May 2018 23:10:46 +0200
Message-Id: <20180521210421.189794910@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109744177472829?=
X-GMAIL-MSGID: =?utf-8?q?1601109744177472829?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -543,16 +543,19 @@ static void bcm_qspi_disable_bspi(struct
 
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
 
@@ -770,8 +773,13 @@ static int write_to_hw(struct bcm_qspi *
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
 
