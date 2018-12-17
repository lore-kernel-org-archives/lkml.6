Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EB2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1D72086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FzHtBQec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbeLQJrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:47:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37836 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732116AbeLQJqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:46:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so11099844wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DZnT+i5jw7FKMKXrOSMgnbdLeVWkWYBBUnpyBbjaMIo=;
        b=FzHtBQecwnsOdmLrHWs1fQzYOhp3dfjJ0dhPsVXtjH7IPLKxHLdtL8K99B09iFOjlM
         nKlO/8up0jW8eqbjiOZjUhUdv9/rStEqwSDMqAXIih+cpUEK8huEj4Gk+ybQPCePF8fA
         dPkfbuUPbHOjqKk5/e3mvs5VhMyDoWap7Knr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DZnT+i5jw7FKMKXrOSMgnbdLeVWkWYBBUnpyBbjaMIo=;
        b=ewogS21ndFKJcwjYyshSkAJg3HPHMUs5QhprgAXXH6VuGRSnW7gdQny0aRoweWgcpv
         L3WRiSj5XmRz1bSmI3NlBmSk+NHltlrp0riZCZw9DvKJH34KBGtFC5iUYowJuI4DveGX
         WvbdYeW5gW3UV1a6LIwq2qclFzNxmD4fxjHXUhpBLeYOP57NfA08c/j8+3K+j8iMlRpn
         I83pPe/qYmn2zTMe7fly7ZetD8DQw6PJbNXO5u73LCUUIPqluSybc5syzS+g9TGtnY7H
         /jWc8khAcuhyV3j71cV6Zj/T41ClbZY5emHtqetZZVaqe5xQ8Rg5nSXs+tvfwv4CyK7/
         ehMA==
X-Gm-Message-State: AA+aEWY5FPgXMzbAo+Cwmfwj529waEJkkKmurQqG4RNe34+4hoY9L6q0
        kQCM2cg4OAxbYuVlm7N7XHkC0w==
X-Google-Smtp-Source: AFSGD/W556/G72nW1KLgphiChECIUNEbP+PQ5P/XZO+ldt3E2+Te6cBFOdGtxBOq5cdnXt3oz6dVlQ==
X-Received: by 2002:adf:a4d9:: with SMTP id h25mr9285946wrb.167.1545040000993;
        Mon, 17 Dec 2018 01:46:40 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 01:46:40 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 03/13] mbox: qcom: replace integer with valid macro
Date:   Mon, 17 Dec 2018 10:46:20 +0100
Message-Id: <1545039990-19984-4-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct macro when registering the platform device.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index dc8fdab1..b782173 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -108,7 +108,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 register_clk:
 	apcs->clk = platform_device_register_data(&pdev->dev,
 						  "qcom-apcs-msm8916-clk",
-						  -1, NULL, 0);
+						  PLATFORM_DEVID_NONE, NULL, 0);
 	if (IS_ERR(apcs->clk))
 		dev_err(&pdev->dev, "failed to register APCS clk\n");
 
-- 
2.7.4

