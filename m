Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8CBC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FD22184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbfA3MpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:45:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:41406 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727946AbfA3MpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:45:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41B7BAE88;
        Wed, 30 Jan 2019 12:45:13 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, Jiri Kosina <jkosina@suse.cz>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jiri Kosina <jikos@kernel.org>
Subject: [PATCH 2/3] mm/filemap: initiate readahead even if IOCB_NOWAIT is set for the I/O
Date:   Wed, 30 Jan 2019 13:44:19 +0100
Message-Id: <20190130124420.1834-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130124420.1834-1-vbabka@suse.cz>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <20190130124420.1834-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

preadv2(RWF_NOWAIT) can be used to open a side-channel to pagecache contents, as
it reveals metadata about residency of pages in pagecache.

If preadv2(RWF_NOWAIT) returns immediately, it provides a clear "page not
resident" information, and vice versa.

Close that sidechannel by always initiating readahead on the cache if we
encounter a cache miss for preadv2(RWF_NOWAIT); with that in place, probing
the pagecache residency itself will actually populate the cache, making the
sidechannel useless.

Originally-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Kevin Easton <kevin@guarana.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Tejun Heo <tj@kernel.org>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Daniel Gruss <daniel@gruss.cc>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/filemap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9f5e323e883e..7bcdd36e629d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2075,8 +2075,6 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 		page = find_get_page(mapping, index);
 		if (!page) {
-			if (iocb->ki_flags & IOCB_NOWAIT)
-				goto would_block;
 			page_cache_sync_readahead(mapping,
 					ra, filp,
 					index, last_index - index);
-- 
2.20.1

