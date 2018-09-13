Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C797C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5877204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5877204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbeIMTIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:08:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34658 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbeIMTIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:08:18 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3A27ED15;
        Thu, 13 Sep 2018 13:58:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 076/197] tcp, ulp: add alias for all ulp modules
Date:   Thu, 13 Sep 2018 15:30:25 +0200
Message-Id: <20180913131844.568035775@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 037b0b86ecf5646f8eae777d8b52ff8b401692ec ]

Lets not turn the TCP ULP lookup into an arbitrary module loader as
we only intend to load ULP modules through this mechanism, not other
unrelated kernel modules:

  [root@bar]# cat foo.c
  #include <sys/types.h>
  #include <sys/socket.h>
  #include <linux/tcp.h>
  #include <linux/in.h>

  int main(void)
  {
      int sock = socket(PF_INET, SOCK_STREAM, 0);
      setsockopt(sock, IPPROTO_TCP, TCP_ULP, "sctp", sizeof("sctp"));
      return 0;
  }

  [root@bar]# gcc foo.c -O2 -Wall
  [root@bar]# lsmod | grep sctp
  [root@bar]# ./a.out
  [root@bar]# lsmod | grep sctp
  sctp                 1077248  4
  libcrc32c              16384  3 nf_conntrack,nf_nat,sctp
  [root@bar]#

Fix it by adding module alias to TCP ULP modules, so probing module
via request_module() will be limited to tcp-ulp-[name]. The existing
modules like kTLS will load fine given tcp-ulp-tls alias, but others
will fail to load:

  [root@bar]# lsmod | grep sctp
  [root@bar]# ./a.out
  [root@bar]# lsmod | grep sctp
  [root@bar]#

Sockmap is not affected from this since it's either built-in or not.

Fixes: 734942cc4ea6 ("tcp: ULP infrastructure")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h  |    4 ++++
 net/ipv4/tcp_ulp.c |    2 +-
 net/tls/tls_main.c |    1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2023,6 +2023,10 @@ int tcp_set_ulp_id(struct sock *sk, cons
 void tcp_get_available_ulp(char *buf, size_t len);
 void tcp_cleanup_ulp(struct sock *sk);
 
+#define MODULE_ALIAS_TCP_ULP(name)				\
+	__MODULE_INFO(alias, alias_userspace, name);		\
+	__MODULE_INFO(alias, alias_tcp_ulp, "tcp-ulp-" name)
+
 /* Call BPF_SOCK_OPS program that returns an int. If the return value
  * is < 0, then the BPF op failed (for example if the loaded BPF
  * program does not support the chosen operation or there is no BPF
--- a/net/ipv4/tcp_ulp.c
+++ b/net/ipv4/tcp_ulp.c
@@ -51,7 +51,7 @@ static const struct tcp_ulp_ops *__tcp_u
 #ifdef CONFIG_MODULES
 	if (!ulp && capable(CAP_NET_ADMIN)) {
 		rcu_read_unlock();
-		request_module("%s", name);
+		request_module("tcp-ulp-%s", name);
 		rcu_read_lock();
 		ulp = tcp_ulp_find(name);
 	}
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -45,6 +45,7 @@
 MODULE_AUTHOR("Mellanox Technologies");
 MODULE_DESCRIPTION("Transport Layer Security Support");
 MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS_TCP_ULP("tls");
 
 enum {
 	TLSV4,


