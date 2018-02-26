Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuv/OXTf/YUg/1MGICO8F1cxeS4Lw2kMpBEzPSbxp+w0y8ROKJVjdhGceROrOrd4en52C4s
ARC-Seal: i=1; a=rsa-sha256; t=1519676559; cv=none;
        d=google.com; s=arc-20160816;
        b=oMGBBGhGQtGUCeR5HSK7a9EnTpsk/5iTgATfqFnBAi535X5W7RzbWfV+/qHdTPRA85
         /4XElU5gEXwbzDux0rVNWKTGXW6di/Zhh7dEmB00yven1BvBsvsUHdKXYQ8jOtViaGwT
         pxIxpze6mERaGBXMqPSfkCFWg825QSls4sS9wz8Ti+Qfe6haMbCFvXOQS3+rzL94XRQS
         o+Z79DVsL+WF6vPq1qRszVAZd3aVm0jFtHxaOHyHN1MtcGRqUT2eSN/6djYbSSmZuOCu
         a1InqZy1Of6cpLHF4hUXyduEtaSaQCBA5NP4Y3+JauPDuRSrCNtUPF3uY1w+kgWMUlb4
         eJ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ci883YQ318n9H0+R8zlzgxh8LJYyQ2c0aQ3jgtuCmU0=;
        b=GKEio3cQ0kYyoieZBbDLXLafH9UYQNlO4l22o1ie9XHXlDmTLHb3zZywKuAaQi2iY0
         Wj09067uIRWW9N1ZIrOfZtb3Lzcih48D8hcaoXopNlEb4CqN6ORRtbJryPzo1B4NSHQU
         I1Jb+FJYH1TzsqgNlXcgE7cX0Y3bcncwJRxGwgC/06ZgLyzD/amXpFZJwOZXZwN6fyF9
         Rxs422r9To/zIa6bK8dWoapS1+ifchpA0oxfJLUQvK8T3YoEb2olwuT1DmxIsfiThpvl
         pQJAQAGd6PGnRfBWkrPJ6ZDCj0/dV92Fh4XDpdM0H2qJFHM+Y+uPLbnpEkPqh6KaMmQP
         lJtQ==
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
Subject: [PATCH 4.9 05/39] X.509: fix BUG_ON() when hash algorithm is unsupported
Date: Mon, 26 Feb 2018 21:20:26 +0100
Message-Id: <20180226201643.899108793@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496367609163811?=
X-GMAIL-MSGID: =?utf-8?q?1593496367609163811?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
