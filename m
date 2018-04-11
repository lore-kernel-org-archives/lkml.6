Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+r9bxR7+ggrG9EYeNADbORs+A7ztMl7AX4s+MxOfp4W6rbjW91MPGRTkQTFDwcS71+ZI6a
ARC-Seal: i=1; a=rsa-sha256; t=1523473228; cv=none;
        d=google.com; s=arc-20160816;
        b=K3Wf6gbz6Ri0jkh7BEuyH6idfA36VG+n0yHbJg4fyrQcGBKa5l4Gf+WYkOz8hz/FYN
         kmBVQ7Vuzl90pPfSr4t0fAEIeCRZr8e6DuDC0tb6/OOMOYWtrcIkheJYPMOmeQkFRshs
         jyylAjwOEVEFHMkiTanprGurU+5eVSO6G17fZrFYPvuoGA8ibpAKEX5GRvGmLpUXN5ez
         qoW5odk88psJysiOGViZ25h61Dy3kw4++99+73Y44mcMb4aZ3z/Ufxx/0QnkTmKXf/q/
         yiyQGPhXPKMA2WmXihFMju2g49NCyT2iw6TZWwvxVLCgujes9AUbLIrdhKY2lob3f95V
         OA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=G5vhFIo8gl4thYffGEJx68KdFjQcbeaOLMI9SqxbZOQ=;
        b=XAuBDeDrRYvQmtQz/i/ooMH1/4HoIR4+ZIpwaeKVkrPQsw7GG3aDACyRFA7puZbbuq
         Puvlh74LM0i28ddWDpHUTjJ8LKmTlark569EkWaSeiXvHmbXK5EmoBLhTmxqzWLB+ici
         nALY2wsoikzvuiCXQp6K2oD86cu56Zk55T9Co+AHYuq0xbgxGOFpD2F5hF0o+SNcgTtb
         BlRVSSSY63sv4eUFD1fHAwhdIF90HtWhjqofnxM/Dq0Lgi+OjkLLunz4E4SZ8hiitL6R
         w1JUUFrmRwNkustHKY9ViOVhtiDb3b9j/hxFV5801478E52nfshWI3XKUHFiDeM4dKP4
         PTEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 170/310] mtd: nand: check ecc->total sanity in nand_scan_tail
Date: Wed, 11 Apr 2018 20:35:09 +0200
Message-Id: <20180411183629.954638344@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477464231055587?=
X-GMAIL-MSGID: =?utf-8?q?1597477464231055587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>


[ Upstream commit 79e0348c4e24fd1affdcf055e0269755580e0fcc ]

Drivers are supposed to set correct ecc->{size,strength,bytes} before
calling nand_scan_tail(), but it does not complain about ecc->total
bigger than oobsize.

In this case, chip->scan_bbt() crashes due to memory corruption, but
it is hard to debug.  It would be kind to fail it earlier with a clear
message.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/nand_base.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -4785,6 +4785,11 @@ int nand_scan_tail(struct mtd_info *mtd)
 		goto err_free;
 	}
 	ecc->total = ecc->steps * ecc->bytes;
+	if (ecc->total > mtd->oobsize) {
+		WARN(1, "Total number of ECC bytes exceeded oobsize\n");
+		ret = -EINVAL;
+		goto err_free;
+	}
 
 	/*
 	 * The number of bytes available for a client to place data into
