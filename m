Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELsajrnqfGM8/cq+MtSzJH8KPjk3bz0uPGG8b2VAZArZv2zV710E0Zb/K0M2jqpKhGxtSkeI
ARC-Seal: i=1; a=rsa-sha256; t=1519831334; cv=none;
        d=google.com; s=arc-20160816;
        b=BPYXbhGsCHItXBoH3mVBqWmUw6dZVzael0+vuXPZhrkrsnUtZqTdGNbrWaO+ugTTDn
         xvicMji49DUErTq/4iZe8Vl2A/2NaMIydRPAR3rBiAPWHoknvrpU0U8bSbDwhmHDqvbE
         1JO4YXAvzEiAzXfHu2Po/otZIFrVlny9RhXWFznX/V3Yb4Z5bq0RDJ0LTXig45C+vxOf
         P89wuQSQbP2n2WEZm7aGqgTF/LLLVggRoKnsjwZQacDsU42VXwj3ru35W40jjJF5FfPa
         je8ACdj/z+hnagZ1ciiAONNXY4lJS3Xn8xc86eIa5hfPAqx9kCbz88tLYdf9jMISbDpi
         yb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=xh5+O2DqetIHMcvxVp/sRGrlOcoS6y0OPe5fNzhegOc=;
        b=uQwG993obg6ggtzZjGIUsvc2jPXkk4ON3o26M0elPms49OFqtpvZRHkENTqQp0Ychc
         U3PeSoprs67Ud0/Q9pQmz/llM9dMw5xoq96bXbrjgH+HoodmJK2EAaq5wV5i+eoP2FAW
         jQ0MDHGao/+jjs8TH5VP1FZM2LAUDElaKRXihwzQWTHxzDagxZQFeMQAWWf0dKfpw9Pk
         Jw5bjD0Y/eLY0pvtmzCMZ8U18Um47qzbcSZ53AnGjqiyndpBtBG6xMhzvt1O74ts33rq
         eHbICw5kkOQ9Mf9I3jrAlOqzgA3olCfAW5Bwy5DjYVtbj3nIAcEm08Z/Rd5W+A0OMNAk
         ySkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "" <syzbot+f9831b881b3e849829fc@syzkaller.appspotmail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Pete Zaitcev" <zaitcev@redhat.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.384663834@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 091/140] USB: fix usbmon BUG trigger
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658660846987394?=
X-GMAIL-MSGID: =?utf-8?q?1593658660846987394?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Pete Zaitcev <zaitcev@redhat.com>

commit 46eb14a6e1585d99c1b9f58d0e7389082a5f466b upstream.

Automated tests triggered this by opening usbmon and accessing the
mmap while simultaneously resizing the buffers. This bug was with
us since 2006, because typically applications only size the buffers
once and thus avoid racing. Reported by Kirill A. Shutemov.

Reported-by: <syzbot+f9831b881b3e849829fc@syzkaller.appspotmail.com>
Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/mon/mon_bin.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -1000,7 +1000,9 @@ static long mon_bin_ioctl(struct file *f
 		break;
 
 	case MON_IOCQ_RING_SIZE:
+		mutex_lock(&rp->fetch_lock);
 		ret = rp->b_size;
+		mutex_unlock(&rp->fetch_lock);
 		break;
 
 	case MON_IOCT_RING_SIZE:
@@ -1227,12 +1229,16 @@ static int mon_bin_vma_fault(struct vm_a
 	unsigned long offset, chunk_idx;
 	struct page *pageptr;
 
+	mutex_lock(&rp->fetch_lock);
 	offset = vmf->pgoff << PAGE_SHIFT;
-	if (offset >= rp->b_size)
+	if (offset >= rp->b_size) {
+		mutex_unlock(&rp->fetch_lock);
 		return VM_FAULT_SIGBUS;
+	}
 	chunk_idx = offset / CHUNK_SIZE;
 	pageptr = rp->b_vec[chunk_idx].pg;
 	get_page(pageptr);
+	mutex_unlock(&rp->fetch_lock);
 	vmf->page = pageptr;
 	return 0;
 }
