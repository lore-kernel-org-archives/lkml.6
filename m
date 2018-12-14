Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7087C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E78A21486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789009;
	bh=0rKXBEQeJBNeLa7TfmYmuOHN+xGbvlY52ISPWuGsLHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bU4pQJydhAe4kK0O3XXcITTYCNO+NVbs+OOGv+vpBc+CVMknYXkTxmAdWYfy9Ce2F
	 MYdojHUEBFDKFHVd2thw9cXJo7Emec5++5tPUcIRdOzHrY5VzDD/OkUwIzO+jbvwnD
	 i7EFDsE7IFH7Xf9mtbbQ2sDA5kRqZV1auTBr2oBc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E78A21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbeLNMD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:03:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729775AbeLNMD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:03:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22DB32147D;
        Fri, 14 Dec 2018 12:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789006;
        bh=0rKXBEQeJBNeLa7TfmYmuOHN+xGbvlY52ISPWuGsLHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=evSbd//YeTaVTu2vC83D+biAuEcOQMbFzNHSL/4irkrzOVMwNjJJYjqb6qGx742as
         kjZmJY4GamWCfqJMxSJtJnPiWbwKtnuS2eYx+yMmiv97U4MVrK8zDekS+WV8+aZJv1
         M0Af8pFidCbZKDBLEh+LlteF/RQK8ZIhOLgLZ9iQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 058/142] bpf: allocate local storage buffers using GFP_ATOMIC
Date:   Fri, 14 Dec 2018 12:59:03 +0100
Message-Id: <20181214115749.382334320@linuxfoundation.org>
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
2.19.1



