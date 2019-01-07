Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E96C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C682221736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866066;
	bh=/L/5+Izm6D5RHlNXjulSiV1Wl/2IV/NmeyyBgp86v/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ib7IP4w4dlWjvD5IfiWsp0lWn1EeyJaviAhVn57iLBH+6ml9TV5a3RVDAdqYsU8Ph
	 PwcyAz8H09jQVXlLkprNDNpknwSDVtksMRrjaEYl3Qiq5HZU/kHcSrXBWUJ5jItaBV
	 jyuJbuojXMCfSLMV5xKhy6DngrTjdYElXfiObsn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfAGNBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:01:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730525AbfAGNBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:01:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1692D217D4;
        Mon,  7 Jan 2019 13:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866062;
        bh=/L/5+Izm6D5RHlNXjulSiV1Wl/2IV/NmeyyBgp86v/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCGNSeMW57XLeXY59SSPm+W+cqPQBFH7FYS+eICCI2ApqW4/5/atMUlRcgHcbKfv+
         N9sPn1nrBW9BmHg/2ee9gjYSd7bKnZe52e51viJ3kctkoC74DDA7se2kFe4m3eO189
         Eoea27rYDFWsodkdg4vSK8hSNhNDpxtvNINEcpuo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+eb4da3a20fad2e52555d@syzkaller.appspotmail.com,
        Ying Xue <ying.xue@windriver.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 032/101] tipc: compare remote and local protocols in tipc_udp_enable()
Date:   Mon,  7 Jan 2019 13:32:20 +0100
Message-Id: <20190107105334.670794353@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit fb83ed496b9a654f60cd1d58a0e1e79ec5694808 ]

When TIPC_NLA_UDP_REMOTE is an IPv6 mcast address but
TIPC_NLA_UDP_LOCAL is an IPv4 address, a NULL-ptr deref is triggered
as the UDP tunnel sock is initialized to IPv4 or IPv6 sock merely
based on the protocol in local address.

We should just error out when the remote address and local address
have different protocols.

Reported-by: syzbot+eb4da3a20fad2e52555d@syzkaller.appspotmail.com
Cc: Ying Xue <ying.xue@windriver.com>
Cc: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/udp_media.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -675,6 +675,11 @@ static int tipc_udp_enable(struct net *n
 	if (err)
 		goto err;
 
+	if (remote.proto != local.proto) {
+		err = -EINVAL;
+		goto err;
+	}
+
 	b->bcast_addr.media_id = TIPC_MEDIA_TYPE_UDP;
 	b->bcast_addr.broadcast = TIPC_BROADCAST_SUPPORT;
 	rcu_assign_pointer(b->media_ptr, ub);


