Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D030C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D66121774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D66121774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeHUJlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:41:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHUJlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:41:52 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A31B68A5;
        Tue, 21 Aug 2018 06:23:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        konrad.wilk@oracle.com, jamie.iles@oracle.com,
        liran.alon@oracle.com, Jeremy Cline <jcline@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 29/35] net: sock_diag: Fix spectre v1 gadget in __sock_diag_cmd()
Date:   Tue, 21 Aug 2018 08:20:55 +0200
Message-Id: <20180821055021.233249273@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055019.954904905@linuxfoundation.org>
References: <20180821055019.954904905@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Cline <jcline@redhat.com>

[ Upstream commit 66b51b0a0341fd42ce657739bdae0561b0410a85 ]

req->sdiag_family is a user-controlled value that's used as an array
index. Sanitize it after the bounds check to avoid speculative
out-of-bounds array access.

This also protects the sock_is_registered() call, so this removes the
sanitize call there.

Fixes: e978de7a6d38 ("net: socket: Fix potential spectre v1 gadget in sock_is_registered")
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: konrad.wilk@oracle.com
Cc: jamie.iles@oracle.com
Cc: liran.alon@oracle.com
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Cline <jcline@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/sock_diag.c |    2 ++
 net/socket.c         |    3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/tcp.h>
 #include <linux/workqueue.h>
+#include <linux/nospec.h>
 
 #include <linux/inet_diag.h>
 #include <linux/sock_diag.h>
@@ -218,6 +219,7 @@ static int __sock_diag_cmd(struct sk_buf
 
 	if (req->sdiag_family >= AF_MAX)
 		return -EINVAL;
+	req->sdiag_family = array_index_nospec(req->sdiag_family, AF_MAX);
 
 	if (sock_diag_handlers[req->sdiag_family] == NULL)
 		sock_load_diag_module(req->sdiag_family, 0);
--- a/net/socket.c
+++ b/net/socket.c
@@ -2690,8 +2690,7 @@ EXPORT_SYMBOL(sock_unregister);
 
 bool sock_is_registered(int family)
 {
-	return family < NPROTO &&
-		rcu_access_pointer(net_families[array_index_nospec(family, NPROTO)]);
+	return family < NPROTO && rcu_access_pointer(net_families[family]);
 }
 
 static int __init sock_init(void)


