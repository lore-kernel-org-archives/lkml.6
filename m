Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088DBC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4ED3223C6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhgVMuXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4ED3223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbeHJRXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:23:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40533 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbeHJRXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:23:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id h15-v6so8552568wrs.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3nhe4ogehPXkAKYsCtMktZfIkdq4Qz0OXPXKO98cZNE=;
        b=MhgVMuXOWZiahjgtOSQvHexGyxlxRrvdwdTml8LUL8wu394seFOkWn6nifjyYtZATL
         wxenX0rsILaZuzo0Fg1sbP11SkSYlXvHX2AYILY5McYYUggbOTS0sHlAK6i0pdDQZZ+8
         YkmeatiN57dp7/r8e/SgA62AZf26sUVOb4J9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3nhe4ogehPXkAKYsCtMktZfIkdq4Qz0OXPXKO98cZNE=;
        b=fmrIwaPvcWJz6tFJYtVcTvkehvUfNSdfZz8WVySBUDqpEdE5J0aTyBkpng+D8HbSPl
         IyhBFI6uX4pI1Ih9Su1qONw7i8vvpC4RS0IDcJ7GFtyMnXtBWZ5p2ILYza8sFWcpvR0Y
         ONVAVw4o7l4Wsmp0jtZshTTIVDBFbh31PY76xn4IkfNy/oA7g0GwTG0z358ihO80aThH
         E6mqifJgj4yijBRraI0rSIsnob25ZGyZnBcxIaAsSmFBA8UC8Up5T1egFy+TGlczcJ1K
         tTYvwOAX43PZYrelC/UDPDHyNhcYp7huP8CbZkk0Hsl+g3HcgJhiIYyPdCrkSeImPpII
         +FAg==
X-Gm-Message-State: AOUpUlGoI5ahecsKFz95yzLsumd7WvA+RMcDUJ+Q64G91VHtc6WTI7TB
        lGM8Qo04+aj3csFs+kBUK3YPzw==
X-Google-Smtp-Source: AA+uWPwDJFVwwPNwQFiL8RulBjA6LXDZWzsgCyMbbskvMpcPdGfFjLAG78VDferPSI4bwhapqLnOCg==
X-Received: by 2002:adf:b3d7:: with SMTP id x23-v6mr4453315wrd.253.1533912777660;
        Fri, 10 Aug 2018 07:52:57 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 9-v6sm19842700wrb.48.2018.08.10.07.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Aug 2018 07:52:56 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v8 8/8] MAINTAINERS: add a maintainer for the interconnect API
Date:   Fri, 10 Aug 2018 17:52:33 +0300
Message-Id: <20180810145233.16466-9-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810145233.16466-1-georgi.djakov@linaro.org>
References: <20180810145233.16466-1-georgi.djakov@linaro.org>
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
index 32fbc6f732d4..ed1b534c901b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7420,6 +7420,16 @@ L:	linux-gpio@vger.kernel.org
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
