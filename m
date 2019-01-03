Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98656C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFD72070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NuGRglHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbfACPLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:11:18 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:37426 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfACPLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:11:17 -0500
Received: by mail-wm1-f44.google.com with SMTP id g67so30560361wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 07:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0dcQ3/dkLOl44sCSWYzCMKpCPVjooWzOO9eRJkxMTew=;
        b=NuGRglHn/0Lqr/u9OI54BSv4S+ZG70CQ1chHvduL/azRJwwNXqtex+qwncXRAttU1J
         iYhIBVCT0MCE8VYwOs83y6NZityicqpTyAJZ4KeZd3JsPeMUJ5DEVpHqIJ/CLGWCUT+l
         Mu63kZmgfLXn3l9/hQtV1+/99jB5/n+KCFmn87nK8lXNoe0K612Kd//YokcgmsCmP6+u
         f/Vt5gukHL/8KMd17XLxZI4ihmczkIusRfXgFZaVuZicYlMFaGktxgkYksqQ/N4hpunu
         oCi2cuaOWv0CS3cxc9WBlXbxxXLtITcSxdn2lQWEnqzZ6zL2BKwOWxQBH8dA8aVx3SxW
         oK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0dcQ3/dkLOl44sCSWYzCMKpCPVjooWzOO9eRJkxMTew=;
        b=Bwa6v4+uVKxMiB+1hf3M0A84y/yqmRttDm9Ht4fxC9lXb5rCvY1hbidCRJFkvqczh+
         knYc6qMAPkkx603pI3fBZOoZFivHI631DYOuPNNH+DY8DfS5dHgbTwiudvmKdu5sfAFe
         MxJNN2JNHaiZN2k1PNAeztRCm/aPpET+4ZqUz/5cmzGdh6rfVABt9wViLDjt67/Goc9g
         x0/5qf3i00XB5WF/aW5PQVvi1WJ7KAngFFB18lpCogLcvu2XxnKFQlxtlMxvyDUiykrL
         cYLxAE01IOHYvXPRSDiIP5u1E2PiE9SGtfQlgJ4/og7CqccVt2ZwUrymkF4k7+nCvVli
         8NEg==
X-Gm-Message-State: AJcUukct9OJA5rRCrfUr/8qkDiRI0hEly24YWOqmYcf7Gl7tjrSWI8qn
        SDotMiJG8psmXWrGx5+vK1xmuw==
X-Google-Smtp-Source: ALg8bN4i09QkBsAAx0LQZbXnP4FHe48ktuHU/6boZLMztuOfPv0oP4tv5IUgR3XlS+2/iN9GSu/HWg==
X-Received: by 2002:a1c:99ce:: with SMTP id b197mr40218807wme.75.1546528275898;
        Thu, 03 Jan 2019 07:11:15 -0800 (PST)
Received: from debian-brgl.baylibre.local (astlambert-681-1-88-79.w90-86.abo.wanadoo.fr. [90.86.3.79])
        by smtp.gmail.com with ESMTPSA id n5sm45620707wrr.94.2019.01.03.07.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 07:11:15 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Andrew F . Davis" <afd@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/5] ARM: davinci: fix label names in GPIO lookup entries
Date:   Thu,  3 Jan 2019 16:10:59 +0100
Message-Id: <20190103151104.11839-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Sekhar,

I noticed some more breakage resulting from commit 587f7a694f01 ("gpio:
davinci: Use dev name for label and automatic base selection"). This
series fixes GPIO lookups in legacy mode for DaVinci.

Bartosz Golaszewski (5):
  ARM: davinci: da830-evm: fix label names in GPIO lookup entries
  ARM: davinci: da850-evm: fix label names in GPIO lookup entries
  ARM: davinci: dm355-evm: fix label names in GPIO lookup entries
  ARM: davinci: dm644x-evm: fix label names in GPIO lookup entries
  ARM: davinci: omapl138-hawk: fix label names in GPIO lookup entries

 arch/arm/mach-davinci/board-da830-evm.c     | 4 ++--
 arch/arm/mach-davinci/board-da850-evm.c     | 4 ++--
 arch/arm/mach-davinci/board-dm355-evm.c     | 4 ++--
 arch/arm/mach-davinci/board-dm644x-evm.c    | 4 ++--
 arch/arm/mach-davinci/board-omapl138-hawk.c | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.19.1

