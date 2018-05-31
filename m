Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeEaEKj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:10:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47719 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750949AbeEaEKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:10:34 -0400
X-ME-Proxy: <xmx:t3UPW75x6Z5Zyx32_1rWZhNyzLrmSsI-lIO6mfYA_OhRqEpOqfP9uA>
X-ME-Proxy: <xmx:t3UPW70VbE6BIr4tzTRwOahMB_YMtNfc-qe7gO1j9ptHdIuIoqpr6Q>
X-ME-Proxy: <xmx:t3UPWxbgjlF3JTIHSiNS09YuEm6EBnMIkRgq_dszdWykU4j06ty9nQ>
X-ME-Proxy: <xmx:t3UPWwnqIJpvBsOB7A8Y_d8r76ZpoNGM7zILbA3t1PqDo86ntiszXQ>
X-ME-Proxy: <xmx:t3UPW52qM9bW-24B_EhDfq8piJQXgf-U9lQWCcLFvrSp8a_ezYtcDA>
X-ME-Proxy: <xmx:t3UPW6XtvvtTRKhX0QQWgLjF-pKhMHFVpRUq-mOnhUCyvqNEu04g3w>
X-ME-Sender: <xms:t3UPWybzy2QSDsXz7xRROcfq9kOag0o7V18D6YWG37lGicMTi9TVzw>
From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
To: netdev@vger.kernel.org
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: [PATCH net] net/ncsi: Fix array size in dumpit handler
Date: Thu, 31 May 2018 14:10:04 +1000
Message-Id: <20180531041004.20172-1-sam@mendozajonas.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_CC_STACKPROTECTOR enabled the kernel panics as below when
parsing a NCSI_CMD_PKG_INFO command:

[  150.149711] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: 805cff08
[  150.149711]
[  150.159919] CPU: 0 PID: 1301 Comm: ncsi-netlink Not tainted 4.13.16-468cbec6d2c91239332cb91b1f0a73aafcb6f0c6 #1
[  150.170004] Hardware name: Generic DT based system
[  150.174852] [<80109930>] (unwind_backtrace) from [<80106bc4>] (show_stack+0x20/0x24)
[  150.182641] [<80106bc4>] (show_stack) from [<805d36e4>] (dump_stack+0x20/0x28)
[  150.189888] [<805d36e4>] (dump_stack) from [<801163ac>] (panic+0xdc/0x278)
[  150.196780] [<801163ac>] (panic) from [<801162cc>] (__stack_chk_fail+0x20/0x24)
[  150.204111] [<801162cc>] (__stack_chk_fail) from [<805cff08>] (ncsi_pkg_info_all_nl+0x244/0x258)
[  150.212912] [<805cff08>] (ncsi_pkg_info_all_nl) from [<804f939c>] (genl_lock_dumpit+0x3c/0x54)
[  150.221535] [<804f939c>] (genl_lock_dumpit) from [<804f873c>] (netlink_dump+0xf8/0x284)
[  150.229550] [<804f873c>] (netlink_dump) from [<804f8d44>] (__netlink_dump_start+0x124/0x17c)
[  150.237992] [<804f8d44>] (__netlink_dump_start) from [<804f9880>] (genl_rcv_msg+0x1c8/0x3d4)
[  150.246440] [<804f9880>] (genl_rcv_msg) from [<804f9174>] (netlink_rcv_skb+0xd8/0x134)
[  150.254361] [<804f9174>] (netlink_rcv_skb) from [<804f96a4>] (genl_rcv+0x30/0x44)
[  150.261850] [<804f96a4>] (genl_rcv) from [<804f7790>] (netlink_unicast+0x198/0x234)
[  150.269511] [<804f7790>] (netlink_unicast) from [<804f7ffc>] (netlink_sendmsg+0x368/0x3b0)
[  150.277783] [<804f7ffc>] (netlink_sendmsg) from [<804abea4>] (sock_sendmsg+0x24/0x34)
[  150.285625] [<804abea4>] (sock_sendmsg) from [<804ac1dc>] (___sys_sendmsg+0x244/0x260)
[  150.293556] [<804ac1dc>] (___sys_sendmsg) from [<804ad98c>] (__sys_sendmsg+0x5c/0x9c)
[  150.301400] [<804ad98c>] (__sys_sendmsg) from [<804ad9e4>] (SyS_sendmsg+0x18/0x1c)
[  150.308984] [<804ad9e4>] (SyS_sendmsg) from [<80102640>] (ret_fast_syscall+0x0/0x3c)
[  150.316743] ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: 805cff08

This turns out to be because the attrs array in ncsi_pkg_info_all_nl()
is initialised to a length of NCSI_ATTR_MAX which is the maximum
attribute number, not the number of attributes.

Fixes: 955dc68cb9b2 ("net/ncsi: Add generic netlink family")
Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
---
 net/ncsi/ncsi-netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 8d7e849d4825..41cede4041d3 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -215,7 +215,7 @@ static int ncsi_pkg_info_nl(struct sk_buff *msg, struct genl_info *info)
 static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
 				struct netlink_callback *cb)
 {
-	struct nlattr *attrs[NCSI_ATTR_MAX];
+	struct nlattr *attrs[NCSI_ATTR_MAX + 1];
 	struct ncsi_package *np, *package;
 	struct ncsi_dev_priv *ndp;
 	unsigned int package_id;
-- 
2.17.0
