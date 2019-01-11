Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AE8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC3C21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216908;
	bh=WhsYUguK6nj1qTIV3emBEfUNIGNjLjl3vBIQh6xg8Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZGolCRZVfy3wKM+hwMwYx4DWvUZE9yUQAi9jcWacLKpUzV8sWy6ta/zoXCIQZyqLP
	 QUuyhNVjVUOdeTr5QqqWoDjp2KkJWpBGDpEhiwLzUxId0/LagK0dXBE4PDMn8tJyEU
	 PiPOC41DhjOdi0SKaC0RA5Ku1y0K96wBahBpMyKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbfAKO21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:28:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388497AbfAKO2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:28:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26CB121841;
        Fri, 11 Jan 2019 14:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216898;
        bh=WhsYUguK6nj1qTIV3emBEfUNIGNjLjl3vBIQh6xg8Jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pt67cLZSzNxEz866AG/AQ9IG6g1nuA3gXvrZZvnx81UKrXALSTUEmzJlgoMjikSp5
         GMMvzALeU3inyPYj7juLQdZYbXbpc+ajw7qJrFMGhONZKTUCdRJzyIgMgUfwDyJ4QN
         XbLGrHSeZKvlv6T0hLBbnopWCCwbgsCd+eEeCSLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 32/63] serial/sunsu: fix refcount leak
Date:   Fri, 11 Jan 2019 15:14:35 +0100
Message-Id: <20190111131050.663667976@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d430aff8cd0c57502d873909c184e3b5753f8b88 ]

The function of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.

su_get_type() doesn't do that. The match node are used as an identifier
to compare against the current node, so we can directly drop the refcount
after getting the node from the path as it is not used as pointer.

Fix this by use a single variable and drop the refcount right after
of_find_node_by_path().

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sunsu.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 9ad98eaa35bf..26ae83026c52 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1393,22 +1393,43 @@ static inline struct console *SUNSU_CONSOLE(void)
 static enum su_type su_get_type(struct device_node *dp)
 {
 	struct device_node *ap = of_find_node_by_path("/aliases");
+	enum su_type rc = SU_PORT_PORT;
 
 	if (ap) {
 		const char *keyb = of_get_property(ap, "keyboard", NULL);
 		const char *ms = of_get_property(ap, "mouse", NULL);
+		struct device_node *match;
 
 		if (keyb) {
-			if (dp == of_find_node_by_path(keyb))
-				return SU_PORT_KBD;
+			match = of_find_node_by_path(keyb);
+
+			/*
+			 * The pointer is used as an identifier not
+			 * as a pointer, we can drop the refcount on
+			 * the of__node immediately after getting it.
+			 */
+			of_node_put(match);
+
+			if (dp == match) {
+				rc = SU_PORT_KBD;
+				goto out;
+			}
 		}
 		if (ms) {
-			if (dp == of_find_node_by_path(ms))
-				return SU_PORT_MS;
+			match = of_find_node_by_path(ms);
+
+			of_node_put(match);
+
+			if (dp == match) {
+				rc = SU_PORT_MS;
+				goto out;
+			}
 		}
 	}
 
-	return SU_PORT_PORT;
+out:
+	of_node_put(ap);
+	return rc;
 }
 
 static int su_probe(struct platform_device *op)
-- 
2.19.1



