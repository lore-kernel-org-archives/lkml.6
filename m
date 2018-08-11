Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0394C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615EC21AA7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sinax.be header.i=@sinax.be header.b="gWB1kC1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615EC21AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=sinax.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeHKTLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 15:11:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33273 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeHKTLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 15:11:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so6257825edr.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sinax.be; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZXaDexgZ88SD9fvTWplw701ZLtNk1O94XyGe3mNf3Oc=;
        b=gWB1kC1h7L0tramDqplxgOhJNcgPaP9+R1wfgE6aiGQ3ETGZNftfkDS9LMO0nCjuBf
         wWTkPUqsGQJhzJZbQKkM+cTNzZBnLGuviGeqRc46AqArEhxAI4rIpZpcmKsw4meMs0HE
         YIZ07H/751kEvzpzmRFvHqNBkEdlXgSIRe9gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZXaDexgZ88SD9fvTWplw701ZLtNk1O94XyGe3mNf3Oc=;
        b=EBrrzIcupRO+HgPNfF3VpyP+BC5Ah5C7681PZo3U2CrVCFTqK4un4we7Sq0VxTGWth
         WL1E0TF+G9NwjgKBrT7YtlO5qRrz4mfCszT5X/gVw38XxXrP0pwzuCnYFNwzWvXreGiC
         YOabm/hHv3OPIxrTewtOsvNRscaStDykqD1P9jwF/NuGtYW9UYe8zST4JqBv/PIoA5tV
         s8tEF95EtCx0tUZJoNwQsdSsDSaOh4d7TYGOx9LjG5yfXyfTTFGEiGi1V2iaY2/Ng8n/
         fUx4/4nZOJmI3SnrTYx+ip99Qv814pMLroDxz57piBY9rDlgvbFj/fA0xdSfoq8v5g3j
         D9Ug==
X-Gm-Message-State: AOUpUlFzyCyPwGUQO9gcWvE+o0SvsNUYU3W170TcVtfkc8Nyrq22ec5d
        JpEUCvnnQg3UUMe8T0VLG/nMJYtNJVE=
X-Google-Smtp-Source: AA+uWPyq5yf29ZWTkCuJLuUUXhsJIQmzCv+1hoLQeQfsISuZHxDxNmIna2F5MK1vRRxrE1/DAlPdng==
X-Received: by 2002:a50:8406:: with SMTP id 6-v6mr13920067edp.97.1534005406221;
        Sat, 11 Aug 2018 09:36:46 -0700 (PDT)
Received: from winston.localdomain (ptr-dkbjq8a20487yy59lye.18120a2.ip6.access.telenet.be. [2a02:1811:c412:9000:7272:808c:939c:a466])
        by smtp.gmail.com with ESMTPSA id w1-v6sm17498362eda.63.2018.08.11.09.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Aug 2018 09:36:45 -0700 (PDT)
Date:   Sat, 11 Aug 2018 18:36:43 +0200
From:   Michael Anckaert <michael.anckaert@sinax.be>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: netlogic: Fixed comments to include
 SPDX-License-Identifier
Message-ID: <20180811163643.GA9735@winston.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some issues with missing SPDX-License-Identifier comments. 

Signed-off-by: Michael Anckaert <michael.anckaert@sinax.be>
---

Changes in v2:
 - Removed unrelated change to different patch.

 drivers/staging/netlogic/platform_net.c | 1 +
 drivers/staging/netlogic/platform_net.h | 1 +
 drivers/staging/netlogic/xlr_net.c      | 1 +
 drivers/staging/netlogic/xlr_net.h      | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/staging/netlogic/platform_net.c b/drivers/staging/netlogic/platform_net.c
index abf4c71ee66b..3886c99c1f68 100644
--- a/drivers/staging/netlogic/platform_net.c
+++ b/drivers/staging/netlogic/platform_net.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2003-2012 Broadcom Corporation
  * All Rights Reserved
diff --git a/drivers/staging/netlogic/platform_net.h b/drivers/staging/netlogic/platform_net.h
index e1b27f649590..1d994f0d0995 100644
--- a/drivers/staging/netlogic/platform_net.h
+++ b/drivers/staging/netlogic/platform_net.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2003-2012 Broadcom Corporation
  * All Rights Reserved
diff --git a/drivers/staging/netlogic/xlr_net.c b/drivers/staging/netlogic/xlr_net.c
index e461168313bf..201db10692de 100644
--- a/drivers/staging/netlogic/xlr_net.c
+++ b/drivers/staging/netlogic/xlr_net.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2003-2012 Broadcom Corporation
  * All Rights Reserved
diff --git a/drivers/staging/netlogic/xlr_net.h b/drivers/staging/netlogic/xlr_net.h
index f76e16cfd15d..de51d64c1f23 100644
--- a/drivers/staging/netlogic/xlr_net.h
+++ b/drivers/staging/netlogic/xlr_net.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2003-2012 Broadcom Corporation
  * All Rights Reserved
-- 
2.17.1

