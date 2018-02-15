Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225oNYFzEUcgmOO4AnsG+5Gst7kwQ0fC78TJqi09fVELGnaKx0krXC7ezWPX/rlgdBm+j639
ARC-Seal: i=1; a=rsa-sha256; t=1518709418; cv=none;
        d=google.com; s=arc-20160816;
        b=WF+GI+xC38w1kHw5kXQu7MUpBH0T83kPUAAUEDfLnunTI5KVRo7Fj52S78aCBx2lvV
         id8EiYo8ZJnhuiFiFfoJssVEI5L/neOhZjNZKanhzlQsS6EdXUUxlHNHWZcUSsXhofy2
         8wM+5sEs37Y+L6Z4BkTWFZ3EeIR8bJU8+E7k/1860RiRSyG53qaRAyEFVuCZYItNTeUU
         iG/S89JFIrw08S0WWhflXjZqRWyUjtneVi3BOu8fCdPLLzH+akkvqZCCkV9tWmMnisgc
         1e4aZLPtwVjjzf+Sf4KtVhJtq2nV1rG49qrt9saoMcB1xfBUEnqEJyGaTnZlHq0RgxIn
         MqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9XJLmUCZ9XRa0xJPIsEvqSAZptnBJozEU/MYdNzwPQU=;
        b=fK8S9hSggQ19MPuJkM4YSjeTRicmi8VyWrYbl2KJSd8umQiMDr6MfuZSy9I/aIKvDf
         /0UmAj2IOx45VaYkRYg6pWb/IoXtquveiQ7lauzmYubFagb3E4D6lpcCJFdguQxHEwa/
         hM8lY+ogSyqf0KYlP//0D3PehMVBnsPepyRBKd/B+xd7sbO7T/Z8ubLInXi/3o6dQUtJ
         MLD8ttaw4TIe6Zq5u9E04TIcp6/KQ6SS5QoU3mfppJ/ib8hWZt1Pn6HHvdshNPlTW8EG
         3w6OtndsHK/SlW4NMsL5GMY5WuNRRSt4sQcd2kPamI/7rnZ0tY9DltzJ+CJOOVtaGrJ+
         Y5ww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 110/202] crypto: mcryptd - pass through absence of ->setkey()
Date: Thu, 15 Feb 2018 16:16:50 +0100
Message-Id: <20180215151718.992101828@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481189631310311?=
X-GMAIL-MSGID: =?utf-8?q?1592482247437375772?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit fa59b92d299f2787e6bae1ff078ee0982e80211f upstream.

When the mcryptd template is used to wrap an unkeyed hash algorithm,
don't install a ->setkey() method to the mcryptd instance.  This change
is necessary for mcryptd to keep working with unkeyed hash algorithms
once we start enforcing that ->setkey() is called when present.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/mcryptd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/crypto/mcryptd.c
+++ b/crypto/mcryptd.c
@@ -535,7 +535,8 @@ static int mcryptd_create_hash(struct cr
 	inst->alg.finup  = mcryptd_hash_finup_enqueue;
 	inst->alg.export = mcryptd_hash_export;
 	inst->alg.import = mcryptd_hash_import;
-	inst->alg.setkey = mcryptd_hash_setkey;
+	if (crypto_hash_alg_has_setkey(halg))
+		inst->alg.setkey = mcryptd_hash_setkey;
 	inst->alg.digest = mcryptd_hash_digest_enqueue;
 
 	err = ahash_register_instance(tmpl, inst);
