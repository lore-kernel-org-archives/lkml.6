Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA615C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AB5208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039492;
	bh=Hrc9EDA1bzNEKcRRwl1h1gkcKf8rR76y+NpYXWrdrl0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eRvZ4pBM3OekxhJsMMlQBnDs26T95u9cTND1mwvf17O8egqCPbP/HFjnh2y4HmITY
	 y/ZRDzGayjEDjgDbM0kjulydUhLQBwWeJDJdEe6cEZNrRG9uSbA0civA+PsYG8c2Zh
	 dfA/FHmO93IGs8QeP1eQn5DODBCW6Ni6GecqZAnI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AB5208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbeLETvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:51:31 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35913 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbeLETv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:27 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so18636505oix.3;
        Wed, 05 Dec 2018 11:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NfslrJYf7trre70F0tuzbENqa0jJOZcBdjPIsSp0w/4=;
        b=GOSkczjv03lT9Sx3FFMy35B7bAPqh/sSkvNT+Mr1Dg6QXeVFP0B17eh72MLZcgS5BD
         yTaXghhPOWzV/kYCEb35yCwho7bsfYWtIKEt3KO4VrV840NAjA4ynSmWmLME8BIuQyAB
         YUUEdSN/Ql7UWXGuxUw6AtC0loxIlUYfDZ9m2wxRtAuIaxVlUlKsKzHhibvNDgp65rj+
         qYCG/1My36BVlq10eyfpwdfNO35aKU4DEV3L99JK2EEsdHfR3yfrKu97EpMqbZVc1nUM
         6gZzrl0CpQNep7HcUZCZSUkJpRHR2fdR5/uNzs3PFs0aWVXV3iRNaDAsjwHHmzjNsCNb
         Yefg==
X-Gm-Message-State: AA+aEWZQ4xaPUosDMbo+zew0mKZx03YusMpNjkrcTF8YKNF6Xxgvuv9i
        Y7dqJcp19jSfVCED0T7K/zhr8HHVWQ==
X-Google-Smtp-Source: AFSGD/XcVf8HePz3RRrSqiZ3ZMP7n9DOTqYHwuV6Psyg9BNf8rG9Ng/yXyIYJsAtEn8lvwXHIfjjaA==
X-Received: by 2002:aca:da02:: with SMTP id r2mr15034703oig.66.1544039486023;
        Wed, 05 Dec 2018 11:51:26 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:25 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH] ALSA: sparc: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:47 -0600
Message-Id: <20181205195050.4759-31-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 sound/sparc/cs4231.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index e73c962590eb..f707cd4886c3 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -2075,12 +2075,12 @@ static int cs4231_ebus_probe(struct platform_device *op)
 static int cs4231_probe(struct platform_device *op)
 {
 #ifdef EBUS_SUPPORT
-	if (!strcmp(op->dev.of_node->parent->name, "ebus"))
+	if (of_node_name_eq(op->dev.of_node->parent, "ebus"))
 		return cs4231_ebus_probe(op);
 #endif
 #ifdef SBUS_SUPPORT
-	if (!strcmp(op->dev.of_node->parent->name, "sbus") ||
-	    !strcmp(op->dev.of_node->parent->name, "sbi"))
+	if (of_node_name_eq(op->dev.of_node->parent, "sbus") ||
+	    of_node_name_eq(op->dev.of_node->parent, "sbi"))
 		return cs4231_sbus_probe(op);
 #endif
 	return -ENODEV;
-- 
2.19.1

