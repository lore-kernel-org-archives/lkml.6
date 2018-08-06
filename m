Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF65C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABFE21A52
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAzhpGbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABFE21A52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbeHFTSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:18:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34663 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeHFTSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:18:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id f8-v6so11219004ljk.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tD0yUFIEyj9TjBkE3S4ZiEWQoVzWVpszb5YvOWGOp2E=;
        b=iAzhpGbqonuTtj/XlA8/ETxjAvfZi46MSMwt3Xqj6eMNfKpZMLLs+x22fIL+qnr8Ud
         Oj9fJhwataYMXbu6O0QUoh+ZbwjH1JHa17ZG56Nfw9LiEkgEdudFT2Jao6+ENPmiYCP4
         GztvKQeDBwQ4hGYhNAfF5SW7qHxjNURgKWXyIEltETihXLp1F0UCAq3PDitaI2IsX6yz
         ZisKWqTnDZkWjjDwpGTn1F76sQ2LUqgo6YzyOXXH9+XWYDh3YEBGQTkpsYel4+aQf0xO
         hONFOlMdqvZYOH7xRmnyhOp3BTFj7Q+53OZUlH1LfKI2PApSDNK31grib5uiJS40Nb4X
         i+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tD0yUFIEyj9TjBkE3S4ZiEWQoVzWVpszb5YvOWGOp2E=;
        b=szVPvC2llWmWyLqMq+GK4biThIDr6qpidVmUGTDgIvfpQMbUDQATb77GqEqjhp4Uy1
         B4O+OYwzkQRUbVjMeHO8GOexlopnvibnT5ntSGR0Wjp0tDOZ6K7KwY1knFYX3DZ395Ce
         HNL+BEU0k4PP4DzB6yCU0ucJGaEAD/74QYp7wn84nE2UHREcjNNTL8XeDVvtUk1RjrG7
         nJDPTv07sw8X90jbTarNxdXvyU5283gEqv5F9GHqURvUZaLvm6gEDNBtxJfjIDtoeLyV
         NL+SjyZKc9lEEqudswPmF2NapKbbp6Xs3/OYksTH36lGqNJoMFwJh/o6nPRQ3GTyKZGw
         oUiw==
X-Gm-Message-State: AOUpUlHnEYLV5dUix+9HA4p+JcM3U7wG19OtJvMA4bhvQhsvYCfu91hx
        wEuZDtIjm4AR4EjWCnoZD8o=
X-Google-Smtp-Source: AAOMgpeeWZnObeOeFd430jEAp+X8lYAElInKhek7Cw1CePpj2IHqR9DFTP5qUJ6clsqTGnIccO1U0A==
X-Received: by 2002:a2e:4d51:: with SMTP id a78-v6mr12741365ljb.106.1533575310362;
        Mon, 06 Aug 2018 10:08:30 -0700 (PDT)
Received: from localhost.localdomain (185.59.110.199.maxnet.net.pl. [185.59.110.199])
        by smtp.gmail.com with ESMTPSA id 36-v6sm2401457lja.65.2018.08.06.10.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Aug 2018 10:08:29 -0700 (PDT)
From:   Arkadiusz Lis <areklis909@gmail.com>
To:     jfrederich@gmail.com, dsd@laptop.org, jon.nettleton@gmail.com,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Arkadiusz Lis <areklis909@gmail.com>
Subject: [PATCH] Staging: One Laptop Per Child: fix SPDX-License-Identifier issue
Date:   Mon,  6 Aug 2018 19:08:20 +0200
Message-Id: <1533575300-5001-1-git-send-email-areklis909@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPDX-License-Identifier to the source files

Signed-off-by: Arkadiusz Lis <areklis909@gmail.com>
---
 drivers/staging/olpc_dcon/olpc_dcon.c        | 1 +
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c   | 1 +
 drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
index 2744c9f..318adc4 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Mainly by David Woodhouse, somewhat modified by Jordan Crouse
  *
diff --git a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
index 633c58c..c72f492 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Mainly by David Woodhouse, somewhat modified by Jordan Crouse
  *
diff --git a/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c b/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
index 6458442..07b70eb 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2009,2010       One Laptop per Child
  *
-- 
1.9.1

