Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EA9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1096206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNvaWG/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfBVTaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:30:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42016 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVTaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:30:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id r5so3543659wrg.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 11:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DuAvEuHmnCrO2xD6btAt1iWEyLFO4pNOkEya2+VM1T0=;
        b=NNvaWG/JR63nVVUxADypkTC2Fq5Eigd51Bd136QT5PQMaqAkFQo35hzKqKkg22YX+u
         J3LolHuQeN8XDdTOI0qyZz1LuU4876IKfhIUCfempx/VpPN5bBAOUtRQ0SM6IGphFVJI
         uWfqcYKMrYL00Fg4PdgCyklO3btIH+ezx220uwvb8rFKxRZi74teHJUPuAfZUp0kmTQY
         PefG0Me3JizY9nFJikSJazoMRzrWT5XuPwUjyuP/OHBRi65AwqxWem4GMFnZdMtAOqzO
         oLs+cg60NzC125m2av2BwXUm5WDgP691VvquMLk1PXUZei+Ih+St/zmgEzlxWXoOPTRh
         aiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DuAvEuHmnCrO2xD6btAt1iWEyLFO4pNOkEya2+VM1T0=;
        b=fwbMTQaLRBLUSca/UZjhSU9N97LzRCnYJtd5krurnAY1IXLK1pnNTNSaJV02hlLbE0
         KLsDXvKlYmBOzMAkwqf+7tkZ2LntJvPK1mZtXqS8wax3j3MoYgA+07D+A1DBw+SGwb3O
         K/QD36JBaJa1U1qyd+DMFe5mwOBUHXZ/gMDoGEHg9wT1W8krbvc4FME15j39g253owOs
         nGAObSGbLFozgtE9R70GKi2MiKj6exDmgZJOY89kSA5qfTzX2qEcWtW340rcLslxkiG+
         aCbB32r0qizv+6M7aIyBvujS9RVhtUo0RdVHutC2VGfYIC8LQRiiE9HsYpSMPi4fXUuL
         QDtg==
X-Gm-Message-State: AHQUAuZmY46D+6l3I6/e6Yfy1aa1N5BWmcooxGwCdw9evvLdqeWD4QlF
        /7knuKtV93kL7E0p+Piex3g=
X-Google-Smtp-Source: AHgI3IZrbwFKBUKyo3xIjSZpu11Q2DfHizrzXSye4sVALXXRSy6vyQJZZUT5ggvvLcroHAb8Q3dGBA==
X-Received: by 2002:adf:ba12:: with SMTP id o18mr4417406wrg.326.1550863802347;
        Fri, 22 Feb 2019 11:30:02 -0800 (PST)
Received: from goyamonster.habana-labs.com ([31.154.181.186])
        by smtp.gmail.com with ESMTPSA id e6sm2920345wrt.14.2019.02.22.11.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 11:30:01 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com
Subject: [PATCH 1/2] habanalabs: don't print result when rc indicates error
Date:   Fri, 22 Feb 2019 21:29:58 +0200
Message-Id: <20190222192959.241499-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

send_cpu_message() doesn't update the result parameter when an error
occurs in its code. Therefore, callers of send_cpu_message() shouldn't use
the result value when the return code indicates error.

This patch fixes a static checker warning in goya_test_cpu_queue(), where
that function did print the result even though the return code from
send_cpu_message() indicated error.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index c43bd37fe693..e6f0d49ab71a 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3380,10 +3380,16 @@ int goya_test_cpu_queue(struct hl_device *hdev)
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &test_pkt,
 			sizeof(test_pkt), HL_DEVICE_TIMEOUT_USEC, &result);
 
-	if (!rc)
-		dev_info(hdev->dev, "queue test on CPU queue succeeded\n");
-	else
-		dev_err(hdev->dev, "CPU queue test failed (0x%08lX)\n", result);
+	if (!rc) {
+		if (result == ARMCP_PACKET_FENCE_VAL)
+			dev_info(hdev->dev,
+				"queue test on CPU queue succeeded\n");
+		else
+			dev_err(hdev->dev,
+				"CPU queue test failed (0x%08lX)\n", result);
+	} else {
+		dev_err(hdev->dev, "CPU queue test failed, error %d\n", rc);
+	}
 
 	return rc;
 }
-- 
2.18.0

