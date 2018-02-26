Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225pGPtPHbH2paf3Z2NF5oXJPR4tiMt1GBONKyJh6xRDRLqsErav7Nd7tlDWSymAZsIPIFzo
ARC-Seal: i=1; a=rsa-sha256; t=1519676610; cv=none;
        d=google.com; s=arc-20160816;
        b=IDW2/Qkj1kdbwDDhPe/BpdVhQjL82m1pu6GGEbwgiyS89UntqPG/z9g1s0IAbrita7
         txHYvxLOIyuAzqEUDVATzUUbXWd+VMW+4g690GhLjsEtmvgSLzvD6LAP0mSw3epfewvJ
         lTFdlPjIyzVe43UR5ljsOYpClXLdlk53TiexSpNzHmTCDCMbrFrFlRpO2OxScdoXO8uj
         Hqaro7l2+hTTU6E3GLDFd/WKUzV2qHALtiKka3SFXR5a1dY8E7Xdgrw1wbEYsGek2tad
         KM2xikF8U1kmO4Ua+QeOZyWAsTfrPt9Iae8jQpzKbq4mAKn1xp4Oc/46BaW7zG7S9+Yo
         Blbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nj1OrQlk2uBQaaL/wX9hqhFZW7qeyUjjpseHtEYadNo=;
        b=Yyxih+qONiV8xtJxHSIeUsXkQsupZJxnVWqWQhMY+48+dXhkFze0SXt8LyebhyWJ+y
         EQ7tHJPi7rAsAahin9+6WwPEd3qd0jeFUSaTJi0chGiOgjeEVSpKNVQ65Xn0ZjoDTpEL
         CccbD3sRnylRx2QKsotkuOcAXDOsxEBsr+gzvTLGd8iMyHWHv2EvgC2+ldfmf7lnQIx3
         ZHiYnB7Zp3iIRWnKgfZHo31LgYOTYmKDnqWLH/ANwKdzDa2DDqW9NAoESnaWsmnkM+Wy
         YnVxa0Nv8DXpzyhd5nVJOdbmUjYubzmBk/KDG9fCbdvfUt+uCfbFMASS4xQhhd4e6wza
         t3mg==
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
Subject: [PATCH 4.14 14/54] PKCS#7: fix certificate blacklisting
Date: Mon, 26 Feb 2018 21:21:51 +0100
Message-Id: <20180226202145.084527004@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496421895342058?=
X-GMAIL-MSGID: =?utf-8?q?1593496421895342058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 29f4a67c17e19314b7d74b8569be935e6c7edf50 upstream.

If there is a blacklisted certificate in a SignerInfo's certificate
chain, then pkcs7_verify_sig_chain() sets sinfo->blacklisted and returns
0.  But, pkcs7_verify() fails to handle this case appropriately, as it
actually continues on to the line 'actual_ret = 0;', indicating that the
SignerInfo has passed verification.  Consequently, PKCS#7 signature
verification ignores the certificate blacklist.

Fix this by not considering blacklisted SignerInfos to have passed
verification.

Also fix the function comment with regards to when 0 is returned.

Fixes: 03bb79315ddc ("PKCS#7: Handle blacklisted certificates")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/asymmetric_keys/pkcs7_verify.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -369,8 +369,7 @@ static int pkcs7_verify_one(struct pkcs7
  *
  *  (*) -EBADMSG if some part of the message was invalid, or:
  *
- *  (*) 0 if no signature chains were found to be blacklisted or to contain
- *	unsupported crypto, or:
+ *  (*) 0 if a signature chain passed verification, or:
  *
  *  (*) -EKEYREJECTED if a blacklisted key was encountered, or:
  *
@@ -426,8 +425,11 @@ int pkcs7_verify(struct pkcs7_message *p
 
 	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
 		ret = pkcs7_verify_one(pkcs7, sinfo);
-		if (sinfo->blacklisted && actual_ret == -ENOPKG)
-			actual_ret = -EKEYREJECTED;
+		if (sinfo->blacklisted) {
+			if (actual_ret == -ENOPKG)
+				actual_ret = -EKEYREJECTED;
+			continue;
+		}
 		if (ret < 0) {
 			if (ret == -ENOPKG) {
 				sinfo->unsupported_crypto = true;
