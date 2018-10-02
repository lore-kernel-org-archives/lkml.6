Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58FDC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75BC2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75BC2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbeJBUOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34074 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbeJBUOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:41 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 80C1ABF0;
        Tue,  2 Oct 2018 13:31:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.18 228/228] powerpc/pseries: Fix unitialized timer reset on migration
Date:   Tue,  2 Oct 2018 06:25:25 -0700
Message-Id: <20181002132512.758000711@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Michael Bringmann <mwb@linux.vnet.ibm.com>

commit 8604895a34d92f5e186ceb931b0d1b384030ea3d upstream.

After migration of a powerpc LPAR, the kernel executes code to
update the system state to reflect new platform characteristics.

Such changes include modifications to device tree properties provided
to the system by PHYP. Property notifications received by the
post_mobility_fixup() code are passed along to the kernel in general
through a call to of_update_property() which in turn passes such
events back to all modules through entries like the '.notifier_call'
function within the NUMA module.

When the NUMA module updates its state, it resets its event timer. If
this occurs after a previous call to stop_topology_update() or on a
system without VPHN enabled, the code runs into an unitialized timer
structure and crashes. This patch adds a safety check along this path
toward the problem code.

An example crash log is as follows.

  ibmvscsi 30000081: Re-enabling adapter!
  ------------[ cut here ]------------
  kernel BUG at kernel/time/timer.c:958!
  Oops: Exception in kernel mode, sig: 5 [#1]
  LE SMP NR_CPUS=2048 NUMA pSeries
  Modules linked in: nfsv3 nfs_acl nfs tcp_diag udp_diag inet_diag lockd unix_diag af_packet_diag netlink_diag grace fscache sunrpc xts vmx_crypto pseries_rng sg binfmt_misc ip_tables xfs libcrc32c sd_mod ibmvscsi ibmveth scsi_transport_srp dm_mirror dm_region_hash dm_log dm_mod
  CPU: 11 PID: 3067 Comm: drmgr Not tainted 4.17.0+ #179
  ...
  NIP mod_timer+0x4c/0x400
  LR  reset_topology_timer+0x40/0x60
  Call Trace:
    0xc0000003f9407830 (unreliable)
    reset_topology_timer+0x40/0x60
    dt_update_callback+0x100/0x120
    notifier_call_chain+0x90/0x100
    __blocking_notifier_call_chain+0x60/0x90
    of_property_notify+0x90/0xd0
    of_update_property+0x104/0x150
    update_dt_property+0xdc/0x1f0
    pseries_devicetree_update+0x2d0/0x510
    post_mobility_fixup+0x7c/0xf0
    migration_store+0xa4/0xc0
    kobj_attr_store+0x30/0x60
    sysfs_kf_write+0x64/0xa0
    kernfs_fop_write+0x16c/0x240
    __vfs_write+0x40/0x200
    vfs_write+0xc8/0x240
    ksys_write+0x5c/0x100
    system_call+0x58/0x6c

Fixes: 5d88aa85c00b ("powerpc/pseries: Update CPU maps when device tree is updated")
Cc: stable@vger.kernel.org # v3.10+
Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/numa.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1452,7 +1452,8 @@ static struct timer_list topology_timer;
 
 static void reset_topology_timer(void)
 {
-	mod_timer(&topology_timer, jiffies + topology_timer_secs * HZ);
+	if (vphn_enabled)
+		mod_timer(&topology_timer, jiffies + topology_timer_secs * HZ);
 }
 
 #ifdef CONFIG_SMP


