Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+5pzYEWfI3KVY5i+jyCf6MH55ko8WGwjy4ig6b7tVn+RoTvPC/IOrbX+haBkzNHIYQsYNV
ARC-Seal: i=1; a=rsa-sha256; t=1523980826; cv=none;
        d=google.com; s=arc-20160816;
        b=PV4vV1A6vHa0L2kU9qs39vzokJ7Uk7ojNoi0ii5BOcfWEmmIZsLC9pBw5nhrMosKe8
         t7LhFisURzMAy9+lAhoPaPhA2nDi3KxWY7UoIcBNm3LpjQVAztYJA6vwQg6Fc8EHI0+a
         ZIOmQbSn08uL/9L9OCJdKD8NoncbimNekPSAwzZFkTbscOGBribS+pQ5k+FQOzEqph3A
         1x/avm0/ilfiQHTdeoGN8Hx3jQBBikKE9glcFhjuMH+FTJyddsL3Y3Tckv7i83TB5syR
         /+6g4D8ECMPGtF1Z/xGFBZjozINSc2qXZfAS2rzyuVsRT9IESS1QGpe6nwW/cY43tgsr
         5DsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lCSWv/9mT1vD8ILAL6ef/o6ghcYENDs+2dEW5IZkrpI=;
        b=IE7axFFspsbe+rl1dbBN7QBwBtpAWNTtWKJAb7n0HJHNOpYKDRPwx23XykTnw9wT4+
         xl5lbBWHfIpneuC8YTFKTqWA9cENK+mr9bkpJTodYpbSxlQEdh3QHOhuyopWlMsbHnRF
         BN7cYmjMB7CGqcYijIFKKyjYPho/xkLh3hOjZJ67fHm7DxFhEfFxdOoruk8ByN6VYB+Y
         9DGCf2ogoAhLOYyW5K3WMNERbZh6b/W1k9LiLOaxavh9BmyFCyOg2FvAgRmNadVH0oNK
         y47mJYsI2zkkbBRrHnZSCRAEsZucMDZ8YlB1shUoSvVpAoJDJ47cPfGTfxCEK1U+c8dz
         I6eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adrian Suhov <v-adsuho@microsoft.com>,
	Chris Valean <v-chvale@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Jack Morgenstein <jackm@mellanox.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4.16 19/68] PCI: hv: Serialize the present and eject work items
Date: Tue, 17 Apr 2018 17:57:32 +0200
Message-Id: <20180417155750.118860977@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009719249133231?=
X-GMAIL-MSGID: =?utf-8?q?1598009719249133231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit 021ad274d7dc31611d4f47f7dd4ac7a224526f30 upstream.

When we hot-remove the device, we first receive a PCI_EJECT message and
then receive a PCI_BUS_RELATIONS message with bus_rel->device_count == 0.

The first message is offloaded to hv_eject_device_work(), and the second
is offloaded to pci_devices_present_work(). Both the paths can be running
list_del(&hpdev->list_entry), causing general protection fault, because
system_wq can run them concurrently.

The patch eliminates the race condition.

Since access to present/eject work items is serialized, we do not need the
hbus->enum_sem anymore, so remove it.

Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
Link: https://lkml.kernel.org/r/KL1P15301MB00064DA6B4D221123B5241CFBFD70@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM
Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
Tested-by: Chris Valean <v-chvale@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
[lorenzo.pieralisi@arm.com: squashed semaphore removal patch]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: <stable@vger.kernel.org> # v4.6+
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pci-hyperv.c |   34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -447,7 +447,6 @@ struct hv_pcibus_device {
 	spinlock_t device_list_lock;	/* Protect lists below */
 	void __iomem *cfg_addr;
 
-	struct semaphore enum_sem;
 	struct list_head resources_for_children;
 
 	struct list_head children;
@@ -461,6 +460,8 @@ struct hv_pcibus_device {
 	struct retarget_msi_interrupt retarget_msi_interrupt_params;
 
 	spinlock_t retarget_msi_interrupt_lock;
+
+	struct workqueue_struct *wq;
 };
 
 /*
@@ -1590,12 +1591,8 @@ static struct hv_pci_dev *get_pcichild_w
  * It must also treat the omission of a previously observed device as
  * notification that the device no longer exists.
  *
- * Note that this function is a work item, and it may not be
- * invoked in the order that it was queued.  Back to back
- * updates of the list of present devices may involve queuing
- * multiple work items, and this one may run before ones that
- * were sent later. As such, this function only does something
- * if is the last one in the queue.
+ * Note that this function is serialized with hv_eject_device_work(),
+ * because both are pushed to the ordered workqueue hbus->wq.
  */
 static void pci_devices_present_work(struct work_struct *work)
 {
@@ -1616,11 +1613,6 @@ static void pci_devices_present_work(str
 
 	INIT_LIST_HEAD(&removed);
 
-	if (down_interruptible(&hbus->enum_sem)) {
-		put_hvpcibus(hbus);
-		return;
-	}
-
 	/* Pull this off the queue and process it if it was the last one. */
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
 	while (!list_empty(&hbus->dr_list)) {
@@ -1637,7 +1629,6 @@ static void pci_devices_present_work(str
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 
 	if (!dr) {
-		up(&hbus->enum_sem);
 		put_hvpcibus(hbus);
 		return;
 	}
@@ -1724,7 +1715,6 @@ static void pci_devices_present_work(str
 		break;
 	}
 
-	up(&hbus->enum_sem);
 	put_hvpcibus(hbus);
 	kfree(dr);
 }
@@ -1770,7 +1760,7 @@ static void hv_pci_devices_present(struc
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 
 	get_hvpcibus(hbus);
-	schedule_work(&dr_wrk->wrk);
+	queue_work(hbus->wq, &dr_wrk->wrk);
 }
 
 /**
@@ -1848,7 +1838,7 @@ static void hv_pci_eject_device(struct h
 	get_pcichild(hpdev, hv_pcidev_ref_pnp);
 	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
 	get_hvpcibus(hpdev->hbus);
-	schedule_work(&hpdev->wrk);
+	queue_work(hpdev->hbus->wq, &hpdev->wrk);
 }
 
 /**
@@ -2461,13 +2451,18 @@ static int hv_pci_probe(struct hv_device
 	spin_lock_init(&hbus->config_lock);
 	spin_lock_init(&hbus->device_list_lock);
 	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
-	sema_init(&hbus->enum_sem, 1);
 	init_completion(&hbus->remove_event);
+	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
+					   hbus->sysdata.domain);
+	if (!hbus->wq) {
+		ret = -ENOMEM;
+		goto free_bus;
+	}
 
 	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
 			 hv_pci_onchannelcallback, hbus);
 	if (ret)
-		goto free_bus;
+		goto destroy_wq;
 
 	hv_set_drvdata(hdev, hbus);
 
@@ -2536,6 +2531,8 @@ free_config:
 	hv_free_config_window(hbus);
 close:
 	vmbus_close(hdev->channel);
+destroy_wq:
+	destroy_workqueue(hbus->wq);
 free_bus:
 	free_page((unsigned long)hbus);
 	return ret;
@@ -2615,6 +2612,7 @@ static int hv_pci_remove(struct hv_devic
 	irq_domain_free_fwnode(hbus->sysdata.fwnode);
 	put_hvpcibus(hbus);
 	wait_for_completion(&hbus->remove_event);
+	destroy_workqueue(hbus->wq);
 	free_page((unsigned long)hbus);
 	return 0;
 }
