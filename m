Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B60DECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE1920664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE1920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbeJaXks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:40:48 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43912 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbeJaXkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:40:47 -0400
Received: by mail-oi1-f195.google.com with SMTP id j202-v6so13362693oih.10;
        Wed, 31 Oct 2018 07:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zrGlurET2Jt29KSx4p05ubi1A5A5HoCWodQot7XFbu0=;
        b=Ue3LgkxbEahSU7hbfQGDiTdRqUMiEW2cdeLyRn35Mt/8YbteKXuAiN8SYUqmCbzOFo
         7GcNdPyztFJf66b6/PMpx8CZj6yBhNsrR4WASxVsl0JxHNU4i6z8OQiZi2uArQF6/0kB
         LOdCtZm3j2zw42kIcSr7NXzK5IxrCgSpI64Dr+N4L5H3nR6u+CXfp4Y+26EK7zN9MoyC
         qymY3+qTwLGpqB4L5E6jdhl/m7+b20GckDXgD1LDl/z/TaHixc/HheB+YCBtp34y9CGI
         CKXVqSsDcukc2vkROaWqDnls9VvqhOHegHhkNU2jxsORgo8WP7yfYA0kDHcsRbDoVzWM
         DV8g==
X-Gm-Message-State: AGRZ1gL766EMm2v8ahAHrva6Evw29R0p2KI7QQ3GHSx2Ddhbey9o8Sjh
        nN4MuQ8rBzTwhV9JaslAhA==
X-Google-Smtp-Source: AJdET5eDkna1wYrRqCZ7py2YmTDVo6zy+VYtvGLuzXDwP4POQtyKUEtW3y81Zg0GirHs6cBuGjhhKg==
X-Received: by 2002:aca:e144:: with SMTP id y65-v6mr2046040oig.289.1540996948110;
        Wed, 31 Oct 2018 07:42:28 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id d131-v6sm12381705oih.4.2018.10.31.07.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 07:42:27 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] of: Fix cpu node iterator to not ignore disabled cpu nodes
Date:   Wed, 31 Oct 2018 09:42:26 -0500
Message-Id: <20181031144226.26747-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In most cases, nodes with 'status = "disabled";' are treated as if the
node is not present though it is a common bug to forget to check that.
However, cpu nodes are different in that "disabled" simply means offline
and the OS can bring the CPU core online. Commit f1f207e43b8a ("of: Add
cpu node iterator for_each_of_cpu_node()") followed the common behavior
of ignoring disabled cpu nodes. This breaks some powerpc systems (at
least NXP P50XX/e5500). Fix this by dropping the status check.

Fixes: 651d44f9679c ("of: use for_each_of_cpu_node iterator")
Fixes: f1f207e43b8a ("of: Add cpu node iterator for_each_of_cpu_node()")
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index cc62da278663..e47c5ce6cd58 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -776,8 +776,6 @@ struct device_node *of_get_next_cpu_node(struct device_node *prev)
 		if (!(of_node_name_eq(next, "cpu") ||
 		      (next->type && !of_node_cmp(next->type, "cpu"))))
 			continue;
-		if (!__of_device_is_available(next))
-			continue;
 		if (of_node_get(next))
 			break;
 	}
-- 
2.19.1

