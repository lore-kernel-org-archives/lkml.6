Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE99C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE906206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Z2/k9DsO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfAIUxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:53:51 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41597 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfAIUxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 15:53:50 -0500
Received: by mail-qt1-f194.google.com with SMTP id l12so9896012qtf.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 12:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HAWmnH5gA+NdcK3Sd3H+huaAiUs74EbVnEGzvD4+3Bs=;
        b=Z2/k9DsOoS/Gw2DPIEhm1wDTy1rgW/FvVXHccPy2MYhWbWDE4gSNheaLML6ssWEdAj
         W8UJQlKTmk+5OWWx0DEQQtzd/dLjRsjTjCat2Mn/kEEV52rS9xW1uiSXryF2dbtn6OUt
         x56ydBZXzzgBiYYYID6paXu8L1+VMntvwFvwKujRBEoHH2I0enPPrKRaPTCy/VR18WvL
         kS50r79lZ19d9yw9x5RsxN1bX2k4VQlqU34SYMOFTqn2xGpSCFTr3WbYPrmxcUA5NqQh
         VgSaBD4M+aVjos18Plh7wcxv8VbbC0qme7N83BYbvho9opjnCQTOED61b9DfRHcJC8Ah
         9y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HAWmnH5gA+NdcK3Sd3H+huaAiUs74EbVnEGzvD4+3Bs=;
        b=EjFY1VMOwb8Yz13sKtoQxJIgNtDTxPQ9i2yKEvKmNfVhAixLzelaZcE855Knw47w2c
         7H8VQve24PQ5FkHPwxZ3D/q4jZPuyMIX/TYdHOS+3UcI1GILMn0sSyzKh4ig5R6lO8yJ
         MtTQk4pM77hk8TNnWq1lnUHpjeVuG2Kpg91CHHvHACG/qdXZ3qvxyz1XmFF4kkEsNhGT
         y9ODcOhHYUnxx0KMweOknpqt0BIlOK8q3A0/yxal0WDU6e30676vvSPx/NtoTGsEQOXn
         Tx6jUbLKTw+DP0/z4cBYTdXtBFfBJ+VOIvHHPY2jYlbqQl/u50lq4bcJb+WmwwafNK21
         iQEQ==
X-Gm-Message-State: AJcUukdeQKw9e2Z00WX+co0PJpH/EKNdFHpNSXXLGtOeVFObYAexaZkR
        IYxOHEeuGKU9/UQTC+D+dNVsuQ==
X-Google-Smtp-Source: ALg8bN4hKl24QV6BdY6fbK82M6QcD+uEDB5+RK6C+l9TfhWf/VAiBTr5HpAazhaMt22huNfaP21C4A==
X-Received: by 2002:a0c:bf0d:: with SMTP id m13mr7195542qvi.139.1547067229040;
        Wed, 09 Jan 2019 12:53:49 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b20sm43286725qkb.17.2019.01.09.12.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 12:53:48 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     darrick.wong@oracle.com
Cc:     dchinner@redhat.com, peterz@infradead.org, bfoster@redhat.com,
        hch@lst.de, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] xfs: silence lockdep false positives when freezing
Date:   Wed,  9 Jan 2019 15:53:29 -0500
Message-Id: <20190109205329.2486-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190106225639.GU4205@dastard>
References: <20190106225639.GU4205@dastard>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Easy to reproduce:

1. run LTP oom02 workload to let kswapd acquire this locking order:
   fs_reclaim -> sb_internal.

 # grep -i fs_reclaim -C 3 /proc/lockdep_chains | grep -C 5 sb_internal
[00000000826b9172] &type->s_umount_key#27
[000000005fa8b2ac] sb_pagefaults
[0000000033f1247e] sb_internal
[000000009e9a9664] fs_reclaim

2. freeze XFS.
  # fsfreeze -f /home

Dave mentioned that this is due to a lockdep limitation - "IOWs, this is
a false positive, caused by the fact that xfs_trans_alloc() is called
from both above and below memory reclaim as well as within /every level/
of freeze processing. Lockdep is unable to describe the staged flush
logic in the freeze process that prevents deadlocks from occurring, and
hence we will pretty much always see false positives in the freeze
path....". Hence, just temporarily disable lockdep in that path.

