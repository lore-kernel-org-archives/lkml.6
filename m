Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B640C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A97420657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+BRq6OC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A97420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeKBH7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbeKBH7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:59:16 -0400
Received: from ebiggers-linuxstation.kir.corp.google.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E98F20866;
        Thu,  1 Nov 2018 22:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541112857;
        bh=GU3tCBUJ8zIG8Ivryy6fFaMUuIw2pxPwqQtzuo7iW/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q+BRq6OCbxF+9/cLhbFrN9807OQMQGG0XKP3YOqwngFsWbePmDcwMzbYNTqkXuhIl
         GeDN+KeB/AVZv5hkZ+6HTG+rWbEzXE5oLCUWOLN/8nIThRruGayC29einhihCvchzZ
         ynM8mya8E8+xSdI6kDAgniGI8k3jiW3mybxTwwGg=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH v2 07/12] fs-verity: add SHA-512 support
Date:   Thu,  1 Nov 2018 15:52:25 -0700
Message-Id: <20181101225230.88058-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181101225230.88058-1-ebiggers@kernel.org>
References: <20181101225230.88058-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add SHA-512 support to fs-verity.  This is primarily a demonstration of
the (small) changes needed to support a new hash algorithm; it's
anticipated that most users will still prefer SHA-256 due to the smaller
space required to store the hashes, though some may prefer SHA-512.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/fsverity_private.h  | 2 +-
 fs/verity/hash_algs.c         | 5 +++++
 include/uapi/linux/fsverity.h | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index dfdbac3874d74..c3a261a598557 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -30,7 +30,7 @@
  * Largest digest size among all hash algorithms supported by fs-verity.  This
  * can be increased if needed.
  */
-#define FS_VERITY_MAX_DIGEST_SIZE	SHA256_DIGEST_SIZE
+#define FS_VERITY_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
 
 /* A hash algorithm supported by fs-verity */
 struct fsverity_hash_alg {
diff --git a/fs/verity/hash_algs.c b/fs/verity/hash_algs.c
index 9c19c9553f120..3174a0c08785d 100644
--- a/fs/verity/hash_algs.c
+++ b/fs/verity/hash_algs.c
@@ -18,6 +18,11 @@ struct fsverity_hash_alg fsverity_hash_algs[] = {
 		.digest_size = 32,
 		.cryptographic = true,
 	},
+	[FS_VERITY_ALG_SHA512] = {
+		.name = "sha512",
+		.digest_size = 64,
+		.cryptographic = true,
+	},
 };
 
 /*
diff --git a/include/uapi/linux/fsverity.h b/include/uapi/linux/fsverity.h
index 55b9f32676220..67ed830ae2ece 100644
--- a/include/uapi/linux/fsverity.h
+++ b/include/uapi/linux/fsverity.h
@@ -28,6 +28,7 @@ struct fsverity_digest {
 
 /* Supported hash algorithms */
 #define FS_VERITY_ALG_SHA256	1
+#define FS_VERITY_ALG_SHA512	2
 
 /* Metadata stored near the end of verity files, after the Merkle tree */
 /* This structure is 64 bytes long */
-- 
2.19.1.568.g152ad8e336-goog

