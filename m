Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpRFcnNwpxd2pubPI6jbl7IaQ8u9EYRJ35CFE3OjbNh9oD4Xu/6bKwNj2fWVCEisVKP9N+h
ARC-Seal: i=1; a=rsa-sha256; t=1525767291; cv=none;
        d=google.com; s=arc-20160816;
        b=NZ3nWj+s2KlhzNjHExM3d3w0z91DKTlch4Jb3qnDz+NORKCgW70q/ya1L8M4y7lWtu
         4D8/WcHbqzUlyHtcvaTsXRjpg/O2J8X/UeOFX609OW6hyK7cEm5+9oVRK7SmgyL115+K
         YzPWHgek7pynvZOpbkZYMR9MAHXhTMjtn8UMpPf456dwmR73lBdBKwOCApqUkKBX7pbS
         pBZdJhyTlzF20J3V2YSoet+awVwMjyhq0gBpdldaloJdvx3gZfdPiRst9cdy5xdGMTo+
         LvCnHYQi298cYlydMIosE8aEi/7NkWQNZHJfOTifyKubyjqKJ3/U5w/a5IAFsMb/eHnd
         7lSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=BVa1j9DAZRciMyr6GzzoCPC15L9O+GkSVjSr61R2CJU=;
        b=PWFVSoHryxGzhqalOQF2HGGG8gLrOw+16ZcmpU5qaWuwANAQgNk7IkHM/izlI8s/LZ
         agxXw9FgHGGs9u1RHwE0o+gLhIivyCH6drgJetgthviC7AjV721deYWIdPprY4mlqgFh
         C4axOUgM20LqfZ2vp2apFJaxnwo6qy7X9JGm8VZGpDJ5URNq3qMvfYVtgS0pNXk0/ZT+
         MQshq0c/lAoHXrkk/UQGgykDP7D4nTgLQiuxhDoiTZvPrO60wAI+j05vZMf3zBtSxuhO
         kb0Tx7lwaV9lO664vmmnxTvo8qSxWV3aw8iTSoa/rcngwYiMuaPVOB2ZXnS0DHA4Cjuu
         LzSA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Vjxiiq+L;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Vjxiiq+L;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Raju Rangoju <rajur@chelsio.com>,
	Steve Wise <swise@opengridcomputing.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 20/43] RDMA/cxgb4: release hw resources on device removal
Date: Tue,  8 May 2018 10:10:39 +0200
Message-Id: <20180508074007.277313391@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882841899832567?=
X-GMAIL-MSGID: =?utf-8?q?1599882964353574942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raju Rangoju <rajur@chelsio.com>

commit 26bff1bd74a4f7417509a83295614e9dab995b2a upstream.

The c4iw_rdev_close() logic was not releasing all the hw
resources (PBL and RQT memory) during the device removal
event (driver unload / system reboot). This can cause panic
in gen_pool_destroy().

The module remove function will wait for all the hw
resources to be released during the device removal event.

Fixes c12a67fe(iw_cxgb4: free EQ queue memory on last deref)
Signed-off-by: Raju Rangoju <rajur@chelsio.com>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
Cc: stable@vger.kernel.org
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/cxgb4/device.c   |    9 ++++++++-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h |    4 ++++
 drivers/infiniband/hw/cxgb4/resource.c |   26 ++++++++++++++++++++++++--
 3 files changed, 36 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -884,6 +884,11 @@ static int c4iw_rdev_open(struct c4iw_rd
 
 	rdev->status_page->db_off = 0;
 
+	init_completion(&rdev->rqt_compl);
+	init_completion(&rdev->pbl_compl);
+	kref_init(&rdev->rqt_kref);
+	kref_init(&rdev->pbl_kref);
+
 	return 0;
 err_free_status_page_and_wr_log:
 	if (c4iw_wr_log && rdev->wr_log)
@@ -902,13 +907,15 @@ destroy_resource:
 
 static void c4iw_rdev_close(struct c4iw_rdev *rdev)
 {
-	destroy_workqueue(rdev->free_workq);
 	kfree(rdev->wr_log);
 	c4iw_release_dev_ucontext(rdev, &rdev->uctx);
 	free_page((unsigned long)rdev->status_page);
 	c4iw_pblpool_destroy(rdev);
 	c4iw_rqtpool_destroy(rdev);
+	wait_for_completion(&rdev->pbl_compl);
+	wait_for_completion(&rdev->rqt_compl);
 	c4iw_ocqp_pool_destroy(rdev);
+	destroy_workqueue(rdev->free_workq);
 	c4iw_destroy_resource(&rdev->resource);
 }
 
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -185,6 +185,10 @@ struct c4iw_rdev {
 	struct wr_log_entry *wr_log;
 	int wr_log_size;
 	struct workqueue_struct *free_workq;
+	struct completion rqt_compl;
+	struct completion pbl_compl;
+	struct kref rqt_kref;
+	struct kref pbl_kref;
 };
 
 static inline int c4iw_fatal_error(struct c4iw_rdev *rdev)
--- a/drivers/infiniband/hw/cxgb4/resource.c
+++ b/drivers/infiniband/hw/cxgb4/resource.c
@@ -260,12 +260,22 @@ u32 c4iw_pblpool_alloc(struct c4iw_rdev
 		rdev->stats.pbl.cur += roundup(size, 1 << MIN_PBL_SHIFT);
 		if (rdev->stats.pbl.cur > rdev->stats.pbl.max)
 			rdev->stats.pbl.max = rdev->stats.pbl.cur;
+		kref_get(&rdev->pbl_kref);
 	} else
 		rdev->stats.pbl.fail++;
 	mutex_unlock(&rdev->stats.lock);
 	return (u32)addr;
 }
 
