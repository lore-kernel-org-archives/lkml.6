Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0707C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8F620861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079825;
	bh=q70DH8/VftqPwg01+y2Rk+IFs7OQuOY0y9LUtELI5cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I1BjgAyGa9etO+ifOSZiznpUrOteFsYrj+78uLIIoQTdwh9NPoXc1kEp5huTDgCUO
	 gkVhtPMvu71fIxr4za9GNaUfD7i8OI4jI64tCPhzsmqrFDCL7H5vqPG/pWlMO6m3Ho
	 zkUiURRlVSqvn0pOEnpANPah1jqOXF4dA8SxDd20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbfAUOKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:10:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730782AbfAUNyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:54:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F7E02084C;
        Mon, 21 Jan 2019 13:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078879;
        bh=q70DH8/VftqPwg01+y2Rk+IFs7OQuOY0y9LUtELI5cE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kaFOhcO4626f04QPFVqe54MIkrgSCZU6JAnL65C390N0wDah/vu3SbxTNvN/mzt8p
         mc31C1NRsLRFia1BcfRz9in/pjLwug5bQ6vdqC3fHAuIKWsqVVbdbjJ3OGy8opGIAU
         2oCI8Vb9TZMETYPSatZMVR9gh7KLY8rZbTuumMiM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 16/51] bonding: update nest level on unlink
Date:   Mon, 21 Jan 2019 14:44:12 +0100
Message-Id: <20190121122455.021801579@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 001e465f09a18857443489a57e74314a3368c805 ]

A network device stack with multiple layers of bonding devices can
trigger a false positive lockdep warning. Adding lockdep nest levels
fixes this. Update the level on both enslave and unlink, to avoid the
following series of events ..

    ip netns add test
    ip netns exec test bash
    ip link set dev lo addr 00:11:22:33:44:55
    ip link set dev lo down

    ip link add dev bond1 type bond
    ip link add dev bond2 type bond

    ip link set dev lo master bond1
    ip link set dev bond1 master bond2

    ip link set dev bond1 nomaster
    ip link set dev bond2 master bond1

.. from still generating a splat:

    [  193.652127] ======================================================
    [  193.658231] WARNING: possible circular locking dependency detected
    [  193.664350] 4.20.0 #8 Not tainted
    [  193.668310] ------------------------------------------------------
    [  193.674417] ip/15577 is trying to acquire lock:
    [  193.678897] 00000000a40e3b69 (&(&bond->stats_lock)->rlock#3/3){+.+.}, at: bond_get_stats+0x58/0x290
    [  193.687851]
    	       but task is already holding lock:
    [  193.693625] 00000000807b9d9f (&(&bond->stats_lock)->rlock#2/2){+.+.}, at: bond_get_stats+0x58/0x290

    [..]

    [  193.851092]        lock_acquire+0xa7/0x190
    [  193.855138]        _raw_spin_lock_nested+0x2d/0x40
    [  193.859878]        bond_get_stats+0x58/0x290
    [  193.864093]        dev_get_stats+0x5a/0xc0
    [  193.868140]        bond_get_stats+0x105/0x290
    [  193.872444]        dev_get_stats+0x5a/0xc0
    [  193.876493]        rtnl_fill_stats+0x40/0x130
    [  193.880797]        rtnl_fill_ifinfo+0x6c5/0xdc0
    [  193.885271]        rtmsg_ifinfo_build_skb+0x86/0xe0
    [  193.890091]        rtnetlink_event+0x5b/0xa0
    [  193.894320]        raw_notifier_call_chain+0x43/0x60
    [  193.899225]        netdev_change_features+0x50/0xa0
    [  193.904044]        bond_compute_features.isra.46+0x1ab/0x270
    [  193.909640]        bond_enslave+0x141d/0x15b0
    [  193.913946]        do_set_master+0x89/0xa0
    [  193.918016]        do_setlink+0x37c/0xda0
    [  193.921980]        __rtnl_newlink+0x499/0x890
    [  193.926281]        rtnl_newlink+0x48/0x70
    [  193.930238]        rtnetlink_rcv_msg+0x171/0x4b0
    [  193.934801]        netlink_rcv_skb+0xd1/0x110
    [  193.939103]        rtnetlink_rcv+0x15/0x20
    [  193.943151]        netlink_unicast+0x3b5/0x520
    [  193.947544]        netlink_sendmsg+0x2fd/0x3f0
    [  193.951942]        sock_sendmsg+0x38/0x50
    [  193.955899]        ___sys_sendmsg+0x2ba/0x2d0
    [  193.960205]        __x64_sys_sendmsg+0xad/0x100
    [  193.964687]        do_syscall_64+0x5a/0x460
    [  193.968823]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: 7e2556e40026 ("bonding: avoid lockdep confusion in bond_get_stats()")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1900,6 +1900,9 @@ static int __bond_release_one(struct net
 	if (!bond_has_slaves(bond)) {
 		bond_set_carrier(bond);
 		eth_hw_addr_random(bond_dev);
+		bond->nest_level = SINGLE_DEPTH_NESTING;
+	} else {
+		bond->nest_level = dev_get_nest_level(bond_dev) + 1;
 	}
 
 	unblock_netpoll_tx();


