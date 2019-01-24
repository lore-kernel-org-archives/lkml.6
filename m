Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BB3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7522F218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358457;
	bh=D//z4tVhfgdXdjwjxI475XGHx06Dyy+IfUr+QbicNyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=io4mTJ2xePFOdwWWJ51Po8Rqka+VJbJjWImz82AdoZmzghi2uFt9FdB8azLZCVVOV
	 WJI0gJCftPZV5I8WiFByRLnyGg1pUXmP/4d3T0Io3+oKmtieX7Ny5nYFbdZpTHuSg/
	 tGWxfMXNCjEDZ3Z0SzyslQf7iztAhMqtqphNlG1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbfAXTeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:34:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732134AbfAXTeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:34:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6608F21903;
        Thu, 24 Jan 2019 19:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358449;
        bh=D//z4tVhfgdXdjwjxI475XGHx06Dyy+IfUr+QbicNyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hksb9c9CBmaMHIefrwtMYO4ibdrymS5DZtBXMU07WCubI0U/qUHjhr3f5weXGVPwa
         qJhduvXzQZ9QpFvF9P2YOzN68x4mvmqKuCVL9iZStpNrBBtW6vzR3xX6LZeP88Chjz
         yZWRVu9sjAy/6XZzngVRbYY66O0V4gzeIzkjSgKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 013/106] drm/amdkfd: fix interrupt spin lock
Date:   Thu, 24 Jan 2019 20:19:30 +0100
Message-Id: <20190124190207.231156986@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 1427675d0e5a..5aba50f63ac6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -661,6 +661,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 {
 	uint32_t patched_ihre[KFD_MAX_RING_ENTRY_SIZE];
 	bool is_patched = false;
+	unsigned long flags;
 
 	if (!kfd->init_complete)
 		return;
@@ -670,7 +671,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 		return;
 	}
 
-	spin_lock(&kfd->interrupt_lock);
+	spin_lock_irqsave(&kfd->interrupt_lock, flags);
 
 	if (kfd->interrupts_active
 	    && interrupt_is_wanted(kfd, ih_ring_entry,
@@ -679,7 +680,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
 				     is_patched ? patched_ihre : ih_ring_entry))
 		queue_work(kfd->ih_wq, &kfd->interrupt_work);
 
-	spin_unlock(&kfd->interrupt_lock);
+	spin_unlock_irqrestore(&kfd->interrupt_lock, flags);
 }
 
 int kgd2kfd_quiesce_mm(struct mm_struct *mm)
-- 
2.19.1



