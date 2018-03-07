Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs+pHoyDu199fwfD3/+MIO+grBWAC3DMBpHH0ZkQqUoNEjPKulWI05hrY0/ykMvd3WKv3OM
ARC-Seal: i=1; a=rsa-sha256; t=1520451655; cv=none;
        d=google.com; s=arc-20160816;
        b=c1IfgbWOjdwExJendMzb3Ghu0QxcYnE9R9Jc3ZnvTJpJff+2Mv5J5vOsyNgQKyMHC4
         Nf/MKP/LE9bPmDLcrjwF5Iv7/D5xLoExXHOOgvXpnYoD1f5h412x4svLZ30ap/pU2bzJ
         Kl8zB188KwrxXY2PtpThYgFS0eaIePCBezQcnMEA8K4GE5Tms+XibSCKl8HNOp40RdK2
         npTpInJl+op/UlHqpjAwaUa4dBWRpx3gOCW8e3RteY8MaPNz494oC20ODCp7kGJ6fmt6
         wkRIa83+zZiPsja7lzf+OtmoM46ix4NtX7SODO+yYdjKtQD8/H9ae60wuoayvEDrZDD9
         reSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jZou8G9Xs9qmr42JxXemaaBgcyAB6tMVEx2gdVkYsdo=;
        b=UOPXgAk9NNK7BQvmWYLggCvbsnIZd9vGaplC9x0DOusZp2PNlPDdqZbHCw7AgK9mBg
         dD8GtcidF1a4bsy0eeaHBwovItdjEVfjEo409exaibfn4dtLjLYmvC7P+LCZTODyiW3K
         SRMBZhmjnhjN8JyIaj7HednHjitX+gQgbZRq3xr4cx7T5FcnFRhYqTnlA8iSt/Jm3xER
         3HHDtWE/sPyZuvWrzLTCqRPkGsM9a6eInENQ//60oXajEk0PWYJVvA1ZMqHBfjd/LypA
         jOUcxDblaqvM5VbBbOtQ2y/6rDIM26GRzmdG7zhYZ7vHyG5noYSMQv8ksOgZckZ6LMt3
         rA7w==
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
Subject: [PATCH 4.15 032/122] vfio: disable filesystem-dax page pinning
Date: Wed,  7 Mar 2018 11:37:24 -0800
Message-Id: <20180307191733.857052031@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309114995317883?=
X-GMAIL-MSGID: =?utf-8?q?1594309114995317883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
