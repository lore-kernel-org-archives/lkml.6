Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227x5DY8MF72ut8ZdpFEWCgU9brMdFmC2JvUZ5CcN+PCCoyPRlunfeTnbvD7xeftHlMsWrgl
ARC-Seal: i=1; a=rsa-sha256; t=1517590789; cv=none;
        d=google.com; s=arc-20160816;
        b=zJiIvr6vgbgchA/g8SGoPbTz8XgzTMVQNP7T7KVF+HxgXPGt8U7T3PretMrc8UYMRW
         xgqjWV1dwz6AhJXnaM5NnKPBJ1oBPVUYzQhegbJ6Ffnh552S+zVYaZ5W6OOS6fB2xf2n
         qmMwYOswhCZVoaPLkaW2LCjDpYFXUQLsmb6XiJIPVlIaKccLWppV+0UarzrsIVj93J89
         TLtM6AfbLbNwPigkozauqiA52BrOp9TAlhaVmD3FakX9rXvp3TLu0InHWcD+eXKP8Du+
         r57LLCpBWdu3ZDeqSThNIglHr1nd0jyOH3HhAXzuBAmibYpY8PhjdHScLcg7xU6e0ZKs
         PTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ESiklJ9Q3h/ofRNKDhUxScHp5j8yBlvTWjX6UBiJbAw=;
        b=rIBLT7BAo12yRMeMiPm27E7inRuXLAmJfv24RIn6GyfuWeZdOyHfzT9zafscfKtype
         oN1UcSdRqywIfDb+SzTCs228nnyS5q4X5PEvS/FtyY3cPf4klH8XEkib6nfvGPIFJInG
         OOWCFjkvpkASqmJ3XzOwhS36OD/EgjNEWJLgGqBdLQXrWL3+zLowI10M1pmy7bXm2DO7
         dhsa74SoTOGZYf6N90qyph2R0qF4roISIE5Re6Ii17oJRPT/w9uQwMXqRPgAH+eypeey
         E+o8xpjf0fKFmv8G4l2lKJNqs0O0noyBO0k371tpHWI4qNqSDBQMsDqd7SqvyyZqJFcI
         +TgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stephan Mueller <smueller@chronox.de>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.4 14/67] crypto: aesni - handle zero length dst buffer
Date: Fri,  2 Feb 2018 17:57:43 +0100
Message-Id: <20180202140816.897155539@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309279717381300?=
X-GMAIL-MSGID: =?utf-8?q?1591309279717381300?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephan Mueller <smueller@chronox.de>

commit 9c674e1e2f9e24fa4392167efe343749008338e0 upstream.

GCM can be invoked with a zero destination buffer. This is possible if
the AAD and the ciphertext have zero lengths and only the tag exists in
the source buffer (i.e. a source buffer cannot be zero). In this case,
the GCM cipher only performs the authentication and no decryption
operation.

When the destination buffer has zero length, it is possible that no page
is mapped to the SG pointing to the destination. In this case,
sg_page(req->dst) is an invalid access. Therefore, page accesses should
only be allowed if the req->dst->length is non-zero which is the
indicator that a page must exist.

This fixes a crash that can be triggered by user space via AF_ALG.

Signed-off-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/crypto/aesni-intel_glue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -965,7 +965,7 @@ static int helper_rfc4106_encrypt(struct
 
 	if (sg_is_last(req->src) &&
 	    req->src->offset + req->src->length <= PAGE_SIZE &&
-	    sg_is_last(req->dst) &&
+	    sg_is_last(req->dst) && req->dst->length &&
 	    req->dst->offset + req->dst->length <= PAGE_SIZE) {
 		one_entry_in_sg = 1;
 		scatterwalk_start(&src_sg_walk, req->src);
