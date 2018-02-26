Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsB4P0GvuxLB+ayVLypUEcQwkcwhQzw3XJBzOU3S23LqzVrmp6urvrp6Fjda2pAYtsg+mFW
ARC-Seal: i=1; a=rsa-sha256; t=1519676782; cv=none;
        d=google.com; s=arc-20160816;
        b=wFlIPwP4zwtUVZ5l4NSjTy3+D/zhLaLUIqmYCyFd/EOO9osIMYkhEubZDscTbAnFIL
         Cgy15PZGzlN4iWZHBsiUexgagdANQD1WVtDd0QmtDsbeaRnE9QBzmqLwRM0Mce356oUn
         RshWk6+HJIKjzmq3Otm2PVToTWhi1sGnsSWNJkJQaR6J6GmkyKGS0S5gKBa52JuGG0v8
         K4uIg0M9T1VpLyhLBBaF+btXtDTrvgKSEFaVzVESBCF8oaKM8DROFbtcBy4DqSQDY2yh
         C/RABQJybDsWiWogXq4yaba4ipMY/KfOhcm+6Fg3s5yIMR0onWL8dw7J9ohvEOcckzDG
         7/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=L0OB0r0tVeKqHh10X9k55+ODIoWYG3i73d/55MR/QgE=;
        b=iXKL61L2aJ+p1DXrnFLFIT6riQqLvx02uAPQvkfhLREolbi6uEe1pmqc1wilD/W/bS
         1fcds5voaTzyJNZjkoVJE38Vihbn8YNSzmRGo3zit8iFdYSxyzo2P/U1zRV3T6UpkYMC
         G7ath9YJUIpFkcCFuqUYCsowuv7BILMcGfmzDcFMewp+I9Gpr26O2sYNYh8aBBFABkCV
         7ypHVkwLvOsNWX9pTkzyQNYojQKF3gSlJbQm32ucBBTs7apBCoBWWyqptEZHHZDX526U
         w3cwlomsVYrbZ5VhRpeT+O0N557jueLCeVmp6cmiuaO7p3dqMyE/2cXX2SfIifOB6QkW
         7o/Q==
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
Subject: [PATCH 4.15 14/64] PKCS#7: fix certificate blacklisting
Date: Mon, 26 Feb 2018 21:21:51 +0100
Message-Id: <20180226202154.051131818@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496421895342058?=
X-GMAIL-MSGID: =?utf-8?q?1593496601429437024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -366,8 +366,7 @@ static int pkcs7_verify_one(struct pkcs7
  *
  *  (*) -EBADMSG if some part of the message was invalid, or:
  *
- *  (*) 0 if no signature chains were found to be blacklisted or to contain
- *	unsupported crypto, or:
+ *  (*) 0 if a signature chain passed verification, or:
  *
  *  (*) -EKEYREJECTED if a blacklisted key was encountered, or:
  *
@@ -423,8 +422,11 @@ int pkcs7_verify(struct pkcs7_message *p
 
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
