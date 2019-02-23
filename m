Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C68C10F0B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9951C20850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOM0zmce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfBWNgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:36:10 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41385 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfBWNgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:36:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id d25so2385843pfn.8;
        Sat, 23 Feb 2019 05:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5Cjccokllz+uihOlKGyN58GRiF4Ga/EDEkE/v6fF5Gk=;
        b=HOM0zmceRZOvQBgFFKBWHe4xbmjNahJN/SdWBpctfeTriA5CKz2Q7BPyOSGQsDRpjm
         qzJ7lFiK65FBVphnoL47Q7n72ZwL5Sbq/pvYgtbpArFulPeQaP45++K46KknDe69GYxH
         9/DRRGq1L2V/Dqyse0m6BTqbbnJE8L5VzIN/ADG6yg9PPdyQeIpKcPy89BQ//TI7v4Ij
         kTt/neAmmPgekNZW2TGkRTS/TyF4BQvkntl/jNCeanVj6ci5mp3hK08tnOJQ6/qqvKlf
         MUgKCzz8z4Pn75fl60aysoq1kb6Bo0FilmAdgoNhZ3pCAa0jePF5FnEoIATJ++Wql6aM
         mI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5Cjccokllz+uihOlKGyN58GRiF4Ga/EDEkE/v6fF5Gk=;
        b=i95K1GXxtCT0d0e7NxhVT3Wqa9QFSvS+sKFowe7z0imSOvGOj70wiSEfK6IxmYyN1t
         me18mqMB8cSr+8mOhOCvwU70KguC8QkKWhs+4O2snXhlT5a06jmOEnq/FicCTMhJgPXh
         OZF0ZDDItmN+a9qjQqSTKus9xfBwnozehj6fP6cubpWcpcDuV+SOUCXcfu6RKsYH1JEY
         uW94P+D9GJ1rp9XB0N/qhfkN4mW+cPMcyRQkqYcbEFljanYpDGfYGD2wt9ioukKui/YO
         xoYgoJAFba8cBirYJdzcb1Sk1Geuu1m8HMjEk1QyEIGTWaZjYXKBEf9QKFWUt7HIlv6Y
         UAyg==
X-Gm-Message-State: AHQUAubBp4jBqtgYOoFB4UbNvE/19odVgoJ9HwZOydk40W5hbmBghcRH
        FduEQEc5lGdNqCDC5PJUcFIBTSBG4O8=
X-Google-Smtp-Source: AHgI3IZWRQpQUzr9FZuDWVI/Rt42Ae/JLqCJ1YMXYMpEzQYpLIbAMSSEYTfZyUAc/ovMpV4ptEhKJQ==
X-Received: by 2002:a65:628e:: with SMTP id f14mr8905755pgv.193.1550928968586;
        Sat, 23 Feb 2019 05:36:08 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id g136sm11796190pfb.154.2019.02.23.05.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:36:07 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     viro@zeniv.linux.org.uk, tj@kernel.org, rostedt@goodmis.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH] writeback: expose cgroup info in trace_writeback_pages_written()
Date:   Sat, 23 Feb 2019 21:35:49 +0800
Message-Id: <1550928949-11879-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With cgroup v2 writeback, we can know these pages are written from which
cgroup.
So expose the cgroup_ino for better tracking.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/fs-writeback.c                | 4 ++--
 include/trace/events/writeback.h | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 36855c1..e98a33e 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1973,7 +1973,7 @@ void wb_workfn(struct work_struct *work)
 		 */
 		do {
 			pages_written = wb_do_writeback(wb);
-			trace_writeback_pages_written(pages_written);
+			trace_writeback_pages_written(wb, pages_written);
 		} while (!list_empty(&wb->work_list));
 	} else {
 		/*
@@ -1983,7 +1983,7 @@ void wb_workfn(struct work_struct *work)
 		 */
 		pages_written = writeback_inodes_wb(wb, 1024,
 						    WB_REASON_FORKER_THREAD);
-		trace_writeback_pages_written(pages_written);
+		trace_writeback_pages_written(wb, pages_written);
 	}
 
 	if (!list_empty(&wb->work_list))
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 32db72c..a806713 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -255,15 +255,18 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 DEFINE_WRITEBACK_WORK_EVENT(writeback_wait);
 
 TRACE_EVENT(writeback_pages_written,
-	TP_PROTO(long pages_written),
-	TP_ARGS(pages_written),
+	TP_PROTO(struct bdi_writeback *wb, long pages_written),
+	TP_ARGS(wb, pages_written),
 	TP_STRUCT__entry(
 		__field(long,		pages)
+		__field(unsigned int,	cgroup_ino)
 	),
 	TP_fast_assign(
 		__entry->pages		= pages_written;
+		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
 	),
-	TP_printk("%ld", __entry->pages)
+	TP_printk("pages=%ld cgroup_ino=%u",
+		   __entry->pages, __entry->cgroup_ino)
 );
 
 DECLARE_EVENT_CLASS(writeback_class,
-- 
1.8.3.1

