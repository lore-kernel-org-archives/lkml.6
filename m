Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192A8C65BAA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3953206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIcK5CjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3953206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbeJEVfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:35:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39549 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbeJEVfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:35:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so2157471wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vSrYxtFz1N3wcfgTO4N+fFrZV9HHfo3EByRhA0R0oWU=;
        b=IIcK5CjKk1VltGSBSwO3JK2UJ49K8UQW+EByaJ+BT5OmWFzCgaIACwik2A6JHKxn+A
         7h/fNHf4Dc02A3TnUR3YLMkt1EvApcMIWjFmQupB3KWqa4/cDKQSTxlYqDHpfbyXDfNv
         Pw4EeQIzAuf/itHlQIK0P+0pGhlCqIATnhn0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vSrYxtFz1N3wcfgTO4N+fFrZV9HHfo3EByRhA0R0oWU=;
        b=Fw6swmwG3GsvjWBuiedF24o1vgnckvCjjyU2/4wjKPLmLqSNANRzPfIeRNrJBFLM2U
         PSkdTTX5UvtVRjlws4jx/DgeIuGfG0DDwxMn34Pnq7dEFq9KK7TUn73NMX8d4kJoiGqi
         +ku9d+lN024VWvBITMJbMUheXjokFhsdS1oUXd3Gea7apT3K8TfWf0LhsRtQCfLtGCLH
         rsm+u9wuu0tystATQU24AP/xtdA07/rfzFo1XIpyfuiK92xErOnTxkZINGizUBn40lsn
         pL3zYRb/pyKOvwTCnxi+JrgM5Jit2k2SZ4X9N/YoiCoH8RaRJ2gEKjcsowCCwzGkkyxs
         PtFg==
X-Gm-Message-State: ABuFfoiFTNq5Cf7PkHlvzhgLQvuyKXN+Lz29C5cTIuLD0DCDVHG2VDar
        dT/DAcmIFzgAhVhpjFL9P9qRGg==
X-Google-Smtp-Source: ACcGV60vfLxpcF4TxLePCq6RO4LPAlPte8z1M0Ki1071VlI67hXWrVOUvxoUp3EqBqlgyEP/mN5aaw==
X-Received: by 2002:a1c:6c09:: with SMTP id h9-v6mr7692083wmc.95.1538750169767;
        Fri, 05 Oct 2018 07:36:09 -0700 (PDT)
Received: from localhost.localdomain (151.240.136.77.rev.sfr.net. [77.136.240.151])
        by smtp.gmail.com with ESMTPSA id t24-v6sm14080377wra.5.2018.10.05.07.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:36:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 04/13] clocksource/drivers/sh_mtu2: Convert to SPDX identifiers
Date:   Fri,  5 Oct 2018 16:35:33 +0200
Message-Id: <1538750143-4282-4-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
References: <20181005143253.GE1881@mai>
 <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates license to use SPDX-License-Identifier instead of verbose
license text.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_mtu2.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 6812e09..354b27d 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SuperH Timer Support - MTU2
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/clk.h>
-- 
2.7.4

