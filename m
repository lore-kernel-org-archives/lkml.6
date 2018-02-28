Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x225m7Kqk9hkSYugm4KwcKhyXEelast9hx+aMY5PJVJyOMb+BiFq/pxwPn//VfonudeUqHA+k
ARC-Seal: i=1; a=rsa-sha256; t=1519834825; cv=none;
        d=google.com; s=arc-20160816;
        b=DVtGn3qu/t91PdY1GNzpc1geZKalvQogMeAqNsz0hfs8TYiSP8dn07qkd71nvUEXsT
         M54eh9b1iFnXOUsNhymKCkOExClrgaQcTv3hn5nQsnFqe3c405FABh3N9fh5vCkvFnYO
         qWrb4LKK04DALTqzqMMt4MxF74A/kcKVT60Ae2Lubc75OBQXrY0HwfTokxF04OWaQhO9
         tXdFRfNka3yW1ol4mGhb1j42PMY9V83gEAyz+oMab1g0X5nM78OaeZvxUqpBI+hgFhLR
         Hv4PiNNBg5i6Ya7es1cIKvM+RCEOnf/l2/u80QUKfcm+hBWPY8OMeF8OdZV1m9Q30bdh
         +N6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=CQj/lbL7yKb0tJyIFALgCbIFbxBRTqRmFz9akKX7kio=;
        b=D/k+qGHJQmjiReaawhlDNczdguV/LKJe2tCahO8N+2neFMwaA6cOVqS2e9GvuZaYMm
         WPng6sYjyUTes33dt7IVFhbnsu6UOJxQhVljj/hZ0R1OBkrJNhG/J8UJwje/B6PTWSsQ
         sDBv6xPJB8e18lNul3r38uyeC4jwL7YlTawMu1uNMtF3d4KhR2Dg3TYR7m3/XUaMs0EB
         ntqu4xY9AxLdzzccnmUj/D7DAQ+RkGy+jtED/Vv2MX5xlE5asArtkJtEGwoU+k6vsP1t
         8fbPpdGz0s8BKUxMq0JYm2mDL0p9IJzqy6ZyS17AOe7TH4Q+ygWtKRiifP7smViERV3Q
         SmlA==
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
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "" <syzbot+f9831b881b3e849829fc@syzkaller.appspotmail.com>,
 "Pete Zaitcev" <zaitcev@redhat.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.929926917@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 190/254] USB: fix usbmon BUG trigger
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658660846987394?=
X-GMAIL-MSGID: =?utf-8?q?1593662321473077774?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

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
