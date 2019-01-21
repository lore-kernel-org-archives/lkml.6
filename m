Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE69C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6B22085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079647;
	bh=/WL4GbxRQtmFVSRKKUT+qLx0n+06oBq40oexvoRgqF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ldtVwRySVG89+NFF4seB7lhqjxoEE4s0xvxbMRuONjvojpCLxOmkRSsLDiV9fX1yQ
	 lhDxKyr3nlbYhWTfHRfbHsm6s6lbegQacXKp4wQGopXrikVHkru0PIRFpyDyrB4eOF
	 NnOdkSjE4M4jv4lLEYHVeK1QdxfflGPokKSohHNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbfAUOHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732242AbfAUN7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:59:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E1A220879;
        Mon, 21 Jan 2019 13:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079184;
        bh=/WL4GbxRQtmFVSRKKUT+qLx0n+06oBq40oexvoRgqF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUJ0Ie0Hkh8qNUnFtfBFdTYt7eL0HEeywO/sw4jzDEiqZDc6V/nzRs91VyDO/NcpH
         qbz3aVaAM3XCgVEXELbO51rlETLEISYoa0hgxa/PrtdZmh6xqdkHoaggVDSzjzI1+w
         1UXi4/TC2QWGbPPEx8Qsu5WLnUihjEFwUI5g5Lto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 36/99] crypto: authenc - fix parsing key with misaligned rta_len
Date:   Mon, 21 Jan 2019 14:48:28 +0100
Message-Id: <20190121134915.267806368@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 8f9c469348487844328e162db57112f7d347c49f upstream.

Keys for "authenc" AEADs are formatted as an rtattr containing a 4-byte
'enckeylen', followed by an authentication key and an encryption key.
crypto_authenc_extractkeys() parses the key to find the inner keys.

However, it fails to consider the case where the rtattr's payload is
longer than 4 bytes but not 4-byte aligned, and where the key ends
before the next 4-byte aligned boundary.  In this case, 'keylen -=
RTA_ALIGN(rta->rta_len);' underflows to a value near UINT_MAX.  This
causes a buffer overread and crash during crypto_ahash_setkey().

Fix it by restricting the rtattr payload to the expected size.

Reproducer using AF_ALG:

	#include <linux/if_alg.h>
	#include <linux/rtnetlink.h>
	#include <sys/socket.h>

	int main()
	{
		int fd;
		struct sockaddr_alg addr = {
			.salg_type = "aead",
			.salg_name = "authenc(hmac(sha256),cbc(aes))",
		};
		struct {
			struct rtattr attr;
			__be32 enckeylen;
			char keys[1];
		} __attribute__((packed)) key = {
			.attr.rta_len = sizeof(key),
			.attr.rta_type = 1 /* CRYPTO_AUTHENC_KEYA_PARAM */,
		};

		fd = socket(AF_ALG, SOCK_SEQPACKET, 0);
		bind(fd, (void *)&addr, sizeof(addr));
		setsockopt(fd, SOL_ALG, ALG_SET_KEY, &key, sizeof(key));
	}

It caused:

	BUG: unable to handle kernel paging request at ffff88007ffdc000
	PGD 2e01067 P4D 2e01067 PUD 2e04067 PMD 2e05067 PTE 0
	Oops: 0000 [#1] SMP
	CPU: 0 PID: 883 Comm: authenc Not tainted 4.20.0-rc1-00108-g00c9fe37a7f27 #13
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-20181126_142135-anatol 04/01/2014
	RIP: 0010:sha256_ni_transform+0xb3/0x330 arch/x86/crypto/sha256_ni_asm.S:155
	[...]
	Call Trace:
	 sha256_ni_finup+0x10/0x20 arch/x86/crypto/sha256_ssse3_glue.c:321
	 crypto_shash_finup+0x1a/0x30 crypto/shash.c:178
	 shash_digest_unaligned+0x45/0x60 crypto/shash.c:186
	 crypto_shash_digest+0x24/0x40 crypto/shash.c:202
	 hmac_setkey+0x135/0x1e0 crypto/hmac.c:66
	 crypto_shash_setkey+0x2b/0xb0 crypto/shash.c:66
	 shash_async_setkey+0x10/0x20 crypto/shash.c:223
	 crypto_ahash_setkey+0x2d/0xa0 crypto/ahash.c:202
	 crypto_authenc_setkey+0x68/0x100 crypto/authenc.c:96
	 crypto_aead_setkey+0x2a/0xc0 crypto/aead.c:62
	 aead_setkey+0xc/0x10 crypto/algif_aead.c:526
	 alg_setkey crypto/af_alg.c:223 [inline]
	 alg_setsockopt+0xfe/0x130 crypto/af_alg.c:256
	 __sys_setsockopt+0x6d/0xd0 net/socket.c:1902
	 __do_sys_setsockopt net/socket.c:1913 [inline]
	 __se_sys_setsockopt net/socket.c:1910 [inline]
	 __x64_sys_setsockopt+0x1f/0x30 net/socket.c:1910
	 do_syscall_64+0x4a/0x180 arch/x86/entry/common.c:290
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: e236d4a89a2f ("[CRYPTO] authenc: Move enckeylen into key itself")
Cc: <stable@vger.kernel.org> # v2.6.25+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/authenc.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/crypto/authenc.c
+++ b/crypto/authenc.c
@@ -58,14 +58,22 @@ int crypto_authenc_extractkeys(struct cr
 		return -EINVAL;
 	if (rta->rta_type != CRYPTO_AUTHENC_KEYA_PARAM)
 		return -EINVAL;
-	if (RTA_PAYLOAD(rta) < sizeof(*param))
+
+	/*
+	 * RTA_OK() didn't align the rtattr's payload when validating that it
+	 * fits in the buffer.  Yet, the keys should start on the next 4-byte
+	 * aligned boundary.  To avoid confusion, require that the rtattr
+	 * payload be exactly the param struct, which has a 4-byte aligned size.
+	 */
+	if (RTA_PAYLOAD(rta) != sizeof(*param))
 		return -EINVAL;
+	BUILD_BUG_ON(sizeof(*param) % RTA_ALIGNTO);
 
 	param = RTA_DATA(rta);
 	keys->enckeylen = be32_to_cpu(param->enckeylen);
 
-	key += RTA_ALIGN(rta->rta_len);
-	keylen -= RTA_ALIGN(rta->rta_len);
+	key += rta->rta_len;
+	keylen -= rta->rta_len;
 
 	if (keylen < keys->enckeylen)
 		return -EINVAL;


