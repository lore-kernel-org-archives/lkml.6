Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850D8C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EDE2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078691;
	bh=+zYpTz3W6eoiYKAj+77j1rJqGpun2BdFPmrjEwWnPec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xoBG0RVAZ9lJNeAgZD722cmj3obR/NglcTHRtPM6HO3zZ6x2cEwnpbpQfgJHKBDGs
	 1k8N8ck+5KymOYnXh6icY4FFHifkJo7ClLxGtjH5blSR6a/WUn6y1xG924yKp+ABFW
	 3AaHKhg1qIkHLmqwOOKxr+YwaE38UR/mihVkruoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfAUNv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:51:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730770AbfAUNv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:51:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABA1D20861;
        Mon, 21 Jan 2019 13:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078687;
        bh=+zYpTz3W6eoiYKAj+77j1rJqGpun2BdFPmrjEwWnPec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXBgMx6Nu234mS6reVHgxDKzZaLay85gihwawgQiFSgXsSB+PLkt7KXtskQNZeORv
         AjKURjylvNV7VvXmOdhT0GUP6MG5AW3kdZWka16i1LLHoh2VzY45pCepRj+Ih8sihH
         p+dMktzCEs3cAaqNOoZGkmeDDIH9y6Mr8Q6RNm9g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Potapenko <glider@google.com>,
        Xin Long <lucien.xin@gmail.com>,
        syzbot+ae0c70c0c2d40c51bb92@syzkaller.appspotmail.com,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 086/111] sctp: allocate sctp_sockaddr_entry with kzalloc
Date:   Mon, 21 Jan 2019 14:43:20 +0100
Message-Id: <20190121122505.548823333@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit 400b8b9a2a17918f8ce00786f596f530e7f30d50 upstream.

The similar issue as fixed in Commit 4a2eb0c37b47 ("sctp: initialize
sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event") also exists
in sctp_inetaddr_event, as Alexander noticed.

To fix it, allocate sctp_sockaddr_entry with kzalloc for both sctp
ipv4 and ipv6 addresses, as does in sctp_v4/6_copy_addrlist().

Reported-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reported-by: syzbot+ae0c70c0c2d40c51bb92@syzkaller.appspotmail.com
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sctp/ipv6.c     |    5 +----
 net/sctp/protocol.c |    4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -97,11 +97,9 @@ static int sctp_inet6addr_event(struct n
 
 	switch (ev) {
 	case NETDEV_UP:
-		addr = kmalloc(sizeof(struct sctp_sockaddr_entry), GFP_ATOMIC);
+		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
 		if (addr) {
 			addr->a.v6.sin6_family = AF_INET6;
-			addr->a.v6.sin6_port = 0;
-			addr->a.v6.sin6_flowinfo = 0;
 			addr->a.v6.sin6_addr = ifa->addr;
 			addr->a.v6.sin6_scope_id = ifa->idev->dev->ifindex;
 			addr->valid = 1;
@@ -431,7 +429,6 @@ static void sctp_v6_copy_addrlist(struct
 		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
 		if (addr) {
 			addr->a.v6.sin6_family = AF_INET6;
-			addr->a.v6.sin6_port = 0;
 			addr->a.v6.sin6_addr = ifp->addr;
 			addr->a.v6.sin6_scope_id = dev->ifindex;
 			addr->valid = 1;
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -101,7 +101,6 @@ static void sctp_v4_copy_addrlist(struct
 		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
 		if (addr) {
 			addr->a.v4.sin_family = AF_INET;
-			addr->a.v4.sin_port = 0;
 			addr->a.v4.sin_addr.s_addr = ifa->ifa_local;
 			addr->valid = 1;
 			INIT_LIST_HEAD(&addr->list);
@@ -776,10 +775,9 @@ static int sctp_inetaddr_event(struct no
 
 	switch (ev) {
 	case NETDEV_UP:
-		addr = kmalloc(sizeof(struct sctp_sockaddr_entry), GFP_ATOMIC);
+		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
 		if (addr) {
 			addr->a.v4.sin_family = AF_INET;
-			addr->a.v4.sin_port = 0;
 			addr->a.v4.sin_addr.s_addr = ifa->ifa_local;
 			addr->valid = 1;
 			spin_lock_bh(&net->sctp.local_addr_lock);


