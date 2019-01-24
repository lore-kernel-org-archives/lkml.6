Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B54C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A300A21908
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358725;
	bh=I93ju16cm15E6t3vpZDPgco4I8k82mggEofNf7MYhN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L5dSQSqPlVOH/cbCRAk0XvoLyZKFRlbxRYpH+1D3iUh5oh0ISzsf4Wtytu/jtHwW9
	 WtX0m5RniunWC14Zzh+ENe0ObzCIgykGG0k2cdvkC9Oqjm6AV9wmLIaDLsvFrUetCy
	 69FfKgLicybCNfiqoCpNsffVBdaQRZMUVBGFu110=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfAXTio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:38:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732551AbfAXTim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:38:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1F8B21906;
        Thu, 24 Jan 2019 19:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358721;
        bh=I93ju16cm15E6t3vpZDPgco4I8k82mggEofNf7MYhN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tS5mX/M4UWuisToo6uHZGUQS9r/0yqpOjhBUqYF8k/PPJ780wBLyCH/94JM6UJ7A/
         LQXowt4C+rF9xq7n7IX8zYgYBgFH/ixnvcyLU3uNgzr+MJ2gx7XlGL0KG/WDQG620o
         5LTiMOHzJ/ohBNkEbBIMrV2q8Xu/uoXZxZEsdTE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH 4.19 102/106] ipmi: fix use-after-free of user->release_barrier.rda
Date:   Thu, 24 Jan 2019 20:20:59 +0100
Message-Id: <20190124190212.390839342@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

From: Yang Yingliang <yangyingliang@huawei.com>

commit 77f8269606bf95fcb232ee86f6da80886f1dfae8 upstream.

When we do the following test, we got oops in ipmi_msghandler driver
while((1))
do
	service ipmievd restart & service ipmievd restart
done

