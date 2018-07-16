Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28B1ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF0A208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 23:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4XXT4Bo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF0A208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbeGPXnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 19:43:31 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39577 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbeGPXnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 19:43:31 -0400
Received: by mail-it0-f65.google.com with SMTP id 198-v6so15746131ite.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 16:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+7TuIbNoKN6Ihw9FelmHri+YNRauzMz//oNK6aD0Sg4=;
        b=c4XXT4Bo6Aq84YV4G3hxIXJTjL7i2klVG9uTWPYiJHlUTQgXOrBIS7viLqK3gaxAXw
         c301u/JVZg0DJOE2baQ0SPJWdoXMFogpBB8f/1ekA1RGETjN0HDUocoiQQFK02jsglWY
         iPVNIUoViKeWNyS3+/Smc6GzqJfuoilARhfKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+7TuIbNoKN6Ihw9FelmHri+YNRauzMz//oNK6aD0Sg4=;
        b=PpgVtOHD18O0hi2OBMgFMenVJfO9Vx+0fRW6zyIV5NaatPnos6fqe6TBg/uQyjyGt0
         SikUsLvsyXr1z0xGii5KPmBksX8bLb9+DiUllsxo3mCGwbfOMbscuYfgCZHF+d8a/MvB
         LmGagizV9jJEtFXIWB+qWo+CshCMqKxRdaw/S7vKiT0X7Mzer/hZumJIU2lB1Sax1AEV
         VrUgtQvuMatblqEZY2R+EX3eKn7Hf9+mep1E8hXncQrxlCE8C0AWXP3gSssyvfyghGCT
         jKjbPAsJOArlWLWrxssalJ5DYMLSkf43b18WSZczUW4+7bNx1Jn+2gxmUYXdDdqnhNVe
         85nw==
X-Gm-Message-State: AOUpUlHkLB6Kk4l6g7I1fBKpfBdJCQtaJNrOFyJeWSkjAlNpn84ABr+P
        sTpTCXFRW2llYN+XbgoczIb9/Q==
X-Google-Smtp-Source: AAOMgpcZGV7S+NGkIa+wkTVmenxiGBKmvUlxnWQpdQ18WOhEOy8DMQO0+kLp+rxPNfqLZpuWiAph6Q==
X-Received: by 2002:a24:280b:: with SMTP id h11-v6mr15230245ith.7.1531782834225;
        Mon, 16 Jul 2018 16:13:54 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i3-v6sm3018709iti.40.2018.07.16.16.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 16:13:53 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     songliubraving@fb.com, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, miklos@szeredi.hu
Cc:     acme@kernel.org, jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf/core: Fix crash when using HW tracing kernel filters
Date:   Mon, 16 Jul 2018 17:13:51 -0600
Message-Id: <1531782831-1186-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function perf_event_parse_addr_filter(), the path::dentry of each struct
perf_addr_filter is left unassigned (as it should be) when the pattern
being parsed is related to kernel space.  But in function
perf_addr_filter_match() the same dentry'ies are given to d_inode() where
the value is not expected to be NULL, resulting in the following splat:

[   53.451557] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000058
[   53.460368] Mem abort info:
[   53.463134]   ESR = 0x96000004
[   53.466158]   Exception class = DABT (current EL), IL = 32 bits
[   53.472019]   SET = 0, FnV = 0
[   53.475042]   EA = 0, S1PTW = 0
[   53.478150] Data abort info:
[   53.481000]   ISV = 0, ISS = 0x00000004
[   53.484796]   CM = 0, WnR = 0
[   53.487734] user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000f0644b81
[   53.494283] [0000000000000058] pgd=0000000000000000
[   53.499181] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   53.504697] Modules linked in:
[   53.507726] CPU: 2 PID: 2860 Comm: uname Not tainted 4.18.0-rc5-dirty #288
[   53.514531] Hardware name: ARM Juno development board (r0) (DT)
[   53.520392] pstate: 20000085 (nzCv daIf -PAN -UAO)
[   53.525141] pc : perf_event_mmap+0x2fc/0x5a0
[   53.529368] lr : perf_event_mmap+0x2c8/0x5a0
[   53.533593] sp : ffff000010883a10
[   53.536872] x29: ffff000010883a10 x28: ffff8009749126c0
[   53.542137] x27: 0000000000000000 x26: ffff800971221000
[   53.547401] x25: ffff80097678bef0 x24: ffff0000091cb000
[   53.552665] x23: ffff800971221430 x22: ffff80097100fe00
[   53.557930] x21: 0000000000001078 x20: ffff0000091af000
[   53.563194] x19: ffff800971221420 x18: 0000000000006451
[   53.568457] x17: 000000000000644f x16: ffff000009404790
[   53.573721] x15: ffff00000932c3b0 x14: 000000000000644e
[   53.578985] x13: 00000000ed3bb5ef x12: ffff8009711e1de8
[   53.584248] x11: 0000000000000000 x10: ffff0000091af808
[   53.589512] x9 : ffff0000091ea000 x8 : ffff0000091af808
[   53.594776] x7 : 0000000000000002 x6 : ffff8009740c7540
[   53.600040] x5 : 0000000000000000 x4 : 00000000000067e8
[   53.605303] x3 : 0000000000000000 x2 : ffff800971131800
[   53.610567] x1 : 0000000000000002 x0 : 0000000000000000
[   53.615832] Process uname (pid: 2860, stack limit = 0x000000001cbcca37)
[   53.622378] Call trace:
[   53.624798]  perf_event_mmap+0x2fc/0x5a0
[   53.628683]  mmap_region+0x124/0x570
[   53.632221]  do_mmap+0x344/0x4f8
[   53.635414]  vm_mmap_pgoff+0xe4/0x110
[   53.639037]  vm_mmap+0x2c/0x40
[   53.642061]  elf_map+0x60/0x108
[   53.645169]  load_elf_binary+0x450/0x12c4
[   53.649138]  search_binary_handler+0x90/0x290
[   53.653449]  __do_execve_file.isra.13+0x6e4/0x858
[   53.658104]  sys_execve+0x3c/0x50
[   53.661385]  el0_svc_naked+0x30/0x34
[   53.664924] Code: eb02027f 54000300 f9400c45 f94012c6 (f9402ca5)
[   53.670959] ---[ end trace 3ef799e7226990e4 ]---

This patch is fixing the problem by introducing a new check in function
perf_addr_filter_match() to see if the filter's dentry is NULL.

Fixes: 9511bce9fe8e ("perf/core: Fix bad use of igrab()")
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f0434a9951a..a56f10b1e13b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7335,6 +7335,10 @@ static bool perf_addr_filter_match(struct perf_addr_filter *filter,
 				     struct file *file, unsigned long offset,
 				     unsigned long size)
 {
+	/* d_inode(NULL) won't be equal to any mapped user space file */
+	if (!filter->path.dentry)
+		return false;
+
 	if (d_inode(filter->path.dentry) != file_inode(file))
 		return false;
 
-- 
2.7.4

