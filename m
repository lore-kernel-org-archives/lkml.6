Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33076C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CD420864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CD420864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936436AbeFRIZF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:25:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935926AbeFRIZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:25:00 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 63EACC74;
        Mon, 18 Jun 2018 08:24:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Sebastian Sanchez <sebastian.sanchez@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 174/279] IB/{hfi1, rdmavt}: Fix memory leak in hfi1_alloc_devdata() upon failure
Date:   Mon, 18 Jun 2018 10:12:39 +0200
Message-Id: <20180618080616.082039671@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Sanchez <sebastian.sanchez@intel.com>

[ Upstream commit e9777ad4399c26c70318c4945f94efac2ed95391 ]

When allocating device data, if there's an allocation failure, the
already allocated memory won't be freed such as per-cpu counters.

Fix memory leaks in exception path by creating a common reentrant
clean up function hfi1_clean_devdata() to be used at driver unload
time and device data allocation failure.

To accomplish this, free_platform_config() and clean_up_i2c() are
changed to be reentrant to remove dependencies when they are called
in different order. This helps avoid NULL pointer dereferences
introduced by this patch if those two functions weren't reentrant.

In addition, set dd->int_counter, dd->rcv_limit,
dd->send_schedule and dd->tx_opstats to NULL after they're freed in
hfi1_clean_devdata(), so that hfi1_clean_devdata() is fully reentrant.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Sebastian Sanchez <sebastian.sanchez@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hfi1/init.c     |   37 ++++++++++++++++++++++++----------
 drivers/infiniband/hw/hfi1/platform.c |    1 
 drivers/infiniband/hw/hfi1/qsfp.c     |    2 +
 3 files changed, 30 insertions(+), 10 deletions(-)

--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1209,30 +1209,49 @@ static void finalize_asic_data(struct hf
 	kfree(ad);
 }
 
-static void __hfi1_free_devdata(struct kobject *kobj)
+/**
+ * hfi1_clean_devdata - cleans up per-unit data structure
+ * @dd: pointer to a valid devdata structure
+ *
+ * It cleans up all data structures set up by
+ * by hfi1_alloc_devdata().
+ */
+static void hfi1_clean_devdata(struct hfi1_devdata *dd)
 {
-	struct hfi1_devdata *dd =
-		container_of(kobj, struct hfi1_devdata, kobj);
 	struct hfi1_asic_data *ad;
 	unsigned long flags;
 
 	spin_lock_irqsave(&hfi1_devs_lock, flags);
-	idr_remove(&hfi1_unit_table, dd->unit);
-	list_del(&dd->list);
+	if (!list_empty(&dd->list)) {
+		idr_remove(&hfi1_unit_table, dd->unit);
+		list_del_init(&dd->list);
+	}
 	ad = release_asic_data(dd);
 	spin_unlock_irqrestore(&hfi1_devs_lock, flags);
-	if (ad)
-		finalize_asic_data(dd, ad);
+
+	finalize_asic_data(dd, ad);
 	free_platform_config(dd);
 	rcu_barrier(); /* wait for rcu callbacks to complete */
 	free_percpu(dd->int_counter);
 	free_percpu(dd->rcv_limit);
 	free_percpu(dd->send_schedule);
 	free_percpu(dd->tx_opstats);
+	dd->int_counter   = NULL;
+	dd->rcv_limit     = NULL;
+	dd->send_schedule = NULL;
+	dd->tx_opstats    = NULL;
 	sdma_clean(dd, dd->num_sdma);
 	rvt_dealloc_device(&dd->verbs_dev.rdi);
 }
 
+static void __hfi1_free_devdata(struct kobject *kobj)
+{
+	struct hfi1_devdata *dd =
+		container_of(kobj, struct hfi1_devdata, kobj);
+
+	hfi1_clean_devdata(dd);
+}
+
 static struct kobj_type hfi1_devdata_type = {
 	.release = __hfi1_free_devdata,
 };
@@ -1333,9 +1352,7 @@ struct hfi1_devdata *hfi1_alloc_devdata(
 	return dd;
 
 bail:
-	if (!list_empty(&dd->list))
-		list_del_init(&dd->list);
-	rvt_dealloc_device(&dd->verbs_dev.rdi);
+	hfi1_clean_devdata(dd);
 	return ERR_PTR(ret);
 }
 
--- a/drivers/infiniband/hw/hfi1/platform.c
+++ b/drivers/infiniband/hw/hfi1/platform.c
@@ -199,6 +199,7 @@ void free_platform_config(struct hfi1_de
 {
 	/* Release memory allocated for eprom or fallback file read. */
 	kfree(dd->platform_config.data);
+	dd->platform_config.data = NULL;
 }
 
 void get_port_type(struct hfi1_pportdata *ppd)
--- a/drivers/infiniband/hw/hfi1/qsfp.c
+++ b/drivers/infiniband/hw/hfi1/qsfp.c
@@ -204,6 +204,8 @@ static void clean_i2c_bus(struct hfi1_i2
 
 void clean_up_i2c(struct hfi1_devdata *dd, struct hfi1_asic_data *ad)
 {
+	if (!ad)
+		return;
 	clean_i2c_bus(ad->i2c_bus0);
 	ad->i2c_bus0 = NULL;
 	clean_i2c_bus(ad->i2c_bus1);


