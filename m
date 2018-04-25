Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49CGZxKn+QdOgPm1TgnGVGhZ9Xq4NRmUoeSPV5GlvoxDKKyNeXtFOZwZhljH0dEVuKC1Uf0
ARC-Seal: i=1; a=rsa-sha256; t=1524652720; cv=none;
        d=google.com; s=arc-20160816;
        b=aA4BC6zrCOQudpq1sdUqeKLCGwyzfWqIDUuyY0YHoHkSgAetXi1XhgrQwaOC/nLNSw
         gmm2gmH9bRzXzcfxJaNGZEm/5i4AR+4DLZbA1CKveyUI4XAhJv7ATcmytPWRlsX85BOc
         gmqS1Iy2quHAsgQsJfUTlvPFj68MsAHKwzsMO9tjh3/ShG9BcZ1zVtINE44HR+T350z0
         eAiq89mZJe1Ort+7/iySLrEJPhuSmpUnkjwcvdmblN8sMw+ctlTWa5jvMVks4yAxOhs4
         bFoqHkc0mHkKF3loXMH/Jy4zbWC2j7wLMuPRWNNO75kMINGdAZvh7++Eqsj+LzuDDDDG
         lsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2Z5MpV5u11auBaGapNkGo9Yxw6jbQMB84UkFIyo02Js=;
        b=szOnyIW7aU1CZdg9DVI+A23wfkgwRW0mUYTGaQV/vRM2A1euX+dEWGRdkJWzmvWcz5
         tPRtn38OWME5A28uvsMsEMXnSacu4XHavox1KDEP+e/gc7sUagVY7A9sCzUOdgVkVele
         xqWW3zrMblU2bunjdzJV4Tu4tncMayHLAKLw3JSMfXgjPF4a21J4EN3pJMlv1B4dPnpi
         nDV+NBC3ham+ViPA3sJuQXJuDH3Es8X3Ih1SIo/vXf3r4A3i1/MfU5QHtcRCIGrrnYFf
         hgMiCg3SQLkm+sMTs0l6UvbV8V6xFL6lIJwqFXW6Pnd51uWgkkOXCCOBldxBefghLWbY
         8uHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 045/183] iommu/vt-d: Use domain instead of cache fetching
Date: Wed, 25 Apr 2018 12:34:25 +0200
Message-Id: <20180425103244.376884547@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714250693784474?=
X-GMAIL-MSGID: =?utf-8?q?1598714250693784474?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Xu <peterx@redhat.com>


[ Upstream commit 9d2e6505f6d6934e681aed502f566198cb25c74a ]

