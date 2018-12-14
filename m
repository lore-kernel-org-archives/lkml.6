Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0B4C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2254021486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789118;
	bh=LFrMV8ItOFs7UG+W1ToX1MBfIMQ3hIjLRKYyqIJn6r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HhAvIGpzKbByVHFsQOziAZfjZzRhQcQXaiGrcSOnqy4asJS1OIipjeUx2y3fQfytN
	 COBcuYddifDYvgb3/yj/RG7tI7Zl7aDjSWQ89ZD5AiqCZqWfbQUU82gb4brunoOF9M
	 VHL/Chg84Ahiu67ptuf4CQNHBJ/YwMbB581SjJq0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2254021486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbeLNMFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730653AbeLNMFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:05:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE862147D;
        Fri, 14 Dec 2018 12:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789112;
        bh=LFrMV8ItOFs7UG+W1ToX1MBfIMQ3hIjLRKYyqIJn6r4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WgauSPO/ipydC3v5qJtrPXozxbnkEQulswtPFVstkiommaydl6oZTzhBzZyHaNpAB
         8HQV48e/NJecDpnDWvC8Up+snUV2VEgoOQFzwE50mV9X/pGUFloRX0s6MspVBplnxP
         urX5yeT/zkINXdbo9Ad152DnRWtnVB4KcrCePpwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 076/142] tools: bpftool: fix potential NULL pointer dereference in do_load
Date:   Fri, 14 Dec 2018 12:59:21 +0100
Message-Id: <20181214115750.102710067@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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
2.19.1



