Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF697C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D53D20881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763556;
	bh=YiirqLleZl1GFyISGs66NxHY8TDgUTCGPKLrft/+wU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DmmcrzcHPK/qlo9WF0PBjAI3UxJgzJkOUjsnCEGYz+WID8/m6ycbYbyXaEuM257Wv
	 2p20aAadlZqJ195r1+xYHcsuT4r+MIZrmzUMgj/EHNewsFupwSB6tKSr/QuaNTtDlm
	 jhPEawlzD+ibmCaqCIMV4pnd1eMuXdkf184OdejU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfA2MFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:05:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729875AbfA2Llg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:41:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85C3720857;
        Tue, 29 Jan 2019 11:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762096;
        bh=YiirqLleZl1GFyISGs66NxHY8TDgUTCGPKLrft/+wU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6x8bJFPXZNCs89BXRoNp9QYlSBF1eefC1dyqgz3mVre1ws6mDu4rpINZ26VwtFVq
         QRscy92LBS6A/3kJ4c9TjS4IKKNKwsGiNhbofRcU3HykbB/SqMCYMvT2/HaaY8NIHc
         VOUJ6TWUhGtuFCb4AU+GvMJPImlHt6JaSGMzfq+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Robert Shteynfeld <robert.shteynfeld@gmail.com>,
        stable@kernel.org, Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.20 108/117] Revert "mm, memory_hotplug: initialize struct pages for the full memory section"
Date:   Tue, 29 Jan 2019 12:35:59 +0100
Message-Id: <20190129113212.758340171@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5542,18 +5542,6 @@ void __meminit memmap_init_zone(unsigned
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
 
 #ifdef CONFIG_ZONE_DEVICE


