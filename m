Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D3DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094C621904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539777;
	bh=Z0KMt7vwHTJHmKR7iyBtLt9Ptzw00TsFKy7UHOmprJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XUrUsZU1SBNPG7dgdc1QU4er+U2UoJOL0hlSAoNtNQyvaTg6Z3ZnQxnwMhUVCYeOF
	 Lwqgzx8f5Ctccur+vPuzdhV77PW3mT6m9YGX8Nl+XHj+fJvi7JHkcgDFTxixtkLWDi
	 mqhhPn9S/xPl/swluUs+0m3CkbeDgHkV4F0TgY5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfBGLm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:42:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:32976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbfBGLmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:42:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC6E8218FE;
        Thu,  7 Feb 2019 11:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539772;
        bh=Z0KMt7vwHTJHmKR7iyBtLt9Ptzw00TsFKy7UHOmprJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0k+0L/hVDfVPiWvOB/azDQQgzK1aZNnkiTqu2q606ivBUANiF6IZ7Gl6xMwv7Nwq
         PYNwqsisky9IRJYSGrhhTFtwrh6mZRl1V6lH56kLigeabRUVeTBn8BocmK3qyodP7Q
         LHNBaWqERtBK/pSxHPBmvS21899oARxPI73AUoCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 18/34] rhashtable: reorganize struct rhashtable layout
Date:   Thu,  7 Feb 2019 12:42:00 +0100
Message-Id: <20190207113026.284710540@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

commit e5d672a0780d9e7118caad4c171ec88b8299398d upstream.

While under frags DDOS I noticed unfortunate false sharing between
@nelems and @params.automatic_shrinking

Move @nelems at the end of struct rhashtable so that first cache line
is shared between all cpus, because almost never dirtied.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/rhashtable.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -133,23 +133,23 @@ struct rhashtable_params {
 /**
  * struct rhashtable - Hash table handle
  * @tbl: Bucket table
- * @nelems: Number of elements in table
  * @key_len: Key length for hashfn
  * @elasticity: Maximum chain length before rehash
  * @p: Configuration parameters
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
 	struct work_struct		run_work;
 	struct mutex                    mutex;
 	spinlock_t			lock;
+	atomic_t			nelems;
 };
 
 /**


