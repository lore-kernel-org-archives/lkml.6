Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB161C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB3B21E9A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CeZoQPzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB3B21E9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933162AbeFUUMZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:12:25 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38179 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932621AbeFUUMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:12:23 -0400
Received: by mail-pg0-f67.google.com with SMTP id c9-v6so1905366pgf.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8EmkKY6gm6q1VIT2y7saUAFdNgQDP/z/9R86qcYMw9M=;
        b=CeZoQPzomfPXZvADOjs59HirFJ/xFRv/YdOST3GinLoIBiMzx3FBT/Xl/lJsjGWCId
         zaF2JAmMd/iZxZ42Lr70g97LlNhg6Swz6Um4rOSlTIZEWJnumXpP7SVsO1lsnKu/lVhF
         ptWcrDkb157W+wD9A3ezAj4YJpXP5pi13IKWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8EmkKY6gm6q1VIT2y7saUAFdNgQDP/z/9R86qcYMw9M=;
        b=N47zWPU10u0ZLoiIqvi6m/BZyEGTKRiBJwXzGWH7YwD/oizQ5jz0PDEe+AjA0wH0Jh
         XhwJst6cLJGIgJpprx/wbXSEgDulJ2bp71MfIbCIKmsbi02tQMvvpQ/o9RiIUIStHSPf
         w8utXybGzUMbyyhmrLuuW00R7e/ozwHcxRpGYXX+svpAHSFAu5R3Ndvn4vrGlcvDHBdm
         BJVTukL39hQtaMsSLMsugr4P3kyvODOxhari7z70QkNtxaHGskpaQibdglxYxGxK5yH3
         0wxLLntocc7FFDqVmQJpF+CO8XxnquL1CTFH5T8pR6oVSD7kTzOBioBPY3aPEsW9M347
         iJ/g==
X-Gm-Message-State: APt69E1yYl1RQyU6kFeplo2fS5Ja0LHC+ghVd+xuV/74tMtH5ZDwDgUy
        28aUf0GuzU4d1bGL6M5mXWnTmw==
X-Google-Smtp-Source: ADUXVKIo/K3xkGndmuwYTI9mWv/+NLb4mpYdX2QJfttumxjy475RW4a14JAer33XwDDynGqfigP7eg==
X-Received: by 2002:a65:46cb:: with SMTP id n11-v6mr23253195pgr.193.1529611943512;
        Thu, 21 Jun 2018 13:12:23 -0700 (PDT)
Received: from delco2.sfo.corp.google.com ([2620:0:1002:19:b211:91ff:fab4:4e8])
        by smtp.gmail.com with ESMTPSA id j13-v6sm6938338pgq.73.2018.06.21.13.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 13:12:23 -0700 (PDT)
From:   Matt Delco <delco@chromium.org>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.or, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matt Delco <delco@chromium.org>
Subject: [PATCH] platform/x86: intel-vbtn: Ignore extraneous events from tablet mode
Date:   Thu, 21 Jun 2018 13:12:07 -0700
Message-Id: <20180621201207.178426-1-delco@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Dell laptop I have has an ACPI that sends 0xCB and 0xCC on entering
tablet mode.  On exiting tablet mode it sends 0xCA and 0xCD.  This
change has the driver ignore 0xCA and 0xCB.

Signed-off-by: Matt Delco <delco@chromium.org>
---
 drivers/platform/x86/intel-vbtn.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index c13780b8dabb..4c6f2bb1d1ac 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -38,8 +38,10 @@ static const struct key_entry intel_vbtn_keymap[] = {
 	{ KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },	/* volume-down key release */
 	{ KE_KEY,    0xC8, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key press */
 	{ KE_KEY,    0xC9, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key release */
-	{ KE_SW,     0xCC, { .sw = { SW_TABLET_MODE, 1 } } },	/* Tablet */
-	{ KE_SW,     0xCD, { .sw = { SW_TABLET_MODE, 0 } } },	/* Laptop */
+	{ KE_IGNORE, 0xCA, { KEY_UNKNOWN } },			/* Laptop key press */
+	{ KE_IGNORE, 0xCB, { KEY_UNKNOWN } },			/* Tablet key press */
+	{ KE_SW,     0xCC, { .sw = { SW_TABLET_MODE, 1 } } },	/* Tablet key release */
+	{ KE_SW,     0xCD, { .sw = { SW_TABLET_MODE, 0 } } },	/* Laptop key release */
 	{ KE_END },
 };
 
-- 
2.18.0.rc2.346.g013aa6912e-goog

