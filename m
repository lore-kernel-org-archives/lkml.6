Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F402C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CF420664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9l2MmIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CF420664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeJ3BNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:13:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44659 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbeJ3BNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:13:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17-v6so9081318wre.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yJCtkrkfIFoRj9cRN8aqIPKmbD9Nc3jaK1cwdarWAHs=;
        b=b9l2MmIpKRXHesHf2ofXp+b+1pZGE08G4PAHV2q0iy8mOYw7DmBHmPnxHI5pQmyaGT
         pblfRnf9cTpHs0a0e24oHPG5zHSCbap2kpRrYg6eUP7HJxXMaMWhi9NdjVW1nDDjFz9x
         zlOcJBtySx0RBYl5UYiiidYzf6roZaLuvmrRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yJCtkrkfIFoRj9cRN8aqIPKmbD9Nc3jaK1cwdarWAHs=;
        b=fuhe/9GkHSDV5J18b4RqHbf7Gt3iv90F9ebd/rg4arVsFpRqC1ooLosnwigUHm4AkV
         AjxyT/VgzVB2ngzWADh12HjOKGUG0MF93NfUtM6Vn0GPzZUI1hpXqob1rSTb6p8OB89p
         NmHZuXH0s6s7aG8+WSwGGlWBjIH93PtuqEMSl5yEtrEUfxdT8RlcJVpNu0gjafffiX/4
         4yXr1j8x92CxyZWMgjLk+3+gjwoH5mKBJY3UVMLgoXW8ZuJy0eNMyuEk4jL2CuNl79r9
         ezzn+1e1NjvA3FKZhRZcIR4FglrsPMZW2ttpeyJNHfYgs/ZqIz4ObEa/T4rNCn5EYlDd
         7MnQ==
X-Gm-Message-State: AGRZ1gIn5ORQ2AbpM5ZJuj7pQzIXhkEyH8KLp7aoXx9KqDiMG59v+5sy
        Yjz/Ldjye3nSaPbfc7rpLmmIsQ==
X-Google-Smtp-Source: AJdET5f+n5fbm28BqusnV9aiGSdA+hUv+Wct5yk8c8fpVYH3ybioL+lpDQwmA2EfcgQJozsCUpxI5w==
X-Received: by 2002:adf:e551:: with SMTP id z17-v6mr14524210wrm.238.1540830234197;
        Mon, 29 Oct 2018 09:23:54 -0700 (PDT)
Received: from localhost.localdomain (137.55.88.92.rev.sfr.net. [92.88.55.137])
        by smtp.gmail.com with ESMTPSA id y19-v6sm28150499wra.60.2018.10.29.09.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Oct 2018 09:23:52 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 3/4] base/drivers/topology: Move instructions in the error path
Date:   Mon, 29 Oct 2018 17:23:19 +0100
Message-Id: <1540830201-2947-3-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the function topology_parse_cpu_capacity() fails, we set the boolean
cap_parsing_failed to true and we free the raw_capacity. This is correct as
the function begins with a check against cap_parsing_failed thus protecting
the function to be re-entered.

However, even it is impossible that can happen with the current code, let's
move in the instructions:

 - cap_parsing_failed = true;
 - free_raw_capacity();

 ... in the 'else' block when the error is detected, that is more semantically
 correct.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/base/arch_topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index b19d6d4..7311641 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -155,9 +155,9 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 			pr_err("cpu_capacity: missing %pOF raw capacity\n",
 				cpu_node);
 			pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
+			cap_parsing_failed = true;
+			free_raw_capacity();
 		}
-		cap_parsing_failed = true;
-		free_raw_capacity();
 	}
 
 	return !ret;
-- 
2.7.4

