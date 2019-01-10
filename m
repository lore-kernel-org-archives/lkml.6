Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC4AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6384F2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tv8H/vdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfAJDJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 22:09:17 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34085 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfAJDJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 22:09:17 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so14300403itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 19:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=feEpNlqpnoPxpeqMd/XrOoCASnhVqa5NxR5fyRNqcco=;
        b=Tv8H/vdqTuaSxx6YM7Tw7ztGe3HG+L/n4C482Wi5x1By3kaM1qCnpEIfvnqdP5T2qY
         n4B+UCkE0CK2HWMreDyQ0g7BL22CUf86NgcZN6/gbQb9t8lRTN+MH9y/6Npy4Kr824lo
         pCW5ay6gwu1oDtDQXfHBe75mGSUwVptoAITTxjLTTONFPseTtVIssVGpvZO23MT8RnDV
         T7khCLNzXzqh0RYFavFyzXU5DwCA4S6NjyTTRQcGLHVeTKTNi8trYXP88L40ldCCwhkg
         v/zitaBmQXlVj/+QJcXpKc98EPpEMmyy5PJC4/7n0Ddd1zepbGxGZtxbaPMqKHTIvC3p
         i75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=feEpNlqpnoPxpeqMd/XrOoCASnhVqa5NxR5fyRNqcco=;
        b=fAJPoxOnT0uaAJ2E38EEWxuA/DXL5NcwmDpc7RdjYacmcjjb4gBL2TgwASRobc0oC2
         yx5OYeCziL/OyCxcS87zAglwGo2Fl5h84Ulynr/VkARjx8x3/AZqvLkf+wZRc02TBjji
         e6vrUE1Pw9TkwgHzUqBWzY1SfwIJhlvoBwOoX1ZOzLYKvk3AUvLshTFcoL6JTf5M+n2B
         K+Ch/244+QVUXzx3z3cnUxJMnLaxPvWgWqJlkpDHOCUTAw59S/Qu7DLvglLUhCDA5tty
         U2IkIQTPv07WSkBGUEiYeZRL+sr8g4mjJfHUN7myV99vo5OW2+ZpiFsKuRRf2w6y3qVD
         HfJA==
X-Gm-Message-State: AJcUukc2j59BIuNiw232Kn/BDclbPigdVUNIw1AIXJntUixTUdwF2MCr
        ZDqap8o4c40ftnN1HZdjDtlC7w==
X-Google-Smtp-Source: ALg8bN535z86xgPNeQ/xvWw3MWLM89G+i8xX+OMvHXHYdqDsqzJ41tdIRkaJNKC3AYPClZ5zQDSF+w==
X-Received: by 2002:a24:cc05:: with SMTP id x5mr6032700itf.82.1547089756085;
        Wed, 09 Jan 2019 19:09:16 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id n124sm8977731itn.4.2019.01.09.19.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 19:09:15 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH] mm/shmem: make find_get_pages_range() work for huge page
Date:   Wed,  9 Jan 2019 20:08:38 -0700
Message-Id: <20190110030838.84446-1-yuzhao@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_get_pages_range() and find_get_pages_range_tag() already
correctly increment reference count on head when seeing compound
page, but they may still use page index from tail. Page index
from tail is always zero, so these functions don't work on huge
shmem. This hasn't been a problem because, AFAIK, nobody calls
these functions on (huge) shmem. Fix them anyway just in case.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 81adec8ee02c..cf5fd773314a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1704,7 +1704,7 @@ unsigned find_get_pages_range(struct address_space *mapping, pgoff_t *start,
 
 		pages[ret] = page;
 		if (++ret == nr_pages) {
-			*start = page->index + 1;
+			*start = xas.xa_index + 1;
 			goto out;
 		}
 		continue;
@@ -1850,7 +1850,7 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
 
 		pages[ret] = page;
 		if (++ret == nr_pages) {
-			*index = page->index + 1;
+			*index = xas.xa_index + 1;
 			goto out;
 		}
 		continue;
-- 
2.20.1.97.g81188d93c3-goog

