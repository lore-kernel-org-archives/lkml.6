Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/gJCF8TNewpNHITrh/LTomxVCybNObw6JUVCvWKrf6TB4fBUB5yY09xlwTj8XVfri5mMDO
ARC-Seal: i=1; a=rsa-sha256; t=1522168663; cv=none;
        d=google.com; s=arc-20160816;
        b=AZXaXNOp3S/q0KMYW4CRNqcgV28bzGuCPv9bNWCdO8SjZUsSWGsERYeSi9dKau3mTB
         etAFBVl2OHUEQ+fVof3PCSeK8Wv1cqBM5L0mNrjGzuvc99hTkCtWTjmZ43zwciVveDba
         AL1d2yNDncU5dBacJYqO2P2kjq/1q2hjbcYsfIa4I0886aIuhthixNEVWVogWAKgFUb8
         FO362t/EOHqj1hZ4x28S3Kk/A3KBWeFrB/VzN3cejUFw+2ChaZm70CqE06QGK3XqxWhs
         PshXeBaxIa2XO4FbnliuaZp+xOeV/nblqiahl/Ec0i0b/5ZWMTCZ1JrlGBRNipjoZBVu
         AVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gTk5g4hvxj8Wz0KRWp8xs1/U5NK3MTaWuVPu4JqBHTI=;
        b=ywAHDtQwl4Vi3JOZt3eHBW4NKP65AM1mxBHNU4rCK4JgUpN5A9rkwck8E0H+RS8VAJ
         ijW7H7EjYopQRzIHqY+vX/umewCfXMz4s/xRdU0nm28V4fymuabs5IuxDQPa3Aak4c9f
         w9eI7GAA7MdUSQIIN4PqCjGLBq5CJK4wP/Ae0vOs0bRY2tT15YzT66SSEy8hrEbuGKZf
         69I+v50+KhiI3Ejhn4v4DcPuFW+R02lAjAkux/QJGogMA1Q35cRx9mFFI++UANACX61N
         hQDHTG0WK2LGPAI7XGhp2W/7szbatTkXs14LwmulSMx7JXdVj8dRpJVloOdoiTcK4pQq
         /tRg==
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
Subject: [PATCH 4.14 061/101] libnvdimm, {btt, blk}: do integrity setup before add_disk()
Date: Tue, 27 Mar 2018 18:27:33 +0200
Message-Id: <20180327162753.731042667@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109160718224747?=
X-GMAIL-MSGID: =?utf-8?q?1596109528182382403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -278,8 +278,6 @@ static int nsblk_attach_disk(struct nd_n
 	disk->queue		= q;
 	disk->flags		= GENHD_FL_EXT_DEVT;
 	nvdimm_namespace_disk_name(&nsblk->common, disk->disk_name);
-	set_capacity(disk, 0);
-	device_add_disk(dev, disk);
 
 	if (devm_add_action_or_reset(dev, nd_blk_release_disk, disk))
 		return -ENOMEM;
@@ -292,6 +290,7 @@ static int nsblk_attach_disk(struct nd_n
 	}
 
 	set_capacity(disk, available_disk_size >> SECTOR_SHIFT);
+	device_add_disk(dev, disk);
 	revalidate_disk(disk);
 	return 0;
 }
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1542,8 +1542,6 @@ static int btt_blk_init(struct btt *btt)
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, btt->btt_queue);
 	btt->btt_queue->queuedata = btt;
 
-	set_capacity(btt->btt_disk, 0);
-	device_add_disk(&btt->nd_btt->dev, btt->btt_disk);
 	if (btt_meta_size(btt)) {
 		int rc = nd_integrity_init(btt->btt_disk, btt_meta_size(btt));
 
@@ -1555,6 +1553,7 @@ static int btt_blk_init(struct btt *btt)
 		}
 	}
 	set_capacity(btt->btt_disk, btt->nlba * btt->sector_size >> 9);
+	device_add_disk(&btt->nd_btt->dev, btt->btt_disk);
 	btt->nd_btt->size = btt->nlba * (u64)btt->sector_size;
 	revalidate_disk(btt->btt_disk);
 
