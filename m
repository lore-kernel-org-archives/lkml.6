Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD2AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3621F21841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130643;
	bh=AbScsffEIi9W7Tl1GJzxW+ZhesoaI8VdbqdcsjgzdfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vZB1esPQi/ZqXqApaEpSTX46ZQhSvCVvOKY7BVPqldGjYpTWqLOmoHcocAh5UbyFb
	 6msMRh92zrM42HX8e+2XS71deWlhFlYSEOKsX+gwOGBAXzP42hkNgR1cqugPpgXG+R
	 KVB+F0NH6BEMry9pte+0ltA4HDO+OTPvmRRPm/Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfBYVhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:37:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:44426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387426AbfBYVhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:37:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A73A217F5;
        Mon, 25 Feb 2019 21:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130637;
        bh=AbScsffEIi9W7Tl1GJzxW+ZhesoaI8VdbqdcsjgzdfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1sY8eHX2GZlgTzBUs6zzigspwwWmLupGJXmmxrSIO1w8za1xK/Ushp7cNb8BrCQd
         jeanxFQYVUjXS3s31QfL2a36zXDvAavIrVjxmQaUGrdhjC3fjMZ+5Ee6ahxvAnUv/h
         NVGS3c77/fB37CmjOoq9D95uPjy0yDaekpB8QL3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Eric Biggers <ebiggers@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.morris@microsoft.com>
Subject: [PATCH 4.20 147/183] KEYS: user: Align the payload buffer
Date:   Mon, 25 Feb 2019 22:12:00 +0100
Message-Id: <20190225195119.726442686@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit cc1780fc42c76c705dd07ea123f1143dc5057630 upstream.

Align the payload of "user" and "logon" keys so that users of the
keyrings service can access it as a struct that requires more than
2-byte alignment.  fscrypt currently does this which results in the read
of fscrypt_key::size being misaligned as it needs 4-byte alignment.

Align to __alignof__(u64) rather than __alignof__(long) since in the
future it's conceivable that people would use structs beginning with
u64, which on some platforms would require more than 'long' alignment.

Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Fixes: 2aa349f6e37c ("[PATCH] Keys: Export user-defined keyring operations")
Fixes: 88bd6ccdcdd6 ("ext4 crypto: add encryption key management facilities")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/keys/user-type.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/keys/user-type.h
+++ b/include/keys/user-type.h
@@ -31,7 +31,7 @@
 struct user_key_payload {
 	struct rcu_head	rcu;		/* RCU destructor */
 	unsigned short	datalen;	/* length of this data */
-	char		data[0];	/* actual data */
+	char		data[0] __aligned(__alignof__(u64)); /* actual data */
 };
 
 extern struct key_type key_type_user;


