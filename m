Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E362C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A56921104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS0YinXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A56921104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390731AbeKTDRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:17:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:55610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390166AbeKTDRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:17:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A49DF206BA;
        Mon, 19 Nov 2018 16:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646389;
        bh=5Oc2eO/1c9CU1zXvIOgKz725fgEfqF/yVN/7GYmkAC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dS0YinXW4UnwYDJI6LN/3+YzVMrE0fvnkAg07dU7EIcOFw5wISniP43717Wrxc3CE
         DaQKiQBpAhoHdacjZFC1+4mfftVU0HQBPey3NufQjTnUaM1Ayy2+nUIisVxF9Q8Vk0
         nArP0Gk+tp72xKkKV4LTlGa7/FsyigTCF5Nk24yk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        syzbot <syzbot+5dcb560fe12aa5091c06@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Oscar Salvador <osalvador@suse.de>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 22/83] mm: do not bug_on on incorrect length in __mm_populate()
Date:   Mon, 19 Nov 2018 17:28:48 +0100
Message-Id: <20181119162616.541769859@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 4.9:
 - There is no do_brk_flags() function; update do_brk()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c  |  2 --
 mm/mmap.c | 19 ++++++++++---------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index be4ccddac26f..d71da7216c6e 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1122,8 +1122,6 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 	int locked = 0;
 	long ret = 0;
 
-	VM_BUG_ON(start & ~PAGE_MASK);
-	VM_BUG_ON(len != PAGE_ALIGN(len));
 	end = start + len;
 
 	for (nstart = start; nstart < end; nstart = nend) {
diff --git a/mm/mmap.c b/mm/mmap.c
index aa97074a4a99..283755645d17 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2876,21 +2876,15 @@ static inline void verify_mm_writelocked(struct mm_struct *mm)
  *  anonymous maps.  eventually we may be able to do some
  *  brk-specific accounting here.
  */
-static int do_brk(unsigned long addr, unsigned long request)
+static int do_brk(unsigned long addr, unsigned long len)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
-	unsigned long flags, len;
+	unsigned long flags;
 	struct rb_node **rb_link, *rb_parent;
 	pgoff_t pgoff = addr >> PAGE_SHIFT;
 	int error;
 
-	len = PAGE_ALIGN(request);
-	if (len < request)
-		return -ENOMEM;
-	if (!len)
-		return 0;
-
 	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 
 	error = get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
@@ -2959,12 +2953,19 @@ static int do_brk(unsigned long addr, unsigned long request)
 	return 0;
 }
 
-int vm_brk(unsigned long addr, unsigned long len)
+int vm_brk(unsigned long addr, unsigned long request)
 {
 	struct mm_struct *mm = current->mm;
+	unsigned long len;
 	int ret;
 	bool populate;
 
+	len = PAGE_ALIGN(request);
+	if (len < request)
+		return -ENOMEM;
+	if (!len)
+		return 0;
+
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
 
-- 
2.17.1



