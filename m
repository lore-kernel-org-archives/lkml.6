Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91657C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CFA218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSif7DwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeLZNcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:32:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38204 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeLZNcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:32:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so7877807pfi.5;
        Wed, 26 Dec 2018 05:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oXiqN+RrYGdfkWEsu1YpPKuSwaRt/K9PJb7pt5kxUUk=;
        b=NSif7DwUlw5nSUGeOq/82phz7UDVUH/7HepPkT5w/8gSEv6+d6T8lNqYjMrYNUdcnp
         covR7MM2dNajHbu/rE4xnMY2QVKOfHOD+S49xLzhQNGtCidpejotzX4+t15nH4oforDr
         FqWpRSEiQN0u1mvbSGZy2n1ecBZrmfz6ljdXha4bMk8dnF9DuPGTARy4VJDtFe6mKEuq
         RmHijbKgexo8KtSQ2ceX21YjfNUiPEvpzUKwZnqb8XJPp4Hs+8xcfJWT/9um109tqS/K
         XpQvIAaQ5gV6DZFOAvDO/zwl7nkjQiFpg7X8S4auo2b+8S+b2WQ5pp1poby9RwTqX0pC
         2Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oXiqN+RrYGdfkWEsu1YpPKuSwaRt/K9PJb7pt5kxUUk=;
        b=JifyeMZMxVI73waEbvCSxGxbnUZtzSlJhkine3YeVMMG4lS9Y2ztxxPNKROiiIpdf5
         wcnvNECnpHdMJsSBs9d14r9idN4J1s02fA0Y4Gk0+6QFacr4auwnZQEiJ+kJrR3zXX0e
         mYyb5K4J7q3OtVbVIT6ReR7xNzngU4KFOk0dZfV4jlDp4DbQNha2I/ZsHUmRPYtq/FOY
         zvo1fNrOlNmdMe+ZuBDi2jIKsjbsdeU0BSjLiWA4qodwNrdBDwxvH72IwBiFXpht5tAL
         NhXSX+8LnZ4rzX7hMAdcMcOZS7X6dJYkMHzLxR+5oIR8ftsO89uBUEubDi9iLIOpj7dk
         zQTA==
X-Gm-Message-State: AJcUukfcIyhvngBvQ7LpoMZooYyK59kg92L4xFtQz9Rc1Csp+ExtGpbE
        XbkgpYmjm5CNTPr+7VMYoNY=
X-Google-Smtp-Source: ALg8bN78uGlG2vYyUhfFJAmY421lVnBEi97xot6zFgkG2FDfmJoi3aYMa3kjUpaMRSJ1EzkzZ2pO6g==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr18770862pgh.265.1545831138571;
        Wed, 26 Dec 2018 05:32:18 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 125sm67850226pfd.124.2018.12.26.05.32.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 05:32:17 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
        kgene@kernel.org, krzk@kernel.org
Cc:     linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: samsung: exynos4: fix refcount leak in exynos4_get_xom()
Date:   Wed, 26 Dec 2018 08:32:15 -0500
Message-Id: <20181226133215.4939-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clk/samsung/clk-exynos4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 59d4d46667ce..54066e6508d3 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1028,6 +1028,7 @@ static unsigned long __init exynos4_get_xom(void)
 			xom = readl(chipid_base + 8);
 
 		iounmap(chipid_base);
+		of_node_put(np);
 	}
 
 	return xom;
-- 
2.17.0

