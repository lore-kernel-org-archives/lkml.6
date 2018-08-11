Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAE1C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B7121A13
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 16:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sinax.be header.i=@sinax.be header.b="KmRNM+FK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B7121A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=sinax.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeHKStu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 14:49:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35074 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbeHKStu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 14:49:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so4770410wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Aug 2018 09:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sinax.be; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=r0WtAf6jv1aOBEvWq2QkiAMWOc6nfS8saAlliB/x44A=;
        b=KmRNM+FK0pR9xyIXJIJRvtwCK4fot1WXSkYnFSaEwGh2I6c6vZ9hL2yNQZMEl+fRAX
         3Kda6zoBG0nhynJSSzPJmUr8v1x2peX+AAHQq/+pYvShNQM6J6jGqcA/A0szCmYjCLkb
         t375TCeZy5dzKbVVzPdSF9jtQUpDQkWj1QjW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=r0WtAf6jv1aOBEvWq2QkiAMWOc6nfS8saAlliB/x44A=;
        b=FcK5lFmMo1V3/aw7XQDWz2PAvL/rPUAkTZ60kb/dP/uFHGBVQAtF9iL0UkN7EgLUfQ
         zMQ0/Sc+plqV0E7IsmGhlGNjii3js94mQYKFNRt1xn1cvWJ56bSw0p8nupMfqP8q0MV9
         RfmaW4ldXe34xb/1e9rJa4LC4HQno9R9hPls74Q5+pkxWnYXfGyPYwUtmL6GeZ2BHqQc
         Ge0kS50m0ecTLcnO+QL2m5ruoaFHp5HkEGFiqpNCy6TiG9MIonrrcdvbFnJcIg5CcvcZ
         umRptIOV1upa7m+0ozAoUmVo2Yxsy2YpA9YBJy8TVC4iuIPq99MABw5cDBprKzguL9OC
         i2Qw==
X-Gm-Message-State: AOUpUlE9w6PMiSVsLvPiT+FseSv9jVNrXYEClvBudlP74+NIoPO73Fxi
        M3CW64D89qFsR0Z1zS68z4LmGYO1/iQ=
X-Google-Smtp-Source: AA+uWPwetdiniq9Sk7nYyokgVadAgmq/LSqQOIyV6j234oRvRzhtgOYxvDyo/M0Jz2TUVlqhBuI9VA==
X-Received: by 2002:a1c:6f06:: with SMTP id k6-v6mr4023131wmc.1.1534004108264;
        Sat, 11 Aug 2018 09:15:08 -0700 (PDT)
Received: from winston.localdomain (ptr-dkbjq8a20487yy59lye.18120a2.ip6.access.telenet.be. [2a02:1811:c412:9000:7272:808c:939c:a466])
        by smtp.gmail.com with ESMTPSA id h14-v6sm15986308wro.15.2018.08.11.09.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Aug 2018 09:15:07 -0700 (PDT)
Date:   Sat, 11 Aug 2018 18:15:05 +0200
From:   Michael Anckaert <michael.anckaert@sinax.be>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: netlogic: Fixed comments to include
 SPDX-License-Identifier
Message-ID: <20180811161505.GA7309@winston.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some issues with missing SPDX-License-Identifier
comments. 

Disclaimer: this is my first patch and instructions were taken from the
KernelNewbies project. 

Signed-off-by: Michael Anckaert <michael.anckaert@sinax.be>
---
 drivers/staging/netlogic/Kconfig        | 6 +++---
 drivers/staging/netlogic/platform_net.c | 1 +
 drivers/staging/netlogic/platform_net.h | 1 +
 drivers/staging/netlogic/xlr_net.c      | 1 +
 drivers/staging/netlogic/xlr_net.h      | 1 +
 5 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/netlogic/Kconfig b/drivers/staging/netlogic/Kconfig
index d660de51b541..ab0b756bc08b 100644
--- a/drivers/staging/netlogic/Kconfig
+++ b/drivers/staging/netlogic/Kconfig
@@ -2,6 +2,6 @@ config NETLOGIC_XLR_NET
 	tristate "Netlogic XLR/XLS network device"
 	depends on CPU_XLR
 	select PHYLIB
-	---help---
-	This driver support Netlogic XLR/XLS on chip gigabit
-	Ethernet.
+	help
+		This driver support Netlogic XLR/XLS on chip gigabit
+		Ethernet.
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

