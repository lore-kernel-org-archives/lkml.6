Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F53BC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B70120866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ga24jAnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B70120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbeJQBQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:16:20 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 639CE20866;
        Tue, 16 Oct 2018 17:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710694;
        bh=7KkJe5SBNQN7tpnHXL9VtI4NDeylxfbk0r6TMICSNX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ga24jAnFl1pu1Hva+wIcx6BXWk/ofw/HmN2iR92G5Ji9CCpXyp9Z3iJe2qwJtKQEt
         eVNpeltFeZBKj6SmdiQG3Q6PW1FnCPExQL7pyQOlNbZs61UiIHy2GkK7CGdyU+aCFw
         dhBoWnMIn+trROF/xtd0hYcnKB6qbbCQaulQhISQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 58/71] inet: frags: reorganize struct netns_frags
Date:   Tue, 16 Oct 2018 19:09:55 +0200
Message-Id: <20181016170542.276848195@linuxfoundation.org>
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
@@ -4,16 +4,17 @@
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


