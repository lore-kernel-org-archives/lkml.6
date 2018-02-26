Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227/OBFFHIvbdIPf7vAtbvdyCJ9Q1dEt6AI9pZDQfxMA7Ny3W4SwIesrIIBH5xQ8FJsH///3
ARC-Seal: i=1; a=rsa-sha256; t=1519676562; cv=none;
        d=google.com; s=arc-20160816;
        b=PrD9AMkojBBxMaKNhjwNMGvU30o4GbTgNf/RLUpAFVTsCmL08l0GUE0Gzox4sHsVeC
         mhH1VOsze3JU8etBVPD/PmxuOWYzaRIj2qQ9XgIWWq44LkrO6j+eSUVxngTCtcpeNOEu
         0+G+2z/fS3sNl9anAw8oBUlBSX8S/GSqAtVVJgEL5FnN8cNkmfj3eM7AbeEBK9zlUCzt
         QQPg0w5ZFa5YPrx9XnzMSdj9+UXcRg5TKVw9TkZNYylV0PKpIOd2IJaEEHqL7PynlzCp
         V66hZAGYlQvaD/gkL0coJqp4ey3xb620/ce9WAp319WtZpcUdxUm4qQeNxkh6tN5lZlX
         Lw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bnYnkrMMuhTkTz5+cB6L5RZ+HYZEQ6rZK/Ajcs2qVL4=;
        b=yvYfUQIozdZT+wwMXrDHUNE23zsoDptud+WEpCfpL2ySKi4EIlFoXzp/cDAVoMyXhQ
         O1QNBvOtD69r5hc5j3jL5NXsrNwgmGY9WRv+JOmxFGUT8Wb0d4wFFipP3ubwrGiTBkrY
         QhEMdKAS0v6dx93rEO/GgwOs0DE853oWaL/y1xTEssF2FwFVOtAu3XqDvKJgh88XwDmn
         HSZWV9Z1+g99pZMT9Y1l848RLcGi9Y0iWOkQxf0BtMQn/FXL20IvYnxNwMxkpxJBh0ar
         HarHxVmQC77OYaLXiWbMDxYLazfSSiz+QQNI4qQX3gPG9IMZrIUGP9EidCccFUlV44md
         +fZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 4.9 06/39] PKCS#7: fix certificate chain verification
Date: Mon, 26 Feb 2018 21:20:27 +0100
Message-Id: <20180226201643.948101062@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496371074574553?=
X-GMAIL-MSGID: =?utf-8?q?1593496371074574553?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 971b42c038dc83e3327872d294fe7131bab152fc upstream.

When pkcs7_verify_sig_chain() is building the certificate chain for a
SignerInfo using the certificates in the PKCS#7 message, it is passing
the wrong arguments to public_key_verify_signature().  Consequently,
when the next certificate is supposed to be used to verify the previous
certificate, the next certificate is actually used to verify itself.

An attacker can use this bug to create a bogus certificate chain that
has no cryptographic relationship between the beginning and end.

Fortunately I couldn't quite find a way to use this to bypass the
overall signature verification, though it comes very close.  Here's the
reasoning: due to the bug, every certificate in the chain beyond the
first actually has to be self-signed (where "self-signed" here refers to
the actual key and signature; an attacker might still manipulate the
certificate fields such that the self_signed flag doesn't actually get
set, and thus the chain doesn't end immediately).  But to pass trust
validation (pkcs7_validate_trust()), either the SignerInfo or one of the
certificates has to actually be signed by a trusted key.  Since only
self-signed certificates can be added to the chain, the only way for an
attacker to introduce a trusted signature is to include a self-signed
trusted certificate.

But, when pkcs7_validate_trust_one() reaches that certificate, instead
of trying to verify the signature on that certificate, it will actually
look up the corresponding trusted key, which will succeed, and then try
to verify the *previous* certificate, which will fail.  Thus, disaster
is narrowly averted (as far as I could tell).

Fixes: 6c2dc5ae4ab7 ("X.509: Extract signature digest and make self-signed cert checks earlier")
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/asymmetric_keys/pkcs7_verify.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -261,7 +261,7 @@ static int pkcs7_verify_sig_chain(struct
 				sinfo->index);
 			return 0;
 		}
-		ret = public_key_verify_signature(p->pub, p->sig);
+		ret = public_key_verify_signature(p->pub, x509->sig);
 		if (ret < 0)
 			return ret;
 		x509->signer = p;
