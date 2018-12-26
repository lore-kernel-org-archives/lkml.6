Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9C5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA9B20651
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863933;
	bh=sRTSOC36zQ8yQw8m5DvqJHGo7ksjDmnIfA7uaypIxQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dRWWel1BdHArVDsxnafts1HztOzUIi5vfkGvUP+18IscwB5aQOl2J1x1hWAqYXet5
	 IJ7K6ifOnq3xBBgg7/aqAoGwVuPkbcPyuDYTM/b/lOeC68Kkywk3PdnEzl7oYaWXsB
	 ayljSH12c+0tVRtwpua01gLkFWep6K5dWJXysW7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbeLZWiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:38:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbeLZWij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 515FD2054F;
        Wed, 26 Dec 2018 22:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863918;
        bh=sRTSOC36zQ8yQw8m5DvqJHGo7ksjDmnIfA7uaypIxQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftnH2L9tsxm06fq4F9TUV6b59eS/U3hTe8rzrMKMZKUZd1Vg8noomjzTDKWzGxib9
         Rm/eSSJyDXjFh4+F/HADmtAIJ75+MMzMDqbenvC8exO7sLDM1d2ExjbLOVgk0rPerK
         61Beocqe4sEhDB2YW62qdvvbjdFWKX+ghW4Mq0XI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, sparclinux@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 96/97] serial/sunsu: fix refcount leak
Date:   Wed, 26 Dec 2018 17:35:56 -0500
Message-Id: <20181226223557.149329-96-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

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
index 6cf3e9b0728f..3e77475668c0 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1394,22 +1394,43 @@ static inline struct console *SUNSU_CONSOLE(void)
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

