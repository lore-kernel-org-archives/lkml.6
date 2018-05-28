Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163150AbeE1Kqh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:46:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163133AbeE1Kqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:46:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 122/496] PKCS#7: fix direct verification of SignerInfo signature
Date: Mon, 28 May 2018 11:58:27 +0200
Message-Id: <20180528100325.070271045@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 6459ae386699a5fe0dc52cf30255f75274fa43a4 ]

If none of the certificates in a SignerInfo's certificate chain match a
trusted key, nor is the last certificate signed by a trusted key, then
pkcs7_validate_trust_one() tries to check whether the SignerInfo's
signature was made directly by a trusted key.  But, it actually fails to
set the 'sig' variable correctly, so it actually verifies the last
signature seen.  That will only be the SignerInfo's signature if the
certificate chain is empty; otherwise it will actually be the last
certificate's signature.

This is not by itself a security problem, since verifying any of the
certificates in the chain should be sufficient to verify the SignerInfo.
Still, it's not working as intended so it should be fixed.

Fix it by setting 'sig' correctly for the direct verification case.

Fixes: 757932e6da6d ("PKCS#7: Handle PKCS#7 messages that contain no X.509 certs")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 crypto/asymmetric_keys/pkcs7_trust.c |    1 +
 1 file changed, 1 insertion(+)

--- a/crypto/asymmetric_keys/pkcs7_trust.c
+++ b/crypto/asymmetric_keys/pkcs7_trust.c
@@ -106,6 +106,7 @@ static int pkcs7_validate_trust_one(stru
 		pr_devel("sinfo %u: Direct signer is key %x\n",
 			 sinfo->index, key_serial(key));
 		x509 = NULL;
+		sig = sinfo->sig;
 		goto matched;
 	}
 	if (PTR_ERR(key) != -ENOKEY)
