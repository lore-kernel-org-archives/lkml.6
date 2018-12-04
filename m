Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC85C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2269C2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYv5O1wm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2269C2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeLDLU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:20:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbeLDLDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:03:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B9AE2087F;
        Tue,  4 Dec 2018 11:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921410;
        bh=X1zK1qSxNZ8h4U7RIMLIGIr+XQ+2/cK5szhiPsHkC9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CYv5O1wm6KcXhZtah5SHQVPaqjXs4iVoxFu0lNMMdKuhN3Q5Fxt4oSScjbN2798Yg
         MJ1lSrBsss7Dv75xLngRDxEo4JWwJc7uJqnInuaGSpmMpA57TURboBxVwSa08+/C0k
         GH4DHCBvKqxMB2cvM6+fjB4dYQqsfKPPv5Yr5xRw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 059/146] net: skb_scrub_packet(): Scrub offload_fwd_mark
Date:   Tue,  4 Dec 2018 11:49:05 +0100
Message-Id: <20181204103729.214402485@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 net/core/skbuff.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4882,6 +4882,10 @@ void skb_scrub_packet(struct sk_buff *sk
 	nf_reset(skb);
 	nf_reset_trace(skb);
 
+#ifdef CONFIG_NET_SWITCHDEV
+	skb->offload_fwd_mark = 0;
+#endif
+
 	if (!xnet)
 		return;
 


