Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFA6C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A520E22460
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sISa/VpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A520E22460
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933033AbeGGClp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:41:45 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32842 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932944AbeGGClh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:41:37 -0400
Received: by mail-pl0-f65.google.com with SMTP id 6-v6so3620960plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 19:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6bUBN1K32LSDL4p+3DaVu1y0y3MwKsoM6IgQmYh4Llo=;
        b=sISa/VpRrsn7UmfsQIuzktDD/TL7i+kAFGwaUeLcCAFWQfo2seYbiwAlcmbNQ0IuTn
         Um+kyS6bgVutIPEHXYD0fiv7ChcdkSB47C6+cZYncIp9wqcD1CFGTVXOsKm6URYCWtWr
         ko3dOjW7uGC8yw7t7QSYRonp7nMK8YGKvKOm2w+HsN73cathaGd2kvnZx7Lvohq+9xgW
         vvQeqZRlaHlB9leKkqWGdREbyWR5mrM5CY5vuS6PTW62veCzHZjjEJyf5dJMhw9Ql+y8
         iwuLY+12EVZPi2+MUhSdnvwKLNFicDL1GeFQRuXtcAPXTPEARue6shGVpYxceb+z4FVd
         v7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6bUBN1K32LSDL4p+3DaVu1y0y3MwKsoM6IgQmYh4Llo=;
        b=GMMAUwyLpci5/vNN9z+gzazAwzJjVwppMO+NObjm/I9O7nc9+YQQAfdYghIU+/pZ4C
         0iZUpF8KXKJ7Y1IPTq99uGU6fHaME6xL2kgk5J+4VpEJEOqc3KG3zjK+ajoYAKdWeQ2K
         qtoKhvNZuIpp2A7knaxDVcWDBpNOpQe4Ko2T59YIDBqawz9PdwD6OttKg8e+SyTjBFKT
         F/tmi4yevrJOwyS4oVDoZ4oXkHs1qAtSztUD0hApJyYFuustSrOxJpWCLJ1a0uk2LZyL
         o2sUT40B4EI+J59U0g6n4UfnitC0WE1w/ZfgxhvDtYkAbR+MvwNklS/pPyA01dR17tlH
         6HGw==
X-Gm-Message-State: APt69E26eP4nOVmLIbpJ9lduhowQbaQyGUFlyj0Cog1FyqEQa3yirDsy
        XQQP9tTJG5s0661BwpJV5Zo=
X-Google-Smtp-Source: AAOMgpcDevsZGOr/+UDHmUeM4V7R/rNn42eEd4Un+wb4+gLeDFmSh83D/6eYlIYlRiotQuIbaw6x4g==
X-Received: by 2002:a17:902:1101:: with SMTP id d1-v6mr12132550pla.147.1530931297387;
        Fri, 06 Jul 2018 19:41:37 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i17-v6sm18897276pfj.95.2018.07.06.19.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 19:41:36 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 3/6] mfd: rave-sp: Initialize flow control and parity of the port
Date:   Fri,  6 Jul 2018 19:41:05 -0700
Message-Id: <20180707024108.32373-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707024108.32373-1-andrew.smirnov@gmail.com>
References: <20180707024108.32373-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relying on serial port defaults for flow control and parity can result
in complete breakdown of communication with RAVE SP on some platforms
where defaults are not what we need them to be. One such case is
VF610-base ZII SPU3 board (not supported upstream). To avoid this
problem in the future, add code to explicitly configure both.

Cc: linux-kernel@vger.kernel.org
Cc: cphealy@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/mfd/rave-sp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index a90ec4986b22..aa75d5841ca0 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -766,6 +766,13 @@ static int rave_sp_probe(struct serdev_device *serdev)
 		return ret;
 
 	serdev_device_set_baudrate(serdev, baud);
+	serdev_device_set_flow_control(serdev, false);
+
+	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	if (ret) {
+		dev_err(dev, "Failed to set parity\n");
+		return ret;
+	}
 
 	ret = rave_sp_get_status(sp);
 	if (ret) {
-- 
2.17.1

