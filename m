Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717C3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A1A21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB0pFqcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A1A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbeKUXXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:23:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36603 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbeKUXXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:23:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id y6-v6so5430956plt.3;
        Wed, 21 Nov 2018 04:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zSoog5Zh0R7CHn1ZePSgECyQFW2V9O5FCNv6qgqIxd0=;
        b=PB0pFqcWJcDfWs4VgpuV8HXevLp94rz7zaPl/AupX+RQCfW8Ga0pQh8eA+4/K7YVxg
         IuJb+n3L/Ib642fkJsS+0Ghvo+gf4JBOBY0d5ZZe6jO4lpxNn+rwgLlnuWZrPl5WX8hC
         oAnH7uwxo28+ydmijGpqUzRgNpwfvd0b9fGvPn9JhXo0aFil7xVnSD+MRH+gcyJhAu1t
         EuCYC/7H74Waf3yiPhWP7Uv52eEAEhUAyBPcFV8LVKbyBpd1kMm8HzpKo8jRKuTweWQP
         SOERomyYtVLTVNW733Dktzl20F1RubnRsBCjQUe2IPauZS2lTLKjOLvcciOPn7MZArGK
         CELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zSoog5Zh0R7CHn1ZePSgECyQFW2V9O5FCNv6qgqIxd0=;
        b=oiRxXnfxwgk2qTXmlVmonjJMGO1qah0Xl4hXmlw1zHnzc8FWdeu6dUvMKs/HChNr4X
         Uq0348XLLYbgfr6JUz7INzuoYbZoH0kpvNVU1df2rPqQsZOL627tI1OZXYAw3LEQYq3f
         KLflweRgcH3WjfhtLOhrR3iDug118Pk2Sl7cWkZ1qx/HcnjYvYHI/4T9O1rlyZ8/Nf4O
         IK2aW1lNL4oxeceu3mc7vNJc/bIY8LzPWFKs4uKJdc3xtmdNd8LIOyv8bU8IZYqwwt5s
         X3V92gRyUbnLgkcN8yFVitcC9MJaG3+zOKwlEUJfMGjQJH7pgMgbypS5GCGeB0ti6PqE
         1lrQ==
X-Gm-Message-State: AA+aEWau4FpK7idtt2FbDx/aC0xpdkucVb8Tk3GEzBaKbA1LSKsNgza+
        uTszJmhR2PmyYn3fK0veNsA=
X-Google-Smtp-Source: AFSGD/U7UvKUS+hXWS4Y+UTABRBG2TQsPTrW8amDs9XTlQqNCgx8vr2dLoZ9LjqVZKUGw4FzUGqeQA==
X-Received: by 2002:a17:902:a58a:: with SMTP id az10mr6852184plb.151.1542804556271;
        Wed, 21 Nov 2018 04:49:16 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id f13sm29088365pfa.132.2018.11.21.04.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 04:49:15 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] soc/tegra: add of_node_put()
Date:   Wed, 21 Nov 2018 07:49:12 -0500
Message-Id: <20181121124912.22074-1-tiny.windzz@gmail.com>
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
 drivers/soc/tegra/common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index cd8f41351add..2e30604c9658 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -23,10 +23,13 @@ static const struct of_device_id tegra_machine_match[] = {
 bool soc_is_tegra(void)
 {
 	struct device_node *root;
+	bool rc;
 
 	root = of_find_node_by_path("/");
 	if (!root)
 		return false;
 
-	return of_match_node(tegra_machine_match, root) != NULL;
+	rc = of_match_node(tegra_machine_match, root) != NULL;
+	of_node_put(root);
+	return rc;
 }
-- 
2.17.0

