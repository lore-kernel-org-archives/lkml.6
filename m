Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9660AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D46721479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmZYJq3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfBSJ7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:59:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41604 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfBSJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:58:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id n2so9288516wrw.8;
        Tue, 19 Feb 2019 01:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SKvnZE8FRNSDrOi2i7LIYAhX4r86ogk967jOuzBNxJ8=;
        b=gmZYJq3EVs/GLEYLKTki9zHJ0/gH7q1NM5Wr67MBcFn4on04RaJvIppP0LBCix+wjx
         QgRpbf3A25ui8nVgPUwR+uJFIXU0jCxExbx2A+sjgZwx5LnEdannR6RiWhR3ZTewWy6w
         UHOMButpLrk8sRedjlOIYFw/f6KvIVWPHygPD8jEJI0IfEv3yhrusX+hhbvJJe5Z+dz9
         +THieDH+Y8638ptIpPasL2eTgIEks5/pOypEj2YWK3dCg3U1s+vf4PXnga+9FbO7BwkD
         /WPQNJ5syuax/6qs/yz9HiAcYY8FBtaoBlnahxuIyleFffCiOfblivF/5YtIaohUyznN
         lU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SKvnZE8FRNSDrOi2i7LIYAhX4r86ogk967jOuzBNxJ8=;
        b=JxMoULt1OEA2oZ0l9GGMicD7eNFLz9L2VzyCal3DDvx9k7/pVZOzA+MFCKKTv43SNG
         r04gRCTDVWBcbGizS6gD4JaAjy+owOmwJtjj4xGKQkhwvb2ZYK9oUegNIc/nqhMp8M0v
         QodZE9FnfMORwSRgALRSH/Y8e7g1fYmwCSMsJgRoqeH4J2x1PaZWDgNwU1VKqZ6PQXLP
         VTjRuyIaMw6e9dj9MoUyA8e8gYA5feVHyDlJOABOP7ZyJQeUjCIrALWKGgibQUOIrwzm
         7A6lApjJI5YehH05kN/ZHWPBA47iVDx84Hy2fpHiQJbuprPv7shlgnVBCwD/UJQAzVOl
         PLfg==
X-Gm-Message-State: AHQUAuavu6U7bxhsfwL525UKaT0zsO413RhH074Tv0qUfLBFIyG5MGxA
        IcZKscojGU/3Oe6JEeDcRC8=
X-Google-Smtp-Source: AHgI3IYAj+J1tqAUPOBuR6osbM7yLZXX4MklFHSY3BnLZetYUh8GKtxt4Mri6/1sbyxfFQOfv6/m0g==
X-Received: by 2002:adf:c752:: with SMTP id b18mr20122745wrh.105.1550570301773;
        Tue, 19 Feb 2019 01:58:21 -0800 (PST)
Received: from fuji.Parrot.Biz (smtp.parrot.biz. [62.23.167.188])
        by smtp.gmail.com with ESMTPSA id k20sm31639220wre.41.2019.02.19.01.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 01:58:20 -0800 (PST)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v3 1/3] pwm: hibvt: Use individual struct per of-data.
Date:   Tue, 19 Feb 2019 10:58:06 +0100
Message-Id: <20190219095808.12059-1-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split pwm-soc array in one struct per soc and point to the
corresponding on in of-data.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/pwm/pwm-hibvt.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index 27c107e78d59..ffc803818c3c 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -49,15 +49,19 @@ struct hibvt_pwm_chip {
 	struct clk *clk;
 	void __iomem *base;
 	struct reset_control *rstc;
+	const struct hibvt_pwm_soc *soc;
 };
 
 struct hibvt_pwm_soc {
 	u32 num_pwms;
 };
 
-static const struct hibvt_pwm_soc pwm_soc[2] = {
-	{ .num_pwms = 4 },
-	{ .num_pwms = 8 },
+static const struct hibvt_pwm_soc hi3516cv300_soc_info = {
+	.num_pwms = 4,
+};
+
+static const struct hibvt_pwm_soc hi3519v100_soc_info = {
+	.num_pwms = 8,
 };
 
 static inline struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
@@ -198,6 +202,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	pwm_chip->chip.npwm = soc->num_pwms;
 	pwm_chip->chip.of_xlate = of_pwm_xlate_with_flags;
 	pwm_chip->chip.of_pwm_n_cells = 3;
+	pwm_chip->soc = soc;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pwm_chip->base = devm_ioremap_resource(&pdev->dev, res);
@@ -250,8 +255,10 @@ static int hibvt_pwm_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id hibvt_pwm_of_match[] = {
-	{ .compatible = "hisilicon,hi3516cv300-pwm", .data = &pwm_soc[0] },
-	{ .compatible = "hisilicon,hi3519v100-pwm", .data = &pwm_soc[1] },
+	{ .compatible = "hisilicon,hi3516cv300-pwm",
+	  .data = &hi3516cv300_soc_info },
+	{ .compatible = "hisilicon,hi3519v100-pwm",
+	  .data = &hi3519v100_soc_info },
 	{  }
 };
 MODULE_DEVICE_TABLE(of, hibvt_pwm_of_match);
-- 
2.17.1

