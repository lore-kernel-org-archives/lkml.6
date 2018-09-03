Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1305C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1ED020779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1ED020779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeICVLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:11:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36224 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbeICVLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:11:54 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DED60CEE;
        Mon,  3 Sep 2018 16:50:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tommi Rantala <tommi.t.rantala@nokia.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 03/56] xfrm: fix missing dst_release() after policy blocking lbcast and multicast
Date:   Mon,  3 Sep 2018 18:48:53 +0200
Message-Id: <20180903164924.239813229@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tommi Rantala <tommi.t.rantala@nokia.com>

[ Upstream commit 8cc88773855f988d6a3bbf102bbd9dd9c828eb81 ]

Fix missing dst_release() when local broadcast or multicast traffic is
xfrm policy blocked.

For IPv4 this results to dst leak: ip_route_output_flow() allocates
dst_entry via __ip_route_output_key() and passes it to
xfrm_lookup_route(). xfrm_lookup returns ERR_PTR(-EPERM) that is
propagated. The dst that was allocated is never released.

IPv4 local broadcast testcase:
 ping -b 192.168.1.255 &
 sleep 1
 ip xfrm policy add src 0.0.0.0/0 dst 192.168.1.255/32 dir out action block

IPv4 multicast testcase:
 ping 224.0.0.1 &
 sleep 1
 ip xfrm policy add src 0.0.0.0/0 dst 224.0.0.1/32 dir out action block

For IPv6 the missing dst_release() causes trouble e.g. when used in netns:
 ip netns add TEST
 ip netns exec TEST ip link set lo up
 ip link add dummy0 type dummy
 ip link set dev dummy0 netns TEST
 ip netns exec TEST ip addr add fd00::1111 dev dummy0
 ip netns exec TEST ip link set dummy0 up
 ip netns exec TEST ping -6 -c 5 ff02::1%dummy0 &
 sleep 1
 ip netns exec TEST ip xfrm policy add src ::/0 dst ff02::1 dir out action block
 wait
 ip netns del TEST

After netns deletion we see:
[  258.239097] unregister_netdevice: waiting for lo to become free. Usage count = 2
[  268.279061] unregister_netdevice: waiting for lo to become free. Usage count = 2
[  278.367018] unregister_netdevice: waiting for lo to become free. Usage count = 2
[  288.375259] unregister_netdevice: waiting for lo to become free. Usage count = 2

Fixes: ac37e2515c1a ("xfrm: release dst_orig in case of error in xfrm_lookup()")
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_policy.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2291,6 +2291,9 @@ struct dst_entry *xfrm_lookup_route(stru
 	if (IS_ERR(dst) && PTR_ERR(dst) == -EREMOTE)
 		return make_blackhole(net, dst_orig->ops->family, dst_orig);
 
+	if (IS_ERR(dst))
+		dst_release(dst_orig);
+
 	return dst;
 }
 EXPORT_SYMBOL(xfrm_lookup_route);


