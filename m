Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoIz/iNKGPIa0juqkVQwPg/bcrSOb9rdix5fNF43/WtYJq1QJ/MUFw1Ez1ybqC5RDh2eJqX
ARC-Seal: i=1; a=rsa-sha256; t=1525767408; cv=none;
        d=google.com; s=arc-20160816;
        b=nFAMReZDhf+7DdobjAXUbU9LErf5zcgif+R1K0xzKnfA7OUAu6DdhhSKJacB7J6mNY
         X1J1+saQ9V4dYseKm6UayOgeNbWZYsHM0J+ReXOSOsDvemumxnczIp22fSOx6rkfbXvA
         zcBktHdmXF76VLdtbaQfONW3ZW2MAcgZMJXbSukEsXEm/qGPtyWIBWxT2XxJgazjz4lM
         VRZcEIB9ZFlbk9eCmqgr+I206JWo+yxnSmFe6D5qpVN5fleiDO8BBTb2srWNag24B+nY
         Akn1ATdOIKnufNO/abLfCRqZZOhB4ki3wzjbbrX4+zEV1x501jMGtnvbd6s/lhF+yJE+
         lCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Ap6z/Zxyg0hLvhVD5nQoNfXgTAn9vTkepAGuvZieoCk=;
        b=YQPgZhU6h6uHiabxpSXaHcPr8agCw2M/wcVOPusRN9FnFwKPiVZn1lzGKX928hYbBK
         xsr0kDcKzLHTwy6WC+0R+zZHA8IwIR2cJQRl0nf+SLl/26oRNpByBAth4QZ9LAhbRx+h
         pxmRLM8DC1uM+fJXKR6D6GhPE3Q4qeQGJ/4hQbs8VKoUVCCQnsD9Gdt/tXNaEnctCMu6
         LQy4QZzLgtuU/Gk7QXCzTZ3i8QVKq+6sRqPCevmalB1wNojRRfOHQ3HM4WRMoGEc3lj/
         Q5PJ/yQ+XWncYBNXhZwic7PVho0+1clccE84RbD0NLZ2AjGxSZO7jNVnkJzzNvxtRcnZ
         42Hg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=aMiHfV1R;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=aMiHfV1R;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Raju Rangoju <rajur@chelsio.com>,
	Steve Wise <swise@opengridcomputing.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.9 16/32] RDMA/cxgb4: release hw resources on device removal
Date: Tue,  8 May 2018 10:10:56 +0200
Message-Id: <20180508074011.416605197@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882841899832567?=
X-GMAIL-MSGID: =?utf-8?q?1599883086516019512?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -856,6 +856,11 @@ static int c4iw_rdev_open(struct c4iw_rd
 
 	rdev->status_page->db_off = 0;
 
+	init_completion(&rdev->rqt_compl);
+	init_completion(&rdev->pbl_compl);
+	kref_init(&rdev->rqt_kref);
+	kref_init(&rdev->pbl_kref);
+
 	return 0;
 err_free_status_page:
 	free_page((unsigned long)rdev->status_page);
@@ -872,12 +877,14 @@ destroy_resource:
 
 static void c4iw_rdev_close(struct c4iw_rdev *rdev)
 {
-	destroy_workqueue(rdev->free_workq);
 	kfree(rdev->wr_log);
 	free_page((unsigned long)rdev->status_page);
 	c4iw_pblpool_destroy(rdev);
 	c4iw_rqtpool_destroy(rdev);
+	wait_for_completion(&rdev->pbl_compl);
+	wait_for_completion(&rdev->rqt_compl);
 	c4iw_destroy_resource(&rdev->resource);
+	destroy_workqueue(rdev->free_workq);
 }
 
 static void c4iw_dealloc(struct uld_ctx *ctx)
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -186,6 +186,10 @@ struct c4iw_rdev {
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
 	PDBG("%s addr 0x%x size %d\n", __func__, addr, size);
@@ -273,6 +283,7 @@ void c4iw_pblpool_free(struct c4iw_rdev
 	rdev->stats.pbl.cur -= roundup(size, 1 << MIN_PBL_SHIFT);
 	mutex_unlock(&rdev->stats.lock);
 	gen_pool_free(rdev->pbl_pool, (unsigned long)addr, size);
+	kref_put(&rdev->pbl_kref, destroy_pblpool);
 }
 
 int c4iw_pblpool_create(struct c4iw_rdev *rdev)
@@ -312,7 +323,7 @@ int c4iw_pblpool_create(struct c4iw_rdev
 
 void c4iw_pblpool_destroy(struct c4iw_rdev *rdev)
 {
-	gen_pool_destroy(rdev->pbl_pool);
+	kref_put(&rdev->pbl_kref, destroy_pblpool);
 }
 
 /*
@@ -333,12 +344,22 @@ u32 c4iw_rqtpool_alloc(struct c4iw_rdev
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
 	PDBG("%s addr 0x%x size %d\n", __func__, addr, size << 6);
@@ -346,6 +367,7 @@ void c4iw_rqtpool_free(struct c4iw_rdev
 	rdev->stats.rqt.cur -= roundup(size << 6, 1 << MIN_RQT_SHIFT);
 	mutex_unlock(&rdev->stats.lock);
 	gen_pool_free(rdev->rqt_pool, (unsigned long)addr, size << 6);
+	kref_put(&rdev->rqt_kref, destroy_rqtpool);
 }
 
 int c4iw_rqtpool_create(struct c4iw_rdev *rdev)
@@ -383,7 +405,7 @@ int c4iw_rqtpool_create(struct c4iw_rdev
 
 void c4iw_rqtpool_destroy(struct c4iw_rdev *rdev)
 {
-	gen_pool_destroy(rdev->rqt_pool);
+	kref_put(&rdev->rqt_kref, destroy_rqtpool);
 }
 
 /*
