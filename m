Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+29VjklS55D1EANIyJ4PLOSUNw8V0kGvF6Tlyb9DjFJhI210L6WeK8C15LleeuzpMgFVBx
ARC-Seal: i=1; a=rsa-sha256; t=1523022236; cv=none;
        d=google.com; s=arc-20160816;
        b=j/PBqO8fnB5+sgn6c3xD1/iVUcXvKpbGg8PfC/TTWuPlFcrh5Sl6v7BrLRpIpWEz4m
         3y6pi5d9H69mlhAjqeRE6y+BHvOkZzLudNM4DWOYD2soDyfjW5NF2KlYUWaPyS9Z22KE
         GFildCM3toZQ95iQwqvQaQq+V+gv4WvbxUpha4GDjXRU0gP7N5TnCXyvSYyI4GFoNqWM
         EriXf88A0WxPf9ePFdjdbXL1hKTdN9t4Uo4OlIeBH86F0gBBNaDqZS5wEfIgT32bQu7r
         vj3lxjVPBjsKmlZOSeknoqP2F8hWT6OfhSkLIyR03KJh7CXij/M6vq/34dcjSbj9n+Gr
         IGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qdaw3l1PSr33HEJk+Gar4qR217PAys11tUAROn2onV4=;
        b=DQ6THbbnkq7LLAiO8RM4E3LhWYCgH2WbLd9HLW3NAQ53LuzyBCyBFBpdp8xtEiVwCP
         LOdwtn1vrXtCcZwvCoUx890tJKztwkElKegiACOwrhoYGJUy1hGw4QJ6Zs+JZC+3nESC
         6KqtXrhdNGYSubtRfsoxaG3pCP2PXfKOzqaNw1KimlIYwkhbcNhhY02v6+8y0bsc4Rs3
         H/HxmnYjDqNuOUveKs2WrYyp44EXMmsI/ZjQccnThhHXvFuo2g5ahx3+ulFLv2deFG/Q
         UOUPuEwvZHY3YRJlLu8mjAS2CbD7YSQmWhcDxM7Po/chKcUZKXrzd716Ah/ey9VXTnPS
         N9sg==
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
Subject: [PATCH 4.15 54/72] crypto: ahash - Fix early termination in hash walk
Date: Fri,  6 Apr 2018 15:24:29 +0200
Message-Id: <20180406084353.157641229@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003644583899503?=
X-GMAIL-MSGID: =?utf-8?q?1597004563829219545?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
