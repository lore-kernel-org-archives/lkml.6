Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrJcm/t7gdK7OXh79qURBVKC99Lca7s28/47f+whOFq0dU94Bu6eZaWNRrcyLqRyNSOxtBe
ARC-Seal: i=1; a=rsa-sha256; t=1525116409; cv=none;
        d=google.com; s=arc-20160816;
        b=yeHGBr0p0/6CoG/9Z30H1B3n25dfKz+4F2gQQ09G6mt4bYgQzh6te+9Sz2WpDj9bkz
         aHUw40FN7EtnBgOMWEGOyQi2sQO6eI3zxSTSN9XQT9ZEDut3YQBD7xdPhWtQeFgcJE6f
         1WtbW6f4O+sZq0HfixZQUfHXxoKSt9S64+cgR6XgT9PJJnTrrvO2Y6EmEUgLAmOSENRE
         txlUVqu6ZU66mZr2n29BZsTIZBAEQi7k8HUwKICUdtrvLQLyepKeKEa6vQkzoRQMjdqO
         Xrw/l1tIliVVFQFd+Rf/QTex0HormE9WpFnZZCEQLWX0NI6dSCzwWNCypQnaJHxJ/BXd
         978w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=TYhgyNM6WKlEzDIxAfqO1sQQ8JWaqc3nLzzNOq7cwjo=;
        b=dR6vvhRIMGNQFDt/u8bd/lcnNTWgyjJNM9yruCoTeWSryKfHjKV6MQARE2akaTJ3sp
         GqsKC6ZJR7oaTVXqI01w37YsMPVhFtGbItpxpHMVtH9bHJMxhuhc3z2p6nY4O/lum/i/
         h48Q/WYT2IrUY7/WbOaxAPgOJ2HGOYR4kSOFK6SG5RIQ26EN04ApF+Q3UahXEECaJwI7
         E3Osjizz4PckPUTm5YDwBzqwvN+OvkUSrV5X3qGfnNcS2vUJCAOcU0p5/fwCe4k+pv9W
         YJ/OVSazUufTKM297QTss6kjasbaLKflK2y5oqqgjVDEcKXdx+koe8bZfK1FVOc1/no7
         ecmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9455E22DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 61/61] powerpc/eeh: Fix race with driver un/bind
Date: Mon, 30 Apr 2018 12:25:04 -0700
Message-Id: <20180430183956.399511929@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200523727871188?=
X-GMAIL-MSGID: =?utf-8?q?1599200463545761916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Neuling <mikey@neuling.org>

commit f0295e047fcf52ccb42561fb7de6942f5201b676 upstream.

The current EEH callbacks can race with a driver unbind. This can
result in a backtraces like this:

  EEH: Frozen PHB#0-PE#1fc detected
  EEH: PE location: S000009, PHB location: N/A
  CPU: 2 PID: 2312 Comm: kworker/u258:3 Not tainted 4.15.6-openpower1 #2
  Workqueue: nvme-wq nvme_reset_work [nvme]
  Call Trace:
    dump_stack+0x9c/0xd0 (unreliable)
    eeh_dev_check_failure+0x420/0x470
    eeh_check_failure+0xa0/0xa4
    nvme_reset_work+0x138/0x1414 [nvme]
    process_one_work+0x1ec/0x328
    worker_thread+0x2e4/0x3a8
    kthread+0x14c/0x154
    ret_from_kernel_thread+0x5c/0xc8
  nvme nvme1: Removing after probe failure status: -19
  <snip>
  cpu 0x23: Vector: 300 (Data Access) at [c000000ff50f3800]
      pc: c0080000089a0eb0: nvme_error_detected+0x4c/0x90 [nvme]
      lr: c000000000026564: eeh_report_error+0xe0/0x110
      sp: c000000ff50f3a80
     msr: 9000000000009033
     dar: 400
   dsisr: 40000000
    current = 0xc000000ff507c000
    paca    = 0xc00000000fdc9d80   softe: 0        irq_happened: 0x01
      pid   = 782, comm = eehd
  Linux version 4.15.6-openpower1 (smc@smc-desktop) (gcc version 6.4.0 (Buildroot 2017.11.2-00008-g4b6188e)) #2 SM                                             P Tue Feb 27 12:33:27 PST 2018
  enter ? for help
    eeh_report_error+0xe0/0x110
    eeh_pe_dev_traverse+0xc0/0xdc
    eeh_handle_normal_event+0x184/0x4c4
    eeh_handle_event+0x30/0x288
    eeh_event_handler+0x124/0x170
    kthread+0x14c/0x154
    ret_from_kernel_thread+0x5c/0xc8

