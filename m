Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9954BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF9521104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVT6tahZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF9521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeKZVut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:50:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbeKZVus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:50:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B8792089F;
        Mon, 26 Nov 2018 10:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229823;
        bh=Uhl00aZDAdPdwveWgKnu5v5GM2fqSTGkLIUC+mAI71A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVT6tahZxGy8rmdnj09kUlFX6WZ48VqhKiIdAaHtKNuvbrGUdRsJNv3Blmd9Jmwso
         rI8EDpkU+uHVt5dgaCTn2Rkih9XKOQ94QAAfQHBLzJSpfSQBHKnFU+hUHgezx0w3Yl
         slS35ZT3wAkXuansaewR73zeYLEOQeVpOzt72jVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 16/46] netfilter: ipset: Correct rcu_dereference() call in ip_set_put_comment()
Date:   Mon, 26 Nov 2018 11:51:05 +0100
Message-Id: <20181126105047.719779198@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
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
index 8d0248525957..9f34204978e4 100644
--- a/include/linux/netfilter/ipset/ip_set_comment.h
+++ b/include/linux/netfilter/ipset/ip_set_comment.h
@@ -41,11 +41,11 @@ ip_set_init_comment(struct ip_set_comment *comment,
 	rcu_assign_pointer(comment->c, c);
 }
 
-/* Used only when dumping a set, protected by rcu_read_lock_bh() */
+/* Used only when dumping a set, protected by rcu_read_lock() */
 static inline int
 ip_set_put_comment(struct sk_buff *skb, struct ip_set_comment *comment)
 {
-	struct ip_set_comment_rcu *c = rcu_dereference_bh(comment->c);
+	struct ip_set_comment_rcu *c = rcu_dereference(comment->c);
 
 	if (!c)
 		return 0;
-- 
2.17.1



