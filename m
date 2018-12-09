Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D161DC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2B020661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2B020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeLIWAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:00:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35992 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbeLIVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:34 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72x-0002io-E2; Sun, 09 Dec 2018 21:55:31 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72j-0003bI-2f; Sun, 09 Dec 2018 21:55:17 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Michael Bringmann" <mwb@linux.vnet.ibm.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.877367211@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 261/328] powerpc/pseries: Fix unitialized timer reset
 on migration
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[bwh: Backported to 3.16: Also remove direct assignment to
 topology_timer.expires, done upstream as part of commit df7e828c1b69
 "timer: Remove init_timer_deferrable() in favor of timer_setup()"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/mm/numa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1654,8 +1654,8 @@ static struct timer_list topology_timer
 static void reset_topology_timer(void)
 {
 	topology_timer.data = 0;
-	topology_timer.expires = jiffies + 60 * HZ;
-	mod_timer(&topology_timer, topology_timer.expires);
+	if (vphn_enabled)
+		mod_timer(&topology_timer, jiffies + 60 * HZ);
 }
 
 #ifdef CONFIG_SMP

