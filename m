Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48qhSTmN/Pj9eCCXb0IjI9gcxfW3pKf8sqCcx3Odc0NTwKaGHzaJ9RWyozpMU7V5aIjkq5R
ARC-Seal: i=1; a=rsa-sha256; t=1522168312; cv=none;
        d=google.com; s=arc-20160816;
        b=mLjMywlK8pzn8+zsBlVkTNKa7/FEQeRBP4JDWHD0ceZwHzDYmiKyOR5I19GU6ua2TL
         DUk+T5d8ygYb4Q86kJj7lmVu0QmaxrO9AZGBzzw0/P2rsLBcydNO42lfVTXZdJsNX4rD
         VzWxF9wdZwm2VpaJP6p0bQ0B4LT4UPb+CMBa/nkWBBeIioMSnESA/raWpDOta2dLruE+
         Wl0QRc4+z+7xVPtLMpAUpdf1gGtnoQQIJN+bkpQ5JNgJvE0Unu3KnzqcAY4nQijcDgdw
         Ztphyc397TPip/8Xjp+vWNTTYViJy3ScLfq1XI6aXWcCIXpN28vLBrUJrXjfIOeIDOIZ
         STZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EBVsHoIHHpp7BuLzPvMZIWXwDgQIu+TkJq1BjwbAgpc=;
        b=mUAs8HB2WydO9JPsAHBdkXrLhB6EvHDTlakfZRx/rv71Qk9qJFzPN0Vh+StYONozPL
         QXWYUjkR2PQCna6VfP/Cs+Q4EOlv6AoKkgnxucheIkZhk/HaAcmgf3pEdo9GHLDCNCU5
         vcpo0WWf3/WSZlSED9v+MCaKTrlQrG+wrTRmfxH55IkNNNooI5/0j3f8th4S+fyUQpWD
         Vdgbw5MvuYmdUclQ177ab5Vyc+2d1lfPqdYp7ds4CJPaUa88nt+VejaO5uIXAKA9wnyc
         os3oL4SQ5oO3+DCEl3Y4z09pkNowtL9U/Ue1BO0QK6DCUGKMW+4Hfu1t1V/rAdst7ny9
         qJDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dariusz Dokupil <dariusz.dokupil@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.9 34/67] libnvdimm, {btt, blk}: do integrity setup before add_disk()
Date: Tue, 27 Mar 2018 18:27:26 +0200
Message-Id: <20180327162728.876868121@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109160718224747?=
X-GMAIL-MSGID: =?utf-8?q?1596109160718224747?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vishal Verma <vishal.l.verma@intel.com>

commit 3ffb0ba9b567a8efb9a04ed3d1ec15ff333ada22 upstream.

Prior to 25520d55cdb6 ("block: Inline blk_integrity in struct gendisk")
we needed to temporarily add a zero-capacity disk before registering for
blk-integrity. But adding a zero-capacity disk caused the partition
table scanning to bail early, and this resulted in partitions not coming
up after a probe of the BTT or blk namespaces.

We can now register for integrity before the disk has been added, and
this fixes the rescan problems.

Fixes: 25520d55cdb6 ("block: Inline blk_integrity in struct gendisk")
Reported-by: Dariusz Dokupil <dariusz.dokupil@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/blk.c |    3 +--
 drivers/nvdimm/btt.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -286,8 +286,6 @@ static int nsblk_attach_disk(struct nd_n
 	disk->queue		= q;
 	disk->flags		= GENHD_FL_EXT_DEVT;
 	nvdimm_namespace_disk_name(&nsblk->common, disk->disk_name);
-	set_capacity(disk, 0);
-	device_add_disk(dev, disk);
 
 	if (devm_add_action_or_reset(dev, nd_blk_release_disk, disk))
 		return -ENOMEM;
@@ -300,6 +298,7 @@ static int nsblk_attach_disk(struct nd_n
 	}
 
 	set_capacity(disk, available_disk_size >> SECTOR_SHIFT);
+	device_add_disk(dev, disk);
 	revalidate_disk(disk);
 	return 0;
 }
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1392,8 +1392,6 @@ static int btt_blk_init(struct btt *btt)
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, btt->btt_queue);
 	btt->btt_queue->queuedata = btt;
 
-	set_capacity(btt->btt_disk, 0);
-	device_add_disk(&btt->nd_btt->dev, btt->btt_disk);
 	if (btt_meta_size(btt)) {
 		int rc = nd_integrity_init(btt->btt_disk, btt_meta_size(btt));
 
@@ -1405,6 +1403,7 @@ static int btt_blk_init(struct btt *btt)
 		}
 	}
 	set_capacity(btt->btt_disk, btt->nlba * btt->sector_size >> 9);
+	device_add_disk(&btt->nd_btt->dev, btt->btt_disk);
 	btt->nd_btt->size = btt->nlba * (u64)btt->sector_size;
 	revalidate_disk(btt->btt_disk);
 
