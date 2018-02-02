Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591264-2-8311864703706769731
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591263; b=Lt4GX4fIjO3GYB9h+LBU3Pilco5QbvYdfesubSzVQyx2ZfN
    iMkTYdqS0z7mZ+sOvM84PFPu7I6Ig7YaULNvc1AgtMyacJj/mAZrVZCqs8qFDSUq
    T3ewX7tO7wJ+5Fwq1gsQAv8CqqQ9qSNnlDXFOwrAJlX9B0ZobvlRvia7TzVRtc1h
    BynB0LXfqioih3xsF4Tz7fVLS41G3lznnCyDhvVtmmCYT5wVSLuaDT8zu3aenrzT
    7xh0OeO5A/Pi7Pexdd0A3yWjRJBCxfQ89doM8n8cxvtIGT/Mgxetv6vFiRGKdCe6
    fTJ8o5w4L47xTFEKW8UWhcuv9SdfJ/w+YYMwPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591263; bh=YEa3+WElmybzeZpOkH+TwxR6Wl
    fDp0DFkf7hIF40OZE=; b=jWpaZ44LaMAx+uTsHY9DjR6shvDqRdD4SZ+brbfeg6
    gsd0zx9up8HYRSe0LI/B9Os1patP8EDPIv/joA56CBCfYmuF1IJWHv2NrkFXYaMD
    jb7Eyf/DYKzZ6BTKoj3fSGyvBIJRNB23nP17IHXKz66QAPsGxbwFQRTc5qCZsHbz
    e++zb6qA0Y1CqGETc65g/IJKmcytFgZidJpfXorawbqT6uvm6m5ArBdpDZ6ClHu1
    VQTHoRDM4WXncvfW7ThKbndHOwg8C7+Joyndd2W02vlgM1hSrgSN3wY3+5NY6Ojq
    n12C8HcVAFEkIcUg3qCrXuOnVzH9oObyyjuRn/2rp/Xg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeBBRHi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:07:38 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753156AbeBBRHg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:07:36 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 018/156] crypto: sha3-generic - fixes for alignment and big endian operation
Date: Fri,  2 Feb 2018 17:56:39 +0100
Message-Id: <20180202140841.138315849@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit c013cee99d5a18aec8c71fee8f5f41369cd12595 upstream.

Ensure that the input is byte swabbed before injecting it into the
SHA3 transform. Use the get_unaligned() accessor for this so that
we don't perform unaligned access inadvertently on architectures
that do not support that.

Fixes: 53964b9ee63b7075 ("crypto: sha3 - Add SHA-3 hash algorithm")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/sha3_generic.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/crypto/sha3_generic.c
+++ b/crypto/sha3_generic.c
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <crypto/sha3.h>
 #include <asm/byteorder.h>
+#include <asm/unaligned.h>
 
 #define KECCAK_ROUNDS 24
 
@@ -149,7 +150,7 @@ static int sha3_update(struct shash_desc
 			unsigned int i;
 
 			for (i = 0; i < sctx->rsizw; i++)
-				sctx->st[i] ^= ((u64 *) src)[i];
+				sctx->st[i] ^= get_unaligned_le64(src + 8 * i);
 			keccakf(sctx->st);
 
 			done += sctx->rsiz;
@@ -174,7 +175,7 @@ static int sha3_final(struct shash_desc
 	sctx->buf[sctx->rsiz - 1] |= 0x80;
 
 	for (i = 0; i < sctx->rsizw; i++)
-		sctx->st[i] ^= ((u64 *) sctx->buf)[i];
+		sctx->st[i] ^= get_unaligned_le64(sctx->buf + 8 * i);
 
 	keccakf(sctx->st);
 
