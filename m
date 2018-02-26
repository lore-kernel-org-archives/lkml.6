Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsZBOcbA5APxMH+PrQfJ8L0BhVOEzPzxszlxH7SOkiSDFzStGfZqI+hBSF7PRH7sF7f4GJs
ARC-Seal: i=1; a=rsa-sha256; t=1519676778; cv=none;
        d=google.com; s=arc-20160816;
        b=v7Y3dOfUwE77OC+aRTDyW/ghWcUF21R8pAv8Yks7NqC+Auw6vFPpdvHKvMOFBC7EUW
         Noq2tx+uEb2kwG9+ZorOdqWFhLKAozO7PottJk72v8lbzZJs/SwZUCgbc/Bu7AsrcqG3
         E8bCsFSrdTkyByrhumIndGiXXo2wtiZLxMtCNj+4byem550moEVPWkkcYqShnGKccNM0
         /cfwdAmXVOlHC0I48Gq3IKYqor5ok2g21YCMcSx4aSOTm4zZqmVyZG+kW49mQIzT4b22
         a+UKvpRqdCJsjYyx+A5TX734LVPd0LjrXN1BZrpf3n0B0iSNIhYLk6tmUVUQZQy8WFQ0
         UWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JcqhGjhFBfaV2iGptlbmuBR3jGUGK06L19gejat8cFY=;
        b=uKUny4tNWSeI3ebBBAwGs4s8yKQ2S/F/ITdSrvKRPJw53WLveNTh+32ZFRpCK90Jfn
         meYPokoqlXObaID87WWpXUPXvAQ6aD12G23M35QsOx0AFQITPvX+wpW0/Jz3duLzh7NE
         0HGKsBsuuqJSwvf+xd8EQ96kfs0m3B3VW8s7lbfFQsSTdpPRwEDN1QO3Dfv5jg80DOyZ
         datqYb4r6dckemrMFqrESLayHDRT79H2sYm5VEQaniXMdX4XV94LJvLeiT3QuM3z2nZb
         37yGTKV5CD2lnoHaL44s8l3SXsShMTXsJRJCIDJN8kBMUPiY8kVTc8Y523QWbcF3XWe9
         iEUw==
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
Subject: [PATCH 4.15 13/64] PKCS#7: fix certificate chain verification
Date: Mon, 26 Feb 2018 21:21:50 +0100
Message-Id: <20180226202154.014220555@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496371074574553?=
X-GMAIL-MSGID: =?utf-8?q?1593496597301323513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -270,7 +270,7 @@ static int pkcs7_verify_sig_chain(struct
 				sinfo->index);
 			return 0;
 		}
-		ret = public_key_verify_signature(p->pub, p->sig);
+		ret = public_key_verify_signature(p->pub, x509->sig);
 		if (ret < 0)
 			return ret;
 		x509->signer = p;
