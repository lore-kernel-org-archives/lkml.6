Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5705C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07AE2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762447;
	bh=/B+1Zv3ry4KRryELdIhteJaqUoi/SJfKMkQbQwRO8Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gZ+LAOV8RJKYFGgZqUWJVULADxHWnuTzi4rjH9aAwpl3gBL8tkDsp7y9ZJVkbQsyc
	 +c+r6Z4vJbBKYraAJP43ZqO6gJc8T1rEL6LoxT366XWSiFydLu0z8KjQVboEC1vv2x
	 rb1oMl9dlCemXTpz3nAhwpaUAP+h4eLZ532ffbSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbfA2LrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731172AbfA2LrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:47:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D94C20882;
        Tue, 29 Jan 2019 11:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762438;
        bh=/B+1Zv3ry4KRryELdIhteJaqUoi/SJfKMkQbQwRO8Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9uTZgeDI1KGx/OmFyeXxfX014252jDApKltE1ErZFr98wKBFa11L3406g1bqX8BI
         0sNuB3+BBGPtN0CBMqlKsvrLCmg+LRz0IjOo7z+SZk4tclJhIaZmKZnpsw0X7EQHSV
         w2m/nC0PDNjeI5tq22Nzmxv/oJaytL3bYH46Chkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Robert Shteynfeld <robert.shteynfeld@gmail.com>,
        stable@kernel.org, Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 101/103] Revert "mm, memory_hotplug: initialize struct pages for the full memory section"
Date:   Tue, 29 Jan 2019 12:36:18 +0100
Message-Id: <20190129113207.561654704@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>

commit 4aa9fc2a435abe95a1e8d7f8c7b3d6356514b37a upstream.

This reverts commit 2830bf6f05fb3e05bc4743274b806c821807a684.

The underlying assumption that one sparse section belongs into a single
numa node doesn't hold really. Robert Shteynfeld has reported a boot
failure. The boot log was not captured but his memory layout is as
follows:

  Early memory node ranges
    node   1: [mem 0x0000000000001000-0x0000000000090fff]
    node   1: [mem 0x0000000000100000-0x00000000dbdf8fff]
    node   1: [mem 0x0000000100000000-0x0000001423ffffff]
    node   0: [mem 0x0000001424000000-0x0000002023ffffff]

This means that node0 starts in the middle of a memory section which is
also in node1.  memmap_init_zone tries to initialize padding of a
section even when it is outside of the given pfn range because there are
code paths (e.g.  memory hotplug) which assume that the full worth of
memory section is always initialized.

In this particular case, though, such a range is already intialized and
most likely already managed by the page allocator.  Scribbling over
those pages corrupts the internal state and likely blows up when any of
those pages gets used.

Reported-by: Robert Shteynfeld <robert.shteynfeld@gmail.com>
Fixes: 2830bf6f05fb ("mm, memory_hotplug: initialize struct pages for the full memory section")
Cc: stable@kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_alloc.c |   12 ------------
 1 file changed, 12 deletions(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5538,18 +5538,6 @@ not_early:
 			cond_resched();
 		}
 	}
-#ifdef CONFIG_SPARSEMEM
-	/*
-	 * If the zone does not span the rest of the section then
-	 * we should at least initialize those pages. Otherwise we
-	 * could blow up on a poisoned page in some paths which depend
-	 * on full sections being initialized (e.g. memory hotplug).
-	 */
-	while (end_pfn % PAGES_PER_SECTION) {
-		__init_single_page(pfn_to_page(end_pfn), end_pfn, zone, nid);
-		end_pfn++;
-	}
-#endif
 }
 
 static void __meminit zone_init_free_lists(struct zone *zone)


