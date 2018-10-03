Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B9DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB85420835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujvnYtfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB85420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeJDAHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:07:32 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:49367 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJDAHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:07:31 -0400
Received: by mail-qt1-f201.google.com with SMTP id f20-v6so5688490qta.16
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Oh8+LIPxqlpH5AytM1H1QSq6tc8XbryVzqqg5ytpvsc=;
        b=ujvnYtfjDpLX0TkIrwvJXOQjo0MgLiqlRvoZNyi1QXYYkG0SGL7F+2qENBgzODQvh1
         vMNizVZHZ58BhbzyVDxHWe+Ha5fHUE3m7Vfk24b5COMjd6Ix0AgYrzeuHlaR243eGa59
         vtRL4L/FM2XUDkCCDrmKasdo2+l8N0wlW5t5y8kpanM0mO3iuRggZJtFW834yndK8v1y
         GD8meQu7oSiq2o/4rk0x3IfjH27bVao+qPnEA8hQWiWWTgVenuQPgA1OxYyN5YSMbUMg
         /NGYsQ8aT5DorB1KY0tNvKGOkdgFaB7HVM3VZhWhh0mxU/5q0KDXkVIaf/t5XzGWPEhr
         r0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Oh8+LIPxqlpH5AytM1H1QSq6tc8XbryVzqqg5ytpvsc=;
        b=bk1Bik+eH/rPYvhVHsRTF/Sz79+kINa5VrBOpoc+iWVrPxk0PJIGoI+BIX5bmbBEne
         YJkFTzyoDqZU9fQgd43cZXTE346vVDR7NHyiVC2fZbmX4ROUJxBJADFpkpNIajiy2Xs4
         39kAoIly2n6QRuWeq5H/xwPdpJtewIi4Lyf49jYU+JAY3ddR5k6y9w0iAExu29oOx9Xj
         vUaZCXIpVQ2/xcFElC5U5Uzc/nqVyyRzRTAPEqHEIyumSbh3QTCGtqkWooBa6AjFbhD9
         HTSPA1CT2aYJZxg6sTYKNCrKV+wa2EDJeYhbDEiLugaNXomUT4+GVIPbvmQCtkpB/xHQ
         BbMw==
X-Gm-Message-State: ABuFfog4MFiz7daQI4wiHMj97QlAakUWlvsYqt4nOlnX7sguNGXuqmCr
        fSUsThLbSJrq0ehAPTFdqv8Ac+vb
X-Google-Smtp-Source: ACcGV638/Q+aO57N+PeyrQ8bg5YawQyC1Q3M9cdNXWXl+MEtsHdn5X+0+4DYGXYtQ4yK9jUfpOBxbBCl
X-Received: by 2002:a0c:9468:: with SMTP id i37-v6mr1802347qvi.21.1538587093701;
 Wed, 03 Oct 2018 10:18:13 -0700 (PDT)
Date:   Wed,  3 Oct 2018 10:17:15 -0700
In-Reply-To: <20181003171720.169953-1-rkir@google.com>
Message-Id: <20181003171720.169953-10-rkir@google.com>
Mime-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 10/15] platform: goldfish: pipe: Remove the license boilerplate
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

Not required with the SPDX-License-Identifier header.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - No change.
Changes in v2:
 - No change.

 drivers/platform/goldfish/goldfish_pipe_v2.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index a1fbbf49cc3f..ff5d88e7959a 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -1,21 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2012 Intel, Inc.
- * Copyright (C) 2013 Intel, Inc.
- * Copyright (C) 2014 Linaro Limited
- * Copyright (C) 2011-2016 Google, Inc.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
 /* This source file contains the implementation of a special device driver
  * that intends to provide a *very* fast communication channel between the
  * guest system and the QEMU emulator.
-- 
2.19.0.605.g01d371f741-goog

