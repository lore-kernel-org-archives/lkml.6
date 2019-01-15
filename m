Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ED2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52637208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570401;
	bh=xxsuo3h3R9Y/SK6X3twXnMtEzT4pDdlMRBKoUzUdA3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HlyWx4N+p/u73BrD5C239nJPOhh/JKSNpGaEqAS2Md4b0hVXUHdrPfMcnT80wvBgP
	 E3J23/XpuUhD53heKuEBAUO7mgAP19oE6neqc+1mq2AlSS0wuyq1XuZ9gBpwmbq+74
	 4gtVXwbQbnEqnqxoLSiV8CGW2K+np3lRgekc+FL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbfAOQj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:39:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732448AbfAOQjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:39:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9222F20675;
        Tue, 15 Jan 2019 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570393;
        bh=xxsuo3h3R9Y/SK6X3twXnMtEzT4pDdlMRBKoUzUdA3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wy7l2s63dZovEfRDtnDfKiyx2Q3RGtg1/lHZnbPs64MTx6HXe5padxr/14HWpRhKv
         oPpxysPKkny+KE9pDUPv+LbQJP4/Aj9fMlqq4wWwrlDb75HkEx3KmS9VQpWN1GxDar
         0KuxZj7PJX5dF9T+6fJ8+FFcPhCaoNumSeOVmwQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Stancek <jstancek@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Laszlo Ersek <lersek@redhat.com>
Subject: [PATCH 4.9 09/16] mm: page_mapped: dont assume compound page is huge or THP
Date:   Tue, 15 Jan 2019 17:35:52 +0100
Message-Id: <20190115154849.203733744@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154848.164648613@linuxfoundation.org>
References: <20190115154848.164648613@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Stancek <jstancek@redhat.com>

commit 8ab88c7169b7fba98812ead6524b9d05bc76cf00 upstream.

LTP proc01 testcase has been observed to rarely trigger crashes
on arm64:
    page_mapped+0x78/0xb4
    stable_page_flags+0x27c/0x338
    kpageflags_read+0xfc/0x164
    proc_reg_read+0x7c/0xb8
    __vfs_read+0x58/0x178
    vfs_read+0x90/0x14c
    SyS_read+0x60/0xc0

The issue is that page_mapped() assumes that if compound page is not
huge, then it must be THP.  But if this is 'normal' compound page
(COMPOUND_PAGE_DTOR), then following loop can keep running (for
HPAGE_PMD_NR iterations) until it tries to read from memory that isn't
mapped and triggers a panic:

        for (i = 0; i < hpage_nr_pages(page); i++) {
                if (atomic_read(&page[i]._mapcount) >= 0)
                        return true;
	}

I could replicate this on x86 (v4.20-rc4-98-g60b548237fed) only
with a custom kernel module [1] which:
 - allocates compound page (PAGEC) of order 1
 - allocates 2 normal pages (COPY), which are initialized to 0xff (to
   satisfy _mapcount >= 0)
 - 2 PAGEC page structs are copied to address of first COPY page
 - second page of COPY is marked as not present
 - call to page_mapped(COPY) now triggers fault on access to 2nd COPY
   page at offset 0x30 (_mapcount)

[1] https://github.com/jstancek/reproducers/blob/master/kernel/page_mapped_crash/repro.c

Fix the loop to iterate for "1 << compound_order" pages.

Kirrill said "IIRC, sound subsystem can producuce custom mapped compound
pages".

Link: http://lkml.kernel.org/r/c440d69879e34209feba21e12d236d06bc0a25db.1543577156.git.jstancek@redhat.com
Fixes: e1534ae95004 ("mm: differentiate page_mapped() from page_mapcount() for compound pages")
Signed-off-by: Jan Stancek <jstancek@redhat.com>
Debugged-by: Laszlo Ersek <lersek@redhat.com>
Suggested-by: "Kirill A. Shutemov" <kirill@shutemov.name>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/util.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/util.c
+++ b/mm/util.c
@@ -389,7 +389,7 @@ bool page_mapped(struct page *page)
 		return true;
 	if (PageHuge(page))
 		return false;
-	for (i = 0; i < hpage_nr_pages(page); i++) {
+	for (i = 0; i < (1 << compound_order(page)); i++) {
 		if (atomic_read(&page[i]._mapcount) >= 0)
 			return true;
 	}


