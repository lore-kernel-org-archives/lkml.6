Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E0CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9A3222D0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1ZrC+HZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405231AbfBNC5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:57:12 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46789 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393447AbfBNC5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:57:11 -0500
Received: by mail-yw1-f65.google.com with SMTP id n12so1755784ywn.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Su8YhrZdfLB1seWDBEyfdxr9UPtgNUUtMSiOc8ZiECM=;
        b=T1ZrC+HZTFadsBC9RrnyJLe5HGq49kKEdRZcyHOhnNM98eAABzqT7XYFcOpGE0M7uV
         koFMXnmCSchflxE42gQG4RZkNIgFZPRodk74WZ3b3oygzunqVzGXoRKkih1WANruR6yM
         6bItZh28WcDFtw5O8GycbgAbRoaTyP1OkrbJmP/k3YTbsNi3jcrNedl/EAd+1GRntV25
         qedPUq7rvwKLKsOr1xt2gziZVs7MgC5a5JLBmS+d+LwLqlBlsCcGxp84yjcStKbMhd+P
         UVshPn73QuuLbSa5wH+HJvDFQIiBQ1FoHcBpyRoFx3XdADu6K/oS2ONY2DnuJXOZnJks
         4etA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Su8YhrZdfLB1seWDBEyfdxr9UPtgNUUtMSiOc8ZiECM=;
        b=Bo6SoZaIrsLr2waqfjaLv6vXr8ghNV+WxfwPGy3Jqof1gGudAVY9dMxzfCpkjDQw8O
         Iq7kWg3R9KcdT4ynkG4XO9HXp5hcFAxAYkdi21k2Qa7Djn9J+jcQ4uY1K1kiLwCc7CB0
         Ji4ccO0nI6swWsr7ddLWl0O2KX5QyIIxurHKnOFyOx9Yy2bI4jzvUw1aVDVWfz5DLF/h
         wEiryx1bifUe4chsDQ0+7WKgd2VMF2bwfTQNYNWuAqdg+/5X/kcXMSD9T6x+SJhbcf2R
         TtBZUPCo6QLJGaxvDIGIEIcAPKkndn2Ynin/ZZ4ND0jouhyVSgauh6PXmzFn4a5m2akR
         kjvQ==
X-Gm-Message-State: AHQUAuanzoWf0nwFtEHFf+aq9dJmRXQkRVkzxXSsAYmHBkVkJTUdgTE8
        DVyqYkw1qlRapXHzcIWlaa0=
X-Google-Smtp-Source: AHgI3IaVuySukgTyhK0qcLcciBnP1kVZVseQJY1irq/R8fldoyeUd4TR6edGfcNE8hpObWgJxF5wiw==
X-Received: by 2002:a0d:eb42:: with SMTP id u63mr1207554ywe.162.1550113030775;
        Wed, 13 Feb 2019 18:57:10 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id 206sm560544yws.95.2019.02.13.18.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:57:10 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com
Cc:     Bo Yu <tsu.yubo@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf pmu-events: Removed unused variable
Date:   Wed, 13 Feb 2019 21:57:03 -0500
Message-Id: <20190214025703.26493-1-tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo Yu <tsu.yubo@gmail.com>

Compiling kernel when W=1, it will throw a warning:

pmu-events/jevents.c: In function ‘save_arch_std_events’:
pmu-events/jevents.c:417:15: warning: unused variable ‘sb’ [-Wunused-variable]
  struct stat *sb = data;

Removed the unused variable

Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
---
 tools/perf/pmu-events/jevents.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 68c92bb599ee..92e60fd11fdd 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -414,7 +414,6 @@ static int save_arch_std_events(void *data, char *name, char *event,
 				char *metric_name, char *metric_group)
 {
 	struct event_struct *es;
-	struct stat *sb = data;
 
 	es = malloc(sizeof(*es));
 	if (!es)
-- 
2.11.0

