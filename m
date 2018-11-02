Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B6FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7B420847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPjWwBs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7B420847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbeKCDxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729745AbeKCDxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:53:46 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35B5220837;
        Fri,  2 Nov 2018 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184333;
        bh=1zIXvyucoAmNmIyie6BECVpADiR6GoT3fNsdSwmv/xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPjWwBs7Z9DRO+AqeZSpDlOlM5mB5XHS8CkyumkXTB4mnBi3K/UDM3Dm8kUViNir0
         kTt5lhKmPA8UuSgGyppI6/5dfivmgogs08/FLpG0flTiuKVEGggvDL5wgELcqcT92R
         kr5A/aEFqxcGPE481v3uOFZ6ya94vIs2IFfH2baY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 137/150] net: bpfilter: use get_pid_task instead of pid_task
Date:   Fri,  2 Nov 2018 19:34:59 +0100
Message-Id: <20181102182912.144844158@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 84258438e8ce12d6888b68a1238bba9cb25307e2 ]

pid_task() dereferences rcu protected tasks array.
But there is no rcu_read_lock() in shutdown_umh() routine so that
rcu_read_lock() is needed.
get_pid_task() is wrapper function of pid_task. it holds rcu_read_lock()
then calls pid_task(). if task isn't NULL, it increases reference count
of task.

test commands:
   %modprobe bpfilter
   %modprobe -rv bpfilter

splat looks like:
[15102.030932] =============================
[15102.030957] WARNING: suspicious RCU usage
[15102.030985] 4.19.0-rc7+ #21 Not tainted
[15102.031010] -----------------------------
[15102.031038] kernel/pid.c:330 suspicious rcu_dereference_check() usage!
[15102.031063]
	       other info that might help us debug this:

[15102.031332]
	       rcu_scheduler_active = 2, debug_locks = 1
[15102.031363] 1 lock held by modprobe/1570:
[15102.031389]  #0: 00000000580ef2b0 (bpfilter_lock){+.+.}, at: stop_umh+0x13/0x52 [bpfilter]
[15102.031552]
               stack backtrace:
[15102.031583] CPU: 1 PID: 1570 Comm: modprobe Not tainted 4.19.0-rc7+ #21
[15102.031607] Hardware name: To be filled by O.E.M. To be filled by O.E.M./Aptio CRB, BIOS 5.6.5 07/08/2015
[15102.031628] Call Trace:
[15102.031676]  dump_stack+0xc9/0x16b
[15102.031723]  ? show_regs_print_info+0x5/0x5
[15102.031801]  ? lockdep_rcu_suspicious+0x117/0x160
[15102.031855]  pid_task+0x134/0x160
[15102.031900]  ? find_vpid+0xf0/0xf0
[15102.032017]  shutdown_umh.constprop.1+0x1e/0x53 [bpfilter]
[15102.032055]  stop_umh+0x46/0x52 [bpfilter]
[15102.032092]  __x64_sys_delete_module+0x47e/0x570
[ ... ]

Fixes: d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bpfilter/bpfilter_kern.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -23,9 +23,11 @@ static void shutdown_umh(struct umh_info
 
 	if (!info->pid)
 		return;
-	tsk = pid_task(find_vpid(info->pid), PIDTYPE_PID);
-	if (tsk)
+	tsk = get_pid_task(find_vpid(info->pid), PIDTYPE_PID);
+	if (tsk) {
 		force_sig(SIGKILL, tsk);
+		put_task_struct(tsk);
+	}
 	fput(info->pipe_to_umh);
 	fput(info->pipe_from_umh);
 	info->pid = 0;


