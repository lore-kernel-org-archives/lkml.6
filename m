Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74866C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402102087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078803;
	bh=9EPt7Rj1g3vs3G5CAgqe28c2cxXRVhjoCLX3APRrSjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=do/3yqkVnm1INLCqe2c93f0qxlyX9kI1wua17qo7FTWUimOKAbqwQw6F8oI4R3WEn
	 q7WRF9AQLFrYwTJ+TIdw9sWF0V3nNWry2/a1RY5Mnwwexq5v1qwlSpjlp+arfHnYbk
	 oqkEK83eYRNNCTbyjuBQssIn5IqSLh+5B9uw6+M0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbfAUNxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:53:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731238AbfAUNxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:53:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72CF320879;
        Mon, 21 Jan 2019 13:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078797;
        bh=9EPt7Rj1g3vs3G5CAgqe28c2cxXRVhjoCLX3APRrSjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBAgT6Bia7hwAwKOWXu3iI6IoiB8Bb9ur9XDMZncv4gOG/qYgVrmtVvcS5gkhskXa
         WbO53GFX+BzPT9E+bORM2Xx1Vnmg8+msvnw+10KUzu3FoA1FVtQVVKeqxTKtS3/+V1
         iWmVlHOfK5AjU3LsCxijPT9/UfTTw5qXcB+/Gykc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Potapenko <glider@google.com>,
        Xin Long <lucien.xin@gmail.com>,
        syzbot+ae0c70c0c2d40c51bb92@syzkaller.appspotmail.com,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 47/59] sctp: allocate sctp_sockaddr_entry with kzalloc
Date:   Mon, 21 Jan 2019 14:44:12 +0100
Message-Id: <20190121122501.944388618@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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
@@ -415,7 +413,6 @@ static void sctp_v6_copy_addrlist(struct
 		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
 		if (addr) {
 			addr->a.v6.sin6_family = AF_INET6;
-			addr->a.v6.sin6_port = 0;
 			addr->a.v6.sin6_addr = ifp->addr;
 			addr->a.v6.sin6_scope_id = dev->ifindex;
 			addr->valid = 1;
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -151,7 +151,6 @@ static void sctp_v4_copy_addrlist(struct
 		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
 		if (addr) {
 			addr->a.v4.sin_family = AF_INET;
-			addr->a.v4.sin_port = 0;
 			addr->a.v4.sin_addr.s_addr = ifa->ifa_local;
 			addr->valid = 1;
 			INIT_LIST_HEAD(&addr->list);
@@ -782,10 +781,9 @@ static int sctp_inetaddr_event(struct no
 
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


