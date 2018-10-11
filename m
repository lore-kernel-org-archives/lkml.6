Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC74C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916CE21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNHzKRiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916CE21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbeJKXQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731315AbeJKXQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:16:54 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4FC6213A2;
        Thu, 11 Oct 2018 15:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272947;
        bh=Nh8FnXTzITE7p7zmzq4iF+KAsgchOqyRJFNzV7JBp8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNHzKRiLJnfw3eDLAp8xO6V56RSvdqrp6y7MzmQG+S+G2/6IBMR5WZvm6Maym3P9i
         eDp7jaRtM4/xZmdHgjVQ+6Dh61KsOdIgrMMhPBEn23FUN5H6BtuC/zRVPcMgltXWm1
         vlpK36R0yf+aPDX8EjsMRanM/JeZFGKYVBM2Ax80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
Subject: [PATCH 4.18 43/44] rds: rds_ib_recv_alloc_cache() should call alloc_percpu_gfp() instead
Date:   Thu, 11 Oct 2018 17:40:21 +0200
Message-Id: <20181011152454.355654299@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
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

From: Ka-Cheong Poon <ka-cheong.poon@oracle.com>

commit f394ad28feffbeebab77c8bf9a203bd49b957c9a upstream.

Currently, rds_ib_conn_alloc() calls rds_ib_recv_alloc_caches()
without passing along the gfp_t flag.  But rds_ib_recv_alloc_caches()
and rds_ib_recv_alloc_cache() should take a gfp_t parameter so that
rds_ib_recv_alloc_cache() can call alloc_percpu_gfp() using the
correct flag instead of calling alloc_percpu().

Signed-off-by: Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/rds/ib.h      |    2 +-
 net/rds/ib_cm.c   |    2 +-
 net/rds/ib_recv.c |   10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

--- a/net/rds/ib.h
+++ b/net/rds/ib.h
@@ -371,7 +371,7 @@ void rds_ib_mr_cqe_handler(struct rds_ib
 int rds_ib_recv_init(void);
 void rds_ib_recv_exit(void);
 int rds_ib_recv_path(struct rds_conn_path *conn);
-int rds_ib_recv_alloc_caches(struct rds_ib_connection *ic);
+int rds_ib_recv_alloc_caches(struct rds_ib_connection *ic, gfp_t gfp);
 void rds_ib_recv_free_caches(struct rds_ib_connection *ic);
 void rds_ib_recv_refill(struct rds_connection *conn, int prefill, gfp_t gfp);
 void rds_ib_inc_free(struct rds_incoming *inc);
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -949,7 +949,7 @@ int rds_ib_conn_alloc(struct rds_connect
 	if (!ic)
 		return -ENOMEM;
 
-	ret = rds_ib_recv_alloc_caches(ic);
+	ret = rds_ib_recv_alloc_caches(ic, gfp);
 	if (ret) {
 		kfree(ic);
 		return ret;
--- a/net/rds/ib_recv.c
+++ b/net/rds/ib_recv.c
@@ -98,12 +98,12 @@ static void rds_ib_cache_xfer_to_ready(s
 	}
 }
 
-static int rds_ib_recv_alloc_cache(struct rds_ib_refill_cache *cache)
+static int rds_ib_recv_alloc_cache(struct rds_ib_refill_cache *cache, gfp_t gfp)
 {
 	struct rds_ib_cache_head *head;
 	int cpu;
 
-	cache->percpu = alloc_percpu(struct rds_ib_cache_head);
+	cache->percpu = alloc_percpu_gfp(struct rds_ib_cache_head, gfp);
 	if (!cache->percpu)
 	       return -ENOMEM;
 
@@ -118,13 +118,13 @@ static int rds_ib_recv_alloc_cache(struc
 	return 0;
 }
 
-int rds_ib_recv_alloc_caches(struct rds_ib_connection *ic)
+int rds_ib_recv_alloc_caches(struct rds_ib_connection *ic, gfp_t gfp)
 {
 	int ret;
 
-	ret = rds_ib_recv_alloc_cache(&ic->i_cache_incs);
+	ret = rds_ib_recv_alloc_cache(&ic->i_cache_incs, gfp);
 	if (!ret) {
-		ret = rds_ib_recv_alloc_cache(&ic->i_cache_frags);
+		ret = rds_ib_recv_alloc_cache(&ic->i_cache_frags, gfp);
 		if (ret)
 			free_percpu(ic->i_cache_incs.percpu);
 	}


