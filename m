Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49kflL3+H33t2tnhIHGc5z4z8QX9QsBYtfL8iQ0JHPYEFNc/GJLgl7/z85NELmcl3gBX0ru
ARC-Seal: i=1; a=rsa-sha256; t=1523981018; cv=none;
        d=google.com; s=arc-20160816;
        b=XVZ9rTAjdyZrJRWcPOyl4ZmL74W1v1hYlQWRgKdsZ65Y0tPKKnFw5K3KPC/Fqg1Cva
         OLnaFMJOIwHNYtcyN16j49rXK0E0/Fu0Fd4ErqtDmwmyomaAVTEbd03pBp3wOBy9sq3B
         n5AL5jXNPVwL4WUZajKiEJcS+C9OZ3uOzWX/WKyyRq02/KAxFkrd57wm+XQsk7HiNCwc
         /qj36rHX0lxhbpzc6E7rsOCV+wwhiN/nqANXnvD4BALzNvcTFdZGDaTpgwozcQTN31v+
         LAciS4eZ4pJf8mVbOHnmLISSDb6g2BE10yHUY/RBWO4hJeQC3BiTEUBaGRTcn5hEtTN4
         1vRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ohtb1tpSyfEEOoJuZDKhhu0SkhV0SNnucB6MeUV44iA=;
        b=WuKfb6iKkP8ET0EbYwZCFaTG3vOpRgz8J1DM9xdbKUQciZ8QSJmcLonc72t6I8DOb+
         QSBeHK0nzDv6MVpDET0nsXU4cU83ceTvoowdxwYvY+lgEyGz7eJHIgcgTAiFq6bU6Ej2
         Q12NmusYiJzaXZuwyg4g1q/xDoWUwNu8jMv0izLG7b8v/v70VJN24Mww+M1oTr+bW4ok
         aX8RpBwhMNrohwm4pAzZLKr+F4FfsdAi4D5RexkPINeqwv31hyhMegJKCwKm3wvpUnhZ
         8bSXBn77+NqP3NGK8J4n2duG6lxIMUPg4+NVGRp2hfnkHDbqMcsdQLto4AL2Uq1/Iq2H
         Wi/Q==
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
Subject: [PATCH 4.15 18/53] PCI: hv: Serialize the present and eject work items
Date: Tue, 17 Apr 2018 17:58:43 +0200
Message-Id: <20180417155723.991592752@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009719249133231?=
X-GMAIL-MSGID: =?utf-8?q?1598009920137727482?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -457,7 +457,6 @@ struct hv_pcibus_device {
 	spinlock_t device_list_lock;	/* Protect lists below */
 	void __iomem *cfg_addr;
 
-	struct semaphore enum_sem;
 	struct list_head resources_for_children;
 
 	struct list_head children;
@@ -471,6 +470,8 @@ struct hv_pcibus_device {
 	struct retarget_msi_interrupt retarget_msi_interrupt_params;
 
 	spinlock_t retarget_msi_interrupt_lock;
+
+	struct workqueue_struct *wq;
 };
 
 /*
@@ -1600,12 +1601,8 @@ static struct hv_pci_dev *get_pcichild_w
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
@@ -1626,11 +1623,6 @@ static void pci_devices_present_work(str
 
 	INIT_LIST_HEAD(&removed);
 
-	if (down_interruptible(&hbus->enum_sem)) {
-		put_hvpcibus(hbus);
-		return;
-	}
-
 	/* Pull this off the queue and process it if it was the last one. */
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
 	while (!list_empty(&hbus->dr_list)) {
@@ -1647,7 +1639,6 @@ static void pci_devices_present_work(str
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 
 	if (!dr) {
-		up(&hbus->enum_sem);
 		put_hvpcibus(hbus);
 		return;
 	}
@@ -1734,7 +1725,6 @@ static void pci_devices_present_work(str
 		break;
 	}
 
-	up(&hbus->enum_sem);
 	put_hvpcibus(hbus);
 	kfree(dr);
 }
@@ -1780,7 +1770,7 @@ static void hv_pci_devices_present(struc
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 
 	get_hvpcibus(hbus);
-	schedule_work(&dr_wrk->wrk);
+	queue_work(hbus->wq, &dr_wrk->wrk);
 }
 
 /**
@@ -1858,7 +1848,7 @@ static void hv_pci_eject_device(struct h
 	get_pcichild(hpdev, hv_pcidev_ref_pnp);
 	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
 	get_hvpcibus(hpdev->hbus);
-	schedule_work(&hpdev->wrk);
+	queue_work(hpdev->hbus->wq, &hpdev->wrk);
 }
 
 /**
@@ -2471,13 +2461,18 @@ static int hv_pci_probe(struct hv_device
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
 
@@ -2546,6 +2541,8 @@ free_config:
 	hv_free_config_window(hbus);
 close:
 	vmbus_close(hdev->channel);
+destroy_wq:
+	destroy_workqueue(hbus->wq);
 free_bus:
 	free_page((unsigned long)hbus);
 	return ret;
@@ -2625,6 +2622,7 @@ static int hv_pci_remove(struct hv_devic
 	irq_domain_free_fwnode(hbus->sysdata.fwnode);
 	put_hvpcibus(hbus);
 	wait_for_completion(&hbus->remove_event);
+	destroy_workqueue(hbus->wq);
 	free_page((unsigned long)hbus);
 	return 0;
 }
