Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249DEC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9F520645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9F520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbeJNXiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:38:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35967 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727563AbeJNXLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:52 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLf-0004cI-Vg; Sun, 14 Oct 2018 16:30:32 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0000kf-3b; Sun, 14 Oct 2018 16:30:27 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Guillaume Nault" <g.nault@alphalink.fr>,
        "Sedat Dilek" <sedat.dilek@gmail.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.654497342@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 350/366] ppp: fix lockdep splat in ppp_dev_uninit()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>

commit 58a89ecaca53736aa465170530acea4f8be34ab4 upstream.

ppp_dev_uninit() locks all_ppp_mutex while under rtnl mutex protection.
ppp_create_interface() must then lock these mutexes in that same order
to avoid possible deadlock.

[  120.880011] ======================================================
[  120.880011] [ INFO: possible circular locking dependency detected ]
[  120.880011] 4.2.0 #1 Not tainted
[  120.880011] -------------------------------------------------------
[  120.880011] ppp-apitest/15827 is trying to acquire lock:
[  120.880011]  (&pn->all_ppp_mutex){+.+.+.}, at: [<ffffffffa0145f56>] ppp_dev_uninit+0x64/0xb0 [ppp_generic]
[  120.880011]
[  120.880011] but task is already holding lock:
[  120.880011]  (rtnl_mutex){+.+.+.}, at: [<ffffffff812e4255>] rtnl_lock+0x12/0x14
[  120.880011]
[  120.880011] which lock already depends on the new lock.
[  120.880011]
[  120.880011]
[  120.880011] the existing dependency chain (in reverse order) is:
[  120.880011]
[  120.880011] -> #1 (rtnl_mutex){+.+.+.}:
[  120.880011]        [<ffffffff81073a6f>] lock_acquire+0xcf/0x10e
[  120.880011]        [<ffffffff813ab18a>] mutex_lock_nested+0x56/0x341
[  120.880011]        [<ffffffff812e4255>] rtnl_lock+0x12/0x14
[  120.880011]        [<ffffffff812d9d94>] register_netdev+0x11/0x27
[  120.880011]        [<ffffffffa0147b17>] ppp_ioctl+0x289/0xc98 [ppp_generic]
[  120.880011]        [<ffffffff8113b367>] do_vfs_ioctl+0x4ea/0x532
[  120.880011]        [<ffffffff8113b3fd>] SyS_ioctl+0x4e/0x7d
[  120.880011]        [<ffffffff813ad7d7>] entry_SYSCALL_64_fastpath+0x12/0x6f
[  120.880011]
[  120.880011] -> #0 (&pn->all_ppp_mutex){+.+.+.}:
[  120.880011]        [<ffffffff8107334e>] __lock_acquire+0xb07/0xe76
[  120.880011]        [<ffffffff81073a6f>] lock_acquire+0xcf/0x10e
[  120.880011]        [<ffffffff813ab18a>] mutex_lock_nested+0x56/0x341
[  120.880011]        [<ffffffffa0145f56>] ppp_dev_uninit+0x64/0xb0 [ppp_generic]
[  120.880011]        [<ffffffff812d5263>] rollback_registered_many+0x19e/0x252
[  120.880011]        [<ffffffff812d5381>] rollback_registered+0x29/0x38
[  120.880011]        [<ffffffff812d53fa>] unregister_netdevice_queue+0x6a/0x77
[  120.880011]        [<ffffffffa0146a94>] ppp_release+0x42/0x79 [ppp_generic]
[  120.880011]        [<ffffffff8112d9f6>] __fput+0xec/0x192
[  120.880011]        [<ffffffff8112dacc>] ____fput+0x9/0xb
[  120.880011]        [<ffffffff8105447a>] task_work_run+0x66/0x80
[  120.880011]        [<ffffffff81001801>] prepare_exit_to_usermode+0x8c/0xa7
[  120.880011]        [<ffffffff81001900>] syscall_return_slowpath+0xe4/0x104
[  120.880011]        [<ffffffff813ad931>] int_ret_from_sys_call+0x25/0x9f
[  120.880011]
[  120.880011] other info that might help us debug this:
[  120.880011]
[  120.880011]  Possible unsafe locking scenario:
[  120.880011]
[  120.880011]        CPU0                    CPU1
[  120.880011]        ----                    ----
[  120.880011]   lock(rtnl_mutex);
[  120.880011]                                lock(&pn->all_ppp_mutex);
[  120.880011]                                lock(rtnl_mutex);
[  120.880011]   lock(&pn->all_ppp_mutex);
[  120.880011]
[  120.880011]  *** DEADLOCK ***

Fixes: 8cb775bc0a34 ("ppp: fix device unregistration upon netns deletion")
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ppp/ppp_generic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -2736,6 +2736,7 @@ static struct ppp *ppp_create_interface(
 	 */
 	dev_net_set(dev, net);
 
+	rtnl_lock();
 	mutex_lock(&pn->all_ppp_mutex);
 
 	if (unit < 0) {
@@ -2766,7 +2767,7 @@ static struct ppp *ppp_create_interface(
 	ppp->file.index = unit;
 	sprintf(dev->name, "ppp%d", unit);
 
-	ret = register_netdev(dev);
+	ret = register_netdevice(dev);
 	if (ret != 0) {
 		unit_put(&pn->units_idr, unit);
 		netdev_err(ppp->dev, "PPP: couldn't register device %s (%d)\n",
@@ -2778,6 +2779,7 @@ static struct ppp *ppp_create_interface(
 
 	atomic_inc(&ppp_unit_count);
 	mutex_unlock(&pn->all_ppp_mutex);
+	rtnl_unlock();
 
 	*retp = 0;
 	return ppp;

