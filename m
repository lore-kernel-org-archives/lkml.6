Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752927AbeFDH2s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752626AbeFDHAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:00:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Suhov <v-adsuho@microsoft.com>,
        Chris Valean <v-chvale@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jack Morgenstein <jackm@mellanox.com>
Subject: [PATCH 4.14 11/52] PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()
Date: Mon,  4 Jun 2018 08:58:06 +0200
Message-Id: <20180604065606.984255770@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065606.532044490@linuxfoundation.org>
References: <20180604065606.532044490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit de0aa7b2f97d348ba7d1e17a00744c989baa0cb6 upstream.

1. With the patch "x86/vector/msi: Switch to global reservation mode",
the recent v4.15 and newer kernels always hang for 1-vCPU Hyper-V VM
with SR-IOV. This is because when we reach hv_compose_msi_msg() by
request_irq() -> request_threaded_irq() ->__setup_irq()->irq_startup()
-> __irq_startup() -> irq_domain_activate_irq() -> ... ->
msi_domain_activate() -> ... -> hv_compose_msi_msg(), local irq is
disabled in __setup_irq().

Note: when we reach hv_compose_msi_msg() by another code path:
pci_enable_msix_range() -> ... -> irq_domain_activate_irq() -> ... ->
hv_compose_msi_msg(), local irq is not disabled.

hv_compose_msi_msg() depends on an interrupt from the host.
With interrupts disabled, a UP VM always hangs in the busy loop in
the function, because the interrupt callback hv_pci_onchannelcallback()
can not be called.

We can do nothing but work it around by polling the channel. This
is ugly, but we don't have any other choice.

2. If the host is ejecting the VF device before we reach
hv_compose_msi_msg(), in a UP VM, we can hang in hv_compose_msi_msg()
forever, because at this time the host doesn't respond to the
CREATE_INTERRUPT request. This issue exists the first day the
pci-hyperv driver appears in the kernel.

Luckily, this can also by worked around by polling the channel
for the PCI_EJECT message and hpdev->state, and by checking the
PCI vendor ID.

Note: actually the above 2 issues also happen to a SMP VM, if
"hbus->hdev->channel->target_cpu == smp_processor_id()" is true.

Fixes: 4900be83602b ("x86/vector/msi: Switch to global reservation mode")
Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
Tested-by: Chris Valean <v-chvale@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: <stable@vger.kernel.org>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Jack Morgenstein <jackm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pci-hyperv.c |   58 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -531,6 +531,8 @@ struct hv_pci_compl {
 	s32 completion_status;
 };
 
+static void hv_pci_onchannelcallback(void *context);
+
 /**
  * hv_pci_generic_compl() - Invoked for a completion packet
  * @context:		Set up by the sender of the packet.
@@ -675,6 +677,31 @@ static void _hv_pcifront_read_config(str
 	}
 }
 
+static u16 hv_pcifront_get_vendor_id(struct hv_pci_dev *hpdev)
+{
+	u16 ret;
+	unsigned long flags;
+	void __iomem *addr = hpdev->hbus->cfg_addr + CFG_PAGE_OFFSET +
+			     PCI_VENDOR_ID;
+
+	spin_lock_irqsave(&hpdev->hbus->config_lock, flags);
+
+	/* Choose the function to be read. (See comment above) */
+	writel(hpdev->desc.win_slot.slot, hpdev->hbus->cfg_addr);
+	/* Make sure the function was chosen before we start reading. */
+	mb();
+	/* Read from that function's config space. */
+	ret = readw(addr);
+	/*
+	 * mb() is not required here, because the spin_unlock_irqrestore()
+	 * is a barrier.
+	 */
+
+	spin_unlock_irqrestore(&hpdev->hbus->config_lock, flags);
+
+	return ret;
+}
+
 /**
  * _hv_pcifront_write_config() - Internal PCI config write
  * @hpdev:	The PCI driver's representation of the device
@@ -1121,8 +1148,37 @@ static void hv_compose_msi_msg(struct ir
 	 * Since this function is called with IRQ locks held, can't
 	 * do normal wait for completion; instead poll.
 	 */
-	while (!try_wait_for_completion(&comp.comp_pkt.host_event))
+	while (!try_wait_for_completion(&comp.comp_pkt.host_event)) {
+		/* 0xFFFF means an invalid PCI VENDOR ID. */
+		if (hv_pcifront_get_vendor_id(hpdev) == 0xFFFF) {
+			dev_err_once(&hbus->hdev->device,
+				     "the device has gone\n");
+			goto free_int_desc;
+		}
+
+		/*
+		 * When the higher level interrupt code calls us with
+		 * interrupt disabled, we must poll the channel by calling
+		 * the channel callback directly when channel->target_cpu is
+		 * the current CPU. When the higher level interrupt code
+		 * calls us with interrupt enabled, let's add the
+		 * local_bh_disable()/enable() to avoid race.
+		 */
+		local_bh_disable();
+
+		if (hbus->hdev->channel->target_cpu == smp_processor_id())
+			hv_pci_onchannelcallback(hbus);
+
+		local_bh_enable();
+
+		if (hpdev->state == hv_pcichild_ejecting) {
+			dev_err_once(&hbus->hdev->device,
+				     "the device is being ejected\n");
+			goto free_int_desc;
+		}
+
 		udelay(100);
+	}
 
 	if (comp.comp_pkt.completion_status < 0) {
 		dev_err(&hbus->hdev->device,
