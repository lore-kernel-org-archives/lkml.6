Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3036C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB86214D9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8CGjNLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB86214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbeLDKzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:55:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbeLDKzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:55:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B5B8214C1;
        Tue,  4 Dec 2018 10:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543920944;
        bh=R0mJtqZce4o6Y/HgqXNN/jURM/VpDgiINhL/DoQCFwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8CGjNLBqLgD1lcoBZz1jgxUv6H7oBfWTh4WYvm7byFE76YHUUlIF5wI/tuXxyamN
         PzR2MBmKVFONQqedtjPXJr+MSU4EVYJQZYvcP0j+5abOGemez8I2mdiG6jF7zmmXhq
         JNKXR6IH6E4o9v7K6TwIso4ZiX6TLONsBUVR8tBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 020/139] net: skb_scrub_packet(): Scrub offload_fwd_mark
Date:   Tue,  4 Dec 2018 11:48:21 +0100
Message-Id: <20181204103650.809480977@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit b5dd186d10ba59e6b5ba60e42b3b083df56df6f3 ]

When a packet is trapped and the corresponding SKB marked as
already-forwarded, it retains this marking even after it is forwarded
across veth links into another bridge. There, since it ingresses the
bridge over veth, which doesn't have offload_fwd_mark, it triggers a
warning in nbp_switchdev_frame_mark().

Then nbp_switchdev_allowed_egress() decides not to allow egress from
this bridge through another veth, because the SKB is already marked, and
the mark (of 0) of course matches. Thus the packet is incorrectly
blocked.

Solve by resetting offload_fwd_mark() in skb_scrub_packet(). That
function is called from tunnels and also from veth, and thus catches the
cases where traffic is forwarded between bridges and transformed in a
way that invalidates the marking.

Fixes: 6bc506b4fb06 ("bridge: switchdev: Add forward mark support for stacked devices")
Fixes: abf4bb6b63d0 ("skbuff: Add the offload_mr_fwd_mark field")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Suggested-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4912,6 +4912,11 @@ void skb_scrub_packet(struct sk_buff *sk
 	nf_reset(skb);
 	nf_reset_trace(skb);
 
+#ifdef CONFIG_NET_SWITCHDEV
+	skb->offload_fwd_mark = 0;
+	skb->offload_mr_fwd_mark = 0;
+#endif
+
 	if (!xnet)
 		return;
 


