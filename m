Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB1FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EE9214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa9L83GK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EE9214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbeKUXql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:46:41 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41211 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKUXqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:46:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so5508769plm.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 05:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OVA19d5rcI4BvomEd5qnimGAF4WeOiUD84lm+QztER8=;
        b=Fa9L83GKB1Jebt4fWgYnZeET3QJm0PalOHv272RwMh8OC5S2b6AoER8R7AXwHSbH9B
         DPvk8dYpzwy5/5MtOv98OUaeQy7qvoSCICgMAxWX0mOnYX8SQlVCQRq9X5DqgPS9LsTC
         fTom9tpwRtYVGCO7WkgvUVIeOFdCQf/c+VlFjd9+YLCJco2IhqmscUNPDFSYacbhkpjI
         Q4PHRlxsOqkdSFKPAOL6Dchwtu/5cgJ2NXHwa5fQP6ULLOe7DVxXH3SwPxtuy/mSsLT8
         DazviqPWec//mUH5Xj8Zc5lJSo2jts36Wsh/8QgTktaoqt2/+gCplElC2L4+xrIUF93U
         F0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OVA19d5rcI4BvomEd5qnimGAF4WeOiUD84lm+QztER8=;
        b=SgwbRTEyZYIbSTtS+c/WpfXxLkKCNjT6Y4+hhJdsgQBBz1qM3iamBHFtpWB3IZurV3
         0BpCouQ73ON8G/bGCZRAO+z6iH9S3ZmV897M1iRV0JsM624n4zexJRudFO7h7fQchnp2
         uKrekAaM79B8y36jg6hOncI6pO9gFrfrHjSsbbcdoYpF2Jsz0W2UDasarWiACZKAPpZo
         sp8Kx0lobfexyCffxjBjwhdxFNCsL9rbaB7Cy34gYVTzEm1xeS2PLmbhv+xmJRIZO4Yo
         Ps/mDUj2tZPPvO/utpXVHsK9y3gS8oGWXdvXlJ1maOYxdXrfTLR3QKK8K/FV5FNTsK+c
         ORWg==
X-Gm-Message-State: AA+aEWZODnhty/5j78+2MrZE9ZMnqDI0cSvWbxmnLu/MxyUtvOZadZnt
        h8DqtgiIcNsLbKEPaAkzNm0=
X-Google-Smtp-Source: AFSGD/W8XLyvqVqH200uh1Ha9rKb9PtxeUkuRnd+OA3TH0iE/mD1MhhDWO3gNgBdZTT5boWgOtDHIQ==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr6807421plb.55.1542805940940;
        Wed, 21 Nov 2018 05:12:20 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id y11-v6sm17185248pfk.70.2018.11.21.05.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 05:12:20 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] tty/sysrq: add of_node_put()
Date:   Wed, 21 Nov 2018 08:12:14 -0500
Message-Id: <20181121131214.22343-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
bl_idle_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/tty/sysrq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index ad1ee5d01b53..4bba54e62204 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -736,6 +736,8 @@ static void sysrq_of_get_keyreset_config(void)
 
 	/* Get reset timeout if any. */
 	of_property_read_u32(np, "timeout-ms", &sysrq_reset_downtime_ms);
+
+	of_node_put(np);
 }
 #else
 static void sysrq_of_get_keyreset_config(void)
-- 
2.17.0

