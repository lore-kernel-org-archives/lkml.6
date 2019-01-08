Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC6FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D20B20660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546978244;
	bh=JAczUz8CzjTCLIv4ona2lT4ONvcnVK49JaKJ52S+XJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qlz1nctODOljCEiHhE1AHkU4aDju8FwPSVKUx9VTA9WyYFMQWqlpjs+Cg0VLMsFMC
	 6XJlWnS4KyjrYasvw53Q8CGx/JObZznb4IozFc9gAf0OZ/sqbYNffD8/jYT2l4awuj
	 uFuJRszADX1Jy8M9jKbOceiGR7f+WbnjvaHZF6Zo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfAHT0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:26:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbfAHT0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:26:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAFC020883;
        Tue,  8 Jan 2019 19:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975600;
        bh=JAczUz8CzjTCLIv4ona2lT4ONvcnVK49JaKJ52S+XJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxzio3X+N+TMB55nrVmkkJZNJCG8c6QirgwwWE5SWc0fWxH3MMVjQ4KTfM/r7wlHM
         MT5A5AayTWQDRQ+gsXmC1IrcPc2hRaM+3A59niGhtFdiLjyccZwhjkfM0QvTJyzIoX
         PPcJvXz9vdTYVUYLXLP8KTIm53bncxJvPUwnF+1E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 005/117] drm/amdkfd: fix interrupt spin lock
Date:   Tue,  8 Jan 2019 14:24:33 -0500
Message-Id: <20190108192628.121270-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 2383a767c0ca06f96534456d8313909017c6c8d0 ]

Vega10 has multiple interrupt rings, so this can be called from multiple
calles at the same time resulting in:

[   71.779334] ================================
[   71.779406] WARNING: inconsistent lock state
[   71.779478] 4.19.0-rc1+ #44 Tainted: G        W
[   71.779565] --------------------------------
[   71.779637] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[   71.779740] kworker/6:1/120 [HC0[0]:SC0[0]:HE1:SE1] takes:
[   71.779832] 00000000ad761971 (&(&kfd->interrupt_lock)->rlock){?...},
at: kgd2kfd_interrupt+0x75/0x100 [amdgpu]
[   71.780058] {IN-HARDIRQ-W} state was registered at:
[   71.780115]   _raw_spin_lock+0x2c/0x40
[   71.780180]   kgd2kfd_interrupt+0x75/0x100 [amdgpu]
[   71.780248]   amdgpu_irq_callback+0x6c/0x150 [amdgpu]
[   71.780315]   amdgpu_ih_process+0x88/0x100 [amdgpu]
[   71.780380]   amdgpu_irq_handler+0x20/0x40 [amdgpu]
[   71.780409]   __handle_irq_event_percpu+0x49/0x2a0
[   71.780436]   handle_irq_event_percpu+0x30/0x70
[   71.780461]   handle_irq_event+0x37/0x60
[   71.780484]   handle_edge_irq+0x83/0x1b0
[   71.780506]   handle_irq+0x1f/0x30
[   71.780526]   do_IRQ+0x53/0x110
[   71.780544]   ret_from_intr+0x0/0x22
[   71.780566]   cpuidle_enter_state+0xaa/0x330
[   71.780591]   do_idle+0x203/0x280
[   71.780610]   cpu_startup_entry+0x6f/0x80
[   71.780634]   start_secondary+0x1b0/0x200
[   71.780657]   secondary_startup_64+0xa4/0xb0

Fix this by always using irq save spin locks.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index e4ded890b1cb..6edaf11d69aa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -688,6 +688,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 {
 	uint32_t patched_ihre[KFD_MAX_RING_ENTRY_SIZE];
 	bool is_patched = false;
+	unsigned long flags;
 
 	if (!kfd->init_complete)
 		return;
@@ -697,7 +698,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 		return;
 	}
 
-	spin_lock(&kfd->interrupt_lock);
+	spin_lock_irqsave(&kfd->interrupt_lock, flags);
 
 	if (kfd->interrupts_active
 	    && interrupt_is_wanted(kfd, ih_ring_entry,
@@ -706,7 +707,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 				     is_patched ? patched_ihre : ih_ring_entry))
 		queue_work(kfd->ih_wq, &kfd->interrupt_work);
 
-	spin_unlock(&kfd->interrupt_lock);
+	spin_unlock_irqrestore(&kfd->interrupt_lock, flags);
 }
 
 int kgd2kfd_quiesce_mm(struct mm_struct *mm)
-- 
2.19.1

