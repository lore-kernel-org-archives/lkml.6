Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD893C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8723120854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8723120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbeKLGJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:09:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53478 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726652AbeKLGJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:09:53 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsy-0000l9-77; Sun, 11 Nov 2018 19:59:08 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsU-0001d4-3p; Sun, 11 Nov 2018 19:58:38 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Steffen Klassert" <steffen.klassert@secunet.com>,
        "Tommi Rantala" <tommi.t.rantala@nokia.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.928015363@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 192/366] xfrm: fix missing dst_release() after policy
 blocking lbcast and multicast
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tommi Rantala <tommi.t.rantala@nokia.com>

commit 8cc88773855f988d6a3bbf102bbd9dd9c828eb81 upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/xfrm/xfrm_policy.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2176,6 +2176,9 @@ struct dst_entry *xfrm_lookup_route(stru
 	if (IS_ERR(dst) && PTR_ERR(dst) == -EREMOTE)
 		return make_blackhole(net, dst_orig->ops->family, dst_orig);
 
+	if (IS_ERR(dst))
+		dst_release(dst_orig);
+
 	return dst;
 }
 EXPORT_SYMBOL(xfrm_lookup_route);