---------------------------------------------------------------
[  294.230186] Unable to handle kernel paging request at virtual address 0000803fea6ea008
[  294.230188] Mem abort info:
[  294.230190]   ESR = 0x96000004
[  294.230191]   Exception class = DABT (current EL), IL = 32 bits
[  294.230193]   SET = 0, FnV = 0
[  294.230194]   EA = 0, S1PTW = 0
[  294.230195] Data abort info:
[  294.230196]   ISV = 0, ISS = 0x00000004
[  294.230197]   CM = 0, WnR = 0
[  294.230199] user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000a1c1b75a
[  294.230201] [0000803fea6ea008] pgd=0000000000000000
[  294.230204] Internal error: Oops: 96000004 [#1] SMP
[  294.235211] Modules linked in: nls_utf8 isofs rpcrdma ib_iser ib_srpt target_core_mod ib_srp scsi_transport_srp ib_ipoib rdma_ucm ib_umad rdma_cm ib_cm iw_cm dm_mirror dm_region_hash dm_log dm_mod aes_ce_blk crypto_simd cryptd aes_ce_cipher ghash_ce sha2_ce ses sha256_arm64 sha1_ce hibmc_drm hisi_sas_v2_hw enclosure sg hisi_sas_main sbsa_gwdt ip_tables mlx5_ib ib_uverbs marvell ib_core mlx5_core ixgbe ipmi_si mdio hns_dsaf ipmi_devintf ipmi_msghandler hns_enet_drv hns_mdio
[  294.277745] CPU: 3 PID: 0 Comm: swapper/3 Kdump: loaded Not tainted 5.0.0-rc2+ #113
[  294.285511] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.37 11/21/2017
[  294.292835] pstate: 80000005 (Nzcv daif -PAN -UAO)
[  294.297695] pc : __srcu_read_lock+0x38/0x58
[  294.301940] lr : acquire_ipmi_user+0x2c/0x70 [ipmi_msghandler]
[  294.307853] sp : ffff00001001bc80
[  294.311208] x29: ffff00001001bc80 x28: ffff0000117e5000
[  294.316594] x27: 0000000000000000 x26: dead000000000100
[  294.321980] x25: dead000000000200 x24: ffff803f6bd06800
[  294.327366] x23: 0000000000000000 x22: 0000000000000000
[  294.332752] x21: ffff00001001bd04 x20: ffff80df33d19018
[  294.338137] x19: ffff80df33d19018 x18: 0000000000000000
[  294.343523] x17: 0000000000000000 x16: 0000000000000000
[  294.348908] x15: 0000000000000000 x14: 0000000000000002
[  294.354293] x13: 0000000000000000 x12: 0000000000000000
[  294.359679] x11: 0000000000000000 x10: 0000000000100000
[  294.365065] x9 : 0000000000000000 x8 : 0000000000000004
[  294.370451] x7 : 0000000000000000 x6 : ffff80df34558678
[  294.375836] x5 : 000000000000000c x4 : 0000000000000000
[  294.381221] x3 : 0000000000000001 x2 : 0000803fea6ea000
[  294.386607] x1 : 0000803fea6ea008 x0 : 0000000000000001
[  294.391994] Process swapper/3 (pid: 0, stack limit = 0x0000000083087293)
[  294.398791] Call trace:
[  294.401266]  __srcu_read_lock+0x38/0x58
[  294.405154]  acquire_ipmi_user+0x2c/0x70 [ipmi_msghandler]
[  294.410716]  deliver_response+0x80/0xf8 [ipmi_msghandler]
[  294.416189]  deliver_local_response+0x28/0x68 [ipmi_msghandler]
[  294.422193]  handle_one_recv_msg+0x158/0xcf8 [ipmi_msghandler]
[  294.432050]  handle_new_recv_msgs+0xc0/0x210 [ipmi_msghandler]
[  294.441984]  smi_recv_tasklet+0x8c/0x158 [ipmi_msghandler]
[  294.451618]  tasklet_action_common.isra.5+0x88/0x138
[  294.460661]  tasklet_action+0x2c/0x38
[  294.468191]  __do_softirq+0x120/0x2f8
[  294.475561]  irq_exit+0x134/0x140
[  294.482445]  __handle_domain_irq+0x6c/0xc0
[  294.489954]  gic_handle_irq+0xb8/0x178
[  294.497037]  el1_irq+0xb0/0x140
[  294.503381]  arch_cpu_idle+0x34/0x1a8
[  294.510096]  do_idle+0x1d4/0x290
[  294.516322]  cpu_startup_entry+0x28/0x30
[  294.523230]  secondary_start_kernel+0x184/0x1d0
[  294.530657] Code: d538d082 d2800023 8b010c81 8b020021 (c85f7c25)
[  294.539746] ---[ end trace 8a7a880dee570b29 ]---
[  294.547341] Kernel panic - not syncing: Fatal exception in interrupt
[  294.556837] SMP: stopping secondary CPUs
[  294.563996] Kernel Offset: disabled
[  294.570515] CPU features: 0x002,21006008
[  294.577638] Memory Limit: none
[  294.587178] Starting crashdump kernel...
[  294.594314] Bye!

Because the user->release_barrier.rda is freed in ipmi_destroy_user(), but
the refcount is not zero, when acquire_ipmi_user() uses user->release_barrier.rda
in __srcu_read_lock(), it causes oops.
Fix this by calling cleanup_srcu_struct() when the refcount is zero.

Fixes: e86ee2d44b44 ("ipmi: Rework locking and shutdown for hot remove")
Cc: stable@vger.kernel.org # 4.18
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_msghandler.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -1182,6 +1182,7 @@ EXPORT_SYMBOL(ipmi_get_smi_info);
 static void free_user(struct kref *ref)
 {
 	struct ipmi_user *user = container_of(ref, struct ipmi_user, refcount);
+	cleanup_srcu_struct(&user->release_barrier);
 	kfree(user);
 }
 
@@ -1258,7 +1259,6 @@ int ipmi_destroy_user(struct ipmi_user *
 {
 	_ipmi_destroy_user(user);
 
-	cleanup_srcu_struct(&user->release_barrier);
 	kref_put(&user->refcount, free_user);
 
 	return 0;


