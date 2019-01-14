Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89877C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5736920873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDqx9A9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfANKeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:34:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45512 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANKeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:34:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so9270337pgc.12;
        Mon, 14 Jan 2019 02:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=26qauMoMVFxrdp73ognFH9lIQFbZNH1j1vuilnAU4pM=;
        b=WDqx9A9lCo8kYqSYiV1wN+j6X2i5ov7Kc+i+v9GmbfRG9t8UZi6+tN7ogZ/J+47sVK
         lTfueKjNMlOv9kJsM7zyOFMud3EHDDbTuvrFngC8ow5m4FMjZMy1l7xhDSsgOOc55GDz
         oDNW4xXbOEVs3Xhj/lXp+nxth0kBEENf7Lxgoz4H2AFGTdzFF0iXqIFyictICWV6q0Rc
         jAVWn9fEGw1XzRbgrY7zaZswJm5N1nScJk0eWfBqwEsgW+uNMvM4KXIj00v6/GXkLdTK
         FDvkiuF/m8z3sxGNDy9EkF4aLvI5U/+WW3W+JHJOaZFIBFrBmUMOiPGqjWZ1d7NFW2GU
         rxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=26qauMoMVFxrdp73ognFH9lIQFbZNH1j1vuilnAU4pM=;
        b=VauJ+4Z4CqLl2CTk5XPx23L3pBaA5GNTuNVlTdgD5rjitXPDyn9cur+OPbdK4IXDqh
         iJTq1IbAutRP4LGBBmBD396M8U+dwgGNmCWiZQOcY2Miuj8Dv5XpJ61ucjENKKFEzbAQ
         zALdqlAzIsr8Pf1lEmLt35VPIGYYO7939CvWI1eTF0qwOWNTm/rfDxnUcDu7RINSKTl5
         WUNjVCkLFsp3dNrE/hFyTcKNgfM8bggjDOg36h1kPZ5b+jxnaxmCGTJdCpqcPNBCctRA
         AVhYqb8BymbLQCeE8My5Zu50kowd2WV5XKLMJnI6YdFTXaVSD+PfxaG2XwGc0bT4mQ/9
         HsIw==
X-Gm-Message-State: AJcUukdwg0o6h1sSjKH12FQXG30trsyw1w+SzhJOYjzTkENWkTocLSYq
        RFTedTqTg+MQhU0Pt8awK4FX8f3n
X-Google-Smtp-Source: ALg8bN6CBGBo2RGWk0ZcUSrmQ9Dei04WaXpFlvzjbftPaUWnJi7whKQmG9pApOmn/9uexN8z/SEoGw==
X-Received: by 2002:a62:1b83:: with SMTP id b125mr25667570pfb.42.1547462050697;
        Mon, 14 Jan 2019 02:34:10 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g3sm206971pfe.37.2019.01.14.02.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 02:34:10 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Alexander Potapenko <glider@google.com>
Subject: [PATCH net] sctp: allocate sctp_sockaddr_entry with kzalloc
Date:   Mon, 14 Jan 2019 18:34:02 +0800
Message-Id: <b1033e296052216772051e87ba5aa61bfc222076.1547462042.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The similar issue as fixed in Commit 4a2eb0c37b47 ("sctp: initialize
sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event") also exists
in sctp_inetaddr_event, as Alexander noticed.

To fix it, allocate sctp_sockaddr_entry with kzalloc for both sctp
ipv4 and ipv6 addresses, as does in sctp_v4/6_copy_addrlist().

Reported-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/ipv6.c     | 5 +----
 net/sctp/protocol.c | 4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index b9ed271..ed8e006 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -97,11 +97,9 @@ static int sctp_inet6addr_event(struct notifier_block *this, unsigned long ev,
 
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
@@ -434,7 +432,6 @@ static void sctp_v6_copy_addrlist(struct list_head *addrlist,
 		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
 		if (addr) {
 			addr->a.v6.sin6_family = AF_INET6;
-			addr->a.v6.sin6_port = 0;
 			addr->a.v6.sin6_addr = ifp->addr;
 			addr->a.v6.sin6_scope_id = dev->ifindex;
 			addr->valid = 1;
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index d5878ae..4e0eeb1 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -101,7 +101,6 @@ static void sctp_v4_copy_addrlist(struct list_head *addrlist,
 		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
 		if (addr) {
 			addr->a.v4.sin_family = AF_INET;
-			addr->a.v4.sin_port = 0;
 			addr->a.v4.sin_addr.s_addr = ifa->ifa_local;
 			addr->valid = 1;
 			INIT_LIST_HEAD(&addr->list);
@@ -776,10 +775,9 @@ static int sctp_inetaddr_event(struct notifier_block *this, unsigned long ev,
 
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
-- 
2.1.0

