Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+QnFcmQ60haRhcc9Y6HOIvttmz4SziH+2V2GxyhDVV2eedbZVeiCYnFXOXBl/igGyBWX1V
ARC-Seal: i=1; a=rsa-sha256; t=1523021546; cv=none;
        d=google.com; s=arc-20160816;
        b=SOlohPN/jih5Oo4Ti6ZbuqsnuoEyhu2gIws9b9tLHFXTfZH4EpO7l71orCCbgxy2C0
         bqc+6xWzJI3yuu6kBi99Sr1otIn6ZlT/CkOhsgnzRXM/L8iwZfGgA6Lt6ETtSr9XOk49
         ZD3dc6U20NNbR0f5Kj0VYgB2A5bQn7BCSCmZWtOBw+fzP5j0LTDn0qoU7eUnKaKC5hmc
         +PgEcpkH0a2Yf/hOKTF1E0lk4QpZTqaWoEy9X3kDgjucXNNaD0OOgFmQtQfQH4nFsvqH
         kqnO48jZG2oQkPABTxNKkGgfTe5KpqHslAuIKKs3oU77CxOEKyYq0CslGjbQ6aRf9mOp
         h2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MFBPdmWKuq1aKeho5Qq7333KGeZl3UBBWKGFjFoCZJA=;
        b=iN7UW062JuQtWOalDbR4p1sOxpRaE7gelUsmWmG/Atjav/K51tBJLOPprw9ktu9ZOU
         e+B0xX71Kfet0UxMHBeZ+gQazhQ3JVP5mLQKZYIrAZXHCzU5Tuf0EngPzyYlzWthyJbz
         ej7+tZak9n0LhRfd9xjpBpbu/9xd5kYVFGwa60L1J9rZJPQQCxNnvKbha6YuotmIZn1u
         ZxFhg3cjRfh5AgemqM3Pd0MX0RWTQm0UenfxOqxPSdW/LIV9xi2TmTwcbkbx68LuU/g+
         ucFwx9L1BkVehcF1H1Qvs2yXfpBzqDrVDkVONB6HeSIYZcngU9T4oDg+Ja8fV806B+Uh
         c7Aw==
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
Subject: [PATCH 4.4 51/72] crypto: ahash - Fix early termination in hash walk
Date: Fri,  6 Apr 2018 15:23:52 +0200
Message-Id: <20180406084309.497760494@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003644583899503?=
X-GMAIL-MSGID: =?utf-8?q?1597003840836232075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
