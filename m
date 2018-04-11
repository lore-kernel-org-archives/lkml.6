Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48TWss+sP5uFtld4DoICNrGu1QTUJoCBtBtFhRZgBWz+DxwpCuu4/pLqpR+aAv9eSV2PY02
ARC-Seal: i=1; a=rsa-sha256; t=1523472960; cv=none;
        d=google.com; s=arc-20160816;
        b=djoGkjS7TzYnmSDybN+eX2hhsVC5s6HeVEMbaCwckcrNSyj+s1opovNXW/VUK4IWyE
         t5zEQG/Mf1sa/MgdnU/BVjrIL7QHdHdLvMSBQPneB3NrO+ObCLFn2r6ivI7NDbcLmaRp
         FH0SXE73niCJCcy2rLO37ffCOSne03okqJWSWqUflnejc+nn1gGaijHxHykdvD4f/2h5
         Oe9cawh3T8uBkQMMRXcf1R46JYcFwTzuAlF286tkFC47fE9vX3iOovN8hds41ReUJQJ3
         SXazeh8uUbxiQdUjG7NlgoGu7v0w/oVB0UGQfUU2iEJIGtxhmgUBGG154ukQp/f81+qC
         H1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CsCF7gtm5V/jOEe1+rg2eV9jd2dbPab19ysfIG9oC+o=;
        b=DldOSWdJb+/HjyD9jz8jjalqmBKEwFiLcKM1UVELkREOYmKKeWlZDdfX23S5rDB6uY
         YdEGh70/0cN/j4hyvu6qAUhSmgTzgr0XZmrwv0lhtgYkTO4nA067yP8lg8jPsz+TJcRS
         qw9tu4/+nc9eSSs3aMSwD0gXjumrVv9gLhTwQadiySTBY/qMtk+OD2pF+7zR7mYdfUC/
         Q/8xeH/W2dnbuJxzqaBzLKU2BoDAIL35XN8wk5ld/2n24HM+aghQmnWYqhvwsQWeAvab
         Cx1eFMYR2MGgQJdv6lJGtCpp1ihsp7MVnvYI8wPlDafn9NPl6BoR6nDXFbmSZiAoQtaC
         VWsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 079/310] ath5k: fix memory leak on buf on failed eeprom read
Date: Wed, 11 Apr 2018 20:33:38 +0200
Message-Id: <20180411183625.696218861@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476119389062447?=
X-GMAIL-MSGID: =?utf-8?q?1597477182918594579?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit 8fed6823e06e43ee9cf7c0ffecec2f9111ce6201 ]

The AR5K_EEPROM_READ macro returns with -EIO if a read error
occurs causing a memory leak on the allocated buffer buf. Fix
this by explicitly calling ath5k_hw_nvram_read and exiting on
the via the freebuf label that performs the necessary free'ing
of buf when a read error occurs.

Detected by CoverityScan, CID#1248782 ("Resource Leak")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath5k/debug.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -939,7 +939,10 @@ static int open_file_eeprom(struct inode
 	}
 
 	for (i = 0; i < eesize; ++i) {
-		AR5K_EEPROM_READ(i, val);
+		if (!ath5k_hw_nvram_read(ah, i, &val)) {
+			ret = -EIO;
+			goto freebuf;
+		}
 		buf[i] = val;
 	}
 
