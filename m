Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvzSMISEqJyIoXTaOwW1yTuAADCW2xy7izPs633Zd1zuY4++oAVBO6mDbTQ+E86D2x3TMrl
ARC-Seal: i=1; a=rsa-sha256; t=1519676553; cv=none;
        d=google.com; s=arc-20160816;
        b=DRO8tUEcRfN48ZhckdLA/FN20wokf/IjdzTYhss/WMYvTUZiNYIi4gns4CNT2cc3jG
         ZMPQYqtumCoRWFScpWU5/LhNuA999HySjhtZHxMf8BOpLnwpBfawfy5HcCWVjTF1I34l
         ZG2Qi+T1SBqAgd5OFqrSRo6qInVyS/ssRyclt8FyIMml5vS9v7NDOYZNLDX7PdSvKBc1
         Z456c69wNYSDExZGZx2d+mgFjUf4SV3AhYteMuEXw7oytlyGUME0lOUjJOtRk/8BLw67
         cgFHbWC7oklyGQhteEhdRykNnXP2ujI4gzmAwavwJujI11tssybgWu19xxxeE9kYGjYk
         GX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9sHTptGW45hGlek0bBvKOjs4P6AIGWtd8UblJkJZH8s=;
        b=EmMRfDKFo0gpTzAmLX2yQqD3D9UjtR9UK2hht2L1jVxccfhebkLq5FWZ7zxbA9iVzd
         jkP9KOaHxKslvb8ZEpmHYJ+nJmGXL1IVR25Q7bofnbcu5dv+xezPeLIor4ndGT/xKdrZ
         Oft36yjAm0smV4UxB16mSzeWYsi0PIxBuEUoMbEmyWaKFPLXnphPI2tviRoG5q2Sbd2F
         l5J5ok+YPE6Tn7bDYk3NNYwB4SeoNmZi+DtYBMTGB1ZmGuUvSiuDhDkBp2WRIjdLiXvF
         f6/R5Xm2s3Ooxh0jhTEbXlL1dvWknopxu+h8WHq2UFUAfvKN6fY47+9ckr8ubKbJaQZA
         MO4g==
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
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Doug Ledford <dledford@redhat.com>,
	Hal Rosenstock <hal.rosenstock@gmail.com>,
	Inki Dae <inki.dae@samsung.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Jeff Moyer <jmoyer@redhat.com>,
	Joonyoung Shim <jy0922.shim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Mel Gorman <mgorman@suse.de>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 34/39] v4l2: disable filesystem-dax mapping support
Date: Mon, 26 Feb 2018 21:20:55 +0100
Message-Id: <20180226201645.165288395@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496361019199994?=
X-GMAIL-MSGID: =?utf-8?q?1593496361019199994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit b70131de648c2b997d22f4653934438013f407a1 upstream.

V4L2 memory registrations are incompatible with filesystem-dax that
needs the ability to revoke dma access to a mapping at will, or
otherwise allow the kernel to wait for completion of DMA.  The
filesystem-dax implementation breaks the traditional solution of
truncate of active file backed mappings since there is no page-cache
page we can orphan to sustain ongoing DMA.

If v4l2 wants to support long lived DMA mappings it needs to arrange to
hold a file lease or use some other mechanism so that the kernel can
coordinate revoking DMA access when the filesystem needs to truncate
mappings.

Link: http://lkml.kernel.org/r/151068940499.7446.12846708245365671207.stgit@dwillia2-desk3.amr.corp.intel.com
Fixes: 3565fce3a659 ("mm, x86: get_user_pages() for dax mappings")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reported-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Hal Rosenstock <hal.rosenstock@gmail.com>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Sean Hefty <sean.hefty@intel.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/videobuf-dma-sg.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/media/v4l2-core/videobuf-dma-sg.c
+++ b/drivers/media/v4l2-core/videobuf-dma-sg.c
@@ -185,12 +185,13 @@ static int videobuf_dma_init_user_locked
 	dprintk(1, "init user [0x%lx+0x%lx => %d pages]\n",
 		data, size, dma->nr_pages);
 
-	err = get_user_pages(data & PAGE_MASK, dma->nr_pages,
+	err = get_user_pages_longterm(data & PAGE_MASK, dma->nr_pages,
 			     flags, dma->pages, NULL);
 
 	if (err != dma->nr_pages) {
 		dma->nr_pages = (err >= 0) ? err : 0;
-		dprintk(1, "get_user_pages: err=%d [%d]\n", err, dma->nr_pages);
+		dprintk(1, "get_user_pages_longterm: err=%d [%d]\n", err,
+			dma->nr_pages);
 		return err < 0 ? err : -EINVAL;
 	}
 	return 0;
