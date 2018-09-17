Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA959ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC892146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC892146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbeIREe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:34:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49318 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbeIREez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:34:55 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0A0BBC49;
        Mon, 17 Sep 2018 23:05:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 108/126] inet: frags: reorganize struct netns_frags
Date:   Tue, 18 Sep 2018 00:42:36 +0200
Message-Id: <20180917211711.051580944@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

Put the read-mostly fields in a separate cache line
at the beginning of struct netns_frags, to reduce
false sharing noticed in inet_frag_kill()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit c2615cf5a761b32bf74e85bddc223dfff3d9b9f0)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/inet_frag.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -5,16 +5,17 @@
 #include <linux/rhashtable.h>
 
 struct netns_frags {
-	struct rhashtable       rhashtable ____cacheline_aligned_in_smp;
-
-	/* Keep atomic mem on separate cachelines in structs that include it */
-	atomic_long_t		mem ____cacheline_aligned_in_smp;
 	/* sysctls */
 	long			high_thresh;
 	long			low_thresh;
 	int			timeout;
 	int			max_dist;
 	struct inet_frags	*f;
+
+	struct rhashtable       rhashtable ____cacheline_aligned_in_smp;
+
+	/* Keep atomic mem on separate cachelines in structs that include it */
+	atomic_long_t		mem ____cacheline_aligned_in_smp;
 };
 
 /**


