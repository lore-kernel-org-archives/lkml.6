Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8296CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4473F2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4473F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeK0N50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:57:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbeK0N50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:57:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0268889ADC;
        Tue, 27 Nov 2018 03:01:05 +0000 (UTC)
Received: from redhat.com (ovpn-121-87.rdu2.redhat.com [10.10.121.87])
        by smtp.corp.redhat.com (Postfix) with SMTP id 73846608DA;
        Tue, 27 Nov 2018 03:01:03 +0000 (UTC)
Date:   Mon, 26 Nov 2018 22:01:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: DMA-API: exceeded 7 overlapping mappings of cacheline
Message-ID: <20181126213232-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 27 Nov 2018 03:01:05 +0000 (UTC)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so I enabled CONFIG_DMA_API_DEBUG: and now I get:

[  178.789451] ------------[ cut here ]------------
[  178.789558] DMA-API: exceeded 7 overlapping mappings of cacheline 0x000000001a161a80
[  178.789578] WARNING: CPU: 7 PID: 1223 at kernel/dma/debug.c:523 add_dma_entry+0x1f6/0x200
[  178.789580] Modules linked in: kvm_intel nouveau kvm iwlmvm iwlwifi
[  178.789592] CPU: 7 PID: 1223 Comm: Xorg Tainted: G        W         4.20.0-rc3-guest-debug+ #183
[  178.789595] Hardware name: LENOVO 20MDCTO1WW/20MDCTO1WW, BIOS N2EET31W (1.13 ) 10/19/2018
[  178.789599] RIP: 0010:add_dma_entry+0x1f6/0x200
[  178.789603] Code: eb 9e 7e ed 80 3d 17 17 18 03 00 75 e4 48 8d 54 24 28 be 07 00 00 00 48 c7 c7 40 38 e9 82 c6 05 fd 16 18 03 01 e8 74 87 f2 ff <0f> 0b eb c3 e8 81 83 f2 ff 90 0f 1f 44 00 00 80 3d 31 20 1e 03 00
[  178.789606] RSP: 0018:ffff888733227348 EFLAGS: 00010086
[  178.789609] RAX: 0000000000000000 RBX: 00000000ffffffef RCX: ffffffff8129f98e
[  178.789612] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8888413de840
[  178.789615] RBP: 000000001a161a80 R08: ffffed110827bd09 R09: ffffed110827bd08
[  178.789618] R10: ffffed110827bd08 R11: ffff8888413de847 R12: 0000000000000202
[  178.789621] R13: 1ffff110e6644e6a R14: ffffffff85a9b6c8 R15: ffff88877ca53528
[  178.789624] FS:  00007efd13337ac0(0000) GS:ffff8888413c0000(0000) knlGS:0000000000000000
[  178.789627] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  178.789630] CR2: 00007f6fb654b024 CR3: 000000073bef6003 CR4: 00000000003606e0
[  178.789632] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  178.789635] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  178.789638] Call Trace:
[  178.789646]  ? active_cacheline_set_overlap.part.21+0x50/0x50
[  178.789655]  ? i915_gem_do_execbuffer+0x768/0x1c00
[  178.789665]  debug_dma_map_sg+0xb2/0x450
[  178.789677]  i915_gem_gtt_prepare_pages+0xdf/0x160
[  178.789688]  __i915_gem_userptr_alloc_pages+0x83/0x190
[  178.789696]  i915_gem_userptr_get_pages+0x1e7/0x2d0
[  178.789704]  __i915_gem_object_get_pages+0x71/0x80
[  178.789710]  __i915_vma_do_pin+0x65d/0xa30
[  178.789724]  ? i915_gem_valid_gtt_space+0xd0/0xd0
[  178.789737]  eb_lookup_vmas+0xd2c/0x1570
[  178.789753]  ? eb_relocate_vma+0x2c0/0x2c0
[  178.789759]  ? __i915_gem_object_unset_pages+0x3a0/0x3a0
[  178.789764]  ? _raw_spin_unlock_irqrestore+0x43/0x50
[  178.789771]  ? lockdep_hardirqs_on+0x17a/0x250
[  178.789778]  ? __pm_runtime_resume+0x59/0xb0
[  178.789787]  i915_gem_do_execbuffer+0x768/0x1c00
[  178.789793]  ? __kmalloc_node+0x1b1/0x440
[  178.789797]  ? i915_gem_execbuffer2_ioctl+0x12b/0x550
[  178.789801]  ? drm_ioctl_kernel+0x14a/0x1a0
[  178.789804]  ? drm_ioctl+0x311/0x550
[  178.789815]  ? eb_relocate_slow+0x610/0x610
[  178.789824]  ? i915_gem_execbuffer2_ioctl+0x12b/0x550
[  178.789840]  ? match_held_lock+0x1b/0x230
[  178.789847]  ? find_held_lock+0xac/0xd0
[  178.789856]  ? __might_fault+0x7d/0xe0
[  178.789876]  i915_gem_execbuffer2_ioctl+0x316/0x550
[  178.789887]  ? i915_gem_execbuffer_ioctl+0x4e0/0x4e0
[  178.789900]  ? i915_gem_execbuffer_ioctl+0x4e0/0x4e0
[  178.789904]  drm_ioctl_kernel+0x14a/0x1a0
[  178.789911]  ? drm_setversion+0x330/0x330
[  178.789924]  drm_ioctl+0x311/0x550
[  178.789931]  ? i915_gem_execbuffer_ioctl+0x4e0/0x4e0
[  178.789936]  ? drm_ioctl_kernel+0x1a0/0x1a0
[  178.789942]  ? mark_held_locks+0xb0/0xb0
[  178.789960]  ? __fget+0x208/0x310
[  178.789963]  ? match_held_lock+0x1b/0x230
[  178.789967]  ? __lock_is_held+0x38/0xc0
[  178.789978]  do_vfs_ioctl+0x137/0x9d0
[  178.789985]  ? ioctl_preallocate+0x140/0x140
[  178.789990]  ? selinux_file_ioctl+0x2a2/0x350
[  178.789998]  ? selinux_file_mprotect+0x240/0x240
[  178.790004]  ? __fget+0x208/0x310
[  178.790012]  ? __ia32_sys_dup2+0x200/0x200
[  178.790029]  ksys_ioctl+0x60/0x90
[  178.790032]  ? lockdep_hardirqs_off+0xb5/0x100
[  178.790039]  __x64_sys_ioctl+0x3d/0x50
[  178.790045]  do_syscall_64+0x68/0x210
[  178.790051]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  178.790055] RIP: 0033:0x7efd1385cfeb
[  178.790059] Code: 0f 1e fa 48 8b 05 9d be 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6d be 0c 00 f7 d8 64 89 01 48
[  178.790062] RSP: 002b:00007ffd768ff718 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  178.790066] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007efd1385cfeb
[  178.790068] RDX: 00007ffd768ff750 RSI: 0000000040406469 RDI: 000000000000000d
[  178.790071] RBP: 00005651b6f38500 R08: 0000000000000002 R09: 0000000000000001
[  178.790074] R10: 00007efd051ef000 R11: 0000000000000246 R12: 0000000000001000
[  178.790077] R13: 00007efd10527000 R14: 00007ffd768ff750 R15: 00007efd105274a0
[  178.790108] irq event stamp: 4678142
[  178.790113] hardirqs last  enabled at (4678141): [<ffffffff82899123>] _raw_spin_unlock_irqrestore+0x43/0x50
[  178.790116] hardirqs last disabled at (4678142): [<ffffffff82898ee2>] _raw_spin_lock_irqsave+0x12/0x50
[  178.790120] softirqs last  enabled at (4678074): [<ffffffff81bd84cf>] i915_request_add+0x53f/0x8a0
[  178.790124] softirqs last disabled at (4678068): [<ffffffff81bd840a>] i915_request_add+0x47a/0x8a0
[  178.790126] ---[ end trace 1d0f05369f2675fe ]---


Using a warning here makes all kind of userspace tools jumpy
and IIUC all this is trying to tell us is that there are not
enough bits to track mappings reliably.

This was also reported here:
https://bugs.freedesktop.org/show_bug.cgi?id=100455

So can we convert it to a printk?

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

build tested only

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 231ca4628062..8e34137b2456 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -518,9 +518,11 @@ static void active_cacheline_inc_overlap(phys_addr_t cln)
 	 * debug_dma_assert_idle() as the cacheline may be marked idle
 	 * prematurely.
 	 */
-	WARN_ONCE(overlap > ACTIVE_CACHELINE_MAX_OVERLAP,
-		  "DMA-API: exceeded %d overlapping mappings of cacheline %pa\n",
-		  ACTIVE_CACHELINE_MAX_OVERLAP, &cln);
+	if (overlap > ACTIVE_CACHELINE_MAX_OVERLAP)
+		printk_once(KERN_WARNING
+			    "DMA-API: exceeded %d "
+			    "overlapping mappings of cacheline %pa\n",
+			    ACTIVE_CACHELINE_MAX_OVERLAP, &cln);
 }
 
 static int active_cacheline_dec_overlap(phys_addr_t cln)

-- 
MST
