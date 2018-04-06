Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+PsXnxKoGzJ4Dc5ai6MPLbpjUl/aMYOu8ATvvniyXHWPOByr1a+Uzi2F7evQdpow+yHmiO
ARC-Seal: i=1; a=rsa-sha256; t=1523021764; cv=none;
        d=google.com; s=arc-20160816;
        b=sbh9cyaLxDCtCzBb/hGuSrX546DsRjxtbO6puaurs4QX3cOgLB+jmFv6ZMUnf8VmT8
         g+++5lbPUMCFztkFXi91QTaLTwr5twPRUCsOv84yOEATnahrrEARKHehMkew76MEIdCS
         x2bOHkxgx4ZR/dAXKtDexDJC/70PCjKrmrd66otSQx0G1/xayLIo4RWOgTnh27jNoceV
         aM0jIzJLTQ4/gG+m6sAq5UaOFEnkeEzoGeuoC0jEDvk5YF5kGm1MX/P1WeM7T3v664G8
         rH6Yca4NvyyQ+plIjof8GEbCQsmXI6B0IL30ijyhSbfsnfOGAtmSiT1flbVqx8jA7rNI
         61/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LPPEhJhSWvLCytud4rARW1UJuvOaP8WRdGLOvCzXIJA=;
        b=agejT0ZCcSHE8X/mEP+KswHq9wdB3UkctwgqoKU1Cs0zsft1fgsVPAROMeDmA6ME9T
         NFzz/a77XpD/zrYNJYJegcpU87jqhUGOQXmgC69Yjjpbqvl+eiAKBjdFR5pLZWOWyxfu
         Bk2/OSPBVzOzn0V8OWTIW/v40ai8UQHzegDW/AKWZgllBzMLQ/dZ/BxyARwRSuTLMCgz
         kszv11+bxkeA/RMRgRaWj8WoUJ2lnHgl1Xy2L0/EXDPOSg9bz41jMCt4cqgyut/t/YPb
         ZZSwqqTBbvL99nLZUfftCu1X8SiIHmxLYS4/dfZLMM3HfsysoJufy+pM6TJlsA6z6D4V
         R9zA==
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
Subject: [PATCH 4.9 083/102] crypto: ahash - Fix early termination in hash walk
Date: Fri,  6 Apr 2018 15:24:04 +0200
Message-Id: <20180406084343.115461865@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003644583899503?=
X-GMAIL-MSGID: =?utf-8?q?1597004069559087579?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -91,13 +91,14 @@ int crypto_hash_walk_done(struct crypto_
 
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
