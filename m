Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A939C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8F0222C7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026284;
	bh=iSyk7m7jTOXntky0w1tVQCTjPmiDHSD+GKrgrPVK4HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RHcO2LunqRtA9x+aP1a5869rY60d5dkwwuyOoiIqxA+b/9JueBJ3Tdd3sxatGIfvk
	 uWnrVe8uFzfJPU0wQ8xnkd6Jf+XoCAliY8hDy8LxJQXsePtSmBs8kDJfV7c1Vc8DVK
	 6AjzzGvOWZAueNWj8OYg8u9JztSyPiUlWBvhSYa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389756AbfBMCvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:51:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388688AbfBMCjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:39:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48891222C9;
        Wed, 13 Feb 2019 02:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025565;
        bh=iSyk7m7jTOXntky0w1tVQCTjPmiDHSD+GKrgrPVK4HE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5pGLOgulZlHjub9JI82rjNsynBSLdb+StbS7+zAsPP7noeEjscNBvHJ6jz9vFxWb
         j3maps1YzthlYLRxF7RTxbA3JVnVVurtnc4k9qjo3lCXR9n7SRL7PRdn7i0h3H+lEL
         /qxUc0UgdZm4Vzs29Hme9u8BGEL44KrgznR1C3rs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 71/83] bpf: zero out build_id for BPF_STACK_BUILD_ID_IP
Date:   Tue, 12 Feb 2019 21:36:49 -0500
Message-Id: <20190213023701.20286-71-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit 4af396ae4836c4ecab61e975b8e61270c551894d ]

When returning BPF_STACK_BUILD_ID_IP from stack_map_get_build_id_offset,
make sure that build_id field is empty. Since we are using percpu
free list, there is a possibility that we might reuse some previous
bpf_stack_build_id with non-zero build_id.

Fixes: 615755a77b24 ("bpf: extend stackmap to save binary_build_id+offset instead of address")
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 98ad9dc3587a..6a32933cae4f 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -314,6 +314,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 		for (i = 0; i < trace_nr; i++) {
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
 			id_offs[i].ip = ips[i];
+			memset(id_offs[i].build_id, 0, BPF_BUILD_ID_SIZE);
 		}
 		return;
 	}
@@ -324,6 +325,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
 			id_offs[i].ip = ips[i];
+			memset(id_offs[i].build_id, 0, BPF_BUILD_ID_SIZE);
 			continue;
 		}
 		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ips[i]
-- 
2.19.1

