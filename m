Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2274kxKdywxDB7NhyVHBHHwynArYi8a4NFCC8WpRaSTuvIE2pmLOTk5b0zjEuOWYUq22UcKW
ARC-Seal: i=1; a=rsa-sha256; t=1519676601; cv=none;
        d=google.com; s=arc-20160816;
        b=Tkdxi7bbvbchCzZ7m3sPhc9aZ5zNKqLS2Sc3CSBS9IvUVmCrDsQz5n0qHjBZBNpwCc
         8049b1OZiHIAieTmWrHehmC3ZuwWTY2jgCISjB3tyoJle+I3Uj51PV4+bymY2MOAnrbv
         jeDILKuwmPr4Kby8mEMCdIuAhj1Xl9+YmTxw4lI2a0zxsIgWRGA7M7TLW6fDtRq//D6j
         8sZ3KOpghiMDisTWCseNKwK+Yi4CvAfwtV3PSJIJ9jnXmWYsDlPbyXMMU2v1HeE14m+u
         kSXwp9vod/N0jL6q7ikILTYaxOSYc7v+5MY6/qw9GzLmmdrW48uAKscCkUKqS2Hka6QT
         0nAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7hdIvQ5hrPwEHx6PkZ2JBBxAbK++vm2FKhD2Mu86VLQ=;
        b=M4+9MQ8AUmmioZYph+UcTiQG85afwpapxbVmHHMpHz6rYNKfZHIv0EFv7u4j8v+pM3
         NfDCt5cvrz5bnUXkyRoJBQ9BjLU40BPwvF7DjzJSfe/bTgRVreGfbZlkLKeXudiOiwuW
         7iXpDUdadYX4l0AcTLxZwPzi2ivHmi70tINNZtPlWRFrZZKgb73HgxhMfkVxdQN0xE3N
         9g1FinMBvFMGNQnyaD3TkV2ageghsLJcOdri2Nomk+1nJeffMjVit0ldQ4O1leLLQZAD
         Hgf0NAP7VxVFMaEYBRHNjFG3lAx8sAdOQaCO/EOApC76sRPrcoYzs90m0iDAm5aKzz8c
         U43Q==
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
Subject: [PATCH 4.14 11/54] X.509: fix BUG_ON() when hash algorithm is unsupported
Date: Mon, 26 Feb 2018 21:21:48 +0100
Message-Id: <20180226202144.931709445@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496367609163811?=
X-GMAIL-MSGID: =?utf-8?q?1593496411730673450?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -93,9 +93,11 @@ int public_key_verify_signature(const st
 
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
