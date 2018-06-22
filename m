Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B892C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3447D23C63
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LS1nYIig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3447D23C63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934359AbeFVC1t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:27:49 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41021 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934157AbeFVC1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:27:20 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so2680273ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 19:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HibrqDSfu7CkjXEim2KkhNerMZHwYYKlhKB9a8eU15I=;
        b=LS1nYIigsDPM6OAyZtZ8yQYRPqSqFWLmAc96Z1UZGbx5s00bJlO7s/ctsr5+5MU3c+
         h5tjRuJGRr7ek0OYg/J+9ttkqELmOOzusON6OZOsJpcSoQhMM69EZHDCko1b+C2rZynD
         7MQE4NfsrJs2MfSQVmUUWLFHEaolcYS9BdO6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HibrqDSfu7CkjXEim2KkhNerMZHwYYKlhKB9a8eU15I=;
        b=LEqs3YNVF633O06enmIiLTgbYMmfeW/AV5fnKJo0hCtN1q+l9GeCM2F+H8sjPONUJ1
         JDipvnztzCOmS0gVsQGctfrMVFA5dO9ZPG9Rg0SIRJcqmq0AZqI+zCTApzn+njyiL5m+
         9qnbxem3jKgCugeYhzCxa31CVt/ZF/lgWLUyfCYKcv9Y++qQh7IXgr0GCVR6Gy6ya9tL
         dsvm91tIOTXEfJUQMdeOYC4b67c/xMOnQOx7woMeshgSPA5O7ACsE13NM4/Jfib9ThQ7
         9OPUkBC0ix+MRKc8YwYRUBZbO2uHVB5YAS213JoXE6+DyeFrA2mjK+em/ne41y+0+2yf
         KpXg==
X-Gm-Message-State: APt69E1VsiIEX1D+qcjU7BjycyVIQIggGQ8K9/Hj0JA53RWpY5zlJGPf
        z0O2egvEYYVUYKJ9+EQfCx7dUw==
X-Google-Smtp-Source: ADUXVKLRWDF9PMBYU+kLuF362YkZJMuLQJ5WMDve8asrYo9sQuAnDoxouxzeYrLVsiZ1fEGbssdxug==
X-Received: by 2002:a17:902:1a2:: with SMTP id b31-v6mr30385002plb.279.1529634440435;
        Thu, 21 Jun 2018 19:27:20 -0700 (PDT)
Received: from swboyd.mtv.corp.google.com ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id b74-v6sm13889045pfl.138.2018.06.21.19.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 19:27:19 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH v3 0/2] Add another regulator to i2c-hid
Date:   Thu, 21 Jun 2018 19:27:15 -0700
Message-Id: <20180622022717.134300-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wacom w9013 device has two supplies that need to be turned
on and in some cases these come from two different power supplies.
This patch series supports that case.

Changes from v1:
 * Use the bulk regulator APIs instead of open coding it (Dmitry)

Changes from v2:
 * Split out devm for allocation into another patch (Dmitry)
 * Drop errant error print that snuck in across port

Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dtor@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>

Stephen Boyd (2):
  HID: i2c-hid: Use devm to allocate i2c_hid struct
  HID: i2c-hid: Add vddl regulator control

 .../bindings/input/hid-over-i2c.txt           |  3 +-
 drivers/hid/i2c-hid/i2c-hid.c                 | 57 +++++++++----------
 include/linux/platform_data/i2c-hid.h         |  7 +--
 3 files changed, 32 insertions(+), 35 deletions(-)

-- 
Sent by a computer through tubes

