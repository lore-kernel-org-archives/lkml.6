Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F4EC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81292218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358002;
	bh=ylduL/TFs5TfxLS3IJ39gTXRytn8ae5gmYonEFoLV/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o/UhXG21LjeaygIeeIV4YQgfm21flcpxMkUIY9S+kpF0Jg8088eP0257uyCW68wBu
	 l5IOqafFUE1JIm9rb4KsFzWdMAIlnYXKIdaN4fb+59FakD7rF4NozMYC0lDo8KRRVB
	 c4bPsTwKeMWgL/XY8LWHvpzRQcrQ/6OfnH/GBCT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbfAXT0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:26:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729813AbfAXT0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:26:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 734DB217D7;
        Thu, 24 Jan 2019 19:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357995;
        bh=ylduL/TFs5TfxLS3IJ39gTXRytn8ae5gmYonEFoLV/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T4Heyh8k9aPpxC2S25Vipt2i7ohxTPEyZ708LCwPptIoVU9nLeiMreo1OlZbYiXfy
         Zd88TPhFaow8XWBeCvPKs92FvrSDpzXRBfKcMVrW9YJlGzyip9QwPAHP2c9CcBncl6
         uJ2rzjPL8m3OR0PDtiy4pZ+NKCynVwU7AtgCY7Vk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Potapenko <glider@google.com>,
        Xin Long <lucien.xin@gmail.com>,
        syzbot+ae0c70c0c2d40c51bb92@syzkaller.appspotmail.com,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 061/104] sctp: allocate sctp_sockaddr_entry with kzalloc
Date:   Thu, 24 Jan 2019 20:19:50 +0100
Message-Id: <20190124190202.383611757@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -412,7 +410,6 @@ static void sctp_v6_copy_addrlist(struct
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
@@ -775,10 +774,9 @@ static int sctp_inetaddr_event(struct no
 
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


