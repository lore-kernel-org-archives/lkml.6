Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A059C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C2A2147D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789262;
	bh=KrmAVJdn8l7GrnQp8UBZeEcxg7kuZN3o1g4bPwgzEzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I+jS2zK1NCe07SUPdZ4Xv5uWVNhNmIbr++dx7jfIETPvwibDK82jZIhtcAcwsysHj
	 Esu3h8fvv4axCXbb43ZSyXTmxnhgEQUmrZdT95pXtLjgz5ZT71ntYcb6cHviJINLk7
	 vC3ifaKq6MksEDrNmIPmrav5wzPDjracOPpFj7xs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C2A2147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbeLNMHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730648AbeLNMHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:07:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 498782148E;
        Fri, 14 Dec 2018 12:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789252;
        bh=KrmAVJdn8l7GrnQp8UBZeEcxg7kuZN3o1g4bPwgzEzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4n+msrR56YMv7o48PWx39SEwFEPsymE19HIJTf3B+STWcns0cBXvtirRLP7G8QZg
         QPc7ZOVg++OCh3gy8FcGtvOf+4SzmVxh7kYxIajK+b2fGfN+Bu2rW9W2bs8G8Cr5B/
         7/g11g0hDX2SndXlAppPy/0QRjfuq5diWegs71TU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+0b05d8aa7cb185107483@syzkaller.appspotmail.com,
        syzbot+aad231d51b1923158444@syzkaller.appspotmail.com,
        Neil Horman <nhorman@tuxdriver.com>,
        Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 11/89] sctp: kfree_rcu asoc
Date:   Fri, 14 Dec 2018 12:59:24 +0100
Message-Id: <20181214115730.233438522@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

[ Upstream commit fb6df5a6234c38a9c551559506a49a677ac6f07a ]

In sctp_hash_transport/sctp_epaddr_lookup_transport, it dereferences
a transport's asoc under rcu_read_lock while asoc is freed not after
a grace period, which leads to a use-after-free panic.

This patch fixes it by calling kfree_rcu to make asoc be freed after
a grace period.

Note that only the asoc's memory is delayed to free in the patch, it
won't cause sk to linger longer.

Thanks Neil and Marcelo to make this clear.

Fixes: 7fda702f9315 ("sctp: use new rhlist interface on sctp transport rhashtable")
Fixes: cd2b70875058 ("sctp: check duplicate node before inserting a new transport")
Reported-by: syzbot+0b05d8aa7cb185107483@syzkaller.appspotmail.com
Reported-by: syzbot+aad231d51b1923158444@syzkaller.appspotmail.com
Suggested-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/sctp/structs.h |    2 ++
 net/sctp/associola.c       |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -1902,6 +1902,8 @@ struct sctp_association {
 
 	__u64 abandoned_unsent[SCTP_PR_INDEX(MAX) + 1];
 	__u64 abandoned_sent[SCTP_PR_INDEX(MAX) + 1];
+
+	struct rcu_head rcu;
 };
 
 
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -432,7 +432,7 @@ static void sctp_association_destroy(str
 
 	WARN_ON(atomic_read(&asoc->rmem_alloc));
 
-	kfree(asoc);
+	kfree_rcu(asoc, rcu);
 	SCTP_DBG_OBJCNT_DEC(assoc);
 }
 


