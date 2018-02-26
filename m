Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224O2zSgdyHSWGpE2lcV5Rlb/YS4TOKqp5EIgWZX1N/0yMbTnQBayMUx5G+b8aOuwPmCwMax
ARC-Seal: i=1; a=rsa-sha256; t=1519676581; cv=none;
        d=google.com; s=arc-20160816;
        b=mMv6t3wgq/uASsv4iW4BnlOC5IdXDPC/cyBNyCC4gtMTbGeM/rU0b5GawXoLddb9ee
         ggakv3krpEXH5Uu19sQpcN049NWuFwkHACsWH/dlPXv7Ns78N0k7MnXjnmaPnSb2LOuw
         p9ESnwjh2b1q4L/9Ga7oRF6Na3//iRTepVFQ9gb4oNRPSHMrj8xzsLAf2PuC9VEgyDEo
         NMZfcpFM2wyMKhutk5RFVdLk+c3xAILh98SDwkbkOYOJ1vL72TwZFjV+9shhAj9uEbUe
         PqAQiD75AVz3A78rHR1Cy59y3uabpI3qhhFZIxJkFq5bVG2+nbkf/SRy6E2GIEfnEaAn
         JV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Vt2pagSk4OTx2a40ROa+IZn/42UuAt/x/wwGTy7rAkY=;
        b=lY4tceTw1tQyBvnB2YvZn5Jyqbwz30fVXF/T68pPCDD2Ei0NDvgJLo6pzDYEssw2Fo
         Csu26xrlYbI6LSCdWSntM6lDQOWKsSyUU6CkOOF3I2wUwrbwsoCL3/SGpKHrFsTxR2c/
         LqJwr5ZFdqRN0RKaluHZqIx+p3UnVyxUj4n9cuB7XTbHDyrUuRUz1E54TNbSzJE/eBYa
         LIlWDJj7hlGarSir/Al/GWEVElk+HTrPLIG8ZT0QrMdMGElIT8GWbWxymR9A/hcNVg2U
         gQ0vGlKkf6CWovmBPE4pRMlHolZC4ceIapWP45ik/6vEi76jZl/gSzHrEo2TOm2ghgeE
         fXIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Jan Kara <jack@suse.cz>,
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Joonyoung Shim <jy0922.shim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Doug Ledford <dledford@redhat.com>,
	Hal Rosenstock <hal.rosenstock@gmail.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Jeff Moyer <jmoyer@redhat.com>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 38/39] mm: fail get_vaddr_frames() for filesystem-dax mappings
Date: Mon, 26 Feb 2018 21:20:59 +0100
Message-Id: <20180226201645.332724931@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496390854252085?=
X-GMAIL-MSGID: =?utf-8?q?1593496390854252085?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit b7f0554a56f21fb3e636a627450a9add030889be upstream.

Until there is a solution to the dma-to-dax vs truncate problem it is
not safe to allow V4L2, Exynos, and other frame vector users to create
long standing / irrevocable memory registrations against filesytem-dax
vmas.

[dan.j.williams@intel.com: add comment for vma_is_fsdax() check in get_vaddr_frames(), per Jan]
  Link: http://lkml.kernel.org/r/151197874035.26211.4061781453123083667.stgit@dwillia2-desk3.amr.corp.intel.com
Link: http://lkml.kernel.org/r/151068939985.7446.15684639617389154187.stgit@dwillia2-desk3.amr.corp.intel.com
Fixes: 3565fce3a659 ("mm, x86: get_user_pages() for dax mappings")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Hal Rosenstock <hal.rosenstock@gmail.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Sean Hefty <sean.hefty@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/frame_vector.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/mm/frame_vector.c
+++ b/mm/frame_vector.c
@@ -52,6 +52,18 @@ int get_vaddr_frames(unsigned long start
 		ret = -EFAULT;
 		goto out;
 	}
+
+	/*
+	 * While get_vaddr_frames() could be used for transient (kernel
+	 * controlled lifetime) pinning of memory pages all current
+	 * users establish long term (userspace controlled lifetime)
+	 * page pinning. Treat get_vaddr_frames() like
+	 * get_user_pages_longterm() and disallow it for filesystem-dax
+	 * mappings.
+	 */
+	if (vma_is_fsdax(vma))
+		return -EOPNOTSUPP;
+
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP))) {
 		vec->got_ref = true;
 		vec->is_pfns = false;
