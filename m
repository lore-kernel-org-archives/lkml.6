Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtrOPdBaYjr+gzFLB/leJQwUfHNONUkC3bJRKM8uHjwryDk02s4MxzbljsoSi8M/hhd9IGV
ARC-Seal: i=1; a=rsa-sha256; t=1519981166; cv=none;
        d=google.com; s=arc-20160816;
        b=tWt3F17AI2aXkVlEXKOgua6v55UMuB7Y1YBJA/yu+r6cHvmJ97E8dL0erJZwwQXGz8
         /nIeYRLprW5JgP4Ht6yy9bRCR9FV2Te0tVVknYvf16GCawA05//RQNqCKdadA7IUxbEB
         On43asMkpQt91mpiACXfm6ElX1AZEicThv/xQnzeQ9p9eJEVKIfZ7kY7Cjiy/YlfRRoY
         FYl1sksN4nIdd92FRvJLwlcPTt+AVJ02XUh88enhvteDlN9He/fBhqPXa8VnJmtEvi4I
         ApZirT+yQL+rX0wE+hwGRMPork9fBRNlDwJ4BwtUXcGWvcCSfKSO4c374iigxKcYlD6M
         PS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6TjwoxVeqhsSwjBZ/BGA2wT/CWbOkLYGycdrN2Pt6fI=;
        b=xa7C8OfkfQTQ9EzjRdTFxL1dzeI9Uk87RUIVpXAqf80WVVC6EqHP5K08uChWqPvkZV
         zPSUhs+zfsCLFdWoa7cULcqZO/+RveiKIy28ACQtmx7+rnH8T0GsYJJibd1sD52+gvuK
         YdWK3Xr2ZwJjQ6QQOdi06iMyzK4939R6qQv0hrvrhH6VNsfN6wy7wu3DPKLiNdYBam+K
         RvgxIn6JtQ7cjywMnMY8+v6eQmrOgCgmX4WJP8v6rol5YOhMlgSd6tqiqBMgC3TSMbEg
         OKeSNSV8cmPxCa1nxc4McpcaZDFOvElAx5Je2oPzuyiVvlcXChEmtUt9A1VUxmw1dRkK
         fR9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Albert Hsieh <wen.hsieh@broadcom.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 013/115] mtd: nand: brcmnand: Zero bitflip is not an error
Date: Fri,  2 Mar 2018 09:50:16 +0100
Message-Id: <20180302084504.401552359@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815582710886048?=
X-GMAIL-MSGID: =?utf-8?q?1593815771732708691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Albert Hsieh <wen.hsieh@broadcom.com>


[ Upstream commit e44b9a9c135727f3410e029910275f40681dc8bc ]

A negative return value of brcmstb_nand_verify_erased_page() indicates a
real bitflip error of an erased page, and other return values (>= 0) show
the corrected bitflip number. Zero return value means no bitflip, but the
current driver code treats it as an error, and eventually leads to
falsely reported ECC error.

Fixes: 02b88eea9f9c ("mtd: brcmnand: Add check for erased page bitflip")
Signed-off-by: Albert Hsieh <wen.hsieh@broadcom.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/brcmnand/brcmnand.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1763,7 +1763,7 @@ try_dmaread:
 			err = brcmstb_nand_verify_erased_page(mtd, chip, buf,
 							      addr);
 			/* erased page bitflips corrected */
-			if (err > 0)
+			if (err >= 0)
 				return err;
 		}
 
