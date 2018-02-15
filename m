Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Rataee/4YMaEGGylvxvgfWvRUkM94QTuy1fPPqLU2XyP0ZkxNHaLYKlN4wIGzYcLHyrQT
ARC-Seal: i=1; a=rsa-sha256; t=1518708499; cv=none;
        d=google.com; s=arc-20160816;
        b=Kk17LycoLeBEc4aLsz7sBuObrfJW7WtdhHUMqLQfx7bcGpveoLPf87iZnERUoZL3wr
         drSxLgve2YB4P2gcERGEO+PfFEyBXB9SeM3imew8Bu2+qtQeVrABECtVnUo6rZDtBfkv
         3dgXWRTfofP907Qon9Pg3naLUo3DsYjMrlJqu2AhMl5XxOzBmkTTM05A9XqFTcOxsc58
         j+QKn0NfVcQuIKAMH6gB4cTfYtTY47PP6r0+veXHXW0C8YZmNHFDmkRHjv/tD8hRTy30
         0i5cILY3Ubx/3auZuIf80YRDuazGp1qKFMGxYhZuJr62xpEUQszAXXxglnbQJiIX8Xz9
         EdrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Nw/suWV7+GX8NOWyhM1gG3SUdMIxp1htLum+V3qO5HU=;
        b=pRKN3JgQ+CtKwRYdf9RBYXGzUZ6vuoQcjZMpLy0AnW9SoSiabe2I4QZkEviWPHhKfc
         PUKp/vRCKHwrDW/2dI0xwWIhhBxGOD/POgbK28RMvA2htgDCqbx4oNR6ZiZWZzvGKfhh
         NbR3XVKglrsVhEcWHzKsTO6GaBzKclro5OQk1x1PYJDskQ8tnJ8AgjlPvFsIpdGl/sMQ
         Ti+gwKOVbNcU6E6fJds4fdLZSTQVP9oZS+ynN3TaB1Tlw3MvPdE1nqgOjOTocxtmRNAT
         GUcZ0eu6D5DlYQZqbObEOrXmL3Mpt2d80FZ0WUz55PRZ44s/NGqnbWOnFP0ijEBMKuxf
         JiJg==
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
Subject: [PATCH 4.9 17/88] mtd: nand: Fix nand_do_read_oob() return value
Date: Thu, 15 Feb 2018 16:16:44 +0100
Message-Id: <20180215151225.149162887@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480724418157633?=
X-GMAIL-MSGID: =?utf-8?q?1592481283165345127?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2320,6 +2320,7 @@ EXPORT_SYMBOL(nand_write_oob_syndrome);
 static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 			    struct mtd_oob_ops *ops)
 {
+	unsigned int max_bitflips = 0;
 	int page, realpage, chipnr;
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct mtd_ecc_stats stats;
@@ -2377,6 +2378,8 @@ static int nand_do_read_oob(struct mtd_i
 				nand_wait_ready(mtd);
 		}
 
+		max_bitflips = max_t(unsigned int, max_bitflips, ret);
+
 		readlen -= len;
 		if (!readlen)
 			break;
@@ -2402,7 +2405,7 @@ static int nand_do_read_oob(struct mtd_i
 	if (mtd->ecc_stats.failed - stats.failed)
 		return -EBADMSG;
 
-	return  mtd->ecc_stats.corrected - stats.corrected ? -EUCLEAN : 0;
+	return max_bitflips;
 }
 
 /**
