Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4586C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8088206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196676;
	bh=u8Wx9GsMXcZZYeBBNGwlq656t69YYYMVAFRicoNjviU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sKLgaknfD5YFfLZNyVPd8f+LsrtYzzfF5MzozGcavsV77pg4zH8sNzqdFFdR2mEe5
	 5q2P9EOaXzbXyvZteQocfnjBQ2nbxJcKZoqQCRFwshbqq1S8VcXo7Sbbjzanma5bKw
	 BeRqH/XQiGzdHmwMVCEIjZha25m0vBmYYnffO5t8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbfBOCLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:11:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfBOCLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 006AD21934;
        Fri, 15 Feb 2019 02:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196671;
        bh=u8Wx9GsMXcZZYeBBNGwlq656t69YYYMVAFRicoNjviU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjuSEg5RzyUfef3PtMlhD7zPmXHqILj2ViaH6TV2qoHgshsjgjXzUybilbAchVAHb
         8tcMf22ZlpVBq0468BMbRTJ3eLzFHA2/KS4y1/xzbZR2rauXhtZobhDrJK4ibtf6UC
         nPm6yc7PcYRSdkEJ6xjOiS+BpIgFsqK/mdoLIKHc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Gardon <bgardon@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 75/77] kvm: selftests: Fix region overlap check in kvm_util
Date:   Thu, 14 Feb 2019 21:08:53 -0500
Message-Id: <20190215020855.176727-75-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Gardon <bgardon@google.com>

[ Upstream commit 94a980c39c8e3f8abaff5d3b5bbcd4ccf1c02c4f ]

Fix a call to userspace_mem_region_find to conform to its spec of
taking an inclusive, inclusive range. It was previously being called
with an inclusive, exclusive range. Also remove a redundant region bounds
check in vm_userspace_mem_region_add. Region overlap checking is already
performed by the call to userspace_mem_region_find.

Tested: Compiled tools/testing/selftests/kvm with -static
	Ran all resulting test binaries on an Intel Haswell test machine
	All tests passed

Signed-off-by: Ben Gardon <bgardon@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1b41e71283d5..6ee49133ad22 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -532,7 +532,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	 * already exist.
 	 */
 	region = (struct userspace_mem_region *) userspace_mem_region_find(
-		vm, guest_paddr, guest_paddr + npages * vm->page_size);
+		vm, guest_paddr, (guest_paddr + npages * vm->page_size) - 1);
 	if (region != NULL)
 		TEST_ASSERT(false, "overlapping userspace_mem_region already "
 			"exists\n"
@@ -548,15 +548,10 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 		region = region->next) {
 		if (region->region.slot == slot)
 			break;
-		if ((guest_paddr <= (region->region.guest_phys_addr
-				+ region->region.memory_size))
-			&& ((guest_paddr + npages * vm->page_size)
-				>= region->region.guest_phys_addr))
-			break;
 	}
 	if (region != NULL)
 		TEST_ASSERT(false, "A mem region with the requested slot "
-			"or overlapping physical memory range already exists.\n"
+			"already exists.\n"
 			"  requested slot: %u paddr: 0x%lx npages: 0x%lx\n"
 			"  existing slot: %u paddr: 0x%lx size: 0x%lx",
 			slot, guest_paddr, npages,
-- 
2.19.1

