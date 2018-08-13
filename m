Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22BFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7048220657
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7048220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbeHNBHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:07:35 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33665 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731950AbeHNBHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:07:35 -0400
Received: by mail-it0-f68.google.com with SMTP id d16-v6so12858824itj.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 15:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k/tjbMtyrQQvtaKEMNynh5C6DAyB4tVOvFw3Fs3pX2I=;
        b=TCXPx+wEmwTKX1vMad6x/k93IDf75bzf9uHy55yhZ9IQTm+uDg+Y7fKrzb7aJPPO/W
         zZtsuoDNqpHajS3s01XzAgzpVU3ULNLnv6nA1SVTMA/Bylwfw0mp6EQCP8CauxO1QMdn
         CFPigxJyl1E4T5jLedvVlvVrp/G7h5radqeTZUgtW+qdgAMcA7x6R4hOE5cpDFkDoBOf
         TO6a71laln6nKsuIP886F5Xd5Nlj1pK24/waVVB+4Ix65iPNL0oh6KaDQcNmJn/8Gvjy
         vGKRGxIeNcbQhRdNmxsIMq134sJoL17+X9hPraMWL/fVr6wI+AJJpka13E/v4ExyfqSu
         t8vA==
X-Gm-Message-State: AOUpUlF7g8gYJ2PCOKh/ld9lG2+EE1EL6S3Rfqd+gMoes/PjtxBPXUlp
        KlaULt/C4s2PcR+QzWp0OGBExw==
X-Google-Smtp-Source: AA+uWPzVWiZbMMR/F8ch/vmwA5ky1V17QJO50DJBDPKgRe419SY7L66NUaX94STJR/m9gyujY9I5pA==
X-Received: by 2002:a24:b701:: with SMTP id h1-v6mr12016571itf.131.1534199003772;
        Mon, 13 Aug 2018 15:23:23 -0700 (PDT)
Received: from builder.jcline.org ([2605:a601:80ce:4700:77a5:8983:ea8b:82ec])
        by smtp.gmail.com with ESMTPSA id a6-v6sm7399648ioq.73.2018.08.13.15.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 15:23:23 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, konrad.wilk@oracle.com,
        jamie.iles@oracle.com, liran.alon@oracle.com,
        stable@vger.kernel.org
Subject: [PATCH] net: sock_diag: Fix spectre v1 gadget in __sock_diag_cmd()
Date:   Mon, 13 Aug 2018 22:23:13 +0000
Message-Id: <20180813222313.3510-1-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

Since commit e978de7a6d38 didn't apply cleanly to v4.14, this won't
either since it reverts that change. To apply cleanly there, the change
to sock_is_registered() needs to be dropped.

 net/core/sock_diag.c | 2 ++
 net/socket.c         | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index c37b5be7c5e4..3312a5849a97 100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/tcp.h>
 #include <linux/workqueue.h>
+#include <linux/nospec.h>
 
 #include <linux/inet_diag.h>
 #include <linux/sock_diag.h>
@@ -218,6 +219,7 @@ static int __sock_diag_cmd(struct sk_buff *skb, struct nlmsghdr *nlh)
 
 	if (req->sdiag_family >= AF_MAX)
 		return -EINVAL;
+	req->sdiag_family = array_index_nospec(req->sdiag_family, AF_MAX);
 
 	if (sock_diag_handlers[req->sdiag_family] == NULL)
 		sock_load_diag_module(req->sdiag_family, 0);
diff --git a/net/socket.c b/net/socket.c
index 53c907169818..391a0da49ffe 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2679,8 +2679,7 @@ EXPORT_SYMBOL(sock_unregister);
 
 bool sock_is_registered(int family)
 {
-	return family < NPROTO &&
-		rcu_access_pointer(net_families[array_index_nospec(family, NPROTO)]);
+	return family < NPROTO && rcu_access_pointer(net_families[family]);
 }
 
 static int __init sock_init(void)
-- 
2.17.1

