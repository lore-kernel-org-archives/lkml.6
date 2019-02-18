Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93685C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF6321479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oCyOYBPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfBRWHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 17:07:33 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:38648 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbfBRWHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 17:07:33 -0500
Received: by mail-yb1-f202.google.com with SMTP id 69so9620236ybf.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 14:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uyrjSL12XYcAJ7X16b+lcNVmEe0yoTnAu2FCRMKgvOY=;
        b=oCyOYBPNAQ/y50GYzlEq92tvgttp46mIb6X4hWkZMRrJZwfa9+aaPhVtjBGZ+UshAn
         uOaKOGEb86VZIO9eoqnHmN5GdRMnW9PVP8iV7dfjlQSoHs0JUZ6xE7v0+CEACcrQ1/AK
         2DkarS3nkjX9/yi/64oguVlPgL6uKvAQ/24J8HjHYP9HIXBSPuMB82e1+GMofkVt/YUJ
         crkhTWRC4QleyW2Pl3EkJdKSwkqdkmDeurAnYfSPsbLa1Pa386/QY9aZGuS8QGeIy1Ax
         TdE/sIkRZof3PHqDKwCN4znVVW9IVB+EOtuI1RSI2hL9fOmFSuKKEkDKwOHsJhGy8xxy
         z9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uyrjSL12XYcAJ7X16b+lcNVmEe0yoTnAu2FCRMKgvOY=;
        b=BPykV32U+/h2iyfhuUMuk+yk3FVKjIYezI5lCXYjQUgdObxiVd8ZGJNaMLgIB1oEDT
         ibNDOio/Ufd2IGoFSqAEvArdo9/npJ23RuNKGGyVu85L7xV+aRned4mnqy+hYbnA56lT
         pWHp3bkbjiLowHy0CG2td3ZRHXwJKhEbRl4g8Fu/eZJQCt2p02i9c4QefqAiSK/M53td
         pezpsoZhzy6xfPCHsHVrfBKog8eg8TkoeJ1or1gqEv4Y5q1Z8rBdtF/OsRgZ7Y3Eahmt
         akFOlZMvoIpvzRdApg13hprnBDF9uNh4cHhU/nZyN8HFgqZs1fulQCsTzXS9RnopP189
         c0Qw==
X-Gm-Message-State: AHQUAuY1vqPMkh9RtrFq4ZqChiRT4o13CkjZVJamg+0t8Knt6jzlsvun
        ORVZK2YRSk778fqofxf0cXIs6AXY9g==
X-Google-Smtp-Source: AHgI3IYISTPyZVE1YaUvvnYT8JzsNYCnJX6rE3bGDjoc6CyIj2tRodjW+zM3fbrbZHHPgl9MyIBGmHI9Iw==
X-Received: by 2002:a81:6c48:: with SMTP id h69mr3505905ywc.17.1550527652619;
 Mon, 18 Feb 2019 14:07:32 -0800 (PST)
Date:   Mon, 18 Feb 2019 23:07:23 +0100
Message-Id: <20190218220723.176737-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH] perf/core: use strndup_user() instead of buggy open-coded version
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
compile-tested only

 kernel/trace/trace_event_perf.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 76217bbef815..c744b02081c3 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -299,15 +299,11 @@ int perf_uprobe_init(struct perf_event *p_event,
 
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
+	if (IS_ERR(path))
+		return PTR_ERR(path);
 	if (path[0] == '\0') {
 		ret = -EINVAL;
 		goto out;
-- 
2.21.0.rc0.258.g878e2cd30e-goog

