Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96116C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A51520672
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZQz3kxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A51520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeLLQBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:01:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40891 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLLQBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:01:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so8793775plq.7;
        Wed, 12 Dec 2018 08:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=z8AEV8YVh1lx17ItldL1ODSRycKNjiolTBWh3tOLxR0=;
        b=OZQz3kxD5iVHSWNlcAVMh+0Uw3zX6/pBH7v1M31NJ3m+DZDL7G+uqkYdJ1w+pgpSSi
         TfwlBbpPC+SG5Q7b7N+aLn+0gkheQU44pcxXAyvR9TJuzBzZg8KZic9dNy4pwNEg6JjF
         W2xGkMUt8686xnJDdokBlezjrq7BxGj0Wo5bx+kwGloUDVYPg4i11OyEyUH48zRJQQw2
         uNAlWM8g4Iz6kbe4yDbRYmAI67AILVdIbWV6iEtHnqu20U8tVLwDiqHq1QveI4s0fywa
         9zslXfLxBWewB3rqoYtcWwL+fjrdAvv1cJmPqkVUNpv+gJVL57qFpwhg1oUyv5xWR9ja
         9p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z8AEV8YVh1lx17ItldL1ODSRycKNjiolTBWh3tOLxR0=;
        b=RekSrXuZZhr0YJx+UXgeh1MDgvYM/bXQPIcCh9W8Lfyjy5Kfafeq8/PsC0kHhFnABa
         XurRdwG6c38s0PzlhuPhxgy7oed/dEGF+s0kGs6ZePOOh5R4GRtCTKqMTpAFElroKqLB
         Gqsi5iFlGJQdR+JAUEnXFtdtZK7oXjQLDl6RMVYnyYEd9r9NBrM3bK7v6KUs2aPfZ6u+
         cBKZkOK5cJ2T85I11DXK6q4WeQCKC+OJ7/0oSO/Omk7HDB9H9uJslvQQCXjP817eE2m6
         WQSuebGTgTZwgEm9Faq3gJxrNlwrCh3b5Rv3KJx0U1JrFayx7jqmqjCTomvbVlmT4bRG
         sKJA==
X-Gm-Message-State: AA+aEWbb+rRWSTOf/Sr7wSdJK7Ru0SpJnf7tP2C/qD8LPqozarG/9n+m
        qeHZ9NruKSP5jPZFrKUp714=
X-Google-Smtp-Source: AFSGD/XEB9ArCb/iTZ8z67ugBlUFbpjrwtaTu0jpUt/Q1iT6KZfs9ak0QHKbko8HjisrLtO5BqhGVg==
X-Received: by 2002:a17:902:e08b:: with SMTP id cb11mr20516170plb.263.1544630514601;
        Wed, 12 Dec 2018 08:01:54 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id m20sm18580354pgv.93.2018.12.12.08.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 08:01:53 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jslaby@suse.com,
        sparclinux@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] serial/sunsu: fix refcount leak
Date:   Wed, 12 Dec 2018 11:01:45 -0500
Message-Id: <20181212160145.23117-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.

su_get_type() doesn't do that. The match node are used as an identifier
to compare against the current node, so we can directly drop the refcount
after getting the node from the path as it is not used as pointer.

Fix this by use a single variable and drop the refcount right after
of_find_node_by_path().

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/tty/serial/sunsu.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 6cf3e9b0728f..c5428b0426a9 100644
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
2.17.0

