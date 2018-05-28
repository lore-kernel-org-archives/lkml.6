Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939102AbeE1NLB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163795AbeE1KvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:51:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Kirjanov <kda@linux-powerpc.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 226/496] fsl/fman: avoid sleeping in atomic context while adding an address
Date: Mon, 28 May 2018 12:00:11 +0200
Message-Id: <20180528100329.433416460@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denis Kirjanov <kda@linux-powerpc.org>

[ Upstream commit 803fafbe0cd522fa6b9e41ca3b96cfb2e2a2222d ]

__dev_mc_add grabs an adress spinlock so use
atomic context in kmalloc.

/ # ifconfig eth0 inet 192.168.0.111
[   89.331622] BUG: sleeping function called from invalid context at mm/slab.h:420
[   89.339002] in_atomic(): 1, irqs_disabled(): 0, pid: 1035, name: ifconfig
[   89.345799] 2 locks held by ifconfig/1035:
[   89.349908]  #0:  (rtnl_mutex){+.+.}, at: [<(ptrval)>] devinet_ioctl+0xc0/0x8a0
[   89.357258]  #1:  (_xmit_ETHER){+...}, at: [<(ptrval)>] __dev_mc_add+0x28/0x80
[   89.364520] CPU: 1 PID: 1035 Comm: ifconfig Not tainted 4.16.0-rc3-dirty #8
[   89.371464] Call Trace:
[   89.373908] [e959db60] [c066f948] dump_stack+0xa4/0xfc (unreliable)
[   89.380177] [e959db80] [c00671d8] ___might_sleep+0x248/0x280
[   89.385833] [e959dba0] [c01aec34] kmem_cache_alloc_trace+0x174/0x320
[   89.392179] [e959dbd0] [c04ab920] dtsec_add_hash_mac_address+0x130/0x240
[   89.398874] [e959dc00] [c04a9d74] set_multi+0x174/0x1b0
[   89.404093] [e959dc30] [c04afb68] dpaa_set_rx_mode+0x68/0xe0
[   89.409745] [e959dc40] [c057baf8] __dev_mc_add+0x58/0x80
[   89.415052] [e959dc60] [c060fd64] igmp_group_added+0x164/0x190
[   89.420878] [e959dca0] [c060ffa8] ip_mc_inc_group+0x218/0x460
[   89.426617] [e959dce0] [c06120fc] ip_mc_up+0x3c/0x190
[   89.431662] [e959dd10] [c0607270] inetdev_event+0x250/0x620
[   89.437227] [e959dd50] [c005f190] notifier_call_chain+0x80/0xf0
[   89.443138] [e959dd80] [c0573a74] __dev_notify_flags+0x54/0xf0
[   89.448964] [e959dda0] [c05743f8] dev_change_flags+0x48/0x60
[   89.454615] [e959ddc0] [c0606744] devinet_ioctl+0x544/0x8a0
[   89.460180] [e959de10] [c060987c] inet_ioctl+0x9c/0x1f0
[   89.465400] [e959de80] [c05479a8] sock_ioctl+0x168/0x460
[   89.470708] [e959ded0] [c01cf3ec] do_vfs_ioctl+0xac/0x8c0
[   89.476099] [e959df20] [c01cfc40] SyS_ioctl+0x40/0xc0
[   89.481147] [e959df40] [c0011318] ret_from_syscall+0x0/0x3c
[   89.486715] --- interrupt: c01 at 0x1006943c
[   89.486715]     LR = 0x100c45ec

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fman/fman_dtsec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
@@ -1100,7 +1100,7 @@ int dtsec_add_hash_mac_address(struct fm
 	set_bucket(dtsec->regs, bucket, true);
 
 	/* Create element to be added to the driver hash table */
-	hash_entry = kmalloc(sizeof(*hash_entry), GFP_KERNEL);
+	hash_entry = kmalloc(sizeof(*hash_entry), GFP_ATOMIC);
 	if (!hash_entry)
 		return -ENOMEM;
 	hash_entry->addr = addr;
