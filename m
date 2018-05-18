Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeERHwc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:52:32 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42654 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752334AbeERHuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:50:15 -0400
X-Google-Smtp-Source: AB8JxZoL3AiIviOKdHrNOfAbn8VtPNkg4tbBYqsmtqEZTe4dyCr9apZRkBYc/ACaORDf0DBczoTz0w==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@kernel.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 07/10] block: Add missing flush_dcache_page() call
Date: Fri, 18 May 2018 03:49:12 -0400
Message-Id: <20180518074918.13816-15-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518074918.13816-1-kent.overstreet@gmail.com>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
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
