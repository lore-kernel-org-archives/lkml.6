Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0C0C10F07
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2FC218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGcXQ8Kp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfBTQyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:54:49 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:53775 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBTQys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:54:48 -0500
Received: by mail-qt1-f201.google.com with SMTP id k37so23793670qtb.20
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 08:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pkDVCnN2cgim62Luscb6DEnMU5ESMPb2u/eLYbyrXCg=;
        b=vGcXQ8Kpewn3WZblPHZlkB+6dH40Vcy4tfDV3MoaxWJRAsVd+sDJdx0HFDStW4FLOJ
         mYgBKp0U+DiWX9k0ge7cpZeFhjRfwYMM1Smtc4RpsRhl6ySWDqJLIwQyoYcP4SMc7pKK
         LDiysPwES5qtYcmobPY9QmpHDy+WPY7JGwI/94bnuxisW7qXA1unov08eajDlWEYlucJ
         8KyjVXYeWZTLRaw4UMqZ2G1+TmHp7O4lei+j+VlU+/tr68Q9UTVP1dB5bsscU9o78Nuk
         gwy8w5leVJ8M0x7B9R6VpVz0iJfPDO3gyhwTCOrWvdvxm6lmRgHvUVOe3OBXwQz8qSSF
         k1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pkDVCnN2cgim62Luscb6DEnMU5ESMPb2u/eLYbyrXCg=;
        b=PW06moCrLRMwYg2J3lB8SC7NUivxOTINhejoZ1DdKXNlj6Rm9Eo3KWtSjBFB46LAhB
         f3HRpQW24rmaf2bCQIqivm5HrHHAzGcSrFUKeo+2uhYHFbyTMDLlgSD86LHKXTM1XfYk
         yHbLW6VKxV83gnUGLBRzox5Ivsc0S/eL3RVvQ+nENKAKG0bXixxE92/wy2T7nhcevhAX
         tnU0n+KbR08cOSDhCpm/UIR80b0BbinDtIGapcozS3U06fdth/fEikNZoE7bi8aBGNFZ
         BxbqMRupuoBLmlgYD9HTQRon77LyuFKeSNwguVPcdPIdbRw8Gs5ErnW2gr2DXJksG6hl
         qHRA==
X-Gm-Message-State: AHQUAuZPLUuZFUpLMQsoXl1+NF/+rqdvjLbO5LwGtruK5g2ccrxPyq0u
        AEUqO7iHWGqftzAdGoQQIQC/2g4Q0A==
X-Google-Smtp-Source: AHgI3IaBlAsWN6zUr1YNDIlQPjXmXAQtC+r3TgDLHbReNCZkGJgXrcRyv7zcde5NUwVX2Gz2c+77kEul9w==
X-Received: by 2002:ae9:f405:: with SMTP id y5mr20427650qkl.49.1550681687633;
 Wed, 20 Feb 2019 08:54:47 -0800 (PST)
Date:   Wed, 20 Feb 2019 17:54:43 +0100
Message-Id: <20190220165443.152385-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH v2] perf/core: use strndup_user() instead of buggy open-coded version
From:   Jann Horn <jannh@google.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first version of this method was missing the check for
`ret == PATH_MAX`; then such a check was added, but it didn't call kfree()
on error, so there was still a small memory leak in the error case.
Fix it by using strndup_user() instead of open-coding it.

Fixes: 0eadcc7a7bc0 ("perf/core: Fix perf_uprobe_init()")
Signed-off-by: Jann Horn <jannh@google.com>
---
v2:
 - be compatible with existing error codes (Masami Hiramatsu)

 kernel/trace/trace_event_perf.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 76217bbef815..4629a6104474 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -299,15 +299,13 @@ int perf_uprobe_init(struct perf_event *p_event,
 
 	if (!p_event->attr.uprobe_path)
 		return -EINVAL;
-	path = kzalloc(PATH_MAX, GFP_KERNEL);
-	if (!path)
-		return -ENOMEM;
-	ret = strncpy_from_user(
-		path, u64_to_user_ptr(p_event->attr.uprobe_path), PATH_MAX);
-	if (ret == PATH_MAX)
-		return -E2BIG;
-	if (ret < 0)
-		goto out;
+
+	path = strndup_user(u64_to_user_ptr(p_event->attr.uprobe_path),
+			    PATH_MAX);
+	if (IS_ERR(path)) {
+		ret = PTR_ERR(path);
+		return (ret == -EINVAL) ? -E2BIG : ret;
+	}
 	if (path[0] == '\0') {
 		ret = -EINVAL;
 		goto out;
-- 
2.21.0.rc0.258.g878e2cd30e-goog

