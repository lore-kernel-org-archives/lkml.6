Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D983C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632632190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026757;
	bh=nZcgSmia24wu9Q80jRP840NvbOLFC/cyoC8/ezPbI+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ywmVj9A3NfNK9Gm498U9mxKNwKDuYeyVCXLPGD8O+pvJVs2jA5IF2ApyCRHQgYpXi
	 Sficf4h5MWbWwAgPA4xHyaejVez5jBurqr0VZF/PZB0bPn6CawkGJ12HLzO/EUQJGo
	 0iaiiIE44mulhJUqgNy2lwxHxlsQiA+//JFj6iNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390219AbfBMC7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:59:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbfBMCgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE303222C7;
        Wed, 13 Feb 2019 02:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025380;
        bh=nZcgSmia24wu9Q80jRP840NvbOLFC/cyoC8/ezPbI+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FESZGShumoR4LeQnv0aA/6t1+DIQUL5dtkQl5EiA4vQ5XkP4LeXVhIdMUrQrJtP01
         lU/peOpahrBohGpndNvWK12/0d63jitG0Ml5PJM93TRBKuD2W2R9Liofnu/xMDr2W3
         /9uMpU9EmU6RHUDfDXytMk9oXXP4pEuV9ksYm92I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 090/105] bpf: zero out build_id for BPF_STACK_BUILD_ID_IP
Date:   Tue, 12 Feb 2019 21:33:21 -0500
Message-Id: <20190213023336.19019-90-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
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
index f9df545e92f6..d43b14535827 100644
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

