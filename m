Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpfj2R9NBrBRAPrdeiFgo6MifcGT28Q2HBOUPWKNqwq+mkxBAgzro4nfRxBaqr3brO1zRrP
ARC-Seal: i=1; a=rsa-sha256; t=1526281164; cv=none;
        d=google.com; s=arc-20160816;
        b=mj4Wgo02tioJUmo2UgZi+b9uMbodw8tIU8aQncG5d0S3dDkIufmHbt/HYyqzSmmn7k
         UF9QPQso1EiQbb5qTcQ/N0zfM031mPaLhC42oSXKaqXJZglMxFwr7Zqq3Z7ukM+zDe6z
         hX4f5NjYqhtEwvXPtV3ZMYvx/2JyDVeHBI33GRCVJ4dWYyrzlAzlTBYbV5P6tydqu+Tn
         enRr/ek9DARCcogXFOZTCWeyGbvQfK1JhFbeyYuGGRLT9urVlFRcsjceDiUCKpIFihgo
         zsLyOOAcoPH25t75bospeeHO388DJ2t8Abksz61UgekO1+xJ6ABYULur4J/qBs8L9Dz9
         2acA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=LR/Y05Ur6lG4rVd3g8YiojBiPiFENRFPTe7bwPx10oo=;
        b=iwCG8VQf6rN0BH8dZ+2ouQoKiYWhUvS1tcbZWg1gCjmT3Qe/H+7hZchNBIEQme/g2S
         FXTF2DWtOLvZ1lq49Eq1viIG77ch3zfFskZeUuLA1yNtFdZeYKWYXl64yRWz4BuivC2W
         aArgvBySCiclrnrz12xtnxUeG4wUU4BAPpaGc2OroZtGqOh2QpfDfj7DSpl/5pHr24o1
         UOp2/nA2aujBQsXGqVcQQhbueyh+ybz3Jni1ILSkNMXzGuGJxmpMmGEqZAZvAKlAR6tB
         9tlzU0GCF9TgPtjIn28W2acgssk6oGjQJCY6XLuIZCpVbGX+4vGWOyKFC3bOCnGSpY/M
         vCIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oPWEeukP;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oPWEeukP;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Boris Brezillon <boris.brezillon@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.16 41/72] mtd: rawnand: Make sure we wait tWB before polling the STATUS reg
Date: Mon, 14 May 2018 08:48:58 +0200
Message-Id: <20180514064824.942453369@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421798169787074?=
X-GMAIL-MSGID: =?utf-8?q?1600421798169787074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 3057fcef385348fe85173f1b0c824d89f1176f72 upstream.

NAND chips require a bit of time to take the NAND operation into
account and set the BUSY bit in the STATUS reg. Make sure we don't poll
the STATUS reg too early in nand_soft_waitrdy().

Fixes: 8878b126df76 ("mtd: nand: add ->exec_op() implementation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/nand_base.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -707,12 +707,17 @@ static void nand_wait_status_ready(struc
  */
 int nand_soft_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
 {
+	const struct nand_sdr_timings *timings;
 	u8 status = 0;
 	int ret;
 
 	if (!chip->exec_op)
 		return -ENOTSUPP;
 
+	/* Wait tWB before polling the STATUS reg. */
+	timings = nand_get_sdr_timings(&chip->data_interface);
+	ndelay(PSEC_TO_NSEC(timings->tWB_max));
+
 	ret = nand_status_op(chip, NULL);
 	if (ret)
 		return ret;
