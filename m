Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71042C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9B020856
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfACALk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 19:11:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43364 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfACALj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 19:11:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so15848153pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 16:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pgzDVuFkNdcUaGFgKDWKsKa3d95bqeFYv0F5c9kcBGA=;
        b=jf9ztHivDuLGF+IEoGgScS1Ayawxeip/iU1MiZe8dUiUldVAJkEjix4D5xHu7qWSkU
         oG/K++tHgRGLOVUuAFBZG4dZKxNf1L5MrfF6C8xNgVanoHcZpMbv77mpTclBhjf1OazW
         I3lHmkMyiDkhMsMe2ZDV3RCeuH9RKvfQTEIhjJchQa56w101bVwiVYxrDDqm/TmVlc8+
         3bKaDoZJTPMp6Bv0cR+YOFnZKCpdLi9paDaQIRnOPeAmYnOtSnXZRzUiQeoZ5Wu/+huv
         SB0C7hB5oJJ7snkdHAAH7EbNQXnCZmUoKaB/orioheXhqBprKurtmVDo7xAhczToQ8XL
         14VA==
X-Gm-Message-State: AA+aEWaBkFVOU31R6NYJI+LSIx+CkjDCcZqpZj6QJfYC1GeGCygp9IeV
        hbtX05RlInheMlMJwvqCG3h7MA==
X-Google-Smtp-Source: AFSGD/UVuDMkbqvT8A7TR6lY4KaRAXEBZlgsLd+JAPQ4YB6fYUn5ElwAjInVSAwp9b+ZmtD1h2ZH1w==
X-Received: by 2002:a62:7c47:: with SMTP id x68mr46847050pfc.209.1546474298363;
        Wed, 02 Jan 2019 16:11:38 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t12sm83822010pfi.45.2019.01.02.16.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 16:11:37 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dean Jenkins <Dean_Jenkins@mentor.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] Bluetooth: Fix locking in bt_accept_enqueue() for BH context
Date:   Wed,  2 Jan 2019 16:11:20 -0800
Message-Id: <20190103001120.177784-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket
atomically") lock_sock[_nested]() is used to acquire the socket lock
before manipulating the socket. lock_sock[_nested]() may block, which
is problematic since bt_accept_enqueue() can be called in bottom half
context (e.g. from rfcomm_connect_ind()):

[<ffffff80080d81ec>] __might_sleep+0x4c/0x80
[<ffffff800876c7b0>] lock_sock_nested+0x24/0x58
[<ffffff8000d7c27c>] bt_accept_enqueue+0x48/0xd4 [bluetooth]
[<ffffff8000e67d8c>] rfcomm_connect_ind+0x190/0x218 [rfcomm]

Add a parameter to bt_accept_enqueue() to indicate whether the
function is called from BH context, and acquire the socket lock
with bh_lock_sock_nested() if that's the case.

Also adapt all callers of bt_accept_enqueue() to pass the new
parameter:

- l2cap_sock_new_connection_cb()
  - uses lock_sock() to lock the parent socket => process context

- rfcomm_connect_ind()
  - acquires the parent socket lock with bh_lock_sock() => BH
    context

- __sco_chan_add()
  - called from sco_chan_add(), which is called from sco_connect().
    parent is NULL, hence bt_accept_enqueue() isn't called in this
    code path and we can ignore it
  - also called from sco_conn_ready(). uses bh_lock_sock() to acquire
    the parent lock => BH context

Fixes: e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket atomically")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- use parameter in bt_accept_enqueue() to decide which lock to
  acquire and adapt all callers
- updated commit message
---
 include/net/bluetooth/bluetooth.h |  2 +-
 net/bluetooth/af_bluetooth.c      | 16 +++++++++++++---
 net/bluetooth/l2cap_sock.c        |  2 +-
 net/bluetooth/rfcomm/sock.c       |  2 +-
 net/bluetooth/sco.c               |  2 +-
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index ec9d6bc658559..fabee6db0abb7 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -276,7 +276,7 @@ int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
 int  bt_sock_wait_ready(struct sock *sk, unsigned long flags);
 
-void bt_accept_enqueue(struct sock *parent, struct sock *sk);
+void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh);
 void bt_accept_unlink(struct sock *sk);
 struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock);
 
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index deacc52d7ff18..8d12198eaa949 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -154,15 +154,25 @@ void bt_sock_unlink(struct bt_sock_list *l, struct sock *sk)
 }
 EXPORT_SYMBOL(bt_sock_unlink);
 
-void bt_accept_enqueue(struct sock *parent, struct sock *sk)
+void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 {
 	BT_DBG("parent %p, sk %p", parent, sk);
 
 	sock_hold(sk);
-	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+
+	if (bh)
+		bh_lock_sock_nested(sk);
+	else
+		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+
 	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
 	bt_sk(sk)->parent = parent;
-	release_sock(sk);
+
+	if (bh)
+		bh_unlock_sock(sk);
+	else
+		release_sock(sk);
+
 	parent->sk_ack_backlog++;
 }
 EXPORT_SYMBOL(bt_accept_enqueue);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 686bdc6b35b03..a3a2cd55e23a9 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1252,7 +1252,7 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 	l2cap_sock_init(sk, parent);
 
-	bt_accept_enqueue(parent, sk);
+	bt_accept_enqueue(parent, sk, false);
 
 	release_sock(parent);
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index aa0db1d1bd9b4..b1f49fcc04780 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -988,7 +988,7 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 	rfcomm_pi(sk)->channel = channel;
 
 	sk->sk_state = BT_CONFIG;
-	bt_accept_enqueue(parent, sk);
+	bt_accept_enqueue(parent, sk, true);
 
 	/* Accept connection and return socket DLC */
 	*d = rfcomm_pi(sk)->dlc;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 529b38996d8bc..9a580999ca57e 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -193,7 +193,7 @@ static void __sco_chan_add(struct sco_conn *conn, struct sock *sk,
 	conn->sk = sk;
 
 	if (parent)
-		bt_accept_enqueue(parent, sk);
+		bt_accept_enqueue(parent, sk, true);
 }
 
 static int sco_chan_add(struct sco_conn *conn, struct sock *sk,
-- 
2.20.1.415.g653613c723-goog

