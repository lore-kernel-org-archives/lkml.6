Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+bto+mHFSqoX15Q3062U1rCiwpsYU+zf0HXOYiycpEY5nd/wSnlQxi7VbIz19Pmcx8fWrA
ARC-Seal: i=1; a=rsa-sha256; t=1523021958; cv=none;
        d=google.com; s=arc-20160816;
        b=BYmDHciSLhI23HEYO2ehD57edhF6kNU4S6UKZqYKa3Xco39q6QTOpt1KEXNxMWXux6
         BXkhbRbdRe5+2o864U7U0FpgYe5gDX0gS3LjPpRV1b1lRy36opLs0BCk94Cla5sPOL3Y
         uW3jbb38mTTUpNGlJ7ixCT0/eUQ1I9YcpoYuoSFG5FXHygc9llRpWS5QHc+YDPFg6wwd
         Ps63Y9+MSNuEbVUKdfKaIIu7mP4RrU8gdN+LdDDODJLjxCHp2FqG3B3Huj1MGAOg3RMk
         FHUo3WVIThdFLSHV7uawz3toLC+mAuJOOSNEgdeLaJl8CSKOOBRe6+FObEsPwL2sxDLD
         H+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rDId82/83FaeLvGWRD9TCGyfXJXdQYp6yX9Zowpv2Lk=;
        b=m3Zp5S3w0DJoW5OAW6M0vSDYJSaKtPJce4yJkxWyVXkJpsHxkUAyGZJQemwuqah9vJ
         XYdCQduFGY5GyJnffSneo5BADfJup1dFITF+8NXeyd5msaCDrvHrB/ULawfG7xuR9xUm
         px8AZTXVoe3M1+f2U2/8lJDBc18WTt7WqezY19mgwXKBRuhqsBDPbiIOR+RNG9M10i8w
         lwTNQxAyG5ola8TEY8pMYuifVa37OPWuMdgX13oX/kQ8VcfcYH6NvMvX16lIbDGrDQzI
         s3Mn0Vm9L4jWmSq6aEQkvaXGO2r3guKwQKeze78pCyck0mz2x/XvOdpm2qhk8a6DRuWu
         JqNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Conor McLoughlin <conor.mcloughlin@intel.com>,
	Stephan Mueller <smueller@chronox.de>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 48/67] crypto: testmgr - Fix incorrect values in PKCS#1 test vector
Date: Fri,  6 Apr 2018 15:24:18 +0200
Message-Id: <20180406084347.519579611@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004273438642213?=
X-GMAIL-MSGID: =?utf-8?q?1597004273438642213?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Conor McLoughlin <conor.mcloughlin@intel.com>

commit 333e18c5cc74438f8940c7f3a8b3573748a371f9 upstream.

The RSA private key for the first form should have
version, prime1, prime2, exponent1, exponent2, coefficient
values 0.
With non-zero values for prime1,2, exponent 1,2 and coefficient
the Intel QAT driver will assume that values are provided for the
private key second form. This will result in signature verification
failures for modules where QAT device is present and the modules
are signed with rsa,sha256.

Cc: <stable@vger.kernel.org>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Conor McLoughlin <conor.mcloughlin@intel.com>
Reviewed-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/testmgr.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -548,7 +548,7 @@ static const struct akcipher_testvec rsa
 static const struct akcipher_testvec pkcs1pad_rsa_tv_template[] = {
 	{
 	.key =
-	"\x30\x82\x03\x1f\x02\x01\x10\x02\x82\x01\x01\x00\xd7\x1e\x77\x82"
+	"\x30\x82\x03\x1f\x02\x01\x00\x02\x82\x01\x01\x00\xd7\x1e\x77\x82"
 	"\x8c\x92\x31\xe7\x69\x02\xa2\xd5\x5c\x78\xde\xa2\x0c\x8f\xfe\x28"
 	"\x59\x31\xdf\x40\x9c\x60\x61\x06\xb9\x2f\x62\x40\x80\x76\xcb\x67"
 	"\x4a\xb5\x59\x56\x69\x17\x07\xfa\xf9\x4c\xbd\x6c\x37\x7a\x46\x7d"
@@ -597,8 +597,8 @@ static const struct akcipher_testvec pkc
 	"\xfe\xf8\x27\x1b\xd6\x55\x60\x5e\x48\xb7\x6d\x9a\xa8\x37\xf9\x7a"
 	"\xde\x1b\xcd\x5d\x1a\x30\xd4\xe9\x9e\x5b\x3c\x15\xf8\x9c\x1f\xda"
 	"\xd1\x86\x48\x55\xce\x83\xee\x8e\x51\xc7\xde\x32\x12\x47\x7d\x46"
-	"\xb8\x35\xdf\x41\x02\x01\x30\x02\x01\x30\x02\x01\x30\x02\x01\x30"
-	"\x02\x01\x30",
+	"\xb8\x35\xdf\x41\x02\x01\x00\x02\x01\x00\x02\x01\x00\x02\x01\x00"
+	"\x02\x01\x00",
 	.key_len = 804,
 	/*
 	 * m is SHA256 hash of following message:
