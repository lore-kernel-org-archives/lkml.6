Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755372AbeDWNbL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:31:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42461 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755059AbeDWNbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:31:00 -0400
X-Google-Smtp-Source: AIpwx49yLZ2T7Qa6/EhKvjbVWpz6czRwj+vDBzV+M9EaujhABMpT03x7lhOnwYC3NgBrrMpEzVvQ2g==
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        teg@jklm.no, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 3/3] selinux: provide unix_stream_socketpair callback
Date: Mon, 23 Apr 2018 15:30:15 +0200
Message-Id: <20180423133015.5455-4-dh.herrmann@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423133015.5455-1-dh.herrmann@gmail.com>
References: <20180423133015.5455-1-dh.herrmann@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to implement the new unix_stream_socketpair callback so the
SO_PEERSEC call on socketpair(2)s will return correct information.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 security/selinux/hooks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4cafe6a19167..828881d9a41d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4905,6 +4905,18 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 	return 0;
 }
 
+static int selinux_socket_unix_stream_socketpair(struct sock *socka,
+						 struct sock *sockb)
+{
+	struct sk_security_struct *sksec_a = socka->sk_security;
+	struct sk_security_struct *sksec_b = sockb->sk_security;
+
+	sksec_a->peer_sid = sksec_b->sid;
+	sksec_b->peer_sid = sksec_a->sid;
+
+	return 0;
+}
+
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
@@ -6995,6 +7007,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
 
 	LSM_HOOK_INIT(unix_stream_connect, selinux_socket_unix_stream_connect),
+	LSM_HOOK_INIT(unix_stream_socketpair,
+			selinux_socket_unix_stream_socketpair),
 	LSM_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
 
 	LSM_HOOK_INIT(socket_create, selinux_socket_create),
-- 
2.17.0
