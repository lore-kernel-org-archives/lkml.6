Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu7dy1tisVRS6L2mdqt6l4yMBWDP1uO45k5UDZNPfCQiHLL77oLFRNKmluZ6MpV51Z6n46d
ARC-Seal: i=1; a=rsa-sha256; t=1519676771; cv=none;
        d=google.com; s=arc-20160816;
        b=vwGK9GqZkB1Px5pOhkL+PA3rvtkjfS+E41BIdZQFlrbBzm+28pw85wtbfk1Kj1uNBJ
         xcbcUP+7s2dKzwM8m0+4/TZDqAXjn1+3Nl8ONtagFxsAsA4QdxHq/tyW9RAGZLkpDSPl
         mvuf6lLnQ26riK3qWOTMKVYT4WBBn3ahmTI/Z6ayAyWWShdqaaGs6C2RBhDec6Qd097Y
         EmcnNZBXzWMq/xjMBnBmr8q8QbfPaI4hxn1DC3DI03a7pnez+0SjRYJwH5QJFlBidO8W
         izdq4PHOuovmww1M+5SwWJsTmM6BFJRv9VsV0NJJ0ydRfbCgzApcv728HnKSdDvVeiIx
         sNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uNuZywYrIPPO8CTp5u6/NrRpkoREHyqEHLoFKUXJ+uc=;
        b=mos/YmU3AHxogS8fqaLQCDlXKXTu/tiWPWq47FUOPnJ6YIiiurhBpUnKwepyteosW1
         2gzAkFn2XBefqbCDBH65776xLqfV//NAne2AqewjnKtRQJiHwlYUZrBqouATT8GECUuk
         ouQKcRGDhpcc9RFJmyd5B2Q+gZS88cKwFMmQBSvCx3QFSrVmd4YvMhDDV5O4xY+WrIFI
         HdjqFPMUm2mPjUDEqthIfTjGE/mXSpa/sPlGPpJQz3AyEYV8cFQB+ADOqDG35DBzWyjb
         EXNrUpRY9lfDIrsIYRT6fLWEimgy2M8LO1WOSXRQTyXql4r4V74tpgsOAhk+mZKpSkzU
         NPiw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Valente <paolo.valente@linaro.org>,
	Eric Biggers <ebiggers@google.com>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 4.15 11/64] X.509: fix BUG_ON() when hash algorithm is unsupported
Date: Mon, 26 Feb 2018 21:21:48 +0100
Message-Id: <20180226202153.911083651@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496367609163811?=
X-GMAIL-MSGID: =?utf-8?q?1593496590855479468?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 437499eea4291ae9621e8763a41df027c110a1ef upstream.

The X.509 parser mishandles the case where the certificate's signature's
hash algorithm is not available in the crypto API.  In this case,
x509_get_sig_params() doesn't allocate the cert->sig->digest buffer;
this part seems to be intentional.  However,
public_key_verify_signature() is still called via
x509_check_for_self_signed(), which triggers the 'BUG_ON(!sig->digest)'.

Fix this by making public_key_verify_signature() return -ENOPKG if the
hash buffer has not been allocated.

Reproducer when all the CONFIG_CRYPTO_SHA512* options are disabled:

    openssl req -new -sha512 -x509 -batch -nodes -outform der \
        | keyctl padd asymmetric desc @s

Fixes: 6c2dc5ae4ab7 ("X.509: Extract signature digest and make self-signed cert checks earlier")
Reported-by: Paolo Valente <paolo.valente@linaro.org>
Cc: Paolo Valente <paolo.valente@linaro.org>
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/asymmetric_keys/public_key.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -79,9 +79,11 @@ int public_key_verify_signature(const st
 
 	BUG_ON(!pkey);
 	BUG_ON(!sig);
-	BUG_ON(!sig->digest);
 	BUG_ON(!sig->s);
 
+	if (!sig->digest)
+		return -ENOPKG;
+
 	alg_name = sig->pkey_algo;
 	if (strcmp(sig->pkey_algo, "rsa") == 0) {
 		/* The data wangled by the RSA algorithm is typically padded
