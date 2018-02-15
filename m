Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227RT91GHnmBc0LiQzpOKnF/D/2j/7RGe0OmkKYMmd0PI4P4WVMcZ4KuYeNrG05hpBPDi9KO
ARC-Seal: i=1; a=rsa-sha256; t=1518707966; cv=none;
        d=google.com; s=arc-20160816;
        b=h6v4js+GYTwJtNoLGnMVfoQROu6sX/YJ99uVM7zVSSLlAkBGguGxHHc0gdxAKDAHLo
         plCxLz32iMKKty4YqYrxELvyY+dF+8u+WYp3KrOmUG7X3fB2TVIwXu7qsIy9qDlbu4OV
         NyYeTizaRtpiTXHm6OQ1eyUOcVXgbMipZnmV1uj1FzB9/37x7fwPtXYr9ylW6daqbcvp
         cqFmmUgunqsa1fyTHJGHTVhmrXBsT+6dvXJD0dzbme/YPskw56+XM28ql2tomMFkDyW5
         rPdDfuOeEqqVGxp0xlI9kHMmoqD9IIQBeyCuP+ODb5qaI8M85GPjJ2+BypY/0i6VZXRK
         SyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=y2ecDtLlUCu6sodnh213O8PwC5CwHv2hwsNPnlD8jdA=;
        b=YZ6IckGXecQPcq1jn4gdS7klET5tfAg4xb2oTod4lBAW4kdMFp4t4toBfsJ2vU/1fA
         Ue1wVE+5NgD59ycnE8/HphHypKvzfpo8x3AiYWT1kj8IfpgYX5VGPxHy6PTsJUwGmTEM
         Jf6Z+5cDX088OFyBP5Sj5PCdwJgbuWK2bg862QZaF20Ri5X3pqX7gzEREEeblwIGWxEE
         1r6G+uFN02FA0A+rQcxKkROPCgpigtKQSFuz0hYsIgVdWEsJqxJ3P/T9LwH/UeobHx1K
         UbOIkm1Qm+BBwy9wgZnuD61yLhN5/JffM231eCsNR4UgPN6brnH93BcWcmUn0VQkjlZ3
         yFvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@free-electrons.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 3.18 27/45] mtd: nand: Fix nand_do_read_oob() return value
Date: Thu, 15 Feb 2018 16:17:18 +0100
Message-Id: <20180215144121.772777702@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480724418157633?=
X-GMAIL-MSGID: =?utf-8?q?1592480724418157633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@free-electrons.com>

commit 87e89ce8d0d14f573c068c61bec2117751fb5103 upstream.

Starting from commit 041e4575f034 ("mtd: nand: handle ECC errors in
OOB"), nand_do_read_oob() (from the NAND core) did return 0 or a
negative error, and the MTD layer expected it.

However, the trend for the NAND layer is now to return an error or a
positive number of bitflips. Deciding which status to return to the user
belongs to the MTD layer.

Commit e47f68587b82 ("mtd: check for max_bitflips in mtd_read_oob()")
brought this logic to the mtd_read_oob() function while the return value
coming from nand_do_read_oob() (called by the ->_read_oob() hook) was
left unchanged.

Fixes: e47f68587b82 ("mtd: check for max_bitflips in mtd_read_oob()")
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/nand_base.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -1872,6 +1872,7 @@ static int nand_write_oob_syndrome(struc
 static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 			    struct mtd_oob_ops *ops)
 {
+	unsigned int max_bitflips = 0;
 	int page, realpage, chipnr;
 	struct nand_chip *chip = mtd->priv;
 	struct mtd_ecc_stats stats;
@@ -1932,6 +1933,8 @@ static int nand_do_read_oob(struct mtd_i
 				nand_wait_ready(mtd);
 		}
 
+		max_bitflips = max_t(unsigned int, max_bitflips, ret);
+
 		readlen -= len;
 		if (!readlen)
 			break;
@@ -1957,7 +1960,7 @@ static int nand_do_read_oob(struct mtd_i
 	if (mtd->ecc_stats.failed - stats.failed)
 		return -EBADMSG;
 
-	return  mtd->ecc_stats.corrected - stats.corrected ? -EUCLEAN : 0;
+	return max_bitflips;
 }
 
 /**
