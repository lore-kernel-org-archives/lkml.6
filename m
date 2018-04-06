Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ncb8BQAB/Krfwu0nsAmNyvQX41rxNL2H+7OT97bU86rEbn4zYZ5Wu9BYlNdeXQ7RZw3eJ
ARC-Seal: i=1; a=rsa-sha256; t=1523021961; cv=none;
        d=google.com; s=arc-20160816;
        b=sPTBe/oRkoPff4dQcswwgOkCBbsZIROfcrMNAa33IjHe/2V4+94WtgZLXZv6ttZQ76
         7HBJqA2IMeJ8W7EVXriup42usGJO3FQk/4cQrOT08VWfQJuZnSHOSDn6X2wz19DFKWVZ
         uiQxKbJSL2RKrijtY31yfyyq+fem93DVK+DDIygXBf73M7XlCVpGii8bD3RCX8b9QeIg
         v1jbBSoaW6B+suWHlsum6zbH+o3IsafY3pxRqA9zrf8lLwc1M0tFZKCTTuRtfVvH3moR
         iG6lWjsKUPpXrTOdeGGJGHcVxON7IHGwX2uwQeoRf/93GUtu01DQcDy6lyvNaKnVklUY
         ghlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7n3QOIkNX2r6d6/enTJNZUSjlLuGPrXWdGbdYoKh828=;
        b=Ph3S9+0tUqHfHCFwb5t2yHWdnbXX9vZfBZaVAQENCGnVe6jPBYNMix3505WaGwpeht
         AEeAHqAoUlvjHxYJOjC0DeN9hk6ANLwaBP8TrysGh8x9odoqq5J1aAToy47Qo55iOq5K
         hInYFZnXcHZHHc4eKsl1X4iJMYwfERCeh+d0DN6rpLNNZT2odsT22I1YKYON+KP9sWuR
         5hWeOpM98j9EoBO15c+fsbGmSFQmr3OhtQl6FOMx8mt0hwumoL0iwfC/DU/676PaUzFH
         srgFbPOUte/jnNSEMBEXqmEf+c8izkBJ4HDk0bNLQLklvcf1PqPRmjMxRemBatG3eq9w
         u9Jw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eli Cooper <elicooper@gmx.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 49/67] crypto: ahash - Fix early termination in hash walk
Date: Fri,  6 Apr 2018 15:24:19 +0200
Message-Id: <20180406084347.586903877@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003644583899503?=
X-GMAIL-MSGID: =?utf-8?q?1597004276230059341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 900a081f6912a8985dc15380ec912752cb66025a upstream.

When we have an unaligned SG list entry where there is no leftover
aligned data, the hash walk code will incorrectly return zero as if
the entire SG list has been processed.

This patch fixes it by moving onto the next page instead.

Reported-by: Eli Cooper <elicooper@gmx.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/ahash.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -92,13 +92,14 @@ int crypto_hash_walk_done(struct crypto_
 
 	if (nbytes && walk->offset & alignmask && !err) {
 		walk->offset = ALIGN(walk->offset, alignmask + 1);
-		walk->data += walk->offset;
-
 		nbytes = min(nbytes,
 			     ((unsigned int)(PAGE_SIZE)) - walk->offset);
 		walk->entrylen -= nbytes;
 
-		return nbytes;
+		if (nbytes) {
+			walk->data += walk->offset;
+			return nbytes;
+		}
 	}
 
 	if (walk->flags & CRYPTO_ALG_ASYNC)
