Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+EzE6y3LreAaNsGWaolp5nIBpiIoS5uSNr9TrAIqWnCo5PZWTihbd/HIFJAo8BZKRO4rMX
ARC-Seal: i=1; a=rsa-sha256; t=1522168885; cv=none;
        d=google.com; s=arc-20160816;
        b=Pt8BfXgX1G0IicpYZkh0+wnvE0W2HVNoxeHwfveM5EC7dZbD2vmsj9my57bedF6tPt
         gwm6U35iFvjB4PX2bBlQaA+jYfuGaMKOZ6LsSITvabhuxVipne1Ovdt1MyfPhM6wvL9n
         FwNwYnQCCbXNeHlzypLj2zzgkFzvnDrFoonAY9ws297DoTOaqNaLXFXS6krxszFUPYhq
         n/gzqMcdjX7d1ybhzYb1K8OmB8tDnNLzYktzvdN9vmVq+chCCyZ2VGZhF2oWk3eLClxW
         k4xVuJBH6gGAqpjZ8AP9RFy15ivmTV6RwZ59tOAdczlJGI2kF1wmWtJFWJO9fd1ZcoKw
         NLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3EgbXbwtRxWojjnWM0E/Lew8QahRumWhXFs0/RUZ63s=;
        b=lBS+Av9E3NtLE9r3E2dhYJGagGEoRDlyBew5Leela/SXRDCDtDzOAEoIGdkerBMtkj
         Mz/fz1aZmWQX82pmNrTu1M8yaiKmavNpL6oJa8sr+mufUkKiX+MDOY81s2b/LYRjAm4Z
         p7WfoW5QHGK7ZvDEtTO7vgDVICfcdiujt/7+jOk1XQZ3HipVIOruajFc6brTZucC+e0t
         8ZRZIb3TEKrCLWPhuy9NBu20kncZJfstyhC5mJFsQGXW+l781oNFGUoV4zIsA1usR0IL
         hsaQNfpz1HFDKUzzIXFL/XxCPPwtgOURuYWuoSj6DhzPMVKioUJBv/8CVnWen1RCVDii
         hymg==
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
Subject: [PATCH 4.15 066/105] libnvdimm, {btt, blk}: do integrity setup before add_disk()
Date: Tue, 27 Mar 2018 18:27:46 +0200
Message-Id: <20180327162801.824833796@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109160718224747?=
X-GMAIL-MSGID: =?utf-8?q?1596109761893413473?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1545,8 +1545,6 @@ static int btt_blk_init(struct btt *btt)
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, btt->btt_queue);
 	btt->btt_queue->queuedata = btt;
 
-	set_capacity(btt->btt_disk, 0);
-	device_add_disk(&btt->nd_btt->dev, btt->btt_disk);
 	if (btt_meta_size(btt)) {
 		int rc = nd_integrity_init(btt->btt_disk, btt_meta_size(btt));
 
@@ -1558,6 +1556,7 @@ static int btt_blk_init(struct btt *btt)
 		}
 	}
 	set_capacity(btt->btt_disk, btt->nlba * btt->sector_size >> 9);
+	device_add_disk(&btt->nd_btt->dev, btt->btt_disk);
 	btt->nd_btt->size = btt->nlba * (u64)btt->sector_size;
 	revalidate_disk(btt->btt_disk);
 
