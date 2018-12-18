Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9104DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6061421871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZd21eyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeLRVag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:30:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38452 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeLRV3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so17406001wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7gbgHFa4HXKExeqUx46ZtMmlK+Z7rANU6HW6YeJSjec=;
        b=dZd21eyG1Ywa9nv3C2kctIm2OmFd3iuPn7g+EE6uVnyLa5tqwsGgwvFt5T0BxUlGiB
         D2nWMwTaOdvrOeTh6DcS9ruzcYsUnnUHfEH3Hh27YzY5cyTYpvL0bqRUMLPD09iyXTef
         nJ6PolZqvnLHfyCow+i0ENezzPepOfvlIumXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7gbgHFa4HXKExeqUx46ZtMmlK+Z7rANU6HW6YeJSjec=;
        b=YBkGAT/1U9xth776v9K7SQJ/f/EhlwIva+ZeV2ge8L8Q2TpiHM581khhFPiknXxlou
         gegV0e5cutEJCEg28OyKnIE5rrMfhjNmmmaum41mFu1Dpah18JxcqdoYN3LoCp8TijvG
         d51tMUc6Fya8GK2wMaqik84CZ/G2j9y/nScKxQhPBSuzd0D6gFN+bT2gH7G84oqunRa1
         zFOefqWqleRcWCyizbTzDwfr3ymvYUkJfz4msC2t3GyCLcYsurS3CmwUiogEOyDYVtK8
         nTi4Pp+ihDkFNy5mLYLj97Ur1NzbqcKMsMJoT3L5phjdi/kWQMN37VYzIFv3qI9QFAkJ
         NmUw==
X-Gm-Message-State: AA+aEWbb1mTcbzIzK/ogefIYZievovP/8iTc4jbTV+RCt0LuBKMWHDoJ
        KF23liJvQBMrDbl0Cb3G+v3qqw==
X-Google-Smtp-Source: AFSGD/X/sVYlfzUdrGDqNDZ2qizVG5JgjYbtDj9LanD+82IMOBUM0mzy68GFemyx6NyltaPoghH+uA==
X-Received: by 2002:adf:8464:: with SMTP id 91mr17158501wrf.251.1545168572787;
        Tue, 18 Dec 2018 13:29:32 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:32 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Simon Arlott <simon@arlott.org>, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE)
Subject: [PATCH 15/25] clocksource/drivers/bcm2835: Switch to SPDX identifier
Date:   Tue, 18 Dec 2018 22:28:33 +0100
Message-Id: <20181218212844.30445-15-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

Adopt the SPDX license identifier headers to ease license compliance
management. Also drop the FSF address.

Cc: Simon Arlott <simon@arlott.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/bcm2835_timer.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 60da2537bef9..2b196cbfadb6 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright 2012 Simon Arlott
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/bitops.h>
-- 
2.17.1

