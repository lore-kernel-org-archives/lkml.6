Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D16C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981FE20658
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4ax68rA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981FE20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbeJQBQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:16:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7FD420658;
        Tue, 16 Oct 2018 17:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710692;
        bh=q/ZqAPODWuFhzaoSc9mdOCZVLhG9//5r99SyhUlS3fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i4ax68rANEZh/5xIhZb3eBDh8uX4DjVVOUxPhhmJHPHkvMYjJhopeoKpElhhULGgK
         BlDO1wn7Q5TG6RwYH3prz3mR8wqgb9Yb1xqAVWH/50vgU/7dMZsjsMyKZW2w4Jdmmd
         HOpvcZ2R/dKtAwYkhfl7lsaPNwT16dtamYXojn50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 57/71] rhashtable: reorganize struct rhashtable layout
Date:   Tue, 16 Oct 2018 19:09:54 +0200
Message-Id: <20181016170542.218605806@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

While under frags DDOS I noticed unfortunate false sharing between
@nelems and @params.automatic_shrinking

Move @nelems at the end of struct rhashtable so that first cache line
is shared between all cpus, because almost never dirtied.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit e5d672a0780d9e7118caad4c171ec88b8299398d)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/rhashtable.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -138,7 +138,6 @@ struct rhashtable_params {
 /**
  * struct rhashtable - Hash table handle
  * @tbl: Bucket table
- * @nelems: Number of elements in table
  * @key_len: Key length for hashfn
  * @elasticity: Maximum chain length before rehash
  * @p: Configuration parameters
@@ -146,10 +145,10 @@ struct rhashtable_params {
  * @run_work: Deferred worker to expand/shrink asynchronously
  * @mutex: Mutex to protect current/future table swapping
  * @lock: Spin lock to protect walker list
+ * @nelems: Number of elements in table
  */
 struct rhashtable {
 	struct bucket_table __rcu	*tbl;
-	atomic_t			nelems;
 	unsigned int			key_len;
 	unsigned int			elasticity;
 	struct rhashtable_params	p;
@@ -157,6 +156,7 @@ struct rhashtable {
 	struct work_struct		run_work;
 	struct mutex                    mutex;
 	spinlock_t			lock;
+	atomic_t			nelems;
 };
 
 /**


