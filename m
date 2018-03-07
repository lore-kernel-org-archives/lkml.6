Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv2E6R9Hb9J9iDBSBZyO9+lrgHFXSb8UI0PCk9bvt9ziyjiqK+hDlyfsOr0qhiYSnLbttLT
ARC-Seal: i=1; a=rsa-sha256; t=1520451912; cv=none;
        d=google.com; s=arc-20160816;
        b=fTwy6vE6jICJcCk2r4HOvFXeEhBQ+EZxGbYh8spIGt/XAhIdbkUVcmT7931jRwyyOv
         haQbKOqr9nz2L6xHmglERORogbx7n3uwIOFNiiryjyFK3zkMJXgp+l6RRGJlnM47/UGk
         l5WcLfhJ9ow7iQe+tb+o2x78IhWVZE91BG2sFKJtXoEDciAWpSWFxxQF1SHR7cuiqnlv
         MOSwVtQvOa90pdVM0b1IZWVmCrmLQxEq/dSOZ/G5Aufmvv4t09mJPVPjUQ5tf0m/N19w
         co0FDEto5RA1WsN0a6nLAac2yFmTcPShWEeLRhl3ZsjyctBiem8oLNW5FeQ87LAYYR41
         9TRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NklUq1Q2I2JMO9kkFDHL/UBHmzHXZsP4nwhxeHQXvhg=;
        b=nZErwq7vdrGusY3e5Pzson8IU5prNafuam7VdLNLRDVzl3Q3QnN9HrrOcBe+Kvov+h
         uSOMcj15kfZil+DHBgj9q5R8INOYE0b1li9KUMGC6KlsJyQMi2Y23YtnZ3PkFDFZeqQy
         nWc4dIJCI/X64tSqfTq1AQyNBIcR59RGLEPGZGuga5gav3V/s4RX7UepL29LX9doJ1iz
         7tNmYJul0wzri1It9IaNda1LgEFMGID1IUz7e/InLz0YOcV7IZbeRtyx1qJQBJjTYSNs
         tZ6aGi82yA5OO40OOHE3ipZ0NHWLyjISnmqW81CUggyEC4ncczWxBZkluX5kMeNMKYRo
         woUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	kvm@vger.kernel.org,
	Haozhong Zhang <haozhong.zhang@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 027/110] vfio: disable filesystem-dax page pinning
Date: Wed,  7 Mar 2018 11:38:10 -0800
Message-Id: <20180307191043.187618642@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309114995317883?=
X-GMAIL-MSGID: =?utf-8?q?1594309384324147220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 94db151dc89262bfa82922c44e8320cea2334667 upstream.

Filesystem-DAX is incompatible with 'longterm' page pinning. Without
page cache indirection a DAX mapping maps filesystem blocks directly.
This means that the filesystem must not modify a file's block map while
any page in a mapping is pinned. In order to prevent the situation of
userspace holding of filesystem operations indefinitely, disallow
'longterm' Filesystem-DAX mappings.

RDMA has the same conflict and the plan there is to add a 'with lease'
mechanism to allow the kernel to notify userspace that the mapping is
being torn down for block-map maintenance. Perhaps something similar can
be put in place for vfio.

Note that xfs and ext4 still report:

   "DAX enabled. Warning: EXPERIMENTAL, use at your own risk"

...at mount time, and resolving the dax-dma-vs-truncate problem is one
of the last hurdles to remove that designation.

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: kvm@vger.kernel.org
Cc: <stable@vger.kernel.org>
Reported-by: Haozhong Zhang <haozhong.zhang@intel.com>
Tested-by: Haozhong Zhang <haozhong.zhang@intel.com>
Fixes: d475c6346a38 ("dax,ext2: replace XIP read and write with DAX I/O")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vfio/vfio_iommu_type1.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -338,11 +338,12 @@ static int vaddr_get_pfn(struct mm_struc
 {
 	struct page *page[1];
 	struct vm_area_struct *vma;
+	struct vm_area_struct *vmas[1];
 	int ret;
 
 	if (mm == current->mm) {
-		ret = get_user_pages_fast(vaddr, 1, !!(prot & IOMMU_WRITE),
-					  page);
+		ret = get_user_pages_longterm(vaddr, 1, !!(prot & IOMMU_WRITE),
+					      page, vmas);
 	} else {
 		unsigned int flags = 0;
 
@@ -351,7 +352,18 @@ static int vaddr_get_pfn(struct mm_struc
 
 		down_read(&mm->mmap_sem);
 		ret = get_user_pages_remote(NULL, mm, vaddr, 1, flags, page,
-					    NULL, NULL);
+					    vmas, NULL);
+		/*
+		 * The lifetime of a vaddr_get_pfn() page pin is
+		 * userspace-controlled. In the fs-dax case this could
+		 * lead to indefinite stalls in filesystem operations.
+		 * Disallow attempts to pin fs-dax pages via this
+		 * interface.
+		 */
+		if (ret > 0 && vma_is_fsdax(vmas[0])) {
+			ret = -EOPNOTSUPP;
+			put_page(page[0]);
+		}
 		up_read(&mm->mmap_sem);
 	}
 
