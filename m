Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD810C65BAA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75231206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/nZwPDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75231206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbeJEVfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:35:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54104 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbeJEVfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:35:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so2096814wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+YjDGmsA1iZ1aDYCWmgdgfOmrNf1zKrdDsjB+ghLQOs=;
        b=C/nZwPDsus1fpTDDzyLJjg93BFQe/AVJb+2dyMDQku2zyxa8z2CbtBppnc5wqlWtrt
         IfHfcYremCXqMmf6pyGpPOzuYFuhJ3YA21XFwwCTYhcEOxQLcyUQkqneiPN+mj+dDRe4
         ftNes557AcgnC78SVcIyT5uBsP9Lc5unnEasQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+YjDGmsA1iZ1aDYCWmgdgfOmrNf1zKrdDsjB+ghLQOs=;
        b=sLHWdqPLIEKISena4DkRwc8+mXwtp65nxVRJyPPsutzFNW4V5J6X1SLsHoOrIBAaN3
         WK2E8/d4gPQsQ+W+V3TYKtrpl9zV3SHY28smDV+E+QuJVrpO85YdrHM9kdXFA8KdMEWw
         /NaGEoblBcfFK9/o01UM9vJtuNL+YQ7R5ExCwoPESXOM0+4XYpRqwV/hTZFVi4fEKGhv
         OemIe3kng6Im3jjuKL1+M7aAfP1cs3cjPAm+uP9lOe93X8qtmvxPS4DM6fZgMKr6AXhz
         wsUTrjstcBUWKH40ve4Db5v72lrCAZiYemuTPdW/sTj2XXQG9uKEdvfzXE4jDcJ73yuA
         7fFw==
X-Gm-Message-State: ABuFfoiK50Fl12xfn6217ffmzCKSnZgCzpkDNg+BvzIcSX0V9dI3hkz4
        X7nKL4031lxMvlcdEeUoql9PtPinf7I=
X-Google-Smtp-Source: ACcGV60PW0UnCDlKQkLWeP1mogXH4XTbZ8wrw0UZF9lrvD/2DdRzEPJbNjHrmoIN6O1UJsUadqVmhA==
X-Received: by 2002:a1c:1804:: with SMTP id 4-v6mr7720216wmy.29.1538750176304;
        Fri, 05 Oct 2018 07:36:16 -0700 (PDT)
Received: from localhost.localdomain (151.240.136.77.rev.sfr.net. [77.136.240.151])
        by smtp.gmail.com with ESMTPSA id t24-v6sm14080377wra.5.2018.10.05.07.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:36:15 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 08/13] clocksource/drivers/sh_cmt: Properly line-wrap sh_cmt_of_table[] initializer
Date:   Fri,  5 Oct 2018 16:35:37 +0200
Message-Id: <1538750143-4282-8-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
References: <20181005143253.GE1881@mai>
 <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

There's no good reason for the sh_cmt_of_table[] initializer to
violate the 80-column limit, especially after the commit 8d50e9476bb4
("clocksource/drivers/sh_cmt: Mark "renesas,cmt-48-gen2" deprecated")
partially fixed it -- fix the R-Car gen2 related entries as well.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_cmt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 0c74489..71624dc 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -927,8 +927,14 @@ static const struct of_device_id sh_cmt_of_table[] __maybe_unused = {
 		.compatible = "renesas,cmt-48-gen2",
 		.data = &sh_cmt_info[SH_CMT0_RCAR_GEN2]
 	},
-	{ .compatible = "renesas,rcar-gen2-cmt0", .data = &sh_cmt_info[SH_CMT0_RCAR_GEN2] },
-	{ .compatible = "renesas,rcar-gen2-cmt1", .data = &sh_cmt_info[SH_CMT1_RCAR_GEN2] },
+	{
+		.compatible = "renesas,rcar-gen2-cmt0",
+		.data = &sh_cmt_info[SH_CMT0_RCAR_GEN2]
+	},
+	{
+		.compatible = "renesas,rcar-gen2-cmt1",
+		.data = &sh_cmt_info[SH_CMT1_RCAR_GEN2]
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sh_cmt_of_table);
-- 
2.7.4

