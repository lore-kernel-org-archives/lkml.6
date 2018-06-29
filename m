Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2163C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CCB27980
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RFqPToSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CCB27980
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936384AbeF2A26 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:28:58 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44718 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935789AbeF2A2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:28:51 -0400
Received: by mail-pf0-f193.google.com with SMTP id j3-v6so3355646pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=drpA6tkH0/4nnAgKnMLWfij+3JEItujTdy3T6O/cSWg=;
        b=RFqPToSNLMCI6KJZJxbEJv6wl7Rq65piSGDcTmMvdrHcYh+bw8Gv0ruw29Jd5rleuY
         NQM+zCNbvI5v2uO2Z5kZJYBuI5ir6n4q/E7OTHqITE0wbO85cbjvBDQ5umXoEa1wsgh4
         fXZz7P3jbe1WRdRT8Hr1rCAFhtqxyfjB/6rAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=drpA6tkH0/4nnAgKnMLWfij+3JEItujTdy3T6O/cSWg=;
        b=P34lKGNx/91VwH263Ic9i5wtWQLzdkBX2RFEq2uMFOwyPNzkWSqlL6DUClRUz9el+9
         4vQXl4TxH/gF9FLY5JxGdrxYN/37Xb8TII5TRhD3eLwynrrqn7yWJ7t30sm9bvxnfeDQ
         QfoTgOli4457gPSv1yzBeLEDvUhGspLFzQG+dYb/ZjJiiZUHLXorZgNr+4ljO+6UHAYM
         b4aNdx3wta8jj74WFiY4Z4JWRH2DPQ4hOeLIgWVAn8+hI+c/7mZ8jT3u5LCt2Nq5hlth
         6kMUwYqwO4m3qycIv50CnYVQpVBH9dLk4pDkJVZYaex7R4XMJ6BlZz+92Ixv4YRmu0Ue
         oefQ==
X-Gm-Message-State: APt69E1ybLmPvBWtpSxx1DYUcoML2QYCC8SoY9NrTVx6xJ5SE429YEIZ
        RKjyEHcZpftynVAueu+kbxmX4w==
X-Google-Smtp-Source: AAOMgpc98v0vXx/Yq5nk2j1vzwN4Jye6X/XzUvIhqPuPk7MaoBNtge+ETCwPdsi4M2fHVq0LCfYlmg==
X-Received: by 2002:a62:c819:: with SMTP id z25-v6mr11428331pff.44.1530232131344;
        Thu, 28 Jun 2018 17:28:51 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q6-v6sm10322786pgc.21.2018.06.28.17.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 17:28:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] dm integrity: Remove VLA usage
Date:   Thu, 28 Jun 2018 17:28:38 -0700
Message-Id: <20180629002843.31095-5-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629002843.31095-1-keescook@chromium.org>
References: <20180629002843.31095-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this uses
the new SHASH_MAX_DIGESTSIZE from the crypto layer to allocate the upper
bounds on stack usage.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-integrity.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 86438b2f10dd..85e8ce1625a2 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -521,7 +521,12 @@ static void section_mac(struct dm_integrity_c *ic, unsigned section, __u8 result
 		}
 		memset(result + size, 0, JOURNAL_MAC_SIZE - size);
 	} else {
-		__u8 digest[size];
+		__u8 digest[SHASH_MAX_DIGESTSIZE];
+
+		if (WARN_ON(size > sizeof(digest))) {
+			dm_integrity_io_error(ic, "digest_size", -EINVAL);
+			goto err;
+		}
 		r = crypto_shash_final(desc, digest);
 		if (unlikely(r)) {
 			dm_integrity_io_error(ic, "crypto_shash_final", r);
@@ -1244,7 +1249,7 @@ static void integrity_metadata(struct work_struct *w)
 		struct bio *bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
 		char *checksums;
 		unsigned extra_space = unlikely(digest_size > ic->tag_size) ? digest_size - ic->tag_size : 0;
-		char checksums_onstack[ic->tag_size + extra_space];
+		char checksums_onstack[SHASH_MAX_DIGESTSIZE];
 		unsigned sectors_to_process = dio->range.n_sectors;
 		sector_t sector = dio->range.logical_sector;
 
@@ -1253,8 +1258,14 @@ static void integrity_metadata(struct work_struct *w)
 
 		checksums = kmalloc((PAGE_SIZE >> SECTOR_SHIFT >> ic->sb->log2_sectors_per_block) * ic->tag_size + extra_space,
 				    GFP_NOIO | __GFP_NORETRY | __GFP_NOWARN);
-		if (!checksums)
+		if (!checksums) {
 			checksums = checksums_onstack;
+			if (WARN_ON(extra_space &&
+				    digest_size > sizeof(checksums_onstack))) {
+				r = -EINVAL;
+				goto error;
+			}
+		}
 
 		__bio_for_each_segment(bv, bio, iter, dio->orig_bi_iter) {
 			unsigned pos;
@@ -1466,7 +1477,7 @@ static bool __journal_read_write(struct dm_integrity_io *dio, struct bio *bio,
 				} while (++s < ic->sectors_per_block);
 #ifdef INTERNAL_VERIFY
 				if (ic->internal_hash) {
-					char checksums_onstack[max(crypto_shash_digestsize(ic->internal_hash), ic->tag_size)];
+					char checksums_onstack[max(SHASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 
 					integrity_sector_checksum(ic, logical_sector, mem + bv.bv_offset, checksums_onstack);
 					if (unlikely(memcmp(checksums_onstack, journal_entry_tag(ic, je), ic->tag_size))) {
@@ -1516,7 +1527,7 @@ static bool __journal_read_write(struct dm_integrity_io *dio, struct bio *bio,
 				if (ic->internal_hash) {
 					unsigned digest_size = crypto_shash_digestsize(ic->internal_hash);
 					if (unlikely(digest_size > ic->tag_size)) {
-						char checksums_onstack[digest_size];
+						char checksums_onstack[SHASH_MAX_DIGESTSIZE];
 						integrity_sector_checksum(ic, logical_sector, (char *)js, checksums_onstack);
 						memcpy(journal_entry_tag(ic, je), checksums_onstack, ic->tag_size);
 					} else
@@ -1937,7 +1948,7 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned write_start,
 				    unlikely(from_replay) &&
 #endif
 				    ic->internal_hash) {
-					char test_tag[max(crypto_shash_digestsize(ic->internal_hash), ic->tag_size)];
+					char test_tag[max_t(size_t, SHASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 
 					integrity_sector_checksum(ic, sec + ((l - j) << ic->sb->log2_sectors_per_block),
 								  (char *)access_journal_data(ic, i, l), test_tag);
-- 
2.17.1

