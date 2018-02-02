Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226bA5xsvsMSY3LvrPTzu9tbau4jW08Qau/6QYgMoUHIBM2VKTO6siqz5ypQqcNFQRfc6/+d
ARC-Seal: i=1; a=rsa-sha256; t=1517590996; cv=none;
        d=google.com; s=arc-20160816;
        b=FCL31xpQCTRxZIyRPeK66wQEBCeMmAMd6Z6td9SYTHoeZ+COyaG5NYdc3SEfGZjIY9
         fFlr+z0fYhW1NkD43dK2Cx6g//JkzXwjALdb3cCrZcIQufjP62kFqB9kdX6smOM9/+Rw
         9m8c2xYWuhPMUhIaSTd75vPGZ0grf1BVVEaQM5U24Z2Gk2yXSCiQLlDkxjt2rcWzIcQi
         fDgmHlwmleNg0TNSjg00BKVT5RqZ1wtEox+HJntzOKi/yaVOpkwuyPimYLmQpo8KvLm4
         KKWNRWaFUTMdzXmyyJJqh/gOT6SSuDvnmDSk0dfHK7aCenjJJ/yoOLUpaRv9AokqNjT9
         GTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Lr48mmwxtB5B29Qgn7rujbMpdBuOJUIlOXG9RMGgadU=;
        b=E34jUYyuBTiAl6NesoUKvgMGDrzI41BIjzdGWsrgM431jZe1r7zPxbt9lHexQSKW7r
         JDk0AWq4PmcETWEkCakYnTw+loD9CeHjkoCm07sG1vIK/OIZqBimUD92TT5LJHqeoC4Q
         bKmvN4IRBlqqM6eK843OSxeUHtbe84K7s+4OCIGCHfAm0XX5Et1hCZ/IWW1U7hh4v5Xv
         9d/BOlhh6jGonoH3AgaTodyekXzrLhO9CqgOWVaooO2fYDm3RGnTc4DrVIUS56sBKHf6
         u/wcgZuMImG7nvogi9LTJDijxMDkPMG0LQ9UoERtL3NjV743nE1oMJ2lCbsctMb4VPGn
         K1pA==
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
Subject: [PATCH 4.9 08/86] crypto: aesni - handle zero length dst buffer
Date: Fri,  2 Feb 2018 17:57:28 +0100
Message-Id: <20180202140823.517531749@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309279717381300?=
X-GMAIL-MSGID: =?utf-8?q?1591309496293593314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -906,7 +906,7 @@ static int helper_rfc4106_encrypt(struct
 
 	if (sg_is_last(req->src) &&
 	    req->src->offset + req->src->length <= PAGE_SIZE &&
-	    sg_is_last(req->dst) &&
++	    sg_is_last(req->dst) && req->dst->length &&
 	    req->dst->offset + req->dst->length <= PAGE_SIZE) {
 		one_entry_in_sg = 1;
 		scatterwalk_start(&src_sg_walk, req->src);
