Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CEBC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF67D222CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025384;
	bh=sCSH2rzZn9xX82VwTmiDXLJFMwtXldl8YrhaQpU+R/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LQY0aDMiHeYAaavjEsLfuHoimtzXA3vantyIk8BIB3ubMZYYiJB3BmzTJ41humKbg
	 0mUuHsI95xT4gErczw8urQQA6CsKCs4w0bipBGDd2Eqd/LW+XzEUI7DP+GPtSlZ50U
	 EV/E+C8/IrQ1dhp5g+kbZECLNoOFlRrTHUKhxlko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbfBMCgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:36:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388098AbfBMCgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9E02206B6;
        Wed, 13 Feb 2019 02:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025379;
        bh=sCSH2rzZn9xX82VwTmiDXLJFMwtXldl8YrhaQpU+R/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R6y7vlSpGZgVpwzCe8zKsLukuAyQSu+9HObdzXhBAyFoBozCc0c+mFQipU5TUvbGT
         yfTOv9HsRc7KelFZFDP4XA6UZYOYTnJ9r1nkP+H2rRz490T0gA65Mx6cXjgAX2+WYp
         fKfJdayOfjFuK8ygsx+85gxwCfWUAinz/LdJKSJo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 089/105] bpf: don't assume build-id length is always 20 bytes
Date:   Tue, 12 Feb 2019 21:33:20 -0500
Message-Id: <20190213023336.19019-89-sashal@kernel.org>
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

[ Upstream commit 0b698005a9d11c0e91141ec11a2c4918a129f703 ]

Build-id length is not fixed to 20, it can be (`man ld` /--build-id):
  * 128-bit (uuid)
  * 160-bit (sha1)
  * any length specified in ld --build-id=0xhexstring

To fix the issue of missing BPF_STACK_BUILD_ID_VALID for shorter build-ids,
assume that build-id is somewhere in the range of 1 .. 20.
Set the remaining bytes to zero.

v2:
* don't introduce new "len = min(BPF_BUILD_ID_SIZE, nhdr->n_descsz)",
  we already know that nhdr->n_descsz <= BPF_BUILD_ID_SIZE if we enter
  this 'if' condition

Fixes: 615755a77b24 ("bpf: extend stackmap to save binary_build_id+offset instead of address")
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index d9e2483669d0..f9df545e92f6 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -180,11 +180,14 @@ static inline int stack_map_parse_build_id(void *page_addr,
 
 		if (nhdr->n_type == BPF_BUILD_ID &&
 		    nhdr->n_namesz == sizeof("GNU") &&
-		    nhdr->n_descsz == BPF_BUILD_ID_SIZE) {
+		    nhdr->n_descsz > 0 &&
+		    nhdr->n_descsz <= BPF_BUILD_ID_SIZE) {
 			memcpy(build_id,
 			       note_start + note_offs +
 			       ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr),
-			       BPF_BUILD_ID_SIZE);
+			       nhdr->n_descsz);
+			memset(build_id + nhdr->n_descsz, 0,
+			       BPF_BUILD_ID_SIZE - nhdr->n_descsz);
 			return 0;
 		}
 		new_offs = note_offs + sizeof(Elf32_Nhdr) +
-- 
2.19.1

