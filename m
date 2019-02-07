Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B57DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052902080A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539911;
	bh=1Xir3KdwxWicQi09zZcXYjGKnuhghIUtrJ/oA7gHGSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2tc3BxYAlJBaEE2SwuE2cHhhhJ/JH8u8yS4Sg5thHtUQtvx8v2JzM09wd7Zg1w1VH
	 Gd3j7zODQODLKCgQP4IKYjOSgOw1j+M10ZmNOqJPRyS0bdIAeQy0wqRiJQKPXbpBfZ
	 sqCOU+V3vGfXzug2tT1c6PtW6xQg6pOUU61C9e58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfBGLnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:43:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbfBGLmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:42:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8EF21907;
        Thu,  7 Feb 2019 11:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539775;
        bh=1Xir3KdwxWicQi09zZcXYjGKnuhghIUtrJ/oA7gHGSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJezqUG8kp48QXEGYTEvvvxEdQ0f2xk/tMgvoyMnCcnEPgOifHSsIR3TDfXqAoDd1
         JYHF0gQTsqQFmTZGO0qGjAuZT7bkvr9c/kSFUhkYZZlTZTe8RHBog7VgH/UNWg/y7Z
         2vP6r4AMUqZxLZsOIVW/Vjhizrty5F8VA5Jp979E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 19/34] inet: frags: reorganize struct netns_frags
Date:   Thu,  7 Feb 2019 12:42:01 +0100
Message-Id: <20190207113026.325520813@linuxfoundation.org>
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

commit c2615cf5a761b32bf74e85bddc223dfff3d9b9f0 upstream.

Put the read-mostly fields in a separate cache line
at the beginning of struct netns_frags, to reduce
false sharing noticed in inet_frag_kill()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 4.4: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/inet_frag.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -4,15 +4,16 @@
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
 	struct inet_frags	*f;
+
+	struct rhashtable       rhashtable ____cacheline_aligned_in_smp;
+
+	/* Keep atomic mem on separate cachelines in structs that include it */
+	atomic_long_t		mem ____cacheline_aligned_in_smp;
 };
 
 /**


