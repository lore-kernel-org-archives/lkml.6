Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89282C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D63921570
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VoVHiYp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D63921570
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeHGXfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:35:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37421 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeHGXfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:35:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so40081pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XEthQhO55UFajYXolwRxBcBomydbdSRnD/7XsWAlazI=;
        b=VoVHiYp/gXE0LJZ4QS++bRem24LHShZuFLMwHmZ6sXT8hqF3SxF6Xz3ZLAPt4euDaK
         ECglSyfn4uIjsXvvu166YDFD3+2sSulnh6CNhIKbqXjy0OYbNqcqwypWBk1ZeNL150yF
         g1toA2/NMcNYkvjuhyFfr78SRyz1fwP+5hmbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XEthQhO55UFajYXolwRxBcBomydbdSRnD/7XsWAlazI=;
        b=jRHiYhVtotQArjTRs2nigJwn4yPoZ93OXbaUUJYMC2y3EpikjB05sogLS7DdgnofIp
         DF7th7qgs5ucWHI5F3FrTqNazAS6NWG4WHbrQPhUJtUUAquSxc2zFkPz7a6US7dcOIBK
         0V18imxv8zEOloGFhwhoO4Ifu90R5WcbNR0fCh2jQ+VYFOGDKxT4Cx5UTbncH3Itgo9v
         cArpLFDAO9cxpEwv8ZuRmDVBXqmikML7jh88sMtoTMBo3c4yP42EiwkpURXqqRMDghV+
         AmEuxtGEALNv4QtzW77xcZLEWbCp5x2dw/JoT2eVpY4qzqRM7i2p2wcw2VMKAwwQtf8I
         gg2w==
X-Gm-Message-State: AOUpUlFJE2bjl1M3NWAQtD4XmVXlxMUfG4+keZpZwlp41DnZQlmGpMlg
        KGdrmvHRxyXYHEnnjrg0z2bcVg==
X-Google-Smtp-Source: AA+uWPz/fe343Jl33/i+Gyzys8F0zdRXEvuDKIjAnH6YJeFS0cii+juo5vag4tBCo9TKCgLcL6wJIg==
X-Received: by 2002:a63:d518:: with SMTP id c24-v6mr58049pgg.357.1533676732370;
        Tue, 07 Aug 2018 14:18:52 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id u83-v6sm8585411pfj.37.2018.08.07.14.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 14:18:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        qat-linux@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v8 5/9] dm: Remove VLA usage from hashes
Date:   Tue,  7 Aug 2018 14:18:39 -0700
Message-Id: <20180807211843.47586-6-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180807211843.47586-1-keescook@chromium.org>
References: <20180807211843.47586-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this uses
the new HASH_MAX_DIGESTSIZE from the crypto layer to allocate the upper
bounds on stack usage.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-integrity.c  | 23 +++++++++++++++++------
 drivers/md/dm-verity-fec.c |  5 ++++-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 86438b2f10dd..884edd7cf1d0 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -521,7 +521,12 @@ static void section_mac(struct dm_integrity_c *ic, unsigned section, __u8 result
 		}
 		memset(result + size, 0, JOURNAL_MAC_SIZE - size);
 	} else {
-		__u8 digest[size];
+		__u8 digest[HASH_MAX_DIGESTSIZE];
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
+		char checksums_onstack[HASH_MAX_DIGESTSIZE];
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
+					char checksums_onstack[max(HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 
 					integrity_sector_checksum(ic, logical_sector, mem + bv.bv_offset, checksums_onstack);
 					if (unlikely(memcmp(checksums_onstack, journal_entry_tag(ic, je), ic->tag_size))) {
@@ -1516,7 +1527,7 @@ static bool __journal_read_write(struct dm_integrity_io *dio, struct bio *bio,
 				if (ic->internal_hash) {
 					unsigned digest_size = crypto_shash_digestsize(ic->internal_hash);
 					if (unlikely(digest_size > ic->tag_size)) {
-						char checksums_onstack[digest_size];
+						char checksums_onstack[HASH_MAX_DIGESTSIZE];
 						integrity_sector_checksum(ic, logical_sector, (char *)js, checksums_onstack);
 						memcpy(journal_entry_tag(ic, je), checksums_onstack, ic->tag_size);
 					} else
@@ -1937,7 +1948,7 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned write_start,
 				    unlikely(from_replay) &&
 #endif
 				    ic->internal_hash) {
-					char test_tag[max(crypto_shash_digestsize(ic->internal_hash), ic->tag_size)];
+					char test_tag[max_t(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 
 					integrity_sector_checksum(ic, sec + ((l - j) << ic->sb->log2_sectors_per_block),
 								  (char *)access_journal_data(ic, i, l), test_tag);
diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 684af08d0747..0ce04e5b4afb 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -212,12 +212,15 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 	struct dm_verity_fec_io *fio = fec_io(io);
 	u64 block, ileaved;
 	u8 *bbuf, *rs_block;
-	u8 want_digest[v->digest_size];
+	u8 want_digest[HASH_MAX_DIGESTSIZE];
 	unsigned n, k;
 
 	if (neras)
 		*neras = 0;
 
+	if (WARN_ON(v->digest_size > sizeof(want_digest)))
+		return -EINVAL;
+
 	/*
 	 * read each of the rsn data blocks that are part of the RS block, and
 	 * interleave contents to available bufs
-- 
2.17.1