======================================================
WARNING: possible circular locking dependency detected
5.0.0-rc1+ #60 Tainted: G        W
------------------------------------------------------
fsfreeze/4346 is trying to acquire lock:
0000000026f1d784 (fs_reclaim){+.+.}, at: fs_reclaim_acquire.part.19+0x5/0x30

but task is already holding lock:
0000000072bfc54b (sb_internal){++++}, at: percpu_down_write+0xb4/0x650

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (sb_internal){++++}:
       __lock_acquire+0x728/0x1200
       lock_acquire+0x269/0x5a0
       __sb_start_write+0x17f/0x260
       xfs_trans_alloc+0x62b/0x9d0
       xfs_setfilesize_trans_alloc+0xd4/0x360
       xfs_submit_ioend+0x4af/0xa40
       xfs_vm_writepage+0x10f/0x180
       pageout.isra.2+0xbf2/0x26b0
       shrink_page_list+0x3e16/0xae70
       shrink_inactive_list+0x64f/0x1cd0
       shrink_node_memcg+0x80a/0x2490
       shrink_node+0x33d/0x13e0
       balance_pgdat+0xa8f/0x18b0
       kswapd+0x881/0x1120
       kthread+0x32c/0x3f0
       ret_from_fork+0x27/0x50

-> #0 (fs_reclaim){+.+.}:
       validate_chain.isra.14+0x11af/0x3b50
       __lock_acquire+0x728/0x1200
       lock_acquire+0x269/0x5a0
       fs_reclaim_acquire.part.19+0x29/0x30
       fs_reclaim_acquire+0x19/0x20
       kmem_cache_alloc+0x3e/0x3f0
       kmem_zone_alloc+0x79/0x150
       xfs_trans_alloc+0xfa/0x9d0
       xfs_sync_sb+0x86/0x170
       xfs_log_sbcount+0x10f/0x140
       xfs_quiesce_attr+0x134/0x270
       xfs_fs_freeze+0x4a/0x70
       freeze_super+0x1af/0x290
       do_vfs_ioctl+0xedc/0x16c0
       ksys_ioctl+0x41/0x80
       __x64_sys_ioctl+0x73/0xa9
       do_syscall_64+0x18f/0xd23
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_internal);
                               lock(fs_reclaim);
                               lock(sb_internal);
  lock(fs_reclaim);

 *** DEADLOCK ***

4 locks held by fsfreeze/4346:
 #0: 00000000b478ef56 (sb_writers#8){++++}, at: percpu_down_write+0xb4/0x650
 #1: 000000001ec487a9 (&type->s_umount_key#28){++++}, at: freeze_super+0xda/0x290
 #2: 000000003edbd5a0 (sb_pagefaults){++++}, at: percpu_down_write+0xb4/0x650
 #3: 0000000072bfc54b (sb_internal){++++}, at: percpu_down_write+0xb4/0x650

stack backtrace:
Call Trace:
 dump_stack+0xe0/0x19a
 print_circular_bug.isra.10.cold.34+0x2f4/0x435
 check_prev_add.constprop.19+0xca1/0x15f0
 validate_chain.isra.14+0x11af/0x3b50
 __lock_acquire+0x728/0x1200
 lock_acquire+0x269/0x5a0
 fs_reclaim_acquire.part.19+0x29/0x30
 fs_reclaim_acquire+0x19/0x20
 kmem_cache_alloc+0x3e/0x3f0
 kmem_zone_alloc+0x79/0x150
 xfs_trans_alloc+0xfa/0x9d0
 xfs_sync_sb+0x86/0x170
 xfs_log_sbcount+0x10f/0x140
 xfs_quiesce_attr+0x134/0x270
 xfs_fs_freeze+0x4a/0x70
 freeze_super+0x1af/0x290
 do_vfs_ioctl+0xedc/0x16c0
 ksys_ioctl+0x41/0x80
 __x64_sys_ioctl+0x73/0xa9
 do_syscall_64+0x18f/0xd23
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Qian Cai <cai@lca.pw>
---
 fs/xfs/libxfs/xfs_sb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index b5a82acd7dfe..ec83cb8289fa 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -965,8 +965,11 @@ xfs_sync_sb(
 	struct xfs_trans	*tp;
 	int			error;
 
+	/* Silence lockdep false positives in the freeze path. */
+	lockdep_off();
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_sb, 0, 0,
 			XFS_TRANS_NO_WRITECOUNT, &tp);
+	lockdep_on();
 	if (error)
 		return error;
 
-- 
2.17.2 (Apple Git-113)

