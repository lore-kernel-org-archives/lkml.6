Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELteqchKfTg3lvo7KIyA4fcW+lX3Iqj27uH4yps9wecNdidieKnN4Tzd3Fj00yLaXjm/qUnG
ARC-Seal: i=1; a=rsa-sha256; t=1521483637; cv=none;
        d=google.com; s=arc-20160816;
        b=p17wJaas9B7B38VwVF4de+NOm1QLilGQE5D1vL6OodkERo9EjFl2HpDOjE0GzvtcEI
         G7xLGly6GI/qmI2EBYatl6vqyIGr5VQbp8lORk8nZpKg+ynlLaY7gVI9ccMBG7/7S//g
         3so8ogDiFX5pfCp1IjJsh2vJXwW0xfzmOYtNJbsE7jwC062e6Q5xjPReCHJgP272rZGy
         zShBckcQgCtrN5odDscBUWUWD6fDniejBNQ66+J9WKtdZ1UxheK2K2zoz6zcKk4tiBCZ
         DMrAQaXbENzvWZGZIgX/b1/ZOBPWf1EBdO/1sTQ5NwkaRkEWz2PbHW/tQilGAooJ4M1d
         IsYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Y+ujeQhtXQY+gGH0MSa3ySzmD6kIRusTrKQKv/UUIRI=;
        b=0PmCsdku1ZEwCJGppUN+sUUXIIBGccj8TQ1sf2YUelNB2/8No0gciY4y0qtXVqzIC8
         dVXdFdVy/S1gQhphC4L/qN/UxFdcf/bsr1x0a97CquMmtVz9fVBp1VEihjJkBsGqDLAK
         trIDZwqCLQ0d/UIkeMAJibKlZ5qSIrq3TpJ/sbxK1mlhmx+3JNo2QN6L8lxeJjz6ty12
         fJN0a2uVc35N07a702dHApXkXsXYofEIDMPyX4bKATIyqhoLW0V85jmlaCMWL87Z5rhW
         /aAAsgX28gUS4CLEg1fy22nFKLfFMiYSAy8ZuVnCiKW/Egpp+v+W5NfDirDwA3LXAH33
         yp4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xiaofeng Wang <xiaofwan@redhat.com>,
	Long Li <longli@microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 060/241] PCI: hv: Properly handle PCI bus remove
Date: Mon, 19 Mar 2018 19:05:25 +0100
Message-Id: <20180319180753.687625995@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391226422279783?=
X-GMAIL-MSGID: =?utf-8?q?1595391226422279783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <longli@microsoft.com>


[ Upstream commit d3a78d8bf759d8848339dcc367c4c1678b57a08b ]

hv_pci_devices_present() is called in hv_pci_remove() when we remove a PCI
device from the host, e.g., by disabling SR-IOV on a device.  In
hv_pci_remove(), the bus is already removed before the call, so we don't
need to rescan the bus in the workqueue scheduled from
hv_pci_devices_present().

By introducing bus state hv_pcibus_removed, we can avoid this situation.

Reported-by: Xiaofeng Wang <xiaofwan@redhat.com>
Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/host/pci-hyperv.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -351,6 +351,7 @@ enum hv_pcibus_state {
 	hv_pcibus_init = 0,
 	hv_pcibus_probed,
 	hv_pcibus_installed,
+	hv_pcibus_removed,
 	hv_pcibus_maximum
 };
 
@@ -1489,13 +1490,24 @@ static void pci_devices_present_work(str
 		put_pcichild(hpdev, hv_pcidev_ref_initial);
 	}
 
-	/* Tell the core to rescan bus because there may have been changes. */
-	if (hbus->state == hv_pcibus_installed) {
+	switch(hbus->state) {
+	case hv_pcibus_installed:
+		/*
+		* Tell the core to rescan bus
+		* because there may have been changes.
+		*/
 		pci_lock_rescan_remove();
 		pci_scan_child_bus(hbus->pci_bus);
 		pci_unlock_rescan_remove();
-	} else {
+		break;
+
+	case hv_pcibus_init:
+	case hv_pcibus_probed:
 		survey_child_resources(hbus);
+		break;
+
+	default:
+		break;
 	}
 
 	up(&hbus->enum_sem);
@@ -2170,6 +2182,7 @@ static int hv_pci_probe(struct hv_device
 	hbus = kzalloc(sizeof(*hbus), GFP_KERNEL);
 	if (!hbus)
 		return -ENOMEM;
+	hbus->state = hv_pcibus_init;
 
 	/*
 	 * The PCI bus "domain" is what is called "segment" in ACPI and
@@ -2312,6 +2325,7 @@ static int hv_pci_remove(struct hv_devic
 		pci_stop_root_bus(hbus->pci_bus);
 		pci_remove_root_bus(hbus->pci_bus);
 		pci_unlock_rescan_remove();
+		hbus->state = hv_pcibus_removed;
 	}
 
 	ret = hv_send_resources_released(hdev);
