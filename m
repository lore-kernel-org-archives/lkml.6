Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16241C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1C021850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129810;
	bh=Gv8LMI3nDL/t40rKahljE0txyrSLcuGGiAWXxbHXCSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kZObvzfsmKbOSuNdWQ3n0rEyCRbgzj7JbCqk+gQwpwkNrQGgMlqeSn0gWEmV8WT7O
	 TBeqaro5KWzb+T69tsJIAlUVXWnOi3NpALqVPymGKCn9qpJj/UQTWttHv+IrsykFxR
	 NvIKyoqL1wmpNmK+5IYtgMqhVugrLLZagYwxGioU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbfBYVX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:23:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730235AbfBYVX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:23:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4408321841;
        Mon, 25 Feb 2019 21:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129805;
        bh=Gv8LMI3nDL/t40rKahljE0txyrSLcuGGiAWXxbHXCSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JV7fIJ74xEhUcpj12ncqQPOjSnm+h/0HYKlcBUwsU33bZG2o8cmGW+yADP7b4J6js
         Qb6xu8clsx12ZbliJLfJzR/DIIDaD7lkZguDQtUJmnanY6GEFxcAQGNjPo/MDFD2gc
         KlSBpQ60XxIFpfUsNLxOY2u5ZHqbOrAilOw1C9Bw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        Elias Konstantinidis <ekondis@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 074/152] drm/amdkfd: Dont assign dGPUs to APU topology devices
Date:   Mon, 25 Feb 2019 22:11:06 +0100
Message-Id: <20190225195048.289098414@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

[ Upstream commit bbdf514fe5648566b0754476cbcb92ac3422dde2 ]

dGPUs need their own topology devices. Don't assign them to APU topology
devices with CPU cores.

Bug: https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/issues/66
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Tested-by: Elias Konstantinidis <ekondis@gmail.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 80f5db4ef75fd..0805c423a5ce0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1072,8 +1072,6 @@ static uint32_t kfd_generate_gpu_id(struct kfd_dev *gpu)
  *		the GPU device is not already present in the topology device
  *		list then return NULL. This means a new topology device has to
  *		be created for this GPU.
- * TODO: Rather than assiging @gpu to first topology device withtout
- *		gpu attached, it will better to have more stringent check.
  */
 static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
 {
@@ -1081,12 +1079,20 @@ static struct kfd_topology_device *kfd_assign_gpu(struct kfd_dev *gpu)
 	struct kfd_topology_device *out_dev = NULL;
 
 	down_write(&topology_lock);
-	list_for_each_entry(dev, &topology_device_list, list)
+	list_for_each_entry(dev, &topology_device_list, list) {
+		/* Discrete GPUs need their own topology device list
+		 * entries. Don't assign them to CPU/APU nodes.
+		 */
+		if (!gpu->device_info->needs_iommu_device &&
+		    dev->node_props.cpu_cores_count)
+			continue;
+
 		if (!dev->gpu && (dev->node_props.simd_count > 0)) {
 			dev->gpu = gpu;
 			out_dev = dev;
 			break;
 		}
+	}
 	up_write(&topology_lock);
 	return out_dev;
 }
-- 
2.19.1



