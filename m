Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3197C64EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AE42089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7AE42089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJBEXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:23:46 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35096 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbeJBEXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:23:45 -0400
Received: by mail-ot1-f65.google.com with SMTP id j9-v6so14775396otl.2;
        Mon, 01 Oct 2018 14:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Az5NjA7D7pxn/8q18ZaQeaoVDR3ADQmGuCcjv9gBHS8=;
        b=rQg7r67djmMFeGcGH0iNKMMdSxBbDL+4gLMnAIG2egvWVGIIj1ctBKKSRLPVEdOvNO
         KxBiN46aZL5woklzqFSCa+5uC8n61+BOo3gdXS9lLO9+2BCvYcwYytv6DjJ7qjaXFPqK
         xXYKHDNDgUroFza/a9XjXvB+wT7ev3oIXJ3fg2ap73PZkvFQYpwH0HSzMPRpACw8ZHmz
         8wpAYlZCCj3K7ckNGuHwYxM6s9DYHnCgLJyWOXEBbda3p/2KGmImowcZqE/e72cb3bS1
         8wqJVDbWMnzZ7JtGLVdOKjj4LYTUKcug0eVtISv2WI213GRWMJzddP+WT4NEzHrzBcpw
         rbYA==
X-Gm-Message-State: ABuFfojLrHTdZnVYp3f3Dr2OBqy2NVGEmWE+s9EFPXK7Tac/exLBbYps
        RHfkX6ugIZtVDEu321tBqTwXI1wh5g==
X-Google-Smtp-Source: ACcGV63kjutL5GzQKEyIcuI6DpQFOyJ9XnobFrHkQG+I3le/j46+164M/8AUgDQVPluxgNhvPtUKvg==
X-Received: by 2002:a9d:5f03:: with SMTP id f3-v6mr8233878oti.166.1538430234469;
        Mon, 01 Oct 2018 14:43:54 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h22-v6sm6401661otd.21.2018.10.01.14.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 14:43:53 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH] power: reset: Convert to using %pOFn instead of device_node.name
Date:   Mon,  1 Oct 2018 16:43:50 -0500
Message-Id: <20181001214351.13230-3-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001214351.13230-1-robh@kernel.org>
References: <20181001214351.13230-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/power/reset/axxia-reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/axxia-reset.c b/drivers/power/reset/axxia-reset.c
index 4e4cd1c8fe50..b16013265142 100644
--- a/drivers/power/reset/axxia-reset.c
+++ b/drivers/power/reset/axxia-reset.c
@@ -65,7 +65,7 @@ static int axxia_reset_probe(struct platform_device *pdev)
 
 	syscon = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
 	if (IS_ERR(syscon)) {
-		pr_err("%s: syscon lookup failed\n", dev->of_node->name);
+		pr_err("%pOFn: syscon lookup failed\n", dev->of_node);
 		return PTR_ERR(syscon);
 	}
 
-- 
2.17.1

