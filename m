Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163616AbeE1KuD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163249AbeE1Kt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:49:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 195/496] block: display the correct diskname for bio
Date: Mon, 28 May 2018 11:59:40 +0200
Message-Id: <20180528100328.143742866@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiufei Xue <jiufei.xue@linux.alibaba.com>

[ Upstream commit 9c0fb1e313aaf4e8edec22433c8b22dd308e466c ]

bio_devname use __bdevname to display the device name, and can
only show the major and minor of the part0,
Fix this by using disk_name to display the correct name.

Fixes: 74d46992e0d9 ("block: replace bi_bdev with a gendisk pointer and partitions index")
Reviewed-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/partition-generic.c |    6 ++++++
 include/linux/bio.h       |    4 +---
 2 files changed, 7 insertions(+), 3 deletions(-)

--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -51,6 +51,12 @@ const char *bdevname(struct block_device
 
 EXPORT_SYMBOL(bdevname);
 
+const char *bio_devname(struct bio *bio, char *buf)
+{
+	return disk_name(bio->bi_disk, bio->bi_partno, buf);
+}
+EXPORT_SYMBOL(bio_devname);
+
 /*
  * There's very little reason to use this, you should really
  * have a struct block_device just about everywhere and use
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -501,6 +501,7 @@ void zero_fill_bio(struct bio *bio);
 extern struct bio_vec *bvec_alloc(gfp_t, int, unsigned long *, mempool_t *);
 extern void bvec_free(mempool_t *, struct bio_vec *, unsigned int);
 extern unsigned int bvec_nr_vecs(unsigned short idx);
+extern const char *bio_devname(struct bio *bio, char *buffer);
 
 #define bio_set_dev(bio, bdev) 			\
 do {						\
@@ -519,9 +520,6 @@ do {						\
 #define bio_dev(bio) \
 	disk_devt((bio)->bi_disk)
 
-#define bio_devname(bio, buf) \
-	__bdevname(bio_dev(bio), (buf))
-
 #ifdef CONFIG_BLK_CGROUP
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
 int bio_associate_current(struct bio *bio);
