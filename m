Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB70C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 00:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1777525390
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 00:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cjD6Bhx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1777525390
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeFYAaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 20:30:05 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:47042 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbeFYAaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 20:30:03 -0400
Received: by mail-pg0-f67.google.com with SMTP id q14-v6so1505860pgt.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 17:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TiqpLj5vJjuHzBO2JRV+YLe/YFUQ2LsxJvvpm8zGnrE=;
        b=cjD6Bhx7hJkCK/LwactZ4qNoWxh3WwECQ69gzgJRGIXuvABMnXMy9FbClzn7+tTSrW
         p6/7BKRl1DYPU/ifqJpK+ce5WHlGGfOdIs+eHxsqV6V14KtMV5KTz7nM5tDS0iFgnjzC
         t3SxOfGjEqEtFf5mQ2e7vhKgyc/QAx2zIaJVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TiqpLj5vJjuHzBO2JRV+YLe/YFUQ2LsxJvvpm8zGnrE=;
        b=Le+o4GpqibSDppvvAJRUedEzq5J+1FTnQYk4J2lMHLSVtdzAqC7cijl4PdFIFxJVPa
         eurIXj+SHHapau0hY0OTJziMzp/fHmDbW2I+Ca7w4KVDtPC6mGxrWUr04QfKfcRDU8Oc
         gXPUsqjooaSiQB/NILAMAZlvXDpNd7HvZNOvB03/SO9c1x0cozVoPGFV7bJHHW5Hfgpp
         B7k15FsaR2Q6GvRB3z8QlX0NMLXtYTNotiLSkRULF6LibL+frvfvn0k/g7FEpRrp2VKT
         FqCV4Ew4HoCx0rkUIYIZIVt5a0VQJxlUbeqC7CuMM4zuK7sq9hdepS9x6G0sWHY82C6a
         uwqQ==
X-Gm-Message-State: APt69E2f6n/U5QhDhUzwI0p0FEnbljHYIzP3/NHkjCs/kAM4Qy9j/DK9
        OuHBRSdHycjuppLRCleS+e09Dw==
X-Google-Smtp-Source: ADUXVKJHkBc/Z6YsGbjXAD5O8rhEN/qNP/l6AGkBZpKQ9WywEyIXixIllkdyqFtnch+HAeTbVmf68g==
X-Received: by 2002:a63:3807:: with SMTP id f7-v6mr8777158pga.446.1529886603049;
        Sun, 24 Jun 2018 17:30:03 -0700 (PDT)
Received: from delco2.sfo.corp.google.com ([2620:0:1002:19:b211:91ff:fab4:4e8])
        by smtp.gmail.com with ESMTPSA id k69-v6sm21948365pgc.39.2018.06.24.17.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 17:30:02 -0700 (PDT)
From:   Matt Delco <delco@chromium.org>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Matt Delco <delco@chromium.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2] platform/x86: intel-vbtn: Add support for dock mode detection
Date:   Sun, 24 Jun 2018 17:29:40 -0700
Message-Id: <20180625002940.117141-1-delco@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Dell laptop I have has an ACPI that sends 0xCB and 0xCC on entering
tablet mode.  On exiting tablet mode it sends 0xCA and 0xCD. Based on:

http://www.traby.de/medion/DSDT/dsdt.dsl
https://gist.github.com/jprvita/5737de3cbb670e80973b7d4e51c38ab6
https://osdn.net/projects/android-x86/scm/git/kernel/commits/
7cbe5a330687b851f32dd9f1048a6ce182d0ff44

It appears that 0xCA and 0xCB are about dock mode, which for my
convertible laptop seems questionably tied to whether I've put
the laptop in tablet or laptop mode.  I previously proposed no-oping
0xCA and 0xCB but this revised change attempts to add support for
detecting dock mode--this detection will essentially be broken for
my laptop (the main workaround would be for 0xCA and 0xCB to be used
to provoke a query of the VGBS method that reports the current dock &
tablet mode [which is accurately reported on my laptop but based on
the prior workarounds in the driver it apparently can't be trusted
for all systems]).

Signed-off-by: Matt Delco <delco@chromium.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/intel-vbtn.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index c13780b8dabb..06cd7e818ed5 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -17,6 +17,7 @@
 
 /* When NOT in tablet mode, VGBS returns with the flag 0x40 */
 #define TABLET_MODE_FLAG 0x40
+#define DOCK_MODE_FLAG   0x80
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("AceLan Kao");
@@ -38,6 +39,8 @@ static const struct key_entry intel_vbtn_keymap[] = {
 	{ KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },	/* volume-down key release */
 	{ KE_KEY,    0xC8, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key press */
 	{ KE_KEY,    0xC9, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key release */
+	{ KE_SW,     0xCA, { .sw = { SW_DOCK, 1 } } },		/* Docked */
+	{ KE_SW,     0xCB, { .sw = { SW_DOCK, 0 } } },		/* Undocked */
 	{ KE_SW,     0xCC, { .sw = { SW_TABLET_MODE, 1 } } },	/* Tablet */
 	{ KE_SW,     0xCD, { .sw = { SW_TABLET_MODE, 0 } } },	/* Laptop */
 	{ KE_END },
@@ -121,6 +124,8 @@ static void detect_tablet_mode(struct platform_device *device)
 
 	m = !(obj->integer.value & TABLET_MODE_FLAG);
 	input_report_switch(priv->input_dev, SW_TABLET_MODE, m);
+	m = (obj->integer.value & DOCK_MODE_FLAG) ? 1 : 0;
+	input_report_switch(priv->input_dev, SW_DOCK, m);
 out:
 	kfree(vgbs_output.pointer);
 }
-- 
2.18.0.rc2.346.g013aa6912e-goog

