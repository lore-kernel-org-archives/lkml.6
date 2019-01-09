Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4F3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152022146F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FGd1q2Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfAICQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:16:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36655 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfAICQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:16:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so6088556wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 18:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WP9AW2JaG2LYFg4TVAG2uP0iTiVnN9sSaijovwmMgCA=;
        b=FGd1q2ZpBbRxqQ0wO1/P0y/CbKZc1qTxCyQzI1rgw11OxyFC23dTX3tQPoHuj6i/zT
         MD91x6bIGAOBTTJELUhElWEj+e0Wuled9B/dXM8oKU9OSYOyHrW7dCg5GMVwHpyYe/NI
         3HfgtCKlViuEDhPp3SjgiVNidqanC/i2vb1wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WP9AW2JaG2LYFg4TVAG2uP0iTiVnN9sSaijovwmMgCA=;
        b=cPG8B42s5F7PQTf5WXoCQlE4uZEYWWV0wJtLJL07ni/l/MG1P1lcSMbnuHSQH8unL8
         VQP7ncnZ74Iy/NlPECmWb2CMhRmoIJQ1J8RGCLSJu1hH6bTpIH4d2oVSI7x+oE/9Jm0+
         qt00g65ftQpk8ifdt/IbyhMPQtDMZNtxBMKWz+ufahJWi0v97ztkaLAz+X3bOhxrn3KP
         eD+y0zpcGDHpn34hb4xkjtP26BREYuCz/1m6gU18z9yxj0JTcUBLCeSlu1E9T3o/zhf0
         lp3oI+R4NRPvWxP48bdxjgSdmjcZSKfiq0tLEzFhNeNnRMdF+iCdqSdKoE4wUOO9hvUm
         Jjgw==
X-Gm-Message-State: AJcUukddzsbzBLz9ZjdZAke0cpRv6HgpMXKMRyUHWF42jWmA1celbr4Y
        7sg2I7+hZUNdrkt1aIPgQvQj/w==
X-Google-Smtp-Source: ALg8bN5cGvuXep07gNEPr8i3CgOuh0Op0TtjqX2nym7Dvuk+QpqQNOQMhjTSn7vNj4ZGHHzIaGTibw==
X-Received: by 2002:a5d:5182:: with SMTP id k2mr3184118wrv.121.1547000201816;
        Tue, 08 Jan 2019 18:16:41 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:99e2:bc56:9ad9:69c5])
        by smtp.gmail.com with ESMTPSA id w18sm48118868wru.54.2019.01.08.18.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Jan 2019 18:16:41 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        rjw@rjwysocki.net, ulf.hansson@linaro.org, tony@atomide.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] PM/runtime: Fix autosuspend_delay on 32bits arch
Date:   Wed,  9 Jan 2019 03:16:28 +0100
Message-Id: <1547000188-2732-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast autosuspend_delay in u64 to make sure that the full computation of
expires will be done in u64, even on 32bits arch.
Otherwise, any delay greater than 2^31 nsec can overflow if signed 32bits
is used when moving delay from msec to nsec

Fixes: 8234f6734c5d ("PM-runtime: Switch autosuspend over to using hrtimers")
Reported-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7062469..44c5c76 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -141,7 +141,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 
 	last_busy = READ_ONCE(dev->power.last_busy);
 
-	expires = last_busy + autosuspend_delay * NSEC_PER_MSEC;
+	expires = last_busy + (u64)(autosuspend_delay) * NSEC_PER_MSEC;
 	if (expires <= now)
 		expires = 0;	/* Already expired. */
 
-- 
2.7.4

