Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD74C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80157206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c+ueTC6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80157206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeLDXou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:44:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40768 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeLDXou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:44:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so9010049pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 15:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9DX8afGv1w+7f65QwpbQigOVELaOuR1amOAtR8RjUg0=;
        b=c+ueTC6VXQdxdWIAp1a6cmzuVy5KFu6tilhwQzSAsPOdfdEmFJtHYGY/oczSlhzM4a
         H4e1LU3v3Kr7m7Cy82xL7jpWIDHbtE6lUouo8+z9Qwp4cFyyjZWga19LGFvl+cP9QNzb
         SsMwsIQjg4iGV6J5IpDyRefPJieLqQYC/8yyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9DX8afGv1w+7f65QwpbQigOVELaOuR1amOAtR8RjUg0=;
        b=Xv3jy7ZagbEMxW2HATocPgEkRe9YVUo9gHbkfjodLN3jBJaCLBEDa2EpYC+oRgbnZ/
         hF5yesBgFwePJqzg4hB4A+NbyXE5JTlRHLCN4FSImEvfcwIVyW3XFVSvq1Yhrkh3GLIz
         KG8B4NybzdK+wSeJAeUCvAgEs/AvnwvreHhqquwxbu+rbGqsApEk3Exfl4D5mZV3MLm3
         vXOQQqHDz7ESYVtKBQ9qWetc0LrJ3xLC8sCGUzIHKD4jBgWnTL5AZLu4pOPi3ecEyfIu
         uMzHZVZCpVMTMaLuxKdtCfInP9NntEx0HFH4CcnHuqX7N42jLORoaK88TxTBtHkbtZHi
         AQCw==
X-Gm-Message-State: AA+aEWZE5ZTFKqeGvA7bdTp2O8FamUU8Op2yvS2FCUIipXDnEcd5Kk7s
        IIPFmw0jjgz4kkcQ8+aRnE1H1w==
X-Google-Smtp-Source: AFSGD/XtRtcBO94nyo7Y8fklBV+AEWss4QCy0cUQkGTa+mMgEq4tgkSCP53WyCtfrj8sF6r7aIv5KQ==
X-Received: by 2002:a63:86c2:: with SMTP id x185mr16974330pgd.230.1543967089176;
        Tue, 04 Dec 2018 15:44:49 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id m20sm20351909pgv.93.2018.12.04.15.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 15:44:47 -0800 (PST)
Date:   Tue, 4 Dec 2018 15:44:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fanotify: Make sure to check event_len when copying
Message-ID: <20181204234446.GA4676@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a precaution, make sure we check event_len when copying to userspace.
Based on old feedback: https://lkml.kernel.org/r/542D9FE5.3010009@gmx.de

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/notify/fanotify/fanotify_user.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index e03be5071362..d9484a0ac6b3 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -206,7 +206,7 @@ static int process_access_response(struct fsnotify_group *group,
 
 static ssize_t copy_event_to_user(struct fsnotify_group *group,
 				  struct fsnotify_event *event,
-				  char __user *buf)
+				  char __user *buf, size_t count)
 {
 	struct fanotify_event_metadata fanotify_event_metadata;
 	struct file *f;
@@ -220,6 +220,12 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 
 	fd = fanotify_event_metadata.fd;
 	ret = -EFAULT;
+	/*
+	 * Sanity check copy size in case get_one_event() and
+	 * fill_event_metadata() event_len sizes ever get out of sync.
+	 */
+	if (WARN_ON_ONCE(fanotify_event_metadata.event_len > count))
+		goto out_close_fd;
 	if (copy_to_user(buf, &fanotify_event_metadata,
 			 fanotify_event_metadata.event_len))
 		goto out_close_fd;
@@ -295,7 +301,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 			continue;
 		}
 
-		ret = copy_event_to_user(group, kevent, buf);
+		ret = copy_event_to_user(group, kevent, buf, count);
 		if (unlikely(ret == -EOPENSTALE)) {
 			/*
 			 * We cannot report events with stale fd so drop it.
-- 
2.17.1


-- 
Kees Cook
