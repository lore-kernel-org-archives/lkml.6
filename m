Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518412608; cv=none;
        d=google.com; s=arc-20160816;
        b=a4s7xAh3VUKXq02AgXg4DUVwSEyfSblI/Tq6aCCxKehZ/t+MBYnZ3zDp6OGzX32kfn
         0iFTpCxdHAxoq4s48S607uBCI6omWKECugPlOjj+xyZUcfqspXSnw1+ylnkTR0Xen5Kn
         IASezfgSYG+2kIT5INHFLGbSi1y0HFk3gSdDnvFYlWTaFpiYRZ7MJQ0mIIS/z4ggehnH
         r60Y24zEUFDSc1DorxQOWVPL50C/axGUktKR1J5s1e2xWhiSRrzfq264gx6+N8Z7FtAZ
         ESzb7hZgd8X5EklUnnUZZMkzRVJyMSGCWA2W0OQHlxK12AetK/sTqCxwuRRNbukJlB6d
         t73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=fVb/4ZYwd0aQQdz/78YYDB4VKsqTJlQtipgZ6TsbkJY=;
        b=aViDUchWVuDtAvPdAEo32hoCFHekR9Gg6eWgtgBH492vsB6Z6xUkPgIxU6ZgdgGVb3
         /JO0tD6o6+UEBU2ewwKH1bjVmo2qYecW3SYjubJx8wy766n6jmmVObqZwN//TFsCV58q
         M7hABdbKtkcuIqsH5ugjMf3RaV/o+f50HF20e5Da0S9R1Cdb9NoGU4NwWfhVkUc4UDWO
         9b3d5Z1eWlwQPhnUQmYwMZeFGQLf4wLuS235TJA5nYOtDo/y4n4mS5M/vIB6i+TGyqWZ
         mfdTDsgvaNjWOglH7kmGrGyX0N9ARu0XQ8NBvMg82PH7yzDjSHJ/7v80ht+cikhzBCV8
         Vp0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=se5a8H40;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=se5a8H40;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x225zSdQWaEJanUPrSwDfkXZ0MVjC3ExbTs9dYYSAYLaemUm2i4Q2tRxL/Kb5L7f4ydF6Pj2ykw==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Eddie James <eajames@us.ibm.com>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christopher Bostic <cbostic@linux.vnet.ibm.com>,
	Brad Bishop <bradleyb@fuzziesquirrel.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 04/10] fsi: Fix one and two byte bus reads/writes
Date: Mon, 12 Feb 2018 15:45:43 +1030
Message-Id: <20180212051549.8575-5-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212051549.8575-1-joel@jms.id.au>
References: <20180212051549.8575-1-joel@jms.id.au>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592171018968868483?=
X-GMAIL-MSGID: =?utf-8?q?1592171018968868483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Eddie James <eajames@us.ibm.com>

Address checker fixed to allow one and two byte reads/writes.
Address alignments for each size verified.

Signed-off-by: Edward James <eajames@us.ibm.com>
Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 6e5aa9b26665..e5dfece248a5 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -656,10 +656,13 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 /* FSI master support */
 static int fsi_check_access(uint32_t addr, size_t size)
 {
-	if (size != 1 && size != 2 && size != 4)
-		return -EINVAL;
-
-	if ((addr & 0x3) != (size & 0x3))
+	if (size == 4) {
+		if (addr & 0x3)
+			return -EINVAL;
+	} else if (size == 2) {
+		if (addr & 0x1)
+			return -EINVAL;
+	} else if (size != 1)
 		return -EINVAL;
 
 	return 0;
-- 
2.15.1
