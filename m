Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BC0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848922147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8fGEx/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848922147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbeJQBRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:17:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:17:09 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5014A204EC;
        Tue, 16 Oct 2018 17:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710742;
        bh=4lWIhtWpEzUXRt+xVM4G+xBS910Um42bnZ49szdbDuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r8fGEx/q2yA84692aUMJnLWfSpS7j41hF6xI97PYcuL77ex6E2BL/azSCs5PqK2rn
         97OXghgAbZZmKBsjD9aofaIB/n476M3vrdDYtSZ4PaYn30V8ACorKu0N1K6TPz2/DY
         5cFCOlm/AkIKaHEllqqsOpvkAxrNBHWjG9PLCvIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 49/71] rhashtable: add schedule points
Date:   Tue, 16 Oct 2018 19:09:46 +0200
Message-Id: <20181016170541.823906038@linuxfoundation.org>
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

Rehashing and destroying large hash table takes a lot of time,
and happens in process context. It is safe to add cond_resched()
in rhashtable_rehash_table() and rhashtable_free_and_destroy()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit ae6da1f503abb5a5081f9f6c4a6881de97830f3e)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/rhashtable.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -251,8 +251,10 @@ static int rhashtable_rehash_table(struc
 	if (!new_tbl)
 		return 0;
 
-	for (old_hash = 0; old_hash < old_tbl->size; old_hash++)
+	for (old_hash = 0; old_hash < old_tbl->size; old_hash++) {
 		rhashtable_rehash_chain(ht, old_hash);
+		cond_resched();
+	}
 
 	/* Publish the new table pointer. */
 	rcu_assign_pointer(ht->tbl, new_tbl);
@@ -993,6 +995,7 @@ void rhashtable_free_and_destroy(struct
 		for (i = 0; i < tbl->size; i++) {
 			struct rhash_head *pos, *next;
 
+			cond_resched();
 			for (pos = rht_dereference(tbl->buckets[i], ht),
 			     next = !rht_is_a_nulls(pos) ?
 					rht_dereference(pos->next, ht) : NULL;


