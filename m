Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CACC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46BE2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMSAX4QY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46BE2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeH2U6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:58:09 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42090 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbeH2U6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:58:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id z11-v6so4873267lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YqKsD95f2OO61iVJlaOUp1to5LgjMVcac79gGsdZvNE=;
        b=aMSAX4QYBwEw+7GsjeG+hreLJIjA53lamtIntHnyljzGBhmH47r95StQw8h53oJnCk
         yzxeK17s7Obh4w6bDGd2q7bPT8RVxkQNP6z+zxhIgNR86PG+Mk8MamViDwG9dL3rHdqv
         s1cGS7drzpgJk7t4qiSiBB/ssy8xNmr/SG5is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YqKsD95f2OO61iVJlaOUp1to5LgjMVcac79gGsdZvNE=;
        b=INWn/VXElxahZ0R/bb1mIS0s8p55ePHw5Om//1OtyJejcMo4hFn8miaZJOswfELbRy
         BgrwDMwrq25xQplCiSw/B85uB49XPGOGfyEifTxlPNmR8OVZJff9VCrRAZhfqhl1lRdT
         pct9BUsWmC/+yo70K3mGfF5hCS8PovEPCwLZN/0cmo01Zco91FIX0sOoNjywDL0oV0zL
         pHmTi8VB5JL4eQ1gDEtXQsRalNYwpdlPsNaojuKD5GqKX6kxVesaDkN0ACMH4YatV5UR
         ahL9BK4kgFuz6ly6tFz+Gn8d14Cc1xf4yCm8TWb532MLBX5eb9zV2BTvCEmXEEGQx0Ap
         lhDQ==
X-Gm-Message-State: APzg51BofIKFLjXtZl9Vxxx8LShw7CrA8n38UcH6NgcHgz2J6HFF0AWa
        /v9fz3z8U/0DoZpxYwxY3Wyd/vwdXXE=
X-Google-Smtp-Source: ANB0Vdb46NH5tA4g+PpbZKDIrN90TnJB/qaWIGwWterJLlZch/Y3EmNhP4CWFmRfKO3Hy8Mtow0+aA==
X-Received: by 2002:a19:c38b:: with SMTP id t133-v6mr5108791lff.7.1535562017307;
        Wed, 29 Aug 2018 10:00:17 -0700 (PDT)
Received: from localhost ([195.238.92.132])
        by smtp.gmail.com with ESMTPSA id m71-v6sm788577lje.84.2018.08.29.10.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 10:00:16 -0700 (PDT)
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 0/2] Fix allmodconfig build with bare-metal toolchain
Date:   Wed, 29 Aug 2018 20:00:13 +0300
Message-Id: <20180829170015.7729-1-semen.protsenko@linaro.org>
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

 drivers/scsi/aic7xxx/aic7770.c                |  6 ---
 drivers/scsi/aic7xxx/aic79xx.h                |  6 ---
 drivers/scsi/aic7xxx/aic79xx_core.c           | 43 -------------------
 drivers/scsi/aic7xxx/aic79xx_pci.c            |  6 ---
 drivers/scsi/aic7xxx/aic7xxx.h                |  6 ---
 drivers/scsi/aic7xxx/aic7xxx_93cx6.c          |  6 ---
 drivers/scsi/aic7xxx/aic7xxx_core.c           | 40 +----------------
 drivers/scsi/aic7xxx/aic7xxx_pci.c            |  7 ---
 drivers/scsi/aic7xxx/aicasm/aicasm.h          |  4 --
 drivers/scsi/aic7xxx/aicasm/aicasm_gram.y     |  4 --
 .../scsi/aic7xxx/aicasm/aicasm_macro_gram.y   |  4 --
 .../scsi/aic7xxx/aicasm/aicasm_macro_scan.l   |  4 --
 drivers/scsi/aic7xxx/aicasm/aicasm_scan.l     |  4 --
 drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c   |  4 --
 drivers/scsi/aic7xxx/aicasm/aicasm_symbol.h   |  4 --
 include/linux/coda.h                          |  3 +-
 16 files changed, 2 insertions(+), 149 deletions(-)

-- 
2.18.0

