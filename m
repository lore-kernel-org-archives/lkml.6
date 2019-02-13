Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AE6C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656442190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026971;
	bh=tH8LjbMMFIDZaNfYmh2W5NDshAm5TaldNQK6TDiTycE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C5gsSP9jS3/b/SW08DSenNMhCIGf9j1U5no4Fah/49FFmvNMZzxhMg+IcKpMa8dME
	 RaXY1U10PAH4XwiN5NWNkM880b3gmhdKECXrXZxJDbBssi86EN08fV0gNueSP47v8z
	 mgsWk5RrfEbS+PKXrqkqPbnKuUYltt1FelhjJ1Ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390373AbfBMDCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:02:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387819AbfBMCet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:34:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3D0B222CA;
        Wed, 13 Feb 2019 02:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025288;
        bh=tH8LjbMMFIDZaNfYmh2W5NDshAm5TaldNQK6TDiTycE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tjt5K6gtLHpegPTw5zZa+9gOING60wpeeldBog+nei3gwiBzutnBoRyb5T7R+5u8H
         DfHaXds//hsIrCchEY4mdcNFPp10c3Ragb9TIF7MT15HaAiCSBOHW5tgx5TWvWK/NM
         aCsdIarvE/8b6LenwFKk+K0vpavctgFcxllKT4sY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 047/105] bpf: fix panic in stack_map_get_build_id() on i386 and arm32
Date:   Tue, 12 Feb 2019 21:32:38 -0500
Message-Id: <20190213023336.19019-47-sashal@kernel.org>
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
index 90daf285de03..d9e2483669d0 100644
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

