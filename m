Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05099ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A5F20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHKUxFsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A5F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbeKIHha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:55750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbeKIHh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:28 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F138220892;
        Thu,  8 Nov 2018 21:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714400;
        bh=wD6hG8fg5ofn4jNYV25c+VuTV3Dlxq1WJXD90xgfqbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHKUxFsXPGgjHMN2kg7wp0ckXaT+iresYYF5QQxOInMCz5CQMB7aXSfUnB/56fwH7
         v/LElBffE0oTz2fB2Gd6daLkUihj1nefK11xe9NFVLT68KbqELe9oRUUA0Cr7pKJP/
         xCoV56xknu7TBmNJuhKnQK/YEonLDfte+JNz7tFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lance Richardson <lrichard@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 060/114] vti6: flush x-netns xfrm cache when vti interface is removed
Date:   Thu,  8 Nov 2018 13:51:15 -0800
Message-Id: <20181108215106.521100197@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7f92083eb58f85ea114d97f65fcbe22be5b0468d ]

This is the same fix than commit a5d0dc810abf ("vti: flush x-netns xfrm
cache when vti interface is removed")

This patch fixes a refcnt problem when a x-netns vti6 interface is removed:
unregister_netdevice: waiting for vti6_test to become free. Usage count = 1

Here is a script to reproduce the problem:

ip link set dev ntfp2 up
ip addr add dev ntfp2 2001::1/64
ip link add vti6_test type vti6 local 2001::1 remote 2001::2 key 1
ip netns add secure
ip link set vti6_test netns secure
ip netns exec secure ip link set vti6_test up
ip netns exec secure ip link s lo up
ip netns exec secure ip addr add dev vti6_test 2003::1/64
ip -6 xfrm policy add dir out tmpl src 2001::1 dst 2001::2 proto esp \
	   mode tunnel mark 1
ip -6 xfrm policy add dir in tmpl src 2001::2 dst 2001::1 proto esp \
	   mode tunnel mark 1
ip xfrm state add src 2001::1 dst 2001::2 proto esp spi 1 mode tunnel \
	   enc des3_ede 0x112233445566778811223344556677881122334455667788 mark 1
ip xfrm state add src 2001::2 dst 2001::1 proto esp spi 1 mode tunnel \
	   enc des3_ede 0x112233445566778811223344556677881122334455667788 mark 1
ip netns exec secure  ping6 -c 4 2003::2
ip netns del secure

CC: Lance Richardson <lrichard@redhat.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Acked-by: Lance Richardson <lrichard@redhat.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_vti.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 60d4052d97a6..51da5987952c 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1140,6 +1140,33 @@ static struct xfrm6_protocol vti_ipcomp6_protocol __read_mostly = {
 	.priority	=	100,
 };
 
+static bool is_vti6_tunnel(const struct net_device *dev)
+{
+	return dev->netdev_ops == &vti6_netdev_ops;
+}
+
+static int vti6_device_event(struct notifier_block *unused,
+			     unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct ip6_tnl *t = netdev_priv(dev);
+
+	if (!is_vti6_tunnel(dev))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_DOWN:
+		if (!net_eq(t->net, dev_net(dev)))
+			xfrm_garbage_collect(t->net);
+		break;
+	}
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block vti6_notifier_block __read_mostly = {
+	.notifier_call = vti6_device_event,
+};
+
 /**
  * vti6_tunnel_init - register protocol and reserve needed resources
  *
@@ -1150,6 +1177,8 @@ static int __init vti6_tunnel_init(void)
 	const char *msg;
 	int err;
 
+	register_netdevice_notifier(&vti6_notifier_block);
+
 	msg = "tunnel device";
 	err = register_pernet_device(&vti6_net_ops);
 	if (err < 0)
@@ -1182,6 +1211,7 @@ xfrm_proto_ah_failed:
 xfrm_proto_esp_failed:
 	unregister_pernet_device(&vti6_net_ops);
 pernet_dev_failed:
+	unregister_netdevice_notifier(&vti6_notifier_block);
 	pr_err("vti6 init: failed to register %s\n", msg);
 	return err;
 }
@@ -1196,6 +1226,7 @@ static void __exit vti6_tunnel_cleanup(void)
 	xfrm6_protocol_deregister(&vti_ah6_protocol, IPPROTO_AH);
 	xfrm6_protocol_deregister(&vti_esp6_protocol, IPPROTO_ESP);
 	unregister_pernet_device(&vti6_net_ops);
+	unregister_netdevice_notifier(&vti6_notifier_block);
 }
 
 module_init(vti6_tunnel_init);
-- 
2.17.1



