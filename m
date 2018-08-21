Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D20C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5608221781
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5608221781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeHUJmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:42:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54830 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeHUJmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:42:03 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E3FFB8A5;
        Tue, 21 Aug 2018 06:23:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 32/35] ip_vti: fix a null pointer deferrence when create vti fallback tunnel
Date:   Tue, 21 Aug 2018 08:20:58 +0200
Message-Id: <20180821055021.350226830@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055019.954904905@linuxfoundation.org>
References: <20180821055019.954904905@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

[ Upstream commit cd1aa9c2c665cafbd05b83507d3f1096f3912aa4 ]

After set fb_tunnels_only_for_init_net to 1, the itn->fb_tunnel_dev will
be NULL and will cause following crash:

[ 2742.849298] BUG: unable to handle kernel NULL pointer dereference at 0000000000000941
[ 2742.851380] PGD 800000042c21a067 P4D 800000042c21a067 PUD 42aaed067 PMD 0
[ 2742.852818] Oops: 0002 [#1] SMP PTI
[ 2742.853570] CPU: 7 PID: 2484 Comm: unshare Kdump: loaded Not tainted 4.18.0-rc8+ #2
[ 2742.855163] Hardware name: Fedora Project OpenStack Nova, BIOS seabios-1.7.5-11.el7 04/01/2014
[ 2742.856970] RIP: 0010:vti_init_net+0x3a/0x50 [ip_vti]
[ 2742.858034] Code: 90 83 c0 48 c7 c2 20 a1 83 c0 48 89 fb e8 6e 3b f6 ff 85 c0 75 22 8b 0d f4 19 00 00 48 8b 93 00 14 00 00 48 8b 14 ca 48 8b 12 <c6> 82 41 09 00 00 04 c6 82 38 09 00 00 45 5b c3 66 0f 1f 44 00 00
[ 2742.861940] RSP: 0018:ffff9be28207fde0 EFLAGS: 00010246
[ 2742.863044] RAX: 0000000000000000 RBX: ffff8a71ebed4980 RCX: 0000000000000013
[ 2742.864540] RDX: 0000000000000000 RSI: 0000000000000013 RDI: ffff8a71ebed4980
[ 2742.866020] RBP: ffff8a71ea717000 R08: ffffffffc083903c R09: ffff8a71ea717000
[ 2742.867505] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a71ebed4980
[ 2742.868987] R13: 0000000000000013 R14: ffff8a71ea5b49c0 R15: 0000000000000000
[ 2742.870473] FS:  00007f02266c9740(0000) GS:ffff8a71ffdc0000(0000) knlGS:0000000000000000
[ 2742.872143] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2742.873340] CR2: 0000000000000941 CR3: 000000042bc20006 CR4: 00000000001606e0
[ 2742.874821] Call Trace:
[ 2742.875358]  ops_init+0x38/0xf0
[ 2742.876078]  setup_net+0xd9/0x1f0
[ 2742.876789]  copy_net_ns+0xb7/0x130
[ 2742.877538]  create_new_namespaces+0x11a/0x1d0
[ 2742.878525]  unshare_nsproxy_namespaces+0x55/0xa0
[ 2742.879526]  ksys_unshare+0x1a7/0x330
[ 2742.880313]  __x64_sys_unshare+0xe/0x20
[ 2742.881131]  do_syscall_64+0x5b/0x180
[ 2742.881933]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reproduce:
echo 1 > /proc/sys/net/core/fb_tunnels_only_for_init_net
modprobe ip_vti
unshare -n

Fixes: 79134e6ce2c9 ("net: do not create fallback tunnels for non-default namespaces")
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_vti.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -438,7 +438,8 @@ static int __net_init vti_init_net(struc
 	if (err)
 		return err;
 	itn = net_generic(net, vti_net_id);
-	vti_fb_tunnel_init(itn->fb_tunnel_dev);
+	if (itn->fb_tunnel_dev)
+		vti_fb_tunnel_init(itn->fb_tunnel_dev);
 	return 0;
 }
 


