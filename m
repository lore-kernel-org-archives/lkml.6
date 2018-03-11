Return-Path: <kernel-hardening-return-12399-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtuyOM3z5MQsocghEsVbgBIf0PWYCeWUzEb1KGGF4vH+xAyAmQevj9vzaFHS5skua/97Ihv
ARC-Seal: i=1; a=rsa-sha256; t=1520802468; cv=none;
        d=google.com; s=arc-20160816;
        b=S7LBMvssjiBOh28vVWMUKHuXK51OfKlRzRshtZjTuim0sWslspqKoKZfzHkmgU2CzS
         RTqnbMz81WZGM7PNpB4uC3DhSfs9JnlBIU9LeCZXLOFaKFEJr5xyCYI7Ek464+bOlSzK
         KYBSJ5cD/mDq10d0Rl2t+hCVx5rRwCe2MVwlYl6R5aCBYm9CjqDlwQFpF+cCG1u+GHUf
         +gIkJf9DTmqu/UL75t+DURVoEqNh9/fwM5nlQgUERXobJ4fhWX+T8dk+albwru/PHQZy
         58ZIESofa06kun9W6DUyBHQgaHJaCNpoLZ6utaoaVyDG+vGen6Yfh9KICQ9NHukfzp0A
         HujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=IGB6nkPQgX3yqXCkeD1VdUirwB6pmWYWcRVr3//tO5M=;
        b=z4fYWHm8ePAR8Z7+ucBnKjQYoop2aCqy7B31XsAYThCh8TxveQkvOHraaJamIHllk5
         nmoxyHphszV1+O6KukZ2Ns1wB8hPQbsffzUqnCF1H/L1xktocjrMxn81/2s4qIL2VJDE
         TyQgSA496+zjSKjn70b70dA/v7k0m956AiVq9E82IL4yS08IvNiZJDLT1R97jcOqJFJS
         XLmbQaltxd3mZ/c1+By4uj3tfPhLnf4EXxsbZE/lnj97zFQ24pG2mX1OYr5knSVJh8V0
         1eLrQbUYgn9QmbzKGmEVTRRUEQ3BmeabmeMSI30X0ESX0uybh/mu+BBYS3kxnzFrcmw3
         E/Ig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PdPVoicm;
       spf=pass (google.com: domain of kernel-hardening-return-12399-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12399-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PdPVoicm;
       spf=pass (google.com: domain of kernel-hardening-return-12399-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12399-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com,
	linux-scsi@vger.kernel.org,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Dario Ballabio <ballabio_dario@emc.com>,
	Kees Cook <keescook@chromium.org>,
	Salvatore Mesoraca <s.mesoraca16@gmail.com>
Subject: [PATCH] scsi: eata: drop VLA in reorder()
Date: Sun, 11 Mar 2018 22:06:58 +0100
Message-Id: <1520802418-17284-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594676969721761588?=
X-GMAIL-MSGID: =?utf-8?q?1594676969721761588?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

n_ready will always be less than or equal to MAX_MAILBOXES.
So we avoid a VLA[1] and use fixed-length arrays instead.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 drivers/scsi/eata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/eata.c b/drivers/scsi/eata.c
index 6501c33..202cd17 100644
--- a/drivers/scsi/eata.c
+++ b/drivers/scsi/eata.c
@@ -2096,7 +2096,7 @@ static int reorder(struct hostdata *ha, unsigned long cursec,
 	unsigned int k, n;
 	unsigned int rev = 0, s = 1, r = 1;
 	unsigned int input_only = 1, overlap = 0;
-	unsigned long sl[n_ready], pl[n_ready], ll[n_ready];
+	unsigned long sl[MAX_MAILBOXES], pl[MAX_MAILBOXES], ll[MAX_MAILBOXES];
 	unsigned long maxsec = 0, minsec = ULONG_MAX, seek = 0, iseek = 0;
 	unsigned long ioseek = 0;
 
-- 
1.9.1
