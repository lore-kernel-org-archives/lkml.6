Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AEDC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51AB20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lieelb2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51AB20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbeLEJjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:39:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbeLEJjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:39:15 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95A4820879;
        Wed,  5 Dec 2018 09:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002754;
        bh=lOwErIsa8GwpK2p1dJze5d6b8FGvbQlIOYerejKeJgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lieelb2Sok6wwKkCcmtpDagCNw3gfjGA4EuDp5hsHZ1r6aW/JeeR7ryNKVm389sjR
         APS5fAwxiFBOnrmhd5c5ooJEnaJMG5mJovanHml+tn2kwGOB4Mxy/Zg2IQMRvfg5Wd
         SYkhVOw+4S82r8XkAuRYGuU3DuRHUI2PaSL8flL8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 058/123] tools: bpftool: fix potential NULL pointer dereference in do_load
Date:   Wed,  5 Dec 2018 04:34:50 -0500
Message-Id: <20181205093555.5386-58-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit dde7011a824cfa815b03f853ec985ff46b740939 ]

This patch fixes a possible null pointer dereference in
do_load, detected by the semantic patch deref_null.cocci,
with the following warning:

./tools/bpf/bpftool/prog.c:1021:23-25: ERROR: map_replace is NULL but dereferenced.

The following code has potential null pointer references:
881             map_replace = reallocarray(map_replace, old_map_fds + 1,
882                                        sizeof(*map_replace));
883             if (!map_replace) {
884                     p_err("mem alloc failed");
885                     goto err_free_reuse_maps;
886             }

...
1019 err_free_reuse_maps:
1020         for (i = 0; i < old_map_fds; i++)
1021                 close(map_replace[i].fd);
1022         free(map_replace);

Fixes: 3ff5a4dc5d89 ("tools: bpftool: allow reuse of maps with bpftool prog load")
Co-developed-by: Wen Yang <wen.yang99@zte.com.cn>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/prog.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index dce960d22106..0de024a6cc2b 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -749,6 +749,7 @@ static int do_load(int argc, char **argv)
 			}
 			NEXT_ARG();
 		} else if (is_prefix(*argv, "map")) {
+			void *new_map_replace;
 			char *endptr, *name;
 			int fd;
 
@@ -782,12 +783,15 @@ static int do_load(int argc, char **argv)
 			if (fd < 0)
 				goto err_free_reuse_maps;
 
-			map_replace = reallocarray(map_replace, old_map_fds + 1,
-						   sizeof(*map_replace));
-			if (!map_replace) {
+			new_map_replace = reallocarray(map_replace,
+						       old_map_fds + 1,
+						       sizeof(*map_replace));
+			if (!new_map_replace) {
 				p_err("mem alloc failed");
 				goto err_free_reuse_maps;
 			}
+			map_replace = new_map_replace;
+
 			map_replace[old_map_fds].idx = idx;
 			map_replace[old_map_fds].name = name;
 			map_replace[old_map_fds].fd = fd;
-- 
2.17.1

