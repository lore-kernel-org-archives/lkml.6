Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/npQTLY0JB4tX96gj3t4X7i8hqNgfPHAOnRxTEC2baVOjHDPEtGGkmtZWaDIL7Gc8PnKCC
ARC-Seal: i=1; a=rsa-sha256; t=1524652923; cv=none;
        d=google.com; s=arc-20160816;
        b=ZjU/bXhv35EF9BoQQMeZSFhxJ/WU2XKLJXtEg9vCVEGGgV0jKViscZJiA/1F10C0XP
         7ne66zGz/mUHXh5A/rANQ3CKWvAvWSeb+l7zX2M4miRrl+R53TgBOOQLTIPPOMhvlRCi
         i+QkzaxCB3sZMFpDoPskLKCSGEruv19bTjeoDtfQpE/78APpMkiHJ3CI978pkSwqd7qc
         ntCIOfgc/7Nje1nCDdswUjXSgb+Tv5n1Oj/LTdwsUNmR3+k35MUKbw42E9y9I3ZIiygl
         dtnEOhGyAxV5G9ZXLGnaTqssEMiSYJp+dLDdPtxTj/1bxNbTpA9t/swY2fwMknfo4KCD
         po9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5K34STT6EXiI9brp54hwRqAJMviUxo7siHXbnyklxNA=;
        b=MLsQX54/YTnIFbyVeUJNk3SLyYQQ95fb6oZA5WxbsJQw+n9kqEmmHbgUb0KCDcvG76
         PFZrP2I3W1Jgkjqd4ENEDsogrnyhc0qbKnFXM+6jD/dDT0G/ibv6XT48jibOGsHN47Vv
         cXl4QNspPPIEkjACs1NMgCAtvfue6HrYiCQYz+Mlz71phs6w+lK7SW/3LrwteFQWMzBH
         /5S8lYfvmOKWkscjJdI+gwp0qH7zR398bdir/t9ZlGzdjGyqEy89wxz21dXBD9zBwFPV
         YK3b8QzaXpiScSrCSz+2EvU3QeMOnlI09x7/TjBGbeQZCx0QmNdOGqsRHSKSyu+9NaeU
         3LSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alex Estrin <alex.estrin@intel.com>,
	Patel Jay P <jay.p.patel@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 120/183] IB/hfi1: Re-order IRQ cleanup to address driver cleanup race
Date: Wed, 25 Apr 2018 12:35:40 +0200
Message-Id: <20180425103247.253481833@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714464343625852?=
X-GMAIL-MSGID: =?utf-8?q?1598714464343625852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Michael J. Ruhl" <michael.j.ruhl@intel.com>


[ Upstream commit 82a979265638c505e12fbe7ba40980dc0901436d ]

The pci_request_irq() interfaces always adds the IRQF_SHARED bit to
all IRQ requests.

When the kernel is built with CONFIG_DEBUG_SHIRQ config flag, if the
IRQF_SHARED bit is set, a call to the IRQ handler is made from the
__free_irq() function. This is testing a race condition between the
IRQ cleanup and an IRQ racing the cleanup.  The HFI driver should be
able to handle this race, but does not.

This race can cause traces that start with this footprint:

BUG: unable to handle kernel NULL pointer dereference at   (null)
Call Trace:
 <hfi1 irq handler>
 ...
 __free_irq+0x1b3/0x2d0
 free_irq+0x35/0x70
 pci_free_irq+0x1c/0x30
 clean_up_interrupts+0x53/0xf0 [hfi1]
 hfi1_start_cleanup+0x122/0x190 [hfi1]
 postinit_cleanup+0x1d/0x280 [hfi1]
 remove_one+0x233/0x250 [hfi1]
 pci_device_remove+0x39/0xc0

Export IRQ cleanup function so it can be called from other modules.

Using the exported cleanup function:

  Re-order the driver cleanup code to clean up IRQ resources before
  other resources, eliminating the race.

  Re-order error path for init so that the race does not occur.

