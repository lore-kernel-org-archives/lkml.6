Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4405AC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0508A20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6iKpHLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0508A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeKBIAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbeKBH7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:59:16 -0400
Received: from ebiggers-linuxstation.kir.corp.google.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76AD02086D;
        Thu,  1 Nov 2018 22:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541112857;
        bh=6aWfDT8BFa0Xa9diw5+HNmJhJldqF+mtmBKHTyX1P4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N6iKpHLIFP/bsmTWDW9CXDlwyhBA33HpZ0VjIMCloQzhOzbz3hG1MOdiS+DbqxI1E
         /Jxo0o7CX2QZfIWbY7Zo5vPEROBH3BAujEzaFs8fzlNH+9UkK33AaER6yOZOYP9D4g
         XCutFPCjcy1XmnMdjb2PQt59Iz0oq9LmCrgzksxw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH v2 08/12] fs-verity: add CRC-32C support
Date:   Thu,  1 Nov 2018 15:52:26 -0700
Message-Id: <20181101225230.88058-9-ebiggers@kernel.org>
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
index 3174a0c08785d..109afeec60fc9 100644
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
index 67ed830ae2ece..a96bbf87077de 100644
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
2.19.1.568.g152ad8e336-goog