after commit a1ddcbe93010 ("iommu/vt-d: Pass dmar_domain directly into
iommu_flush_iotlb_psi", 2015-08-12), we have domain pointer as parameter
to iommu_flush_iotlb_psi(), so no need to fetch it from cache again.

More importantly, a NULL reference pointer bug is reported on RHEL7 (and
it can be reproduced on some old upstream kernels too, e.g., v4.13) by
unplugging an 40g nic from a VM (hard to test unplug on real host, but
it should be the same):

https://bugzilla.redhat.com/show_bug.cgi?id=1531367

[   24.391863] pciehp 0000:00:03.0:pcie004: Slot(0): Attention button pressed
[   24.393442] pciehp 0000:00:03.0:pcie004: Slot(0): Powering off due to button press
[   29.721068] i40evf 0000:01:00.0: Unable to send opcode 2 to PF, err I40E_ERR_QUEUE_EMPTY, aq_err OK
[   29.783557] iommu: Removing device 0000:01:00.0 from group 3
[   29.784662] BUG: unable to handle kernel NULL pointer dereference at 0000000000000304
[   29.785817] IP: iommu_flush_iotlb_psi+0xcf/0x120
[   29.786486] PGD 0
[   29.786487] P4D 0
[   29.786812]
[   29.787390] Oops: 0000 [#1] SMP
[   29.787876] Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_ng
[   29.795371] CPU: 0 PID: 156 Comm: kworker/0:2 Not tainted 4.13.0 #14
[   29.796366] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-1.el7 04/01/2014
[   29.797593] Workqueue: pciehp-0 pciehp_power_thread
[   29.798328] task: ffff94f5745b4a00 task.stack: ffffb326805ac000
[   29.799178] RIP: 0010:iommu_flush_iotlb_psi+0xcf/0x120
[   29.799919] RSP: 0018:ffffb326805afbd0 EFLAGS: 00010086
[   29.800666] RAX: ffff94f5bc56e800 RBX: 0000000000000000 RCX: 0000000200000025
[   29.801667] RDX: ffff94f5bc56e000 RSI: 0000000000000082 RDI: 0000000000000000
[   29.802755] RBP: ffffb326805afbf8 R08: 0000000000000000 R09: ffff94f5bc86bbf0
[   29.803772] R10: ffffb326805afba8 R11: 00000000000ffdc4 R12: ffff94f5bc86a400
[   29.804789] R13: 0000000000000000 R14: 00000000ffdc4000 R15: 0000000000000000
[   29.805792] FS:  0000000000000000(0000) GS:ffff94f5bfc00000(0000) knlGS:0000000000000000
[   29.806923] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.807736] CR2: 0000000000000304 CR3: 000000003499d000 CR4: 00000000000006f0
[   29.808747] Call Trace:
[   29.809156]  flush_unmaps_timeout+0x126/0x1c0
[   29.809800]  domain_exit+0xd6/0x100
[   29.810322]  device_notifier+0x6b/0x70
[   29.810902]  notifier_call_chain+0x4a/0x70
[   29.812822]  __blocking_notifier_call_chain+0x47/0x60
[   29.814499]  blocking_notifier_call_chain+0x16/0x20
[   29.816137]  device_del+0x233/0x320
[   29.817588]  pci_remove_bus_device+0x6f/0x110
[   29.819133]  pci_stop_and_remove_bus_device+0x1a/0x20
[   29.820817]  pciehp_unconfigure_device+0x7a/0x1d0
[   29.822434]  pciehp_disable_slot+0x52/0xe0
[   29.823931]  pciehp_power_thread+0x8a/0xa0
[   29.825411]  process_one_work+0x18c/0x3a0
[   29.826875]  worker_thread+0x4e/0x3b0
[   29.828263]  kthread+0x109/0x140
[   29.829564]  ? process_one_work+0x3a0/0x3a0
[   29.831081]  ? kthread_park+0x60/0x60
[   29.832464]  ret_from_fork+0x25/0x30
[   29.833794] Code: 85 ed 74 0b 5b 41 5c 41 5d 41 5e 41 5f 5d c3 49 8b 54 24 60 44 89 f8 0f b6 c4 48 8b 04 c2 48 85 c0 74 49 45 0f b6 ff 4a 8b 3c f8 <80> bf
[   29.838514] RIP: iommu_flush_iotlb_psi+0xcf/0x120 RSP: ffffb326805afbd0
[   29.840362] CR2: 0000000000000304
[   29.841716] ---[ end trace b10ec0d6900868d3 ]---

This patch fixes that problem if applied to v4.13 kernel.

The bug does not exist on latest upstream kernel since it's fixed as a
side effect of commit 13cf01744608 ("iommu/vt-d: Make use of iova
deferred flushing", 2017-08-15).  But IMHO it's still good to have this
patch upstream.

CC: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Fixes: a1ddcbe93010 ("iommu/vt-d: Pass dmar_domain directly into iommu_flush_iotlb_psi")
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/intel-iommu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1603,8 +1603,7 @@ static void iommu_flush_iotlb_psi(struct
 	 * flush. However, device IOTLB doesn't need to be flushed in this case.
 	 */
 	if (!cap_caching_mode(iommu->cap) || !map)
-		iommu_flush_dev_iotlb(get_iommu_domain(iommu, did),
-				      addr, mask);
+		iommu_flush_dev_iotlb(domain, addr, mask);
 }
 
 static void iommu_flush_iova(struct iova_domain *iovad)
