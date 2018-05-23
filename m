Return-Path: <yehs2007@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527095296; cv=none;
        d=google.com; s=arc-20160816;
        b=1GOyyxrq9j5ecUhrN6F4Xj9C29F2SMX8+j32INJLXiSQyouKMaU0tPuYmCD+mIIV+G
         iGCajXsCRzuPDxhkBMPSm6eVRVxHVCsJCn4tz4PR/puZoIVFMFyh1SWlTGjLNJvggems
         BTFWgqjsbxpNGXAQaKoD5ZAm93cUrRY+lo+iaLEZdj4j/TWR3oM7k1/TlIo2Sl+nUBgZ
         hlwycjJEKaiM5p6AY2zZhCqStJGzwG2xHQlIRvhtSgEeWkSMxDQHx6Ip2/3wV9Ro0q0K
         2C06nofL3H4wziqFivY9JCWfqiKEAMdj2os5BCsPrBLi8um3r7ELlY+/+AztPdkuqLqd
         iI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=XRMIRY7Bl0mnuZDmDjxg/oXpZPKnlUTZJQQhFU+roes=;
        b=JW7FCfVD9s5EJ7opdZrbKEyIcxDhBRlugWDbtWE4pdYfVbME4fBPjBWySk6S9ElgPL
         fRNQ8e8IJhGlgBkcjsbxOCE8IK1m/zo0ZypSiKRnXz0Oh1JRdJLXtbzGEtIYa0jazEet
         2VGZv14jiCp/hvo0Qiv1KLTArgC4FgTgI60J30+ReH25LOZDUMcxeBA2Y4uKxJTHd1kQ
         whSXQgs4qr+ByUvEtPVg0WYSPc7VHlIuVgiIFwIGXxpCoRiTe0nOb/UvpFhlc/rWuikY
         3DYsU2K/I+QsOUmfqrb67LaiylwRmp9Qr1bAw2DipJbcm9BHFLp2dd749xdF4gA5ncrB
         aAog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qmMTBpLO;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qmMTBpLO;
       spf=pass (google.com: domain of yehs2007@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=yehs2007@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZohldhYpTuP/qY+cqPYNnVVtPnSwSfkvn4RPMN9x+oJvENdMuT7FuqSllge3G3xSzZIi2d6GA==
From: Huaisheng Ye <yehs2007@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: mhocko@suse.com,
	willy@infradead.org,
	hch@lst.de,
	vbabka@suse.cz,
	mgorman@techsingularity.net,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	colyli@suse.de,
	chengnt@lenovo.com,
	hehy1@lenovo.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org,
	linux-btrfs@vger.kernel.org,
	Huaisheng Ye <yehs1@lenovo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v3 8/9] include/linux/highmem.h: update usage of movableflags
Date: Thu, 24 May 2018 01:08:06 +0800
Message-Id: <1527095286-5165-1-git-send-email-yehs2007@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601275478095562257?=
X-GMAIL-MSGID: =?utf-8?q?1601275478095562257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Huaisheng Ye <yehs1@lenovo.com>

GFP_HIGHUSER_MOVABLE doesn't equal to GFP_HIGHUSER | __GFP_MOVABLE,
modify it to adapt patch of getting rid of GFP_ZONE_TABLE/BAD.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Christoph Hellwig <hch@infradead.org>
---
 include/linux/highmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 0690679..5383c9e 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -159,8 +159,8 @@ static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
 			struct vm_area_struct *vma,
 			unsigned long vaddr)
 {
-	struct page *page = alloc_page_vma(GFP_HIGHUSER | movableflags,
-			vma, vaddr);
+	struct page *page = alloc_page_vma(movableflags ?
+		GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER, vma, vaddr);
 
 	if (page)
 		clear_user_highpage(page, vaddr);
-- 
1.8.3.1
