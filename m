Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E80CC43610
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC8A20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lhwe3/Xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC8A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeKIITp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728915AbeKIHdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:36 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 041422089A;
        Thu,  8 Nov 2018 21:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714169;
        bh=tsU6L4NqBvmesVda34w42L6XwO8PyLUnduxTpztgTiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lhwe3/Xk67CwtxT+kYZbRp3lJXw5FbtXy/UILxpYfEjIDIun6mrqgZ2BQTvc8/c0u
         FHyvIRnDoGcRYdFBAABtMaFQHzlhXGYykSpQyQ9I33fcQxBJAS/bggl8CaJ51RZ9Js
         MqgO7L+/kZLGamRt66MQE8KDL53hU84W3QlzSLtw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoffer Dall <cdall@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 090/144] arm/arm64: KVM: Take mmap_sem in stage2_unmap_vm
Date:   Thu,  8 Nov 2018 13:51:01 -0800
Message-Id: <20181108215101.941288550@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 90f6e150e44a0dc3883110eeb3ab35d1be42b6bb ]

We don't hold the mmap_sem while searching for the VMAs when
we try to unmap each memslot for a VM. Fix this properly to
avoid unexpected results.

Fixes: commit 957db105c997 ("arm/arm64: KVM: Introduce stage2_unmap_vm")
Cc: stable@vger.kernel.org # v3.19+
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kvm/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index e506389d02fb..017d6d1e1766 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -760,6 +760,7 @@ void stage2_unmap_vm(struct kvm *kvm)
 	int idx;
 
 	idx = srcu_read_lock(&kvm->srcu);
+	down_read(&current->mm->mmap_sem);
 	spin_lock(&kvm->mmu_lock);
 
 	slots = kvm_memslots(kvm);
@@ -767,6 +768,7 @@ void stage2_unmap_vm(struct kvm *kvm)
 		stage2_unmap_memslot(kvm, memslot);
 
 	spin_unlock(&kvm->mmu_lock);
+	up_read(&current->mm->mmap_sem);
 	srcu_read_unlock(&kvm->srcu, idx);
 }
 
-- 
2.17.1



