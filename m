Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbeBKKgs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 05:36:48 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:56903 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752790AbeBKKgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 05:36:47 -0500
Authentication-Results: smtpcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH] proc/kpageflags: add KPF_WAITERS
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
Date: Sun, 11 Feb 2018 13:36:41 +0300
Message-ID: <151834540184.176427.12174649162560874101.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KPF_WAITERS indicates tasks are waiting for a page lock or writeback.
This might be false-positive, in this case next unlock will clear it.
This looks like worth information not only for kernel hacking.

In tool page-types in non-raw mode treat KPF_WAITERS without
KPF_LOCKED and KPF_WRITEBACK as false-positive and hide it.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/proc/page.c                         |    1 +
 include/uapi/linux/kernel-page-flags.h |    1 +
 tools/vm/page-types.c                  |    7 +++++++
 3 files changed, 9 insertions(+)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 1491918a33c3..b9312e1124af 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -159,6 +159,7 @@ u64 stable_page_flags(struct page *page)
 		u |= 1 << KPF_IDLE;
 
 	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
+	u |= kpf_copy_bit(k, KPF_WAITERS,	PG_waiters);
 
 	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
 	if (PageTail(page) && PageSlab(compound_head(page)))
diff --git a/include/uapi/linux/kernel-page-flags.h b/include/uapi/linux/kernel-page-flags.h
index fa139841ec18..1118a028f2b3 100644
--- a/include/uapi/linux/kernel-page-flags.h
+++ b/include/uapi/linux/kernel-page-flags.h
@@ -35,6 +35,7 @@
 #define KPF_BALLOON		23
 #define KPF_ZERO_PAGE		24
 #define KPF_IDLE		25
+#define KPF_WAITERS		26
 
 
 #endif /* _UAPILINUX_KERNEL_PAGE_FLAGS_H */
diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index a8783f48f77f..76d880b768b5 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -107,6 +107,7 @@
 
 static const char * const page_flag_names[] = {
 	[KPF_LOCKED]		= "L:locked",
+	[KPF_WAITERS]		= "Q:waiters",
 	[KPF_ERROR]		= "E:error",
 	[KPF_REFERENCED]	= "R:referenced",
 	[KPF_UPTODATE]		= "U:uptodate",
@@ -498,6 +499,12 @@ static uint64_t well_known_flags(uint64_t flags)
 	if ((flags & BITS_COMPOUND) && !(flags & BIT(HUGE)))
 		flags &= ~BITS_COMPOUND;
 
+	/* Treat WAITERS without LOCKED or WRITEBACK as false-postive */
+	if ((flags & (BIT(WAITERS) |
+		      BIT(LOCKED) |
+		      BIT(WRITEBACK))) == BIT(WAITERS))
+		flags &= ~BIT(WAITERS);
+
 	return flags;
 }
 
