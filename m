Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778B9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1F4205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LanoK9Fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405294AbfAPQLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:11:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42917 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405238AbfAPQLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:11:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so7545914wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDr5HA/Xz+XFJL8rSCgd+oCXVMfCO13lm4Kef3RvTeo=;
        b=LanoK9FolMz6mPf3K+0ED09NHHZR5+oRYTxu6VW5YCMcEsvZkM+MDQjs9+V+JBtjUr
         UkGQwHFVafDCQTPu8rkIR7n/2KuGjGqmcro5KX6f7fMFnHewpHEJgATvKWWDJzZjw40E
         6U2IFpyFROaEIcHTmOawdKGAsh/lBQR07pF0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDr5HA/Xz+XFJL8rSCgd+oCXVMfCO13lm4Kef3RvTeo=;
        b=G1tskGTGZ1ccqEgl0IinFMsuOV/oJU/6CcDCdaNefZPypSxgd82VN/dBlp5fIr2Ela
         2YQ1/XqEaXCvicA8QMk1jT/Sf5Svg1y22B8YFX+09SC1OeuhUrokUWKKWTnGdWRLuYQN
         TSFHAS/1xP4z92rrd3dIJjfbURYigN/vOCQZozuVkHM2GZkUb6w5UvbjTHvq2QRKRaIE
         hdmNzaO76tp2EeoEgRvog0GZhj62VYiTp64WJGdh/12ZqMawg3jMaSL60YdF0Q5AHmqU
         P3OP1MJu9Xy9CKAxgJVUnV32QwwsSS8vydDaJvhBpgl2F1Hx38/piL9fvc8jzn80b3L4
         Z44g==
X-Gm-Message-State: AJcUukdLefLP0tBdeCmvXCdinTh6fr5T+LHHYsTy7T4SB762bh5kNNi9
        ZYDZwdlqyFK4PVyLd+tI7DeS+g==
X-Google-Smtp-Source: ALg8bN6CC3lM1Zi300TtDtZd4tlTOD+K7DXx9f0Kg6hP4L+7/r5db+LtNlCzNBye94gqLiSEffapgg==
X-Received: by 2002:adf:9542:: with SMTP id 60mr7901351wrs.60.1547655083058;
        Wed, 16 Jan 2019 08:11:23 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a17sm78193407wrs.58.2019.01.16.08.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 08:11:22 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     andy.gross@linaro.org, olof@lixom.net, arnd@arndb.de,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, abailon@baylibre.com,
        maxime.ripard@bootlin.com, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, georgi.djakov@linaro.org
Subject: [PATCH v13 7/8] MAINTAINERS: add a maintainer for the interconnect API
Date:   Wed, 16 Jan 2019 18:11:02 +0200
Message-Id: <20190116161103.6937-8-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190116161103.6937-1-georgi.djakov@linaro.org>
References: <20190116161103.6937-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the maintainer of the interconnect API.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d04cebb4a71..00a12cd11aa4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7883,6 +7883,16 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-intel-mid.c
 
+INTERCONNECT API
+M:	Georgi Djakov <georgi.djakov@linaro.org>
+S:	Maintained
+F:	Documentation/interconnect/
+F:	Documentation/devicetree/bindings/interconnect/
+F:	drivers/interconnect/
+F:	include/dt-bindings/interconnect/
+F:	include/linux/interconnect-provider.h
+F:	include/linux/interconnect.h
+
 INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-iio@vger.kernel.org
