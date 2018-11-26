Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA734C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8197021479
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClfF5wDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8197021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbeKZV5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:57:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbeKZV5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:57:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D05620645;
        Mon, 26 Nov 2018 11:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230202;
        bh=TOaeQZRScDvdewOaGX4xlsW11hW/6x1Mp/eOzDrjCa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ClfF5wDsuiom41c6PO8naaP7pJq+FqgoNOkh1fkQx9MWORPfDR4qcNhTCEqvphDWH
         6nsnVSNB4eS71fvd5TuT1dJ7WnIuecMKFCo4ZKck6NUVD5md3tuXHVBe9JfXfpDYav
         ak7zSRS032hTmZ9cQeu8WHfpOs+Yk4metogH49yk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 047/118] netfilter: ipset: Correct rcu_dereference() call in ip_set_put_comment()
Date:   Mon, 26 Nov 2018 11:50:41 +0100
Message-Id: <20181126105102.705718381@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 17b8b74c0f8dbf9b9e3301f9ca5b65dd1c079951 ]

The function is called when rcu_read_lock() is held and not
when rcu_read_lock_bh() is held.

Signed-off-by: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/netfilter/ipset/ip_set_comment.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/netfilter/ipset/ip_set_comment.h b/include/linux/netfilter/ipset/ip_set_comment.h
index 8e2bab1e8e90..70877f8de7e9 100644
--- a/include/linux/netfilter/ipset/ip_set_comment.h
+++ b/include/linux/netfilter/ipset/ip_set_comment.h
@@ -43,11 +43,11 @@ ip_set_init_comment(struct ip_set *set, struct ip_set_comment *comment,
 	rcu_assign_pointer(comment->c, c);
 }
 
-/* Used only when dumping a set, protected by rcu_read_lock_bh() */
+/* Used only when dumping a set, protected by rcu_read_lock() */
 static inline int
 ip_set_put_comment(struct sk_buff *skb, const struct ip_set_comment *comment)
 {
-	struct ip_set_comment_rcu *c = rcu_dereference_bh(comment->c);
+	struct ip_set_comment_rcu *c = rcu_dereference(comment->c);
 
 	if (!c)
 		return 0;
-- 
2.17.1



