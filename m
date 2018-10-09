Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C353C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBC320C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBC320C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJIWtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:49:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36637 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJIWtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:49:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99FVMxX1091824
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 08:31:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99FVL791091821;
        Tue, 9 Oct 2018 08:31:21 -0700
Date:   Tue, 9 Oct 2018 08:31:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bjorn Helgaas <tipbot@zytor.com>
Message-ID: <tip-a98959fdbda1849a01b2150bb635ed559ec06700@git.kernel.org>
Cc:     dan.j.williams@intel.com, thomas.lendacky@amd.com,
        lijiang@redhat.com, bp@suse.de, bhelgaas@google.com,
        baiyaowei@cmss.chinamobile.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tiwai@suse.de,
        mingo@kernel.org, brijesh.singh@amd.com, tglx@linutronix.de,
        x86@kernel.org, vgoyal@redhat.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tiwai@suse.de,
          mingo@kernel.org, tglx@linutronix.de, brijesh.singh@amd.com,
          vgoyal@redhat.com, x86@kernel.org, thomas.lendacky@amd.com,
          lijiang@redhat.com, dan.j.williams@intel.com, bp@suse.de,
          bhelgaas@google.com, akpm@linux-foundation.org,
          baiyaowei@cmss.chinamobile.com
In-Reply-To: <153805812254.1157.16736368485811773752.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153805812254.1157.16736368485811773752.stgit@bhelgaas-glaptop.roam.corp.google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] resource: Include resource end in walk_*() interfaces
Git-Commit-ID: a98959fdbda1849a01b2150bb635ed559ec06700
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a98959fdbda1849a01b2150bb635ed559ec06700
Gitweb:     https://git.kernel.org/tip/a98959fdbda1849a01b2150bb635ed559ec06700
Author:     Bjorn Helgaas <bhelgaas@google.com>
AuthorDate: Thu, 27 Sep 2018 09:22:02 -0500
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 9 Oct 2018 17:18:34 +0200

resource: Include resource end in walk_*() interfaces

find_next_iomem_res() finds an iomem resource that covers part of a range
described by "start, end".  All callers expect that range to be inclusive,
i.e., both start and end are included, but find_next_iomem_res() doesn't
handle the end address correctly.

If it finds an iomem resource that contains exactly the end address, it
skips it, e.g., if "start, end" is [0x0-0x10000] and there happens to be an
iomem resource [mem 0x10000-0x10000] (the single byte at 0x10000), we skip
it:

  find_next_iomem_res(...)
  {
    start = 0x0;
    end = 0x10000;
    for (p = next_resource(...)) {
      # p->start = 0x10000;
      # p->end = 0x10000;
      # we *should* return this resource, but this condition is false:
      if ((p->end >= start) && (p->start < end))
        break;

Adjust find_next_iomem_res() so it allows a resource that includes the
single byte at the end of the range.  This is a corner case that we
probably don't see in practice.

Fixes: 58c1b5b07907 ("[PATCH] memory hotadd fixes: find_next_system_ram catch range fix")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Brijesh Singh <brijesh.singh@amd.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: H. Peter Anvin <hpa@zytor.com>
CC: Lianbo Jiang <lijiang@redhat.com>
CC: Takashi Iwai <tiwai@suse.de>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Tom Lendacky <thomas.lendacky@amd.com>
CC: Vivek Goyal <vgoyal@redhat.com>
CC: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
CC: bhe@redhat.com
CC: dan.j.williams@intel.com
CC: dyoung@redhat.com
CC: kexec@lists.infradead.org
CC: mingo@redhat.com
CC: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/153805812254.1157.16736368485811773752.stgit@bhelgaas-glaptop.roam.corp.google.com
---
 kernel/resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 30e1bc68503b..155ec873ea4d 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -319,7 +319,7 @@ int release_resource(struct resource *old)
 EXPORT_SYMBOL(release_resource);
 
 /*
- * Finds the lowest iomem resource existing within [res->start.res->end).
+ * Finds the lowest iomem resource existing within [res->start..res->end].
  * The caller must specify res->start, res->end, res->flags, and optionally
  * desc.  If found, returns 0, res is overwritten, if not found, returns -1.
  * This function walks the whole tree and not just first level children until
@@ -352,7 +352,7 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
 			p = NULL;
 			break;
 		}
-		if ((p->end >= start) && (p->start < end))
+		if ((p->end >= start) && (p->start <= end))
 			break;
 	}
 
