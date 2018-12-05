Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3ADC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC9A2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQDJjZgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC9A2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeLEJiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:38:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbeLEJiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:38:12 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E498D20850;
        Wed,  5 Dec 2018 09:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002691;
        bh=bxWvCza3QCgNPprfQ9W6db1FLqK6x9Injw0oYaLGC2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQDJjZgcg6SgbUXxG5WJjdIKnuUE+WeH+f7ssC13/p7adjv2DOLKx7WS+Fm3LPX/e
         8+01zlY4sVvUZZYnaQLWDhl8ihehPEZIbjf+DBuQYkEen62YDui+YYWnMZ43WiJjz8
         qwUlWENtv/alUzFi5OiHy88uKLjOJ06Fua61b+y0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guroan@gmail.com>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 040/123] bpf: allocate local storage buffers using GFP_ATOMIC
Date:   Wed,  5 Dec 2018 04:34:32 -0500
Message-Id: <20181205093555.5386-40-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Gushchin <guroan@gmail.com>

[ Upstream commit 569a933b03f3c48b392fe67c0086b3a6b9306b5a ]

Naresh reported an issue with the non-atomic memory allocation of
cgroup local storage buffers:

[   73.047526] BUG: sleeping function called from invalid context at
/srv/oe/build/tmp-rpb-glibc/work-shared/intel-corei7-64/kernel-source/mm/slab.h:421
[   73.060915] in_atomic(): 1, irqs_disabled(): 0, pid: 3157, name: test_cgroup_sto
[   73.068342] INFO: lockdep is turned off.
[   73.072293] CPU: 2 PID: 3157 Comm: test_cgroup_sto Not tainted
4.20.0-rc2-next-20181113 #1
[   73.080548] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[   73.088018] Call Trace:
[   73.090463]  dump_stack+0x70/0xa5
[   73.093783]  ___might_sleep+0x152/0x240
[   73.097619]  __might_sleep+0x4a/0x80
[   73.101191]  __kmalloc_node+0x1cf/0x2f0
[   73.105031]  ? cgroup_storage_update_elem+0x46/0x90
[   73.109909]  cgroup_storage_update_elem+0x46/0x90

cgroup_storage_update_elem() (as well as other update map update
callbacks) is called with disabled preemption, so GFP_ATOMIC
allocation should be used: e.g. alloc_htab_elem() in hashtab.c.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/local_storage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 830d7f095748..fc1605aee5ea 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -138,7 +138,8 @@ static int cgroup_storage_update_elem(struct bpf_map *map, void *_key,
 		return -ENOENT;
 
 	new = kmalloc_node(sizeof(struct bpf_storage_buffer) +
-			   map->value_size, __GFP_ZERO | GFP_USER,
+			   map->value_size,
+			   __GFP_ZERO | GFP_ATOMIC | __GFP_NOWARN,
 			   map->numa_node);
 	if (!new)
 		return -ENOMEM;
-- 
2.17.1

