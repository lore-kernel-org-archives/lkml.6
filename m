Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2846CC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BF620880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SVsdpxZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BF620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbeGXVKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:10:34 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43086 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388587AbeGXVKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:10:34 -0400
Received: by mail-pl0-f66.google.com with SMTP id x6-v6so540364plv.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fxyppTkMfFGXpvvAHvd5Vl07SMUO+rXqR7ekmXh1EDI=;
        b=SVsdpxZbj1xpQ0UXU1GE9rGZycYrRiCsUcBGcqe/L9YfYjqYJA9wLZYLhJBLeD6R9b
         oeY+2d2I8u86DD1pWGxfASTBP/naBlowKSBAhzq9GoGhKr8M1xTQ48GX+GGBD0cHOHJF
         EaUdoqVsFwR86MczKwN+jwW5ctEEBXRXlH9HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fxyppTkMfFGXpvvAHvd5Vl07SMUO+rXqR7ekmXh1EDI=;
        b=Z3cc5Wd6H/2t5r3GdEpQNcSb6QsYnaDyJIgWlwutNoirZr+2WgLT6S1zBqOrQ17c8Q
         Gm8n2DlKgs1ADIKb5meSrZej/xD1tWcBazNoAr+NkwMcNQ2B52h/Wjr8CjSocUf9+iDl
         8mxZ424BOFaMbUExcR7t1rGfvaV2llC2gsF1qxaOq9vuIBujTTSy38UXZcKM4u2kx6Xk
         OqCvLsfbFntHqvehdAjXJFanKjm5nwZrfdRfDWK8oAvLMOWrB3AWPVl81SX1IESpUmvK
         EIZMd05UwVeSur8e8GbzJOgZ82VjHvsOJEspKHLXvIvWtd/9X5GU80XRdUqxC8Q49aIN
         QSAw==
X-Gm-Message-State: AOUpUlHjNsaBTQZew4TFKdAqAJGugewYoygAHax1pfvGGE+iBz6+LTru
        e8oMKkYUEmhb7RtW2D12Daujo3B+w0w=
X-Google-Smtp-Source: AAOMgpdmgXUGb6kIozT86FaOR2rtfHvbpRqTCHH6+mJsrZJwbkaL7pMZANSIkS8qWSp21Lkzdu4DEQ==
X-Received: by 2002:a17:902:7106:: with SMTP id a6-v6mr18707542pll.28.1532462549831;
        Tue, 24 Jul 2018 13:02:29 -0700 (PDT)
Received: from zsmcros.c.googlers.com.com (235.153.227.35.bc.googleusercontent.com. [35.227.153.235])
        by smtp.googlemail.com with ESMTPSA id y3-v6sm22429009pfi.24.2018.07.24.13.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 13:02:28 -0700 (PDT)
From:   Zubin Mithra <zsm@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, groeck@chromium.org, zsm@chromium.org
Subject: [PATCH] tracefs: Annotate tracefs_ops with __ro_after_init
Date:   Tue, 24 Jul 2018 16:02:14 -0400
Message-Id: <20180724200214.95975-1-zsm@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tracefs_ops is initialized inside tracefs_create_instance_dir and not
modified after. tracefs_create_instance_dir allows for initialization
only once, and is called from create_trace_instances(marked __init),
which is called from tracer_init_tracefs(marked __init).

Signed-off-by: Zubin Mithra <zsm@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/tracefs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index bea8ad876bf9..20e965873f27 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -53,7 +53,7 @@ static const struct file_operations tracefs_file_operations = {
 static struct tracefs_dir_ops {
 	int (*mkdir)(const char *name);
 	int (*rmdir)(const char *name);
-} tracefs_ops;
+} tracefs_ops __ro_after_init;
 
 static char *get_dname(struct dentry *dentry)
 {
-- 
2.18.0.233.g985f88cf7e-goog

