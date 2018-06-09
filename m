Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /HtnFgLzG1tQYAAAmS7hNA
	; Sat, 09 Jun 2018 15:32:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 411B2608BF; Sat,  9 Jun 2018 15:32:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2wKZygD"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A8B92608B8;
	Sat,  9 Jun 2018 15:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8B92608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbeFIPcQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932395AbeFIPcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:32:12 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 541E9204EC;
        Sat,  9 Jun 2018 15:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558331;
        bh=P9iJlQFFlZfIUvIqNGLiSCbc4TUZYyVUddHbClJUjic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S2wKZygDl7g8pXDj3Dg3rOeXw2GH4omy55754pMLTKK/Ez1NJuI703k+EjnjPc05y
         wZqR/EDdW1w1aKhBg+QSo77ZcvEhQg4uCxfzawVYQd34mXQS31By7m089SlRT/QPQ3
         Zg2qP8iOHBlYlTFhNGJ3n/AIpgoyCMX3e4y0YXWU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlad Buslov <vladbu@mellanox.com>,
        Roi Dayan <roid@mellanox.com>, Jiri Pirko <jiri@mellanox.com>,
        Paul Blakey <paulb@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 07/48] cls_flower: Fix incorrect idr release when failing to modify rule
Date: Sat,  9 Jun 2018 17:29:19 +0200
Message-Id: <20180609145948.147600514@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Blakey <paulb@mellanox.com>

[ Upstream commit 8258d2da9f9f521dce7019e018360c28d116354e ]

When we fail to modify a rule, we incorrectly release the idr handle
of the unmodified old rule.

Fix that by checking if we need to release it.

Fixes: fe2502e49b58 ("net_sched: remove cls_flower idr on failure")
Reported-by: Vlad Buslov <vladbu@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Paul Blakey <paulb@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_flower.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -974,7 +974,7 @@ static int fl_change(struct net *net, st
 	return 0;
 
 errout_idr:
-	if (fnew->handle)
+	if (!fold)
 		idr_remove(&head->handle_idr, fnew->handle);
 errout:
 	tcf_exts_destroy(&fnew->exts);
