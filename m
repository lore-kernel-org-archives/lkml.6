Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DEAC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C47A20895
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C47A20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404778AbeHGVQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:16:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404424AbeHGVQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:16:20 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 00BBF74;
        Tue,  7 Aug 2018 19:00:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>, Florian Westphal <fw@strlen.de>,
        Peter Oskolkov <posk@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 74/85] inet: frag: enforce memory limits earlier
Date:   Tue,  7 Aug 2018 20:52:16 +0200
Message-Id: <20180807172400.103557595@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 56e2c94f055d328f5f6b0a5c1721cca2f2d4e0a1 ]

We currently check current frags memory usage only when
a new frag queue is created. This allows attackers to first
consume the memory budget (default : 4 MB) creating thousands
of frag queues, then sending tiny skbs to exceed high_thresh
limit by 2 to 3 order of magnitude.

Note that before commit 648700f76b03 ("inet: frags: use rhashtables
for reassembly units"), work queue could be starved under DOS,
getting no cpu cycles.
After commit 648700f76b03, only the per frag queue timer can eventually
remove an incomplete frag queue and its skbs.

Fixes: b13d3cbfb8e8 ("inet: frag: move eviction of queues to work queue")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Jann Horn <jannh@google.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Peter Oskolkov <posk@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/inet_fragment.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -379,11 +379,6 @@ static struct inet_frag_queue *inet_frag
 {
 	struct inet_frag_queue *q;
 
-	if (frag_mem_limit(nf) > nf->high_thresh) {
-		inet_frag_schedule_worker(f);
-		return NULL;
-	}
-
 	q = kmem_cache_zalloc(f->frags_cachep, GFP_ATOMIC);
 	if (q == NULL)
 		return NULL;
@@ -420,6 +415,11 @@ struct inet_frag_queue *inet_frag_find(s
 	struct inet_frag_queue *q;
 	int depth = 0;
 
+	if (!nf->high_thresh || frag_mem_limit(nf) > nf->high_thresh) {
+		inet_frag_schedule_worker(f);
+		return NULL;
+	}
+
 	if (frag_mem_limit(nf) > nf->low_thresh)
 		inet_frag_schedule_worker(f);
 


