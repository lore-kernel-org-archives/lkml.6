Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53881C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDFA222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025496;
	bh=TNkmIcypAoyoP3+FNg/zLJ4g6tuh4egK7HK+8TMCHKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZdXcZ8L8pwfs+ZSwdv+IqcwRMl1HqETdbNDHMgB8GxxT8ebrp5vu9RNDnYB9jYqoQ
	 4aI0xmmTk0VhwoHYVh2XQocBErwtwPlUgKpXDUvL1y/sHcRL+W+GKKNVDzZ8tgykwd
	 LLidEf4/vw9I6Y+ETLYx2Rq9Pe952IBrI7QdFZSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbfBMCiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:38:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730629AbfBMCiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:38:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F252222C2;
        Wed, 13 Feb 2019 02:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025489;
        bh=TNkmIcypAoyoP3+FNg/zLJ4g6tuh4egK7HK+8TMCHKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2iEretVhtsX587++DjSTlpqdOcIEQp/wI67834OipKQ4t/og7a7kKHIUTFqIUdoCK
         2VxIqzpswpq1dV0u+w8NHXAYPFOjfHqpcZjwi2YT3lznv7K5herFIUS5UqTY+YU4dA
         GhPa+pzyATRJv3dQNTmckl4gxubJWV9aZFPlWxIQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 40/83] bpf: fix panic in stack_map_get_build_id() on i386 and arm32
Date:   Tue, 12 Feb 2019 21:36:18 -0500
Message-Id: <20190213023701.20286-40-sashal@kernel.org>
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

From: Song Liu <songliubraving@fb.com>

[ Upstream commit beaf3d1901f4ea46fbd5c9d857227d99751de469 ]

As Naresh reported, test_stacktrace_build_id() causes panic on i386 and
arm32 systems. This is caused by page_address() returns NULL in certain
cases.

This patch fixes this error by using kmap_atomic/kunmap_atomic instead
of page_address.

Fixes: 615755a77b24 (" bpf: extend stackmap to save binary_build_id+offset instead of address")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 8061a439ef18..e50ef5bca421 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -260,7 +260,7 @@ static int stack_map_get_build_id(struct vm_area_struct *vma,
 		return -EFAULT;	/* page not mapped */
 
 	ret = -EINVAL;
-	page_addr = page_address(page);
+	page_addr = kmap_atomic(page);
 	ehdr = (Elf32_Ehdr *)page_addr;
 
 	/* compare magic x7f "ELF" */
@@ -276,6 +276,7 @@ static int stack_map_get_build_id(struct vm_area_struct *vma,
 	else if (ehdr->e_ident[EI_CLASS] == ELFCLASS64)
 		ret = stack_map_get_build_id_64(page_addr, build_id);
 out:
+	kunmap_atomic(page_addr);
 	put_page(page);
 	return ret;
 }
-- 
2.19.1

