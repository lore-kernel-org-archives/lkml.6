Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342C1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFAB217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129849;
	bh=PuXq4EcWnfPW/JohJdYDwYJ7x+jLjK4GWTkxaQPFc1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qQmIXGHScz038kFc5eKGc4HAfRq+H7N7fcBwL89Q0QQ6Goe1iP/FkTL3LdiarlUzf
	 VEO8VVHpCliOa7gcuOtIyknt5C0Gi6fLeEOLQLEzhq+jLhxqQyrFQx1XwmpAOrgy7P
	 WFVYOnxiltj/S3W6iBYnYa39/L5unCeiuaMvva/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbfBYVYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:24:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730793AbfBYVYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:24:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73BAB21734;
        Mon, 25 Feb 2019 21:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129844;
        bh=PuXq4EcWnfPW/JohJdYDwYJ7x+jLjK4GWTkxaQPFc1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vP2BtBreFpjurqTA4MwSDigOyDs89WcXuLoW6HZuUnV6FZSskdogPYeE82M6O5NZB
         vsN6+nJTW25NwtgejT9b30xVERQWywh9Mpkx/JiiakNRRQU/6wis1H92U5MlAebYg7
         9jKSQJ/hro7HDU6Gvd9K5d6TRx68SFdd/GOJv69s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 085/152] bpf: zero out build_id for BPF_STACK_BUILD_ID_IP
Date:   Mon, 25 Feb 2019 22:11:17 +0100
Message-Id: <20190225195048.899363963@linuxfoundation.org>
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
index 98ad9dc3587aa..6a32933cae4ff 100644
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



