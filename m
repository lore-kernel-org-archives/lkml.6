Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCDEC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE21721557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOQdVjW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE21721557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeHXT7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbeHXT6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:58:52 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A8592159F;
        Fri, 24 Aug 2018 16:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535127810;
        bh=xLQOyqOdBZE9OaHvzop6bdy6Jv/N6ypKdUom9H1RQIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOQdVjW3k5Ry9mPyhdGxppJ8fYzLL8vDlhh4UlyDh8AD0sCQby3usRYS/nxr4wQ3l
         nXs7m31khQFULtgRbEtZ16CLZSD7En3qNAnkXZqcfwAv3sMl/Tx0m0/skg0iNVDGQC
         LT8Jfo2e/X0CyD47vCkruE/LUBsmVMNm7X4wdFeM=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [RFC PATCH 06/10] fs-verity: add CRC-32C support
Date:   Fri, 24 Aug 2018 09:16:38 -0700
Message-Id: <20180824161642.1144-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824161642.1144-1-ebiggers@kernel.org>
References: <20180824161642.1144-1-ebiggers@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add CRC-32C support to fs-verity, to provide a faster alternative to
SHA-256 for users who want integrity-only (not authenticity), i.e. who
want to detect only accidental corruption, not malicious changes.

CRC-32C is chosen over CRC-32 because the CRC-32C polynomial is believed
to provide slightly better error-detection properties; and CRC-32C is
just as fast (or can be just as fast) as CRC-32, or even faster e.g. on
some x86 processors that have a CRC-32C instruction but not CRC-32.

We use "crc32c" from the crypto API, so the polynomial convention is
bitwise little-endian, the digest is bytewise little-endian, and the CRC
bits are inverted at the beginning and end (which is desirable).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/hash_algs.c         | 4 ++++
 include/uapi/linux/fsverity.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/fs/verity/hash_algs.c b/fs/verity/hash_algs.c
index e16d767070fec..3fd4bba7c4aa6 100644
--- a/fs/verity/hash_algs.c
+++ b/fs/verity/hash_algs.c
@@ -23,6 +23,10 @@ struct fsverity_hash_alg fsverity_hash_algs[] = {
 		.digest_size = 64,
 		.cryptographic = true,
 	},
+	[FS_VERITY_ALG_CRC32C] = {
+		.name = "crc32c",
+		.digest_size = 4,
+	},
 };
 
 /*
diff --git a/include/uapi/linux/fsverity.h b/include/uapi/linux/fsverity.h
index 64846763f7aef..b1afd205bbf87 100644
--- a/include/uapi/linux/fsverity.h
+++ b/include/uapi/linux/fsverity.h
@@ -29,6 +29,7 @@ struct fsverity_digest {
 /* Supported hash algorithms */
 #define FS_VERITY_ALG_SHA256	1
 #define FS_VERITY_ALG_SHA512	2
+#define FS_VERITY_ALG_CRC32C	3	/* for integrity only */
 
 /* Metadata stored near the end of verity files, after the Merkle tree */
 /* This structure is 64 bytes long */
-- 
2.18.0

