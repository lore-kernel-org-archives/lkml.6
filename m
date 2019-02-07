Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2A8C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E942190C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539821;
	bh=DM2fWN6SC8lsQFEUud3PAG88ZbXDbGbDvKsBAgz+q9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zNdErl2++dHaN7SJXnKFojBalFpPk7LuBFSLgDuu3AoOkbbL6v7Q77mR8vTzJ//xh
	 ObPhfQce/qzBTf6vrQNK0km7a6vfmEB6qUczhZxxSG6t1vfjfMj5bMAUxYREIIuVCX
	 O0DCx5mXy7gtkXHYDrWhTIV2aOeVhCdKaZ88Sdps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfBGLnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:43:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbfBGLni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:43:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D84E21907;
        Thu,  7 Feb 2019 11:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539817;
        bh=DM2fWN6SC8lsQFEUud3PAG88ZbXDbGbDvKsBAgz+q9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JwM6WTB5snMQ+ghVWufXZLapsCVwK699ZAlpNcWZUXPV4IkSwFJv6FGYfCNYgJskc
         tE00M6k5vajqtJJZQmY9Cj3lid4LBHiTvUFDOwDdf2+UjCQgrrRi26QiJuolFl8ahH
         D7Z6htFZIgkdK3A3w4hynfXNwTinDWxwmk7Iu2j0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 08/34] rhashtable: add schedule points
Date:   Thu,  7 Feb 2019 12:41:50 +0100
Message-Id: <20190207113025.890542584@linuxfoundation.org>
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

commit ae6da1f503abb5a5081f9f6c4a6881de97830f3e upstream.

Rehashing and destroying large hash table takes a lot of time,
and happens in process context. It is safe to add cond_resched()
in rhashtable_rehash_table() and rhashtable_free_and_destroy()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/rhashtable.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -250,8 +250,10 @@ static int rhashtable_rehash_table(struc
 	if (!new_tbl)
 		return 0;
 
-	for (old_hash = 0; old_hash < old_tbl->size; old_hash++)
+	for (old_hash = 0; old_hash < old_tbl->size; old_hash++) {
 		rhashtable_rehash_chain(ht, old_hash);
+		cond_resched();
+	}
 
 	/* Publish the new table pointer. */
 	rcu_assign_pointer(ht->tbl, new_tbl);
@@ -842,6 +844,7 @@ void rhashtable_free_and_destroy(struct
 		for (i = 0; i < tbl->size; i++) {
 			struct rhash_head *pos, *next;
 
+			cond_resched();
 			for (pos = rht_dereference(tbl->buckets[i], ht),
 			     next = !rht_is_a_nulls(pos) ?
 					rht_dereference(pos->next, ht) : NULL;


