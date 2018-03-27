Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+0+i/yUfmIcaTnyw3xH83kKIUTbKesoAMsOWBuyEINnIcxzhA/5kLaakog3NyLbhSPMFag
ARC-Seal: i=1; a=rsa-sha256; t=1522168828; cv=none;
        d=google.com; s=arc-20160816;
        b=ToWWum87bU0WdxHgOqLoM1Kp8Yd0zeo8L/hw7aLrP9WytFG+/8VrHkFt+tdc0uwm9y
         63XKkWhGlRtDffpMnSrFRdAL9paekUL9FbWQYd2Zvz/CAwWcOUOzzfDKVE0GRfMfzOub
         XngMBFt/At9g7jDqpVIZ8b5crxFT9or/s3xCkRyWxmY84wSAXxdancLeDZJK/p92LkJl
         g21+ILaFP5TvN26H3mhyTMZMDRCezb+UG3InwQURjMrrAL51TXuYtPqg3KMFZh8v8HQq
         VHinWt/T7dQ9PYoA6MNUg0vlG0ykE7hD1O0qK0j4zxn4XhNrSZznyfFjZvyHhwGyKb/0
         HBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GqE5/xkNW5as3K8p4IH19/wpULbDi61aeF9w9oRKNuk=;
        b=iTZhjEeQ34CYJoEhDNUu1OD8lbIpxrLAuYNdmx7sNwpuDzeMdetOwYyx+wcJL4DxVR
         zmDRy0syWVTU6iaKKcizWNWWfORFyONP8S9LAjLOZM/wTlZphuzbawzwCjt+wyFZn/5N
         /OHB88TNkr9LkRPWq6uQ2ffwwDzZRQWNPDCvHmFzpRoRajWLiKVKuXM79G62vcC1YTNV
         Md5JrXyRLrxG1adzR8oj5WWn94+1mGQ1oZbp+IneRRxkS8xvmSSNAz1+vSAgcT5xtEZL
         3fTa/VTxq2ThCS5x6ZmYF8BR1djJbkU5ZsdjD2gQYpn6/AEaNN/1xD+PD5QUyZIXE3UG
         zvQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Nic Losby <blurbdust@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Yisheng Xie <xieyisheng1@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 047/105] hugetlbfs: check for pgoff value overflow
Date: Tue, 27 Mar 2018 18:27:27 +0200
Message-Id: <20180327162800.183556530@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109395911378895?=
X-GMAIL-MSGID: =?utf-8?q?1596109700987028145?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Kravetz <mike.kravetz@oracle.com>

commit 63489f8e821144000e0bdca7e65a8d1cc23a7ee7 upstream.

A vma with vm_pgoff large enough to overflow a loff_t type when
converted to a byte offset can be passed via the remap_file_pages system
call.  The hugetlbfs mmap routine uses the byte offset to calculate
reservations and file size.

A sequence such as:

  mmap(0x20a00000, 0x600000, 0, 0x66033, -1, 0);
  remap_file_pages(0x20a00000, 0x600000, 0, 0x20000000000000, 0);

will result in the following when task exits/file closed,

  kernel BUG at mm/hugetlb.c:749!
  Call Trace:
    hugetlbfs_evict_inode+0x2f/0x40
    evict+0xcb/0x190
    __dentry_kill+0xcb/0x150
    __fput+0x164/0x1e0
    task_work_run+0x84/0xa0
    exit_to_usermode_loop+0x7d/0x80
    do_syscall_64+0x18b/0x190
    entry_SYSCALL_64_after_hwframe+0x3d/0xa2

The overflowed pgoff value causes hugetlbfs to try to set up a mapping
with a negative range (end < start) that leaves invalid state which
causes the BUG.

The previous overflow fix to this code was incomplete and did not take
the remap_file_pages system call into account.

[mike.kravetz@oracle.com: v3]
  Link: http://lkml.kernel.org/r/20180309002726.7248-1-mike.kravetz@oracle.com
[akpm@linux-foundation.org: include mmdebug.h]
[akpm@linux-foundation.org: fix -ve left shift count on sh]
Link: http://lkml.kernel.org/r/20180308210502.15952-1-mike.kravetz@oracle.com
Fixes: 045c7a3f53d9 ("hugetlbfs: fix offset overflow in hugetlbfs mmap")
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reported-by: Nic Losby <blurbdust@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/hugetlbfs/inode.c |   17 ++++++++++++++---
 mm/hugetlb.c         |    7 +++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -118,6 +118,16 @@ static void huge_pagevec_release(struct
 	pagevec_reinit(pvec);
 }
 
+/*
+ * Mask used when checking the page offset value passed in via system
+ * calls.  This value will be converted to a loff_t which is signed.
+ * Therefore, we want to check the upper PAGE_SHIFT + 1 bits of the
+ * value.  The extra bit (- 1 in the shift value) is to take the sign
+ * bit into account.
+ */
+#define PGOFF_LOFFT_MAX \
+	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))
+
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
@@ -137,12 +147,13 @@ static int hugetlbfs_file_mmap(struct fi
 	vma->vm_ops = &hugetlb_vm_ops;
 
 	/*
-	 * Offset passed to mmap (before page shift) could have been
-	 * negative when represented as a (l)off_t.
+	 * page based offset in vm_pgoff could be sufficiently large to
+	 * overflow a (l)off_t when converted to byte offset.
 	 */
-	if (((loff_t)vma->vm_pgoff << PAGE_SHIFT) < 0)
+	if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
 		return -EINVAL;
 
+	/* must be huge page aligned */
 	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
 		return -EINVAL;
 
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -18,6 +18,7 @@
 #include <linux/bootmem.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
+#include <linux/mmdebug.h>
 #include <linux/sched/signal.h>
 #include <linux/rmap.h>
 #include <linux/string_helpers.h>
@@ -4354,6 +4355,12 @@ int hugetlb_reserve_pages(struct inode *
 	struct resv_map *resv_map;
 	long gbl_reserve;
 
+	/* This should never happen */
+	if (from > to) {
+		VM_WARN(1, "%s called with a negative range\n", __func__);
+		return -EINVAL;
+	}
+
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
 	 * attempt will be made for VM_NORESERVE to allocate a page
