Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FD0C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405F5218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9u+Etsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeLZNVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:21:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40943 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeLZNVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:21:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so7865576pfo.7;
        Wed, 26 Dec 2018 05:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uSsdMkjHIATB6sU1R5ZpsqhHSBi5yvQoA4EyHCSaEhI=;
        b=K9u+EtsqBHpucT/R5/6nPbTM7DtL983hxY/UMLjXqiVq8dQJgqrmHupupFTwdFfkO6
         V5wrI1XIxaRyrjqxfeWl2hHbndzrSm+xKLNxY5Jvzbxxt+ZYLllaBAtYJCNlk0LoxAHg
         siXEmVaTBKSbO6YSs1aEZnQydU8eyz+HGmuhvdDziYjGy2+fJNB2DaxUHmEAvA0pklak
         Q+mD2PPIfySYAKA4jbHglfBtSr2XTQxwU7iJ2/8RJce/4vSkBbhOoKRIfzboJW+WwxEe
         eDkatZDvgPYeTkfREuRbv6GbroYign69oD9dK2tm7LzfRsSsmoYhvktjeJmlVHdNlBY6
         LZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uSsdMkjHIATB6sU1R5ZpsqhHSBi5yvQoA4EyHCSaEhI=;
        b=EU8QHIW1rODfM3K9RVmwdx44pzEKaCli1ynLOdhwTWZTzrN/kZJ6YRyZifwVsVhwtk
         HMX/zcHEweKBk4sOuh2QvsZ2Zefr4VqSw1V8Kqq2X6QcIdHfrOjxJprrkbErDRH9h+2+
         li5DlwVqEkKqcFcd9IH+plZ/IEt4U94VUuMCnsowPipSO8fNjRjujFVx9+QCGncHcfQF
         f6dGFC+tX+0dF4z1YxsIcmLsI8e+uu94sITry8gNFwotXCkb2vW5fKLY4kA7/S2m98WC
         /CEEsaOeIDUVrMLYiCoS9ggGmMFt/05Afu4KF1j3qEEGBnMNAlXWgxmjxyJat6o5Ci62
         /q/g==
X-Gm-Message-State: AA+aEWbradYBqH50sTTJPoRiYfcXuMcZRYmLn0rrRgwFNCrc3h3HaA7s
        fwzOLRyz07e+Jy8Xy7nlTY4=
X-Google-Smtp-Source: AFSGD/UQ9PdMtGDW00dxc1lzow5j/YhnrKINxRGmz0l82AlFBOUi88kd8MNom1BTF7i9fXeoqYk6DA==
X-Received: by 2002:a62:444b:: with SMTP id r72mr20468511pfa.184.1545830494414;
        Wed, 26 Dec 2018 05:21:34 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id d13sm39190607pfd.58.2018.12.26.05.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 05:21:33 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: ti: fix refcount leak in ti_dt_clocks_register()
Date:   Wed, 26 Dec 2018 08:21:31 -0500
Message-Id: <20181226132131.4619-1-tiny.windzz@gmail.com>
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
 drivers/clk/ti/clk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index d0cd58534781..6c640838cdaa 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -191,9 +191,13 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 			clkdev_add(&c->lk);
 		} else {
 			if (num_args && !has_clkctrl_data) {
-				if (of_find_compatible_node(NULL, NULL,
-							    "ti,clkctrl")) {
+				struct device_node *np;
+
+				np = of_find_compatible_node(NULL, NULL,
+					       		     "ti,clkctrl");	
+				if (np) {
 					has_clkctrl_data = true;
+					of_node_put(np);
 				} else {
 					clkctrl_nodes_missing = true;
 
-- 
2.17.0

