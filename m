Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jV86LoL2G1uhdQAAmS7hNA
	; Sat, 09 Jun 2018 15:47:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 940DE608C1; Sat,  9 Jun 2018 15:47:14 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcQ4RUm2"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DC641608B8;
	Sat,  9 Jun 2018 15:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC641608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753698AbeFIPrM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932608AbeFIPdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:33:09 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBF0F204EC;
        Sat,  9 Jun 2018 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558388;
        bh=5U2VKFA6/9ukO2d67iCm9+S05ShXNCFqkOYSemviVrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcQ4RUm251QDQwuvHjRmeYdET+edIDTktA9rty3yf6cn5pNGNfEoUxi3vI6Qby2V4
         LnC28xAJt+gkGJSd4VzcQLXpB7rieuXMazahNfr/1lop5E794lusChSsKOD5Fx9UCK
         Jf/wTdNvTdD2glRGfKby3ZmBMNpyjp+LnORK5DLw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 18/48] mlxsw: spectrum: Forbid creation of VLAN 1 over port/LAG
Date: Sat,  9 Jun 2018 17:29:30 +0200
Message-Id: <20180609145948.830230443@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit 47bf9df2e8201d07c40670e093629f8dfd1b5d9f ]

VLAN 1 is internally used for untagged traffic. Prevent creation of
explicit netdevice for that VLAN, because that currently isn't supported
and leads to the NULL pointer dereference cited below.

Fix by preventing creation of VLAN devices with VID of 1 over mlxsw
devices or LAG devices that involve mlxsw devices.

[  327.175816] ================================================================================
[  327.184544] UBSAN: Undefined behaviour in drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c:200:12
[  327.193667] member access within null pointer of type 'const struct mlxsw_sp_fid'
[  327.201226] CPU: 0 PID: 8983 Comm: ip Not tainted 4.17.0-rc4-petrm_net_ip6gre_headroom-custom-140 #11
[  327.210496] Hardware name: Mellanox Technologies Ltd. "MSN2410-CB2F"/"SA000874", BIOS 4.6.5 03/08/2016
[  327.219872] Call Trace:
[  327.222384]  dump_stack+0xc3/0x12b
[  327.234007]  ubsan_epilogue+0x9/0x49
[  327.237638]  ubsan_type_mismatch_common+0x1f9/0x2d0
[  327.255769]  __ubsan_handle_type_mismatch+0x90/0xa7
[  327.264716]  mlxsw_sp_fid_type+0x35/0x50 [mlxsw_spectrum]
[  327.270255]  mlxsw_sp_port_vlan_router_leave+0x46/0xc0 [mlxsw_spectrum]
[  327.277019]  mlxsw_sp_inetaddr_port_vlan_event+0xe1/0x340 [mlxsw_spectrum]
[  327.315031]  mlxsw_sp_netdevice_vrf_event+0xa8/0x100 [mlxsw_spectrum]
[  327.321626]  mlxsw_sp_netdevice_event+0x276/0x430 [mlxsw_spectrum]
[  327.367863]  notifier_call_chain+0x4c/0x150
[  327.372128]  __netdev_upper_dev_link+0x1b3/0x260
[  327.399450]  vrf_add_slave+0xce/0x170 [vrf]
[  327.403703]  do_setlink+0x658/0x1d70
[  327.508998]  rtnl_newlink+0x908/0xf20
[  327.559128]  rtnetlink_rcv_msg+0x50c/0x720
[  327.571720]  netlink_rcv_skb+0x16a/0x1f0
[  327.583450]  netlink_unicast+0x2ca/0x3e0
[  327.599305]  netlink_sendmsg+0x3e2/0x7f0
[  327.616655]  sock_sendmsg+0x76/0xc0
[  327.620207]  ___sys_sendmsg+0x494/0x5d0
[  327.666117]  __sys_sendmsg+0xc2/0x130
[  327.690953]  do_syscall_64+0x66/0x370
[  327.694677]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  327.699782] RIP: 0033:0x7f4c2f3f8037
[  327.703393] RSP: 002b:00007ffe8c389708 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[  327.711035] RAX: ffffffffffffffda RBX: 000000005b03f53e RCX: 00007f4c2f3f8037
[  327.718229] RDX: 0000000000000000 RSI: 00007ffe8c389760 RDI: 0000000000000003
[  327.725431] RBP: 00007ffe8c389760 R08: 0000000000000000 R09: 00007f4c2f443630
[  327.732632] R10: 00000000000005eb R11: 0000000000000246 R12: 0000000000000000
[  327.739833] R13: 00000000006774e0 R14: 00007ffe8c3897e8 R15: 0000000000000000
[  327.747096] ================================================================================

Fixes: 9589a7b5d7d9 ("mlxsw: spectrum: Handle VLAN devices linking / unlinking")
Suggested-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4870,6 +4870,11 @@ static int mlxsw_sp_netdevice_port_upper
 				       "spectrum: Can not put a VLAN on an OVS port");
 			return -EINVAL;
 		}
+		if (is_vlan_dev(upper_dev) &&
+		    vlan_dev_vlan_id(upper_dev) == 1) {
+			NL_SET_ERR_MSG_MOD(extack, "Creating a VLAN device with VID 1 is unsupported: VLAN 1 carries untagged traffic");
+			return -EINVAL;
+		}
 		break;
 	case NETDEV_CHANGEUPPER:
 		upper_dev = info->upper_dev;
