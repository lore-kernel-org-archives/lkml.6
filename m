Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02473C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA41A2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA41A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeKCFuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:50:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:19509 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbeKCFuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:50:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 13:41:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,457,1534834800"; 
   d="scan'208";a="93295567"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 02 Nov 2018 13:41:23 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 02 Nov 2018 22:41:22 +0200
Date:   Fri, 2 Nov 2018 22:41:22 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drm/i915: Fix NULL deref when re-enabling HPD
 IRQs on systems with MST
Message-ID: <20181102204122.GG9144@intel.com>
References: <20181026224910.10138-1-lyude@redhat.com>
 <20181026224910.10138-3-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181026224910.10138-3-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 06:49:08PM -0400, Lyude Paul wrote:
> Turns out that if you trigger an HPD storm on a system that has an MST
> topology connected to it, you'll end up causing the kernel to eventually
> hit a NULL deref:
> 
> [  332.339041] BUG: unable to handle kernel NULL pointer dereference at 00000000000000ec
> [  332.340906] PGD 0 P4D 0
> [  332.342750] Oops: 0000 [#1] SMP PTI
> [  332.344579] CPU: 2 PID: 25 Comm: kworker/2:0 Kdump: loaded Tainted: G           O      4.18.0-rc3short-hpd-storm+ #2
> [  332.346453] Hardware name: LENOVO 20BWS1KY00/20BWS1KY00, BIOS JBET71WW (1.35 ) 09/14/2018
> [  332.348361] Workqueue: events intel_hpd_irq_storm_reenable_work [i915]
> [  332.350301] RIP: 0010:intel_hpd_irq_storm_reenable_work.cold.3+0x2f/0x86 [i915]
> [  332.352213] Code: 00 00 ba e8 00 00 00 48 c7 c6 c0 aa 5f a0 48 c7 c7 d0 73 62 a0 4c 89 c1 4c 89 04 24 e8 7f f5 af e0 4c 8b 04 24 44 89 f8 29 e8 <41> 39 80 ec 00 00 00 0f 85 43 13 fc ff 41 0f b6 86 b8 04 00 00 41
> [  332.354286] RSP: 0018:ffffc90000147e48 EFLAGS: 00010006
> [  332.356344] RAX: 0000000000000005 RBX: ffff8802c226c9d4 RCX: 0000000000000006
> [  332.358404] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff88032dc95570
> [  332.360466] RBP: 0000000000000005 R08: 0000000000000000 R09: ffff88031b3dc840
> [  332.362528] R10: 0000000000000000 R11: 000000031a069602 R12: ffff8802c226ca20
> [  332.364575] R13: ffff8802c2268000 R14: ffff880310661000 R15: 000000000000000a
> [  332.366615] FS:  0000000000000000(0000) GS:ffff88032dc80000(0000) knlGS:0000000000000000
> [  332.368658] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  332.370690] CR2: 00000000000000ec CR3: 000000000200a003 CR4: 00000000003606e0
> [  332.372724] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  332.374773] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  332.376798] Call Trace:
> [  332.378809]  process_one_work+0x1a1/0x350
> [  332.380806]  worker_thread+0x30/0x380
> [  332.382777]  ? wq_update_unbound_numa+0x10/0x10
> [  332.384772]  kthread+0x112/0x130
> [  332.386740]  ? kthread_create_worker_on_cpu+0x70/0x70
> [  332.388706]  ret_from_fork+0x35/0x40
> [  332.390651] Modules linked in: i915(O) vfat fat joydev btusb btrtl btbcm btintel bluetooth ecdh_generic iTCO_wdt wmi_bmof i2c_algo_bit drm_kms_helper intel_rapl syscopyarea sysfillrect x86_pkg_temp_thermal sysimgblt coretemp fb_sys_fops crc32_pclmul drm psmouse pcspkr mei_me mei i2c_i801 lpc_ich mfd_core i2c_core tpm_tis tpm_tis_core thinkpad_acpi wmi tpm rfkill video crc32c_intel serio_raw ehci_pci xhci_pci ehci_hcd xhci_hcd [last unloaded: i915]
> [  332.394963] CR2: 00000000000000ec
> 
> This appears to be due to the fact that with an MST topology, not all
> intel_connector structs will have ->encoder set. So, fix this by
> skipping connectors without encoders in
> intel_hpd_irq_storm_reenable_work().
> 
> For those wondering, this bug was found on accident while simulating HPD
> storms using a Chamelium connected to a ThinkPad T450s (Broadwell).
> 
> Changes since v1:
> - Check intel_connector->mst_port instead of intel_connector->encoder
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>

1 and 2 are
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
>  drivers/gpu/drm/i915/intel_hotplug.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_hotplug.c b/drivers/gpu/drm/i915/intel_hotplug.c
> index 648a13c6043c..8326900a311e 100644
> --- a/drivers/gpu/drm/i915/intel_hotplug.c
> +++ b/drivers/gpu/drm/i915/intel_hotplug.c
> @@ -228,7 +228,9 @@ static void intel_hpd_irq_storm_reenable_work(struct work_struct *work)
>  		drm_for_each_connector_iter(connector, &conn_iter) {
>  			struct intel_connector *intel_connector = to_intel_connector(connector);
>  
> -			if (intel_connector->encoder->hpd_pin == pin) {
> +			/* Don't check MST ports, they don't have pins */
> +			if (!intel_connector->mst_port &&
> +			    intel_connector->encoder->hpd_pin == pin) {
>  				if (connector->polled != intel_connector->polled)
>  					DRM_DEBUG_DRIVER("Reenabling HPD on connector %s\n",
>  							 connector->name);
> -- 
> 2.17.2

-- 
Ville Syrjälä
Intel
