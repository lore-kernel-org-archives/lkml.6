Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C91C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA68208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZASU3fEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA68208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbeJEVfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:35:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38586 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbeJEVfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:35:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id a13-v6so13793627wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5lXR8m8cjW/Gcniq6z5N+1Ak1GesFWLZUsd12sT42iE=;
        b=ZASU3fEJ4JaRbZ/qFbTeK2i+MaU66vosrWmzsG4/TPjJSjAzpMemb+mnqQJhzAAdRb
         4QPG/Au0CEf5Zevp8BirypeAr54uki3xbT7h2ACf99NZz1SlPRvzvYRflzfDc7rkQox+
         NOyO8QzkWrZUDCgmZzfkcPHurAUs1d+WWp5QA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5lXR8m8cjW/Gcniq6z5N+1Ak1GesFWLZUsd12sT42iE=;
        b=KQtH6uAClQYB3OLBD50nOL9eR1sHLyO6iiP2Q5wNpdwgUcZBvTjHQgst29n7tjBg6Q
         HBHhU9oB1CuljeD/+adZsvkBlk6Z0RZNtKZmsLu8PQqSM6D9keVbuX82Fc5kZ8pNky9l
         JjWWqm4a3FcpSqPRea3m/XylL2hvNhEv/Ri85bvWxyj4gkCCpOT74WmJosZLEMz8coa8
         pMYG3LLcZVNYasiMV85coOQ0jjLMTdSA804Z8ZlO5V2+g64LZ9jbKXxyEXpSO+Hh5JHg
         eMpynRrKNK6NG9B0sPqxjbkRvGG/v+Hc0EzEavTdkVHaHmGWNwuGYUWUfoJ/WFyHtidD
         J5BA==
X-Gm-Message-State: ABuFfojnDu24956MU/z91+yRKA+QTQ5b4f7SLGCdO0N1qGBlHfqNwus8
        214di4unAQaVdLk2Tt32xRQq47bMpFA=
X-Google-Smtp-Source: ACcGV61BM47rUhx7zhrT55ce9Xfgwgpl64LjirtoOTDX2c+IZuZwbxA+7ydEGZlxCVzSN0lxiDCtuQ==
X-Received: by 2002:adf:d4c6:: with SMTP id w6-v6mr8203555wrk.119.1538750166548;
        Fri, 05 Oct 2018 07:36:06 -0700 (PDT)
Received: from localhost.localdomain (151.240.136.77.rev.sfr.net. [77.136.240.151])
        by smtp.gmail.com with ESMTPSA id t24-v6sm14080377wra.5.2018.10.05.07.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 07:36:05 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 02/13] clocksource/drivers/renesas-ostm: Convert to SPDX identifiers
Date:   Fri,  5 Oct 2018 16:35:31 +0200
Message-Id: <1538750143-4282-2-git-send-email-daniel.lezcano@linaro.org>
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
 drivers/clocksource/renesas-ostm.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 6cffd7c..61d5f3b 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -1,18 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Timer Support - OSTM
  *
  * Copyright (C) 2017 Renesas Electronics America, Inc.
  * Copyright (C) 2017 Chris Brandt
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 #include <linux/of_address.h>
-- 
2.7.4

