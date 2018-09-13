Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC3C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E9420881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E9420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbeIMTBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:01:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730390AbeIMTBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:01:34 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A9917D1A;
        Thu, 13 Sep 2018 13:51:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 031/197] ip6_vti: fix a null pointer deference when destroy vti6 tunnel
Date:   Thu, 13 Sep 2018 15:29:40 +0200
Message-Id: <20180913131842.809036737@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

[ Upstream commit 9c86336c15db1c48cbaddff56caf2be0a930e991 ]

If load ip6_vti module and create a network namespace when set
fb_tunnels_only_for_init_net to 1, then exit the namespace will
cause following crash:

[ 6601.677036] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[ 6601.679057] PGD 8000000425eca067 P4D 8000000425eca067 PUD 424292067 PMD 0
[ 6601.680483] Oops: 0000 [#1] SMP PTI
[ 6601.681223] CPU: 7 PID: 93 Comm: kworker/u16:1 Kdump: loaded Tainted: G            E     4.18.0+ #3
[ 6601.683153] Hardware name: Fedora Project OpenStack Nova, BIOS seabios-1.7.5-11.el7 04/01/2014
[ 6601.684919] Workqueue: netns cleanup_net
[ 6601.685742] RIP: 0010:vti6_exit_batch_net+0x87/0xd0 [ip6_vti]
[ 6601.686932] Code: 7b 08 48 89 e6 e8 b9 ea d3 dd 48 8b 1b 48 85 db 75 ec 48 83 c5 08 48 81 fd 00 01 00 00 75 d5 49 8b 84 24 08 01 00 00 48 89 e6 <48> 8b 78 08 e8 90 ea d3 dd 49 8b 45 28 49 39 c6 4c 8d 68 d8 75 a1
[ 6601.690735] RSP: 0018:ffffa897c2737de0 EFLAGS: 00010246
[ 6601.691846] RAX: 0000000000000000 RBX: 0000000000000000 RCX: dead000000000200
[ 6601.693324] RDX: 0000000000000015 RSI: ffffa897c2737de0 RDI: ffffffff9f2ea9e0
[ 6601.694824] RBP: 0000000000000100 R08: 0000000000000000 R09: 0000000000000000
[ 6601.696314] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8dc323c07e00
[ 6601.697812] R13: ffff8dc324a63100 R14: ffffa897c2737e30 R15: ffffa897c2737e30
[ 6601.699345] FS:  0000000000000000(0000) GS:ffff8dc33fdc0000(0000) knlGS:0000000000000000
[ 6601.701068] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6601.702282] CR2: 0000000000000008 CR3: 0000000424966002 CR4: 00000000001606e0
[ 6601.703791] Call Trace:
[ 6601.704329]  cleanup_net+0x1b4/0x2c0
[ 6601.705268]  process_one_work+0x16c/0x370
[ 6601.706145]  worker_thread+0x49/0x3e0
[ 6601.706942]  kthread+0xf8/0x130
[ 6601.707626]  ? rescuer_thread+0x340/0x340
[ 6601.708476]  ? kthread_bind+0x10/0x10
[ 6601.709266]  ret_from_fork+0x35/0x40

Reproduce:
modprobe ip6_vti
echo 1 > /proc/sys/net/core/fb_tunnels_only_for_init_net
unshare -n
exit

This because ip6n->tnls_wc[0] point to fallback device in default, but
in non-default namespace, ip6n->tnls_wc[0] will be NULL, so add the NULL
check comparatively.

Fixes: e2948e5af8ee ("ip6_vti: fix creating fallback tunnel device for vti6")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_vti.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1102,7 +1102,8 @@ static void __net_exit vti6_destroy_tunn
 	}
 
 	t = rtnl_dereference(ip6n->tnls_wc[0]);
-	unregister_netdevice_queue(t->dev, list);
+	if (t)
+		unregister_netdevice_queue(t->dev, list);
 }
 
 static int __net_init vti6_init_net(struct net *net)