Reduce severity on spurious error message for SDMA IRQs to info.

Reviewed-by: Alex Estrin <alex.estrin@intel.com>
Reviewed-by: Patel Jay P <jay.p.patel@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hfi1/chip.c |   18 ++++++++++++------
 drivers/infiniband/hw/hfi1/hfi.h  |    1 +
 drivers/infiniband/hw/hfi1/init.c |    4 +++-
 3 files changed, 16 insertions(+), 7 deletions(-)

--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -8294,8 +8294,8 @@ static irqreturn_t sdma_interrupt(int ir
 		/* handle the interrupt(s) */
 		sdma_engine_interrupt(sde, status);
 	} else {
-		dd_dev_err_ratelimited(dd, "SDMA engine %u interrupt, but no status bits set\n",
-				       sde->this_idx);
+		dd_dev_info_ratelimited(dd, "SDMA engine %u interrupt, but no status bits set\n",
+					sde->this_idx);
 	}
 	return IRQ_HANDLED;
 }
@@ -12967,7 +12967,14 @@ static void disable_intx(struct pci_dev
 	pci_intx(pdev, 0);
 }
 
-static void clean_up_interrupts(struct hfi1_devdata *dd)
+/**
+ * hfi1_clean_up_interrupts() - Free all IRQ resources
+ * @dd: valid device data data structure
+ *
+ * Free the MSI or INTx IRQs and assoicated PCI resources,
+ * if they have been allocated.
+ */
+void hfi1_clean_up_interrupts(struct hfi1_devdata *dd)
 {
 	int i;
 
@@ -13344,7 +13351,7 @@ static int set_up_interrupts(struct hfi1
 	return 0;
 
 fail:
-	clean_up_interrupts(dd);
+	hfi1_clean_up_interrupts(dd);
 	return ret;
 }
 
@@ -14770,7 +14777,6 @@ void hfi1_start_cleanup(struct hfi1_devd
 	aspm_exit(dd);
 	free_cntrs(dd);
 	free_rcverr(dd);
-	clean_up_interrupts(dd);
 	finish_chip_resources(dd);
 }
 
@@ -15229,7 +15235,7 @@ bail_free_rcverr:
 bail_free_cntrs:
 	free_cntrs(dd);
 bail_clear_intr:
-	clean_up_interrupts(dd);
+	hfi1_clean_up_interrupts(dd);
 bail_cleanup:
 	hfi1_pcie_ddcleanup(dd);
 bail_free:
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1954,6 +1954,7 @@ void hfi1_verbs_unregister_sysfs(struct
 int qsfp_dump(struct hfi1_pportdata *ppd, char *buf, int len);
 
 int hfi1_pcie_init(struct pci_dev *pdev, const struct pci_device_id *ent);
+void hfi1_clean_up_interrupts(struct hfi1_devdata *dd);
 void hfi1_pcie_cleanup(struct pci_dev *pdev);
 int hfi1_pcie_ddinit(struct hfi1_devdata *dd, struct pci_dev *pdev);
 void hfi1_pcie_ddcleanup(struct hfi1_devdata *);
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1039,8 +1039,9 @@ static void shutdown_device(struct hfi1_
 	}
 	dd->flags &= ~HFI1_INITTED;
 
-	/* mask interrupts, but not errors */
+	/* mask and clean up interrupts, but not errors */
 	set_intr_state(dd, 0);
+	hfi1_clean_up_interrupts(dd);
 
 	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
 		ppd = dd->pport + pidx;
@@ -1696,6 +1697,7 @@ static int init_one(struct pci_dev *pdev
 		dd_dev_err(dd, "Failed to create /dev devices: %d\n", -j);
 
 	if (initfail || ret) {
+		hfi1_clean_up_interrupts(dd);
 		stop_timers(dd);
 		flush_workqueue(ib_wq);
 		for (pidx = 0; pidx < dd->num_pports; ++pidx) {
