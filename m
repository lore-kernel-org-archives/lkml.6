Return-Path: <kernel-hardening-return-12004-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtg6MoBSO4Ot9Fv59jWfx9W3JDE5qXSrW+6ql5lLYD7ZBPI9+1ZbdRhJMxHAIJ/KDzTFcgO
ARC-Seal: i=1; a=rsa-sha256; t=1519737452; cv=none;
        d=google.com; s=arc-20160816;
        b=aEL8YIEfQVBwFBfPmsLjJ63SVFIPZXWTGLcdMvQ5bKsopAJ3g5/pvcr4qIrZ038+Db
         SvdvYYgyR0dBO/eJfm/ULkgD1PoKF79JYm4hXqEPDpVe8TN1pUHGGq/SyT0iXZRznGqS
         0/j9ewYn7XKGORLH8Ya6nOTZ2kvYSysmEKGTEwRYtbmgKMnuL4hsy1dr9BlCfFfS7yKh
         Ea5rP5bGVdPgKL1Z5sWZXP4xeXt5kNBwquCNf6Ll3Zeh13+JjsY7pGDJX7O7eft/sjib
         huSlMK0rDvX1QFytOa9hFSBA0bUXqvQ2imibOiaP/f10KrVP4goFNJA8pQ45pAT4zmUh
         rOIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=tQbEFfJcOkGoLMhcZejkPYa+MAVPx5XPROZbbXWUjkE=;
        b=RMuYs1gwS0WLqLHE0rkkKzN5GsoeGgR4bDOfR4RuzFMWmj38tF7kEQStpJg48Okjzu
         cnRaBcKJ09UgAtjCOF2kthcn+tydt8N82bh6+K6CWrnBUez8h+MUDT8rmKsU9m//TM2B
         PamqFw4hOQQkOitNuhpG0ZtWPNRGivQBj0JOlKCGSNgvHsJe0fbeimWCttZa/vBHZIXa
         S/e3hjjdcodUxoEea+qqCF0Ag+Ts3b5pTRL+c4/mnaqrv0pD8FFeabXDxYqy7uF+B4Oi
         t4kyclwVSHjAqh7HJKC0YH9wXJOZjfizjYtJV/GsNkm49h/362JmdxCe0Wh8gD4bnW9P
         ohJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XxJAsUo3;
       spf=pass (google.com: domain of kernel-hardening-return-12004-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12004-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XxJAsUo3;
       spf=pass (google.com: domain of kernel-hardening-return-12004-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12004-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Ilya Smith <blackzert@gmail.com>
To: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	mhocko@suse.com,
	kirill.shutemov@linux.intel.com,
	jack@suse.cz,
	jglisse@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	deller@gmx.de,
	aarcange@redhat.com,
	oleg@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Cc: Ilya Smith <blackzert@gmail.com>
Subject: [RFC PATCH] Randomization of address chosen by mmap.
Date: Tue, 27 Feb 2018 16:13:38 +0300
Message-Id: <20180227131338.3699-1-blackzert@gmail.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1593560218941631465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is more proof of concept. Current implementation doesn't randomize
address returned by mmap. All the entropy ends with choosing mmap_base_addr
at the process creation. After that mmap build very predictable layout
of address space. It allows to bypass ASLR in many cases.
This patch make randomization of address on any mmap call.
It works good on 64 bit system, but usage under 32 bit systems is not
recommended. This approach uses current implementation to simplify search
of address.

Here I would like to discuss this approach.

Signed-off-by: Ilya Smith <blackzert@gmail.com>
---
 include/linux/mm.h |   4 ++
 mm/mmap.c          | 171 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42adb1a..f81b6c8a0bc5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/page_ref.h>
 #include <linux/memremap.h>
+#include <linux/sched.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -2253,6 +2254,7 @@ struct vm_unmapped_area_info {
 	unsigned long align_offset;
 };
 
+extern unsigned long unmapped_area_random(struct vm_unmapped_area_info *info);
 extern unsigned long unmapped_area(struct vm_unmapped_area_info *info);
 extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
 
@@ -2268,6 +2270,8 @@ extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
 static inline unsigned long
 vm_unmapped_area(struct vm_unmapped_area_info *info)
 {
+	if (current->flags & PF_RANDOMIZE)
+		return unmapped_area_random(info);
 	if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
 		return unmapped_area_topdown(info);
 	else
diff --git a/mm/mmap.c b/mm/mmap.c
index 9efdc021ad22..58110e065417 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -45,6 +45,7 @@
 #include <linux/moduleparam.h>
 #include <linux/pkeys.h>
 #include <linux/oom.h>
+#include <linux/random.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -1780,6 +1781,176 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return error;
 }
 
+unsigned long unmapped_area_random(struct vm_unmapped_area_info *info)
+{
+	// first lets find right border with unmapped_area_topdown
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct vm_area_struct *right_vma = 0;
+	unsigned long entropy;
+	unsigned int entropy_count;
+	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long addr, low, high;
+
+	/* Adjust search length to account for worst case alignment overhead */
+	length = info->length + info->align_mask;
+	if (length < info->length)
+		return -ENOMEM;
+
+	/*
+	 * Adjust search limits by the desired length.
+	 * See implementation comment at top of unmapped_area().
+	 */
+	gap_end = info->high_limit;
+	if (gap_end < length)
+		return -ENOMEM;
+	high_limit = gap_end - length;
+
+	info->low_limit = 0x10000;
+	if (info->low_limit > high_limit)
+		return -ENOMEM;
+	low_limit = info->low_limit + length;
+
+	/* Check highest gap, which does not precede any rbtree node */
+	gap_start = mm->highest_vm_end;
+	if (gap_start <= high_limit)
+		goto found;
+
+	/* Check if rbtree root looks promising */
+	if (RB_EMPTY_ROOT(&mm->mm_rb))
+		return -ENOMEM;
+	vma = rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
+	if (vma->rb_subtree_gap < length)
+		return -ENOMEM;
+
+	while (true) {
+		/* Visit right subtree if it looks promising */
+		gap_start = vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
+		if (gap_start <= high_limit && vma->vm_rb.rb_right) {
+			struct vm_area_struct *right =
+				rb_entry(vma->vm_rb.rb_right,
+					 struct vm_area_struct, vm_rb);
+			if (right->rb_subtree_gap >= length) {
+				vma = right;
+				continue;
+			}
+		}
+
+check_current_down:
+		/* Check if current node has a suitable gap */
+		gap_end = vm_start_gap(vma);
+		if (gap_end < low_limit)
+			return -ENOMEM;
+		if (gap_start <= high_limit &&
+		    gap_end > gap_start && gap_end - gap_start >= length)
+			goto found;
+
+		/* Visit left subtree if it looks promising */
+		if (vma->vm_rb.rb_left) {
+			struct vm_area_struct *left =
+				rb_entry(vma->vm_rb.rb_left,
+					 struct vm_area_struct, vm_rb);
+			if (left->rb_subtree_gap >= length) {
+				vma = left;
+				continue;
+			}
+		}
+
+		/* Go back up the rbtree to find next candidate node */
+		while (true) {
+			struct rb_node *prev = &vma->vm_rb;
+
+			if (!rb_parent(prev))
+				return -ENOMEM;
+			vma = rb_entry(rb_parent(prev),
+				       struct vm_area_struct, vm_rb);
+			if (prev == vma->vm_rb.rb_right) {
+				gap_start = vma->vm_prev ?
+					vm_end_gap(vma->vm_prev) : 0;
+				goto check_current_down;
+			}
+		}
+	}
+
+found:
+	right_vma = vma;
+	low = gap_start;
+	high = gap_end - length;
+
+	entropy = get_random_long();
+	entropy_count = 0;
+
+	// from left node to right we check if node is fine and
+	// randomly select it.
+	vma = mm->mmap;
+	while (vma != right_vma) {
+		/* Visit left subtree if it looks promising */
+		gap_end = vm_start_gap(vma);
+		if (gap_end >= low_limit && vma->vm_rb.rb_left) {
+			struct vm_area_struct *left =
+				rb_entry(vma->vm_rb.rb_left,
+					 struct vm_area_struct, vm_rb);
+			if (left->rb_subtree_gap >= length) {
+				vma = left;
+				continue;
+			}
+		}
+
+		gap_start = vma->vm_prev ? vm_end_gap(vma->vm_prev) : low_limit;
+check_current_up:
+		/* Check if current node has a suitable gap */
+		if (gap_start > high_limit)
+			break;
+		if (gap_end >= low_limit &&
+		    gap_end > gap_start && gap_end - gap_start >= length) {
+			if (entropy & 1) {
+				low = gap_start;
+				high = gap_end - length;
+			}
+			entropy >>= 1;
+			if (++entropy_count == 64) {
+				entropy = get_random_long();
+				entropy_count = 0;
+			}
+		}
+
+		/* Visit right subtree if it looks promising */
+		if (vma->vm_rb.rb_right) {
+			struct vm_area_struct *right =
+				rb_entry(vma->vm_rb.rb_right,
+					 struct vm_area_struct, vm_rb);
+			if (right->rb_subtree_gap >= length) {
+				vma = right;
+				continue;
+			}
+		}
+
+		/* Go back up the rbtree to find next candidate node */
+		while (true) {
+			struct rb_node *prev = &vma->vm_rb;
+
+			if (!rb_parent(prev))
+				BUG(); // this should not happen
+			vma = rb_entry(rb_parent(prev),
+				       struct vm_area_struct, vm_rb);
+			if (prev == vma->vm_rb.rb_left) {
+				gap_start = vm_end_gap(vma->vm_prev);
+				gap_end = vm_start_gap(vma);
+				if (vma == right_vma)
+					break;
+				goto check_current_up;
+			}
+		}
+	}
+
+	if (high == low)
+		return low;
+
+	addr = get_random_long() % ((high - low) >> PAGE_SHIFT);
+	addr = low + (addr << PAGE_SHIFT);
+	return addr;
+}
+
 unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
 	/*
-- 
2.14.1
