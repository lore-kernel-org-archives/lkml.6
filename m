Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Vi4cznn/XuYxuS3Z576extvv/Xs2fzvs6Mh7fiG2OYX6wgJz418dvcUPWgabxcAQFTEEe
ARC-Seal: i=1; a=rsa-sha256; t=1523980831; cv=none;
        d=google.com; s=arc-20160816;
        b=d98ZprIsD+yntOMchGCFdVN5fTq2tt7IjbtNjYzYFT+y/QgpY1PRwT0ZQRaBhAufqA
         tM+N3Pc9tkldLqK8HnOY0Re7oKw9HrSD5pB1Yn4mVV0vt+3Xj2G+MfaWyEPgS8NLRvLw
         1+BJ/ph8ZfhJa6i3fF55MZpkFVNgFSu5P9gbN6nAl1CUwAasZOf4+C8zM/aLpWO7UG0F
         AImSXd69wJN4QuL7QH02DqT3hLUNZvEbH7EybTutjiTtzqIJEziDGqT/GtrtavEw/6Yd
         oIe6vM9HgBe48GGr7uFysftzgHQWR6BEz/7tJKVcWNCu8kQT+FgsxlIscNQkgAuQGFMa
         iJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wg/XItSVVQgnaS3l5wjf79H5qXR/1/veE7vTIGsOp0I=;
        b=TWeKdiRMInfxAIzuV9X0modJsTVaTDIn+EPlDl8E2YvOVALyaqOukTwEJgoZ5Nqfiv
         Vp6iawYJiOb5JpIIAqefQOoR0IWOgG9umwoQFX7PgwJmT083/ZXRnos6g98prL7Gudkp
         f5huGXJ+htsV5x3vUgZJFfCBS+QVCTXK+bCID9Ov9vM0Ct6lf6li8laH8BT6cyJ0Nzj7
         xO69p1DeaEcjqS48s3ddOnUO/fkdWXlLAYrlvBtPjRquK6h1F5kAHFlg3/SSLthV/O9r
         BYL5Ig633EsQS8zFUergeCUdqWdmyGVkBOZJ2nzteNxbtHx7TdLfHyNe4XzHEmLUGS/h
         a9WA==
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
	Stephen Hemminger <sthemmin@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Jack Morgenstein <jackm@mellanox.com>
Subject: [PATCH 4.16 20/68] PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()
Date: Tue, 17 Apr 2018 17:57:33 +0200
Message-Id: <20180417155750.160812585@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009724979136034?=
X-GMAIL-MSGID: =?utf-8?q?1598009724979136034?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -521,6 +521,8 @@ struct hv_pci_compl {
 	s32 completion_status;
 };
 
+static void hv_pci_onchannelcallback(void *context);
+
 /**
  * hv_pci_generic_compl() - Invoked for a completion packet
  * @context:		Set up by the sender of the packet.
@@ -665,6 +667,31 @@ static void _hv_pcifront_read_config(str
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
@@ -1107,8 +1134,37 @@ static void hv_compose_msi_msg(struct ir
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
