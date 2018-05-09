Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933582AbeEIBed (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 21:34:33 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34763 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933532AbeEIBe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 21:34:27 -0400
X-Google-Smtp-Source: AB8JxZpjM6DG4JsDlui+eG+1+PEtsOKMzu5N3LrNc43l4QYW8T2J5SVI0VQ13Kakk9I/Ow0yKJllaA==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@kernel.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 07/10] block: Add missing flush_dcache_page() call
Date: Tue,  8 May 2018 21:33:55 -0400
Message-Id: <20180509013358.16399-8-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509013358.16399-1-kent.overstreet@gmail.com>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a bio can point to userspace pages (e.g. direct IO), this is
generally necessary.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 block/bio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index c58544d4bc..ce8e259f9a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -994,6 +994,8 @@ void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 		kunmap_atomic(dst_p);
 		kunmap_atomic(src_p);
 
+		flush_dcache_page(dst_bv.bv_page);
+
 		bio_advance_iter(src, src_iter, bytes);
 		bio_advance_iter(dst, dst_iter, bytes);
 	}
-- 
2.17.0
