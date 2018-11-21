Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C96BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F8B21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F8B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeKUSPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:15:19 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:33224 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeKUSPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:15:19 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 5722D13616AF56812A6E;
        Wed, 21 Nov 2018 15:41:49 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAL7fhR7087238;
        Wed, 21 Nov 2018 15:41:43 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018112115420546-12071605 ;
          Wed, 21 Nov 2018 15:42:05 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, jakub.kicinski@netronome.com,
        quentin.monnet@netronome.com, jiong.wang@netronome.com,
        guro@fb.com, sandipan@linux.vnet.ibm.com, john.fastabend@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, wang.yi59@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH 3/4] tools: bpftool: fix potential NULL pointer dereference in do_load
Date:   Wed, 21 Nov 2018 15:43:12 +0800
Message-Id: <1542786192-19164-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-21 15:42:05,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-21 15:41:35,
        Serialize complete at 2018-11-21 15:41:35
X-MAIL: mse01.zte.com.cn wAL7fhR7087238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a possible null pointer dereference in
do_load, detected by the semantic patch
deref_null.cocci, with the following warning:

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

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
CC: Julia Lawall <julia.lawall@lip6.fr>
---
 tools/bpf/bpftool/prog.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 5302ee2..de42187 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1017,8 +1017,9 @@ static int do_load(int argc, char **argv)
 err_close_obj:
 	bpf_object__close(obj);
 err_free_reuse_maps:
-	for (i = 0; i < old_map_fds; i++)
-		close(map_replace[i].fd);
+	if (map_replace)
+		for (i = 0; i < old_map_fds; i++)
+			close(map_replace[i].fd);
 	free(map_replace);
 	return -1;
 }
-- 
2.9.5

