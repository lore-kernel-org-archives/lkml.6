Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E78C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8032020851
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RBQT1Wl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8032020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeH1SQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:16:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39004 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbeH1SQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:16:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so1583272lji.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KcFzbcYOQ1xiLMaN/Eh0sKOGIuSv1gy9/LNssarYENM=;
        b=RBQT1Wl3bFurHVO5Ruk+fKm+zAVK02EKXodRYHFuZ1lzVO/GdcQkOHvCAukziVpfuH
         LdaKV8yyX7cQx2u/PZ5S2CCZdmDapX36VUPZNw1sGlBN/uzuZVs7zEqF8EIzrC/QHgrm
         kAqqshq3yAUWVEnk6QRgIWBz4QbwYWic6w9qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KcFzbcYOQ1xiLMaN/Eh0sKOGIuSv1gy9/LNssarYENM=;
        b=JebKJFzMaMwZQbVVOF72sDHqugJXRiLW5gv1DW5zl3P3kPwG2BTWc9dK1Bc8GJPBPT
         CNBvdmUfA6vgyd2UlKQXbZFeHbrbzXMSReq/MnT9ShPhGwVajqAIzdwKBp0OcnSX/La0
         wcuQkQ28r3mw9VKOsSv+llNrB6ZeK3U+okBjlZWP0RBibuWPICZVgUBd/NY215GasNjZ
         zypu4SgO8RiHuNPbZOyJiPKLfoZVhbjjnpjxevvimvA4dFJXB58aiQSbSeJ6tEnbqAlR
         6qzY4iCN/S9JoNVNTSanJXK1iXbLEXWfLNpkc038X9SAU2pf5HsoAqsvCVKOSNnhEgNf
         5uDw==
X-Gm-Message-State: APzg51ALx4I21efDfEHRqyDh+MiEZxhYpJ665E7c9/fg8BqcryfzUb1q
        WZ/L/v72Vw5migJ+uHxS5T2rBSXZqqE=
X-Google-Smtp-Source: ANB0VdYL3Q8+oJXSsHeG19vSPbqRIMAO6cfVj3GpoBwBlAGmjHnF1Fune8jLicFLGIwDznEcE5QH3g==
X-Received: by 2002:a2e:3005:: with SMTP id w5-v6mr1463002ljw.20.1535466263478;
        Tue, 28 Aug 2018 07:24:23 -0700 (PDT)
Received: from localhost ([195.238.92.132])
        by smtp.gmail.com with ESMTPSA id c5-v6sm229607lff.65.2018.08.28.07.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 07:24:22 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Paul Sokolovsky <paul.sokolovsky@linaro.org>,
        Miklos Szeredi <mszeredi@suse.cz>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 0/2] Fix allmodconfig build with bare-metal toolchain
Date:   Tue, 28 Aug 2018 17:24:19 +0300
Message-Id: <20180828142421.15335-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to build allmodconfig (for ARM platforms) using bare-metal
toolchain fails with errors related to __linux__ definition. It's only
defined on Linux toolchains, but not defined on bare-metal toolchains.
This patch series fixes that.

Some similar patches (for different files) were applied previously:
  - commit 4c82456eeb4d ("fuse: fix type definitions in uapi header")
  - commit b6330548383c ("drm.h: Fix DRM compilation with bare-metal
toolchain.")

Sam Protsenko (2):
  codafs: Fix build using bare-metal toolchain
  scsi: aic7xxx: Fix build using bare-metal toolchain

 drivers/scsi/aic7xxx/aic7770.c                  |  2 +-
 drivers/scsi/aic7xxx/aic79xx.h                  |  4 ++--
 drivers/scsi/aic7xxx/aic79xx_core.c             | 12 ++++++------
 drivers/scsi/aic7xxx/aic79xx_pci.c              |  2 +-
 drivers/scsi/aic7xxx/aic7xxx.h                  |  4 ++--
 drivers/scsi/aic7xxx/aic7xxx_93cx6.c            |  2 +-
 drivers/scsi/aic7xxx/aic7xxx_core.c             | 12 ++++++------
 drivers/scsi/aic7xxx/aic7xxx_pci.c              |  2 +-
 drivers/scsi/aic7xxx/aicasm/aicasm.h            |  2 +-
 drivers/scsi/aic7xxx/aicasm/aicasm_gram.y       |  2 +-
 drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.y |  2 +-
 drivers/scsi/aic7xxx/aicasm/aicasm_macro_scan.l |  2 +-
 drivers/scsi/aic7xxx/aicasm/aicasm_scan.l       |  2 +-
 drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c     |  2 +-
 drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h     |  2 +-
 include/uapi/linux/coda.h                       |  5 +++++
 16 files changed, 32 insertions(+), 27 deletions(-)

-- 
2.18.0

