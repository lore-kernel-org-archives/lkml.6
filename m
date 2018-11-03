Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697C5C65C22
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E272081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E272081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeKCJ2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 05:28:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeKCJ2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 05:28:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA51158E42;
        Sat,  3 Nov 2018 00:19:19 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB4785D9CD;
        Sat,  3 Nov 2018 00:19:18 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] drm/i915: Fix NULL deref when re-enabling HPD IRQs on systems with MST
Date:   Fri,  2 Nov 2018 20:19:05 -0400
Message-Id: <20181103001909.23645-3-lyude@redhat.com>
In-Reply-To: <20181103001909.23645-1-lyude@redhat.com>
References: <20181103001909.23645-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 03 Nov 2018 00:19:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out that if you trigger an HPD storm on a system that has an MST
topology connected to it, you'll end up causing the kernel to eventually
hit a NULL deref:

[  332.339041] BUG: unable to handle kernel NULL pointer dereference at 00000000000000ec
[  332.340906] PGD 0 P4D 0
[  332.342750] Oops: 0000 [#1] SMP PTI
[  332.344579] CPU: 2 PID: 25 Comm: kworker/2:0 Kdump: loaded Tainted: G           O      4.18.0-rc3short-hpd-storm+ #2
[  332.346453] Hardware name: LENOVO 20BWS1KY00/20BWS1KY00, BIOS JBET71WW (1.35 ) 09/14/2018
[  332.348361] Workqueue: events intel_hpd_irq_storm_reenable_work [i915]
[  332.350301] RIP: 0010:intel_hpd_irq_storm_reenable_work.cold.3+0x2f/0x86 [i915]
[  332.352213] Code: 00 00 ba e8 00 00 00 48 c7 c6 c0 aa 5f a0 48 c7 c7 d0 73 62 a0 4c 89 c1 4c 89 04 24 e8 7f f5 af e0 4c 8b 04 24 44 89 f8 29 e8 <41> 39 80 ec 00 00 00 0f 85 43 13 fc ff 41 0f b6 86 b8 04 00 00 41
[  332.354286] RSP: 0018:ffffc90000147e48 EFLAGS: 00010006
[  332.356344] RAX: 0000000000000005 RBX: ffff8802c226c9d4 RCX: 0000000000000006
[  332.358404] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff88032dc95570
[  332.360466] RBP: 0000000000000005 R08: 0000000000000000 R09: ffff88031b3dc840
[  332.362528] R10: 0000000000000000 R11: 000000031a069602 R12: ffff8802c226ca20
[  332.364575] R13: ffff8802c2268000 R14: ffff880310661000 R15: 000000000000000a
[  332.366615] FS:  0000000000000000(0000) GS:ffff88032dc80000(0000) knlGS:0000000000000000
[  332.368658] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  332.370690] CR2: 00000000000000ec CR3: 000000000200a003 CR4: 00000000003606e0
[  332.372724] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  332.374773] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  332.376798] Call Trace:
[  332.378809]  process_one_work+0x1a1/0x350
[  332.380806]  worker_thread+0x30/0x380
[  332.382777]  ? wq_update_unbound_numa+0x10/0x10
[  332.384772]  kthread+0x112/0x130
[  332.386740]  ? kthread_create_worker_on_cpu+0x70/0x70
[  332.388706]  ret_from_fork+0x35/0x40
[  332.390651] Modules linked in: i915(O) vfat fat joydev btusb btrtl btbcm btintel bluetooth ecdh_generic iTCO_wdt wmi_bmof i2c_algo_bit drm_kms_helper intel_rapl syscopyarea sysfillrect x86_pkg_temp_thermal sysimgblt coretemp fb_sys_fops crc32_pclmul drm psmouse pcspkr mei_me mei i2c_i801 lpc_ich mfd_core i2c_core tpm_tis tpm_tis_core thinkpad_acpi wmi tpm rfkill video crc32c_intel serio_raw ehci_pci xhci_pci ehci_hcd xhci_hcd [last unloaded: i915]
[  332.394963] CR2: 00000000000000ec

This appears to be due to the fact that with an MST topology, not all
intel_connector structs will have ->encoder set. So, fix this by
skipping connectors without encoders in
intel_hpd_irq_storm_reenable_work().

For those wondering, this bug was found on accident while simulating HPD
storms using a Chamelium connected to a ThinkPad T450s (Broadwell).

Changes since v1:
- Check intel_connector->mst_port instead of intel_connector->encoder

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/intel_hotplug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_hotplug.c b/drivers/gpu/drm/i915/intel_hotplug.c
index 648a13c6043c..8326900a311e 100644
--- a/drivers/gpu/drm/i915/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/intel_hotplug.c
@@ -228,7 +228,9 @@ static void intel_hpd_irq_storm_reenable_work(struct work_struct *work)
 		drm_for_each_connector_iter(connector, &conn_iter) {
 			struct intel_connector *intel_connector = to_intel_connector(connector);
 
-			if (intel_connector->encoder->hpd_pin == pin) {
+			/* Don't check MST ports, they don't have pins */
+			if (!intel_connector->mst_port &&
+			    intel_connector->encoder->hpd_pin == pin) {
 				if (connector->polled != intel_connector->polled)
 					DRM_DEBUG_DRIVER("Reenabling HPD on connector %s\n",
 							 connector->name);
-- 
2.19.1

