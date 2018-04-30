Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZriEq/ESA7UyGkBbk+IG9qXL2rwxp1TSZXce0nOOWPiJ/6apFfAq57Qx0eEO4YJq2BhOI9T
ARC-Seal: i=1; a=rsa-sha256; t=1525116518; cv=none;
        d=google.com; s=arc-20160816;
        b=VeC83oBlKWAjFrO7rBEZ1mevPQqOrJigJiYgCxlyhoCGPe8mci4pRadZueEuIxwa+j
         FwFE22ncjD2qHsZawGPAHKq4wInnjuXfadKF/xKUVsKMtbtIciFeWujEGDaSaVNYzurm
         Xz0tUBbSJRDZO6pPN6R7fL0JrFtuV46qGCyVvi27k4rucFq8ATNKYdFsUYC/3jR+1SSv
         QkNkTNboBX0dVWfhEDxeY6XBDqpKHOyJydmbxVEvCWVBdGQXPr0KCt+/o71IycDPjb/f
         P3vHRcxl4KbKSFOscfmqnt+IXLeXSglOw1sYF8SNs+a+wlz+mROCIPV/DWBKGjcud0XK
         MEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=u6tvxNPqdiq+QSxrCPOUS6/9Ap6Pj67O6IG6eYZbxGI=;
        b=ufKKcHJNtbBbhxxMq43LOFa+ewgbIBqF2a5Htl8p7rregP8h1nf5V79Qf/tS8mDqNH
         /ozEJ6e88NWZ8P40wTJ3JCrmNTXXu9Kk12D8Cu54wc8J1PGk4jSuH4Fco336s7UmeTFe
         fwMB+Rm/3Z6MTQ9B+Hl1vy/PeOQV8sSw3fenyLn5x/ViG4HRDhYgbBo2fJviBwTsyz6B
         HsEXaSe5Puxt8PzWAQf3ufnmn1FraSw2UNuY3V3W8SlgD2WGMt2j6b8PYnQ/OaO36Rzd
         z/f3mbsXSaBl8bKMUjDws4atkJXYJ/VHdviZD1CaVAeERqCLTN1eVhtmbelz8CSYPN6o
         3NHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C5122DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stephan Mueller <smueller@chronox.de>,
	syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.16 083/113] crypto: drbg - set freed buffers to NULL
Date: Mon, 30 Apr 2018 12:24:54 -0700
Message-Id: <20180430184018.696347574@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200468155576446?=
X-GMAIL-MSGID: =?utf-8?q?1599200578664915087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephan Mueller <smueller@chronox.de>

commit eea0d3ea7546961f69f55b26714ac8fd71c7c020 upstream.

During freeing of the internal buffers used by the DRBG, set the pointer
to NULL. It is possible that the context with the freed buffers is
reused. In case of an error during initialization where the pointers
do not yet point to allocated memory, the NULL value prevents a double
free.

Cc: stable@vger.kernel.org
Fixes: 3cfc3b9721123 ("crypto: drbg - use aligned buffers")
Signed-off-by: Stephan Mueller <smueller@chronox.de>
Reported-by: syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/drbg.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1134,8 +1134,10 @@ static inline void drbg_dealloc_state(st
 	if (!drbg)
 		return;
 	kzfree(drbg->Vbuf);
+	drbg->Vbuf = NULL;
 	drbg->V = NULL;
 	kzfree(drbg->Cbuf);
+	drbg->Cbuf = NULL;
 	drbg->C = NULL;
 	kzfree(drbg->scratchpadbuf);
 	drbg->scratchpadbuf = NULL;
