Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CDFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE4F20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE4F20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbeKLGYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:24:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49974 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730206AbeKLFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:13 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0000oN-46; Sun, 11 Nov 2018 19:58:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001jI-If; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Huang, Ying" <ying.huang@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "syzbot" <syzbot+5dcb560fe12aa5091c06@syzkaller.appspotmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        "Zi Yan" <zi.yan@cs.rutgers.edu>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Michal Hocko" <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.584953115@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 254/366] mm: do not bug_on on incorrect length in
 __mm_populate()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>

commit bb177a732c4369bb58a1fe1df8f552b6f0f7db5f upstream.

syzbot has noticed that a specially crafted library can easily hit
VM_BUG_ON in __mm_populate

  kernel BUG at mm/gup.c:1242!
  invalid opcode: 0000 [#1] SMP
  CPU: 2 PID: 9667 Comm: a.out Not tainted 4.18.0-rc3 #644
  Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
  RIP: 0010:__mm_populate+0x1e2/0x1f0
  Code: 55 d0 65 48 33 14 25 28 00 00 00 89 d8 75 21 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 75 18 f1 ff 0f 0b e8 6e 18 f1 ff <0f> 0b 31 db eb c9 e8 93 06 e0 ff 0f 1f 00 55 48 89 e5 53 48 89 fb
  Call Trace:
     vm_brk_flags+0xc3/0x100
     vm_brk+0x1f/0x30
     load_elf_library+0x281/0x2e0
     __ia32_sys_uselib+0x170/0x1e0
     do_fast_syscall_32+0xca/0x420
     entry_SYSENTER_compat+0x70/0x7f

The reason is that the length of the new brk is not page aligned when we
try to populate the it.  There is no reason to bug on that though.
do_brk_flags already aligns the length properly so the mapping is
expanded as it should.  All we need is to tell mm_populate about it.
Besides that there is absolutely no reason to to bug_on in the first
place.  The worst thing that could happen is that the last page wouldn't
get populated and that is far from putting system into an inconsistent
state.

Fix the issue by moving the length sanitization code from do_brk_flags
up to vm_brk_flags.  The only other caller of do_brk_flags is brk
syscall entry and it makes sure to provide the proper length so t here
is no need for sanitation and so we can use do_brk_flags without it.

Also remove the bogus BUG_ONs.

[osalvador@techadventures.net: fix up vm_brk_flags s@request@len@]
Link: http://lkml.kernel.org/r/20180706090217.GI32658@dhcp22.suse.cz
Signed-off-by: Michal Hocko <mhocko@suse.com>
Reported-by: syzbot <syzbot+5dcb560fe12aa5091c06@syzkaller.appspotmail.com>
Tested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16:
 - There is no do_brk_flags() function; update do_brk()
 - do_brk(), vm_brk() return the address on success
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -669,8 +669,6 @@ int __mm_populate(unsigned long start, u
 	int locked = 0;
 	long ret = 0;
 
-	VM_BUG_ON(start & ~PAGE_MASK);
-	VM_BUG_ON(len != PAGE_ALIGN(len));
 	end = start + len;
 
 	for (nstart = start; nstart < end; nstart = nend) {
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2751,21 +2751,15 @@ static inline void verify_mm_writelocked
  *  anonymous maps.  eventually we may be able to do some
  *  brk-specific accounting here.
  */
-static unsigned long do_brk(unsigned long addr, unsigned long request)
+static unsigned long do_brk(unsigned long addr, unsigned long len)
 {
 	struct mm_struct * mm = current->mm;
 	struct vm_area_struct * vma, * prev;
-	unsigned long flags, len;
+	unsigned long flags;
 	struct rb_node ** rb_link, * rb_parent;
 	pgoff_t pgoff = addr >> PAGE_SHIFT;
 	int error;
 
-	len = PAGE_ALIGN(request);
-	if (len < request)
-		return -ENOMEM;
-	if (!len)
-		return addr;
-
 	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 
 	error = get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
@@ -2834,12 +2828,19 @@ out:
 	return addr;
 }
 
-unsigned long vm_brk(unsigned long addr, unsigned long len)
+unsigned long vm_brk(unsigned long addr, unsigned long request)
 {
 	struct mm_struct *mm = current->mm;
+	unsigned long len;
 	unsigned long ret;
 	bool populate;
 
+	len = PAGE_ALIGN(request);
+	if (len < request)
+		return -ENOMEM;
+	if (!len)
+		return addr;
+
 	down_write(&mm->mmap_sem);
 	ret = do_brk(addr, len);
 	populate = ((mm->def_flags & VM_LOCKED) != 0);

