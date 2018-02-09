Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Ic9AMf9fO6q5+iEvud7Od/s0qz32Gu34Dzrmm50p7UNjoNZev9AWqWYZ1Hh2zKmqOn6Jy
ARC-Seal: i=1; a=rsa-sha256; t=1518183927; cv=none;
        d=google.com; s=arc-20160816;
        b=RUCohVszN5t/gu0M0iFgqfhDBLZdxNy1oWeK2L/hVyKtmdjDrEsvyrj6BBGZBzyJmv
         xoLyAzMQ3S263+xuSPq3O56NgDiByuRG9I394cSG8ub/rQu5M1bpKVGehGsLLGkS9xiW
         9BA9wD97DNVPKCkLHGTMNzSrHwDIYtJP7jDMLWx6rZZVtx12AF+o0M8eQr1aBxHi5f+P
         Vz1DOdmpNAL4TVUCj/g1kgbAA6soGz2nySuPa+kcMNnIWkdcMuUyvus/HwZoU2Y1ENra
         wwoW4XgVcYKdMWbBBzX2Dat/5vBQ7YYkCh+X8kmwjVBichyupyH0qQVPeHzFCCW386kp
         RufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CE/djJHFvMN/mdrmCi1/aUHStcbFWs2FqIq9vm7rieg=;
        b=qO1tUszSIxlpYQmNBMNrZOkzts9e0XXc5kztLd6ZyCl0E7+Kl+QcN1GDXon1qX5B+r
         LaKxvnCuwtP2BZeVsb2B5KlAiFKb8dh7xknLuR5vhvJBhdE9ccJ6rKvbu7hqq242cN6K
         /mrOb/T2M2BY5PDTv1x6sVfgxrU8L8nlqNCSZ4zXV8TTHN2GM9Ni0iLvujYaKqxftCAn
         GoC1btrl7tpei5xuoAH8gHniypQc07DiOrHXwiKkDWOh1aefTxnyP+BJUPlKa26Jz/fS
         zffET9SM8fXlvwDdjC8MAoJ7g8NkMw3JNkMtR5ex5MNqotVbAqKMxKdGPdVV5R9xFBx8
         F7Mw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robert Baronescu <robert.baronescu@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
Subject: [PATCH 4.14 19/22] crypto: tcrypt - fix S/G table for test_aead_speed()
Date: Fri,  9 Feb 2018 14:40:08 +0100
Message-Id: <20180209133935.523797679@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591931177082123788?=
X-GMAIL-MSGID: =?utf-8?q?1591931230322599079?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Baronescu <robert.baronescu@nxp.com>

commit 5c6ac1d4f8fbdbed65dbeb8cf149d736409d16a1 upstream.

In case buffer length is a multiple of PAGE_SIZE,
the S/G table is incorrectly generated.
Fix this by handling buflen = k * PAGE_SIZE separately.

Signed-off-by: Robert Baronescu <robert.baronescu@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/tcrypt.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -221,11 +221,13 @@ static void sg_init_aead(struct scatterl
 	}
 
 	sg_init_table(sg, np + 1);
-	np--;
+	if (rem)
+		np--;
 	for (k = 0; k < np; k++)
 		sg_set_buf(&sg[k + 1], xbuf[k], PAGE_SIZE);
 
-	sg_set_buf(&sg[k + 1], xbuf[k], rem);
+	if (rem)
+		sg_set_buf(&sg[k + 1], xbuf[k], rem);
 }
 
 static void test_aead_speed(const char *algo, int enc, unsigned int secs,
