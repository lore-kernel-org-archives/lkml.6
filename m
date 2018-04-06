Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+iHTa0IKSt3rISzMnuc/MEzZTb2XkS9AFL/iTKMsj27hIEwzP7/AcsRJCiYAiZTexT7IRr
ARC-Seal: i=1; a=rsa-sha256; t=1523022273; cv=none;
        d=google.com; s=arc-20160816;
        b=o3/KmfPKx9rwPT39s+Mxv9YfnIdsuvo93MGZkYqaFZRJrgTpD1lm1hobncoIkL2o4b
         VazmZoupxvx8XbvNobOMN1thRu+Yr+UCsqwddaPqMFtR1IrT4/vrAFDpTDvOx4EgZWSd
         dNUHG8ywPhfmN1qaIFDk4mOJhL3zRZo7+z8qm7WwXFh7m/9nPe9U8GfgmyXz+glbvDgs
         jbekANEyVnUoIh0/SnXUNOmuKzAf1ZApxfrWblP1uVdmjUuKESyXqNLXsb1VnrcdhQ9b
         adCdpVQeE8ZW3ARYMVspJdP9C2WWJun8uI4LkTO5nSIhM5O3+sBbAjg4rY/2LkURwn1w
         HO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ISbMUtkF+BGSG3utcJs6vExTs3qFshXOJKZMJzmsakU=;
        b=h+QMcc+/gcqgc7IZ0CVe9pFDNM46j/Zw571waJRwnWLkaLDeuFUGl1K60vmrYsSffi
         8ObEzI9bj4dKWJMkvwzUJlcXGSy6kfN+o9EVyrHUYO/+hfZ/4HrVwiWoXOXryF4FFEbH
         hZNhjg76voxmIT/rZ/6hw3YKTRDLKZtFu0La8EgDVi67qjXoYRcN4C88sb66mF1oAfAQ
         p8hUaCMgyR5pTxRUK4Sb2oo2u4bHRvfn0m6Spd1pKPzNmoRbFAIV/W4cBw2KlBtlxYMa
         lkKzqiwhvlnAMiGz+JG4rWcRUKp8U4MnCy5Zn1XLqy4Kn90/HUDfKbkOCJDUctzEZjt1
         Ed/A==
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
Subject: [PATCH 4.16 16/31] crypto: ahash - Fix early termination in hash walk
Date: Fri,  6 Apr 2018 15:24:41 +0200
Message-Id: <20180406084343.212737588@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003644583899503?=
X-GMAIL-MSGID: =?utf-8?q?1597004603605256373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