+static void destroy_pblpool(struct kref *kref)
+{
+	struct c4iw_rdev *rdev;
+
+	rdev = container_of(kref, struct c4iw_rdev, pbl_kref);
+	gen_pool_destroy(rdev->pbl_pool);
+	complete(&rdev->pbl_compl);
+}
+
 void c4iw_pblpool_free(struct c4iw_rdev *rdev, u32 addr, int size)
 {
 	pr_debug("%s addr 0x%x size %d\n", __func__, addr, size);
@@ -273,6 +283,7 @@ void c4iw_pblpool_free(struct c4iw_rdev
 	rdev->stats.pbl.cur -= roundup(size, 1 << MIN_PBL_SHIFT);
 	mutex_unlock(&rdev->stats.lock);
 	gen_pool_free(rdev->pbl_pool, (unsigned long)addr, size);
+	kref_put(&rdev->pbl_kref, destroy_pblpool);
 }
 
 int c4iw_pblpool_create(struct c4iw_rdev *rdev)
@@ -310,7 +321,7 @@ int c4iw_pblpool_create(struct c4iw_rdev
 
 void c4iw_pblpool_destroy(struct c4iw_rdev *rdev)
 {
-	gen_pool_destroy(rdev->pbl_pool);
+	kref_put(&rdev->pbl_kref, destroy_pblpool);
 }
 
 /*
@@ -331,12 +342,22 @@ u32 c4iw_rqtpool_alloc(struct c4iw_rdev
 		rdev->stats.rqt.cur += roundup(size << 6, 1 << MIN_RQT_SHIFT);
 		if (rdev->stats.rqt.cur > rdev->stats.rqt.max)
 			rdev->stats.rqt.max = rdev->stats.rqt.cur;
+		kref_get(&rdev->rqt_kref);
 	} else
 		rdev->stats.rqt.fail++;
 	mutex_unlock(&rdev->stats.lock);
 	return (u32)addr;
 }
 
+static void destroy_rqtpool(struct kref *kref)
+{
+	struct c4iw_rdev *rdev;
+
+	rdev = container_of(kref, struct c4iw_rdev, rqt_kref);
+	gen_pool_destroy(rdev->rqt_pool);
+	complete(&rdev->rqt_compl);
+}
+
 void c4iw_rqtpool_free(struct c4iw_rdev *rdev, u32 addr, int size)
 {
 	pr_debug("%s addr 0x%x size %d\n", __func__, addr, size << 6);
@@ -344,6 +365,7 @@ void c4iw_rqtpool_free(struct c4iw_rdev
 	rdev->stats.rqt.cur -= roundup(size << 6, 1 << MIN_RQT_SHIFT);
 	mutex_unlock(&rdev->stats.lock);
 	gen_pool_free(rdev->rqt_pool, (unsigned long)addr, size << 6);
+	kref_put(&rdev->rqt_kref, destroy_rqtpool);
 }
 
 int c4iw_rqtpool_create(struct c4iw_rdev *rdev)
@@ -380,7 +402,7 @@ int c4iw_rqtpool_create(struct c4iw_rdev
 
 void c4iw_rqtpool_destroy(struct c4iw_rdev *rdev)
 {
-	gen_pool_destroy(rdev->rqt_pool);
+	kref_put(&rdev->rqt_kref, destroy_rqtpool);
 }
 
 /*
