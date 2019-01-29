Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE80CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A1F214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="JnOTWShy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfA2XgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:36:20 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39756 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfA2XgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:36:20 -0500
Received: by mail-yw1-f68.google.com with SMTP id k188so8921706ywa.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 15:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypcjhC5gLgv1najtmqf3KGwBGuKlXgrvvho14o6HPq4=;
        b=JnOTWShy8zOoZyip47uhC8ph1M4XcBA2QNn/g34BScolFhs1qAn5yHiIAiYqNKjwHY
         nmCc9DcEdq5jBZ8RAhFB/5J2py2kKU47cVjPJ+KWp/bwqEEe0RAxd5fOzNg1SVcsfEqK
         v8j/SDr9HWejcaQ0n9k7CG7A6XP2mgL6JkcmWaE6BKnZLlr51syPc9bw0yQBJnsu/rUZ
         EjMOSfq0hVZLVhf78Ieu+Vt168ODqC3uhSZlf9yg3mEfuw3Kwrh6XDmMMtkLHpSDDYiX
         n+K+K7XRC38sbnnXxoPxYPA1ZiZ/17uZZd6rHcaGaqYcNDdPG/OsjrYY6EEKOBDiDuWO
         bICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypcjhC5gLgv1najtmqf3KGwBGuKlXgrvvho14o6HPq4=;
        b=HpgeGtIE/nPWA82Nv+7cHEDErU1eS/IgvDys+bmkdCL0P/TK4W9v34dbBoSW+3zFuY
         ZTRY2GpUwjVtMS4+nOXS/eBwm6D2JUnk0kHFuwEnC+thf93acrQADZFGRr8ZT1hePhKG
         VPsnTtYeE7rVJxTTgqUyup+L/tBCBf9dtFDFtGDKQzfJCyL5gVb0MXN4C9Qdzi78H7e2
         BCT6EHF7fF2N4rQIZnTVbE6LJccGSRaikIVPHL2Njt4tvMAGC4jS4tDhuyjoWg7GrZil
         zt51/caojps3T7C7aGrFvYB0ZdZ5BY2LZnlqw7PXVpo516IHIGKoInlOf/jDFpJFMldt
         kAAw==
X-Gm-Message-State: AJcUukccvBU/DVRoGNABuWxlKDMN4m/haFr3+KjTilogZhKHWUXig13B
        SSQbmzOslMoZ9czruV0BBOHHvQ==
X-Google-Smtp-Source: ALg8bN6PRN1HYwkcGXaRrY0s20nXRdjPrEH7n5y8QSD0tg5DA7sqfugxO+FQ+zN8x44L+qcnQSxumA==
X-Received: by 2002:a81:6257:: with SMTP id w84mr27686832ywb.273.1548804979275;
        Tue, 29 Jan 2019 15:36:19 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:1d25])
        by smtp.gmail.com with ESMTPSA id j12sm16757805ywk.43.2019.01.29.15.36.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 15:36:18 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] psi: clarify the Kconfig text for the default-disable option
Date:   Tue, 29 Jan 2019 18:36:17 -0500
Message-Id: <20190129233617.16767-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current help text caused some confusion in online forums about
whether or not to default-enable or default-disable psi in vendor
kernels. This is because it doesn't communicate the reason for why we
made this setting configurable in the first place: that the overhead
is non-zero in an artificial scheduler stress test.

Since this isn't representative of real workloads, and the effect was
not measurable in scheduler-heavy real world applications such as the
webservers and memcache installations at Facebook, it's fair to point
out that this is a pretty cautious option to select.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 init/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 513fa544a134..ad3381e57402 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -512,6 +512,17 @@ config PSI_DEFAULT_DISABLED
 	  per default but can be enabled through passing psi=1 on the
 	  kernel commandline during boot.
 
+	  This feature adds some code to the task wakeup and sleep
+	  paths of the scheduler. The overhead is too low to affect
+	  common scheduling-intense workloads in practice (such as
+	  webservers, memcache), but it does show up in artificial
+	  scheduler stress tests, such as hackbench.
+
+	  If you are paranoid and not sure what the kernel will be
+	  used for, say Y.
+
+	  Say N if unsure.
+
 endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
-- 
2.20.1

