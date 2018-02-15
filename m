Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226Gj2Q8PFKW6wcf99wHKntOYxvXvwAOXwaKMjCoG1I9VfhUcF5lmwt3TOlI8uJCkLXpOhM+
ARC-Seal: i=1; a=rsa-sha256; t=1518708831; cv=none;
        d=google.com; s=arc-20160816;
        b=OMal6LHWoXnJz+2Fh4pRItXua7Bw9/gV4zlmi/lyNBymPLOOj7oMx6WeNEPiZh+9Mv
         QSW20vFcq7l20ejmlxjl8J/wOYmIFZxF0RoytXNfTLn+Pwz2q3oVGIbqhbrnq4UpYst0
         ONjcix7xh6MGMVBtUddhKkRU9xLe1/CA+vqJA+zjKrCCPenqyo69XzRa4XjhNF/QDGRl
         EipumocvcT2pctzf7jjbSa8Epk+g2Vv8z6wM0zT7abUMgUoLDf3oZ82nJrJsn371if9c
         S2nv+/221wdXcacHyLcZ3s+RhC0Jg2h+g4+42HqoMy9+/0h0o0nbcOd4mjUBpYnBsBgl
         gZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XBc7X4LJD37wOzH33nsMXaqbNBQDwoIhXihh4zgA4r0=;
        b=UxLXuAK7OHQWpbW+FpbOkXeGpFltR5CrNfT+cMP/MW3wYaBk3y5MOskQ76gHC4Qaou
         mS/jFwHjPl2WFLWizd6d32hilskMtPwNcsY7F9HN2XCjDUAXhP7c713xf+Eiq2cEDqdg
         SLhDxwY+tnAO0ee4QNsugL5RSbUjnQCBUTzPYO+rQ3Ib4DjpBuVgcykFCMttWgF/yjOO
         2D+0HjMAZ4nECuVQYZIGjem6XuEZ1IxEmH40NXnw/zZKmLMW7t04ctJPld7+XQM7413D
         LdpWzpLIIqWnUidhhermqgLeIqHTnUd8QjJ9D2V667hqF5/r5rX87DUxI283aGh2xAND
         T4BA==
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
Subject: [PATCH 4.14 097/195] mtd: nand: Fix nand_do_read_oob() return value
Date: Thu, 15 Feb 2018 16:16:28 +0100
Message-Id: <20180215151710.545546721@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480724418157633?=
X-GMAIL-MSGID: =?utf-8?q?1592481632253626933?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2201,6 +2201,7 @@ EXPORT_SYMBOL(nand_write_oob_syndrome);
 static int nand_do_read_oob(struct mtd_info *mtd, loff_t from,
 			    struct mtd_oob_ops *ops)
 {
+	unsigned int max_bitflips = 0;
 	int page, realpage, chipnr;
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct mtd_ecc_stats stats;
@@ -2258,6 +2259,8 @@ static int nand_do_read_oob(struct mtd_i
 				nand_wait_ready(mtd);
 		}
 
+		max_bitflips = max_t(unsigned int, max_bitflips, ret);
+
 		readlen -= len;
 		if (!readlen)
 			break;
@@ -2283,7 +2286,7 @@ static int nand_do_read_oob(struct mtd_i
 	if (mtd->ecc_stats.failed - stats.failed)
 		return -EBADMSG;
 
-	return  mtd->ecc_stats.corrected - stats.corrected ? -EUCLEAN : 0;
+	return max_bitflips;
 }
 
 /**
