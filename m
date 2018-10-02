Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A655BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FB32064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FB32064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbeJBUlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:41:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbeJBUO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:28 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0FD32C2A;
        Tue,  2 Oct 2018 13:31:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Emily Deng <Emily.Deng@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 219/228] drm/amdgpu: Need to set moved to true when evict bo
Date:   Tue,  2 Oct 2018 06:25:16 -0700
Message-Id: <20181002132512.338916613@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emily Deng <Emily.Deng@amd.com>

[ Upstream commit 6ddd9769db4fc11a98bd7e58be1764e47fdb8384 ]

Fix the VMC page fault when the running sequence is as below:
1.amdgpu_gem_create_ioctl
2.ttm_bo_swapout->amdgpu_vm_bo_invalidate, as not called
amdgpu_vm_bo_base_init, so won't called
list_add_tail(&base->bo_list, &bo->va). Even the bo was evicted,
it won't set the bo_base->moved.
3.drm_gem_open_ioctl->amdgpu_vm_bo_base_init, here only called
list_move_tail(&base->vm_status, &vm->evicted), but not set the
bo_base->moved.
4.amdgpu_vm_bo_map->amdgpu_vm_bo_insert_map, as the bo_base->moved is
not set true, the function amdgpu_vm_bo_insert_map will call
list_move(&bo_va->base.vm_status, &vm->moved)
5.amdgpu_cs_ioctl won't validate the swapout bo, as it is only in the
moved list, not in the evict list. So VMC page fault occurs.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -123,6 +123,7 @@ static void amdgpu_vm_bo_base_init(struc
 	 * is validated on next vm use to avoid fault.
 	 * */
 	list_move_tail(&base->vm_status, &vm->evicted);
+	base->moved = true;
 }
 
 /**


