Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7C5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7C020666
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xQhICGAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7C020666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbeHXT64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727615AbeHXT6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:58:51 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6D7721581;
        Fri, 24 Aug 2018 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535127810;
        bh=OQD0rd+rLeKn0lKuhrJDO40aKV0AV4BVVy99LbMSS4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xQhICGAEHPmsRxgxdYQyMUZPuVdcp1+8hGao9sQK37aVdxsAAealskjJvu0STPSOt
         lHLoPxSBjW1iKhKP3JK9r4RsGZ4Lof2muPPSPaBfF9A6yfQ7YZSRs2YQ6EetoMghj9
         EJIg1EjSztPR10qo0sIaDPRBymLeJMITHyhwBoOE=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [RFC PATCH 05/10] fs-verity: add SHA-512 support
Date:   Fri, 24 Aug 2018 09:16:37 -0700
Message-Id: <20180824161642.1144-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824161642.1144-1-ebiggers@kernel.org>
References: <20180824161642.1144-1-ebiggers@kernel.org>
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
index c553f99dc4973..1046b87b12dee 100644
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
index 424a26ee2f3c2..e16d767070fec 100644
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
index 24ebb8b6ea0d4..64846763f7aef 100644
--- a/include/uapi/linux/fsverity.h
+++ b/include/uapi/linux/fsverity.h
@@ -28,6 +28,7 @@ struct fsverity_digest {
 
 /* Supported hash algorithms */
 #define FS_VERITY_ALG_SHA256	1
+#define FS_VERITY_ALG_SHA512	2
 
 /* Metadata stored near the end of verity files, after the Merkle tree */
 /* This structure is 64 bytes long */
-- 
2.18.0

