Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49RJh5FmR81ZUlCib0EqIkEqSFInDXUBDM2vcFJ+w0kVqqayLCCgPYLAtBNjvlkqh6mv7Br
ARC-Seal: i=1; a=rsa-sha256; t=1523021358; cv=none;
        d=google.com; s=arc-20160816;
        b=pkF0/TrV0bTjRLV7qkJ2ma6C+RUS9TJCagNuP1a2whpLvFCIcH6fpvJLe04DN9Iiz7
         v6ofN2uBepWK139pBs2t/BLQcj5QX2MjCDpntvGfQtj9I0VMENJM9vbZLL0YiG45SyQk
         +JYPoXF4+i8XdsdxYuAvGLIw4PVZooHUZ7xAY2yvSoivIwS0GEOmOvl/Ov27+WrpUEnZ
         5o0vfB7Ky6DiWk/COmV1J+5xHhnbODqrEsCegO3rM7JP02ybNBOLud42RDv4Uy9Ybpi0
         1Nh3kd26lyfDWWvf49GZ+CPkAWovvJ4qoLOT9gE7nxF2+03XUtHc1q1eStBMY4Iu8I27
         i+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vhvkFuhGYSfQKCV92RN5vC0o6kptA0ynbsgZYMpP7+0=;
        b=bSuScNuZ101t3+sC5SckcRvsyuJa9z1AaBPC8qnvcSilhw3g+2cxnjKVEeW8i+DZFv
         tDRkxbR4loETFvIX2nG8BHEht9CxbBIds1p/N/IDJQJ0PlTc8aMoTAJV4J3pVVxtTAM8
         wCs7idSH0kJgIjLNTMyR+03a6J3oN0oIoaAI0v2XGQP/5uE+8mUszQ+IT+k7/xn7+OPQ
         WcEC+ZAlPD2XOlGmn+8U+qOOjkRSsoaFOhrrz2oyYo2nA9xL/TjQaX6iuETocizPDmoU
         KjVtoM+je8avn9djQ+Gozgx9/6LQGeZKdiZw2zN64CKjrsJQcXeqLQcZrgmeoGcGuHOb
         yLDw==
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
Subject: [PATCH 3.18 81/93] crypto: ahash - Fix early termination in hash walk
Date: Fri,  6 Apr 2018 15:23:50 +0200
Message-Id: <20180406084228.698842439@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003644583899503?=
X-GMAIL-MSGID: =?utf-8?q?1597003644583899503?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -90,13 +90,14 @@ int crypto_hash_walk_done(struct crypto_
 
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
