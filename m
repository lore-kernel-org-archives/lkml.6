Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0305FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED3121479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZfe0jvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED3121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbeGLIxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:53:40 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34923 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeGLIxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:53:39 -0400
Received: by mail-pf0-f196.google.com with SMTP id q7-v6so19089017pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7IO3qfA2g2fabXqH25n3LDrGVQAknfMl75vi9SRb11A=;
        b=KZfe0jvvXty2GG8LXIKc32hsXEFJFQwUFWQykXM7YHeuqU7Ad1bu3g6bV4YyivQJPJ
         T60QXemlq5tzKsEZ1F1aawwEdlArITP4t0V8AWNgK6ErIDfD8wKe1iorFdBSU9PzXkVI
         yvZS+vO2pGwW+/Ce162krUyK53dzzZuDroh+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7IO3qfA2g2fabXqH25n3LDrGVQAknfMl75vi9SRb11A=;
        b=Z/veEstKKETWAdD4/iU/E4Xp1MfHaCFOGRe/Dw1DL03wML8wZRALZKpP3W2Tf+3VGi
         IKGc6bsD9PygkDL3ZUyE8w/qq6eY1MBeqwZBlAG4Fqpie/wpfprHx52igfS9QxPjeYLu
         +ZPQJJFcSV6ng3rz2nib0lW34PqSNqj2QP0b3hW2g84aozHBiP/yN6d68akC7W6OSr9A
         5WwVwajIbCyd1j+dhShJMNB6O1B7Hu7x1e8YtIBziM3dnRpsYWl+Auy/++zNPFfMVBKN
         mx3TxlfaXo3NXrvmx4Q4UgwedmLF+6BWP9Umx4TiEsRqlVVjR0Hy9KYEIUGdgdqA73zp
         onDQ==
X-Gm-Message-State: AOUpUlG+bdD027dVTBkOokSCPISVqqyko3fof+WiDt7WPBVTYl161HtK
        5vZkPk7cPkwuTfFFiyhZHlIVHkXSlQM=
X-Google-Smtp-Source: AAOMgpcay/Y9iwjZ0inZqO5nJWIJgxxTCZxvgH40wWTg9JYlOA1aRREUDPDCJaQ1E0h8NbZrXnGtLg==
X-Received: by 2002:a62:e813:: with SMTP id c19-v6mr1418186pfi.124.1531385103205;
        Thu, 12 Jul 2018 01:45:03 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v17-v6sm27184314pfn.177.2018.07.12.01.45.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 01:45:02 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     tglx@linutronix.de, john.stultz@linaro.org, sboyd@kernel.org,
        arnd@arndb.de, broonie@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, baolin.wang@linaro.org
Subject: [RFC PATCH 2/2] clocksource: sprd: Register one always-on timer to compensate suspend time
Date:   Thu, 12 Jul 2018 16:44:13 +0800
Message-Id: <9f6309ba7e9c49d1f887f276471716d07a7f7bba.1531384486.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4aa9a65166f7e10984bfcff59e72d86e37c369a1.1531384486.git.baolin.wang@linaro.org>
References: <4aa9a65166f7e10984bfcff59e72d86e37c369a1.1531384486.git.baolin.wang@linaro.org>
In-Reply-To: <4aa9a65166f7e10984bfcff59e72d86e37c369a1.1531384486.git.baolin.wang@linaro.org>
References: <4aa9a65166f7e10984bfcff59e72d86e37c369a1.1531384486.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the clocksource framework has introduced one suspend clocksource to
compensate the suspend time, this patch registers one always-on timer as
the suspend clocksource.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/timer-sprd.c |   50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
index ef9ebea..430cb99 100644
--- a/drivers/clocksource/timer-sprd.c
+++ b/drivers/clocksource/timer-sprd.c
@@ -156,4 +156,54 @@ static int __init sprd_timer_init(struct device_node *np)
 	return 0;
 }
 
+static struct timer_of suspend_to = {
+	.flags = TIMER_OF_BASE | TIMER_OF_CLOCK,
+};
+
+static u64 sprd_suspend_timer_read(struct clocksource *cs)
+{
+	return ~(u64)readl_relaxed(timer_of_base(&suspend_to) +
+				   TIMER_VALUE_SHDW_LO) & cs->mask;
+}
+
+static int sprd_suspend_timer_enable(struct clocksource *cs)
+{
+	sprd_timer_update_counter(timer_of_base(&suspend_to),
+				  TIMER_VALUE_LO_MASK);
+	sprd_timer_enable(timer_of_base(&suspend_to), TIMER_CTL_PERIOD_MODE);
+
+	return 0;
+}
+
+static void sprd_suspend_timer_disable(struct clocksource *cs)
+{
+	sprd_timer_disable(timer_of_base(&suspend_to));
+}
+
+static struct clocksource suspend_clocksource = {
+	.name	= "sprd_suspend_timer",
+	.rating	= 200,
+	.read	= sprd_suspend_timer_read,
+	.enable = sprd_suspend_timer_enable,
+	.disable = sprd_suspend_timer_disable,
+	.mask	= CLOCKSOURCE_MASK(32),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
+};
+
+static int __init sprd_suspend_timer_init(struct device_node *np)
+{
+	int ret;
+
+	ret = timer_of_init(np, &suspend_to);
+	if (ret)
+		return ret;
+
+	clocksource_register_hz(&suspend_clocksource,
+				timer_of_rate(&suspend_to));
+
+	return 0;
+}
+
 TIMER_OF_DECLARE(sc9860_timer, "sprd,sc9860-timer", sprd_timer_init);
+TIMER_OF_DECLARE(sc9860_persistent_timer, "sprd,sc9860-suspend-timer",
+		 sprd_suspend_timer_init);
-- 
1.7.9.5

