Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CC2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681BF208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=net.com.org.es header.i=@net.com.org.es header.b="N7yBokEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681BF208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=net.com.org.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeKOKc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:32:56 -0500
Received: from delany.relativists.org ([176.31.98.17]:52760 "EHLO
        delany.relativists.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOKc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 05:32:56 -0500
Received: from geertz.rel (geertz.rel [192.168.82.3])
        by delany.relativists.org (Postfix) with ESMTPSA id 09B1F8B7;
        Wed, 14 Nov 2018 21:27:22 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=net.com.org.es;
        s=delany-v1; t=1542241642;
        bh=yALvhPzxzvWc1tryg/p0QMuut6ADbaoj0qvTouUF3Ts=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type:From;
        b=N7yBokEGNfAvAknlXk7iMFuJd5J4rvXQrj3rCcJ027X919a8Is2cZQuPnuOHW5pT+
         gI3ZOyquNLbz2vFkWwvwV9M1dlLQzFIV3tvB1KyoqYnFGKRf07Lu26wmZUrACI5gup
         X2T05cBrFLVKsWmOIDt5U/+rwtKKUO14gdX/8v34=
Received: by geertz.rel (Postfix, from userid 1000)
        id 657CF7FE95; Wed, 14 Nov 2018 21:27:19 -0300 (-03)
From:   =?UTF-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Chris Mason <clm@fb.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] lib/zstd: mark some internal functions as static with ZSTD_STATIC
Date:   Wed, 14 Nov 2018 21:27:19 -0300
Message-Id: <7e1778db6a6f586f3c7662c4878a349fde92084d.1542240915.git.dato@net.com.org.es>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <0ba48478013532f20856dca7d90c343d93901d54.1542240915.git.dato@net.com.org.es>
References: <0ba48478013532f20856dca7d90c343d93901d54.1542240915.git.dato@net.com.org.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ZSTD_STATIC instead of vanilla static because the functions are
actually unused, and the macro adds the unused attribute.

This silences -Wmissing-prototypes when defining.

Signed-off-by: Adeodato Simó <dato@net.com.org.es>
---
I separated these two functions into a separate patch because they
are actually unused.

If you'd rather have them removed, we may do that as well.

Note that the ZSTD_STATIC macro adds the unused attribute in addition
to static, but it adds __inline as well.

 lib/zstd/compress.c     | 2 +-
 lib/zstd/fse_compress.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
index 3eee699e1fd6..c572d064775f 100644
--- a/lib/zstd/compress.c
+++ b/lib/zstd/compress.c
@@ -431,7 +431,7 @@ static void ZSTD_reduceIndex(ZSTD_CCtx *zc, const U32 reducerValue)
 
 /* See doc/zstd_compression_format.md for detailed format description */
 
-size_t ZSTD_noCompressBlock(void *dst, size_t dstCapacity, const void *src, size_t srcSize)
+ZSTD_STATIC size_t ZSTD_noCompressBlock(void *dst, size_t dstCapacity, const void *src, size_t srcSize)
 {
 	if (srcSize + ZSTD_blockHeaderSize > dstCapacity)
 		return ERROR(dstSize_tooSmall);
diff --git a/lib/zstd/fse_compress.c b/lib/zstd/fse_compress.c
index ef3d1741d532..05a148eabd09 100644
--- a/lib/zstd/fse_compress.c
+++ b/lib/zstd/fse_compress.c
@@ -474,7 +474,7 @@ size_t FSE_count_wksp(unsigned *count, unsigned *maxSymbolValuePtr, const void *
 	`FSE_symbolCompressionTransform symbolTT[maxSymbolValue+1];`  // This size is variable
 Allocation is manual (C standard does not support variable-size structures).
 */
-size_t FSE_sizeof_CTable(unsigned maxSymbolValue, unsigned tableLog)
+ZSTD_STATIC size_t FSE_sizeof_CTable(unsigned maxSymbolValue, unsigned tableLog)
 {
 	if (tableLog > FSE_MAX_TABLELOG)
 		return ERROR(tableLog_tooLarge);
-- 
2.19.1

