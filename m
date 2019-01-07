Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B39CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C4221855
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866533;
	bh=IEVSNX9tgVaqqhZMmwuHULrWU+d+8HgHgaPWJt4BHuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l8iwnYzcddcbroV+4F1TMR1RuqtcOvE5c65k8th34spAlmyd/grr2Vuy3ROAKd1bW
	 1fzAnPYdY0aVlMDaudixrpb+IkDlWTIfGzmNKfpKYSuQqWFaLWBEKuZs+gzUcCl4ti
	 PLUD+DsRF5GNp3ZHIf3ch9aFePlHPV430KY4ua9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbfAGNIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:08:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731204AbfAGNIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:08:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D07F8218A3;
        Mon,  7 Jan 2019 13:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866529;
        bh=IEVSNX9tgVaqqhZMmwuHULrWU+d+8HgHgaPWJt4BHuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mM1cTTiW7f2BqQxS3ipdelqk6Rm7lW/Lx2fXomT86eHUwFfelrwwo9r6XZ3rM/BFu
         0zZ3Jld0yMLyknVfx8fVsOyK/nwt387g8GvmTCSLV0drYdDvciQcM5pF2vFWC01jWI
         Y+ATNeUmT82cJqt2M/S0AzqPJS0sZBcBhHMY+xVQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+eb4da3a20fad2e52555d@syzkaller.appspotmail.com,
        Ying Xue <ying.xue@windriver.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 24/71] tipc: compare remote and local protocols in tipc_udp_enable()
Date:   Mon,  7 Jan 2019 13:32:53 +0100
Message-Id: <20190107105334.179236891@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -674,6 +674,11 @@ static int tipc_udp_enable(struct net *n
 	if (err)
 		goto err;
 
+	if (remote.proto != local.proto) {
+		err = -EINVAL;
+		goto err;
+	}
+
 	b->bcast_addr.media_id = TIPC_MEDIA_TYPE_UDP;
 	b->bcast_addr.broadcast = 1;
 	rcu_assign_pointer(b->media_ptr, ub);