The first part is an EEH (on boot), the second half is the resulting
crash. nvme probe starts the nvme_reset_work() worker thread. This
worker thread starts touching the device which see a device error
(EEH) and hence queues up an event in the powerpc EEH worker
thread. nvme_reset_work() then continues and runs
nvme_remove_dead_ctrl_work() which results in unbinding the driver
from the device and hence releases all resources. At the same time,
the EEH worker thread starts doing the EEH .error_detected() driver
callback, which no longer works since the resources have been freed.

This fixes the problem in the same way the generic PCIe AER code (in
drivers/pci/pcie/aer/aerdrv_core.c) does. It makes the EEH code hold
the device_lock() while performing the driver EEH callbacks and
associated code. This ensures either the callbacks are no longer
register, or if they are registered the driver will not be removed
from underneath us.

This has been broken forever. The EEH call backs were first introduced
in 2005 (in 77bd7415610) but it's not clear if a lock was needed back
then.

Fixes: 77bd74156101 ("[PATCH] powerpc: PCI Error Recovery: PPC64 core recovery routines")
Cc: stable@vger.kernel.org # v2.6.16+
Signed-off-by: Michael Neuling <mikey@neuling.org>
Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/eeh_driver.c |   61 ++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 23 deletions(-)

--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -207,18 +207,18 @@ static void *eeh_report_error(void *data
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_frozen;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
 
 	eeh_disable_irq(dev);
 
 	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    !driver->err_handler->error_detected)
+		goto out;
 
 	rc = driver->err_handler->error_detected(dev, pci_channel_io_frozen);
 
@@ -227,7 +227,10 @@ static void *eeh_report_error(void *data
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
 
 	edev->in_error = true;
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -250,15 +253,14 @@ static void *eeh_report_mmio_enabled(voi
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
 
+	device_lock(&dev->dev);
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->mmio_enabled ||
-	    (edev->mode & EEH_DEV_NO_HANDLER)) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    (edev->mode & EEH_DEV_NO_HANDLER))
+		goto out;
 
 	rc = driver->err_handler->mmio_enabled(dev);
 
@@ -266,7 +268,10 @@ static void *eeh_report_mmio_enabled(voi
 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
 
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -289,20 +294,20 @@ static void *eeh_report_reset(void *data
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_normal;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
 
 	eeh_enable_irq(dev);
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->slot_reset ||
 	    (edev->mode & EEH_DEV_NO_HANDLER) ||
-	    (!edev->in_error)) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    (!edev->in_error))
+		goto out;
 
 	rc = driver->err_handler->slot_reset(dev);
 	if ((*res == PCI_ERS_RESULT_NONE) ||
@@ -310,7 +315,10 @@ static void *eeh_report_reset(void *data
 	if (*res == PCI_ERS_RESULT_DISCONNECT &&
 	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -361,10 +369,12 @@ static void *eeh_report_resume(void *dat
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_normal;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
 
 	was_in_error = edev->in_error;
 	edev->in_error = false;
@@ -374,13 +384,15 @@ static void *eeh_report_resume(void *dat
 	    !driver->err_handler->resume ||
 	    (edev->mode & EEH_DEV_NO_HANDLER) || !was_in_error) {
 		edev->mode &= ~EEH_DEV_NO_HANDLER;
-		eeh_pcid_put(dev);
-		return NULL;
+		goto out;
 	}
 
 	driver->err_handler->resume(dev);
 
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -400,22 +412,25 @@ static void *eeh_report_failure(void *da
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_perm_failure;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
 
 	eeh_disable_irq(dev);
 
 	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    !driver->err_handler->error_detected)
+		goto out;
 
 	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
 
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
