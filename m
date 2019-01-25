Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0D7C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15816218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lovztCXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfAYCS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:18:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40634 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbfAYCS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:18:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so3973026pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 18:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RBetwYWYLmofzjKR9nH332q/LlF+CPSCksN63/MPFgA=;
        b=lovztCXvP2znz2YDWCsnt9PbEfmCDm9dGv58FaX89sLzl4MY/1AZWTJLwzLFDgizLC
         kfBND4TcOSRCzAad8vvz85YTEUEhgPNWMZfTSPKIi9775t7jiAAJCVlW219ozUCLhC6/
         XZ7R/1tQs4iPMuOHApzKYu9ITOLiwubCqQPay2801u0NE+Y3kvCg8R7nxUf8sGBgzTsl
         Iws8RbnPpyaOWT8Q1Ltuohhdvz30hDF4V22Rmn3vGGbBfj3YEyc2EnMxTi7y5N0ne64X
         iCFh108jS0CP0LX8zeub0X3dvM6zMQNBdbBga+pxscbwqS03NlO0ttDDREKiyc+yvGDr
         ttEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RBetwYWYLmofzjKR9nH332q/LlF+CPSCksN63/MPFgA=;
        b=ZFN1gJlMHWFC9HGbgGv+d+3wQ4tPJ+IYFtZ+0k8F7MvkhPzSfhRMg0wbFsuL1GKmYP
         A6363GoGYLY3wEUXFyWFfEd9N1o5RykDLx3XV/uFTb69Wr08/vRQq7FZi/xfL9oTc8FR
         rlCm/axbb9DT5A99ruWuMOujKtCNbyyDptt4Xot5u/9JgHaGg9X9AigtQjbFH6cm5BpJ
         /mjaQtbWEEEDlxLXIZwQOsro6SIoRGthB2Be8irkWvbcJQpUWdLUcHBV4u7UKxVJamQE
         PE3j3mmoYupAoi2zziP0bhP6C04ItRivh0Bto3d/OlGTRSVKvIjsroQJPJZRpPieaAlQ
         wIHg==
X-Gm-Message-State: AJcUukfg7Q16oisPxPn4NzbITo2G7fs0JgoXGr6T2Nn1H6DUQrajjKUK
        Kya3bpTNWFaIEc+AukYxaPo=
X-Google-Smtp-Source: ALg8bN642rHhCzO8H9HKNuHNjPkxbhzdjudMBhrLvHGtkPME37ykMgpJXcNbmjHa5OyyOKTntNdfWA==
X-Received: by 2002:a62:2b8b:: with SMTP id r133mr9029018pfr.246.1548382706449;
        Thu, 24 Jan 2019 18:18:26 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id d68sm32580500pfa.64.2019.01.24.18.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 18:18:25 -0800 (PST)
From:   frowand.list@gmail.com
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH] tracing: initialize variable in create_dyn_event()
Date:   Thu, 24 Jan 2019 18:17:50 -0800
Message-Id: <1548382670-30266-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Fix compile warning in create_dyn_event(): 'ret' may be used uninitialized
in this function [-Wuninitialized].

Fixes: 5448d44c3855 ("tracing: Add unified dynamic event framework")

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Compile and boot tested only.  Please verify the initialization value
of zero is correct.

There is also a sparse warning you might want to check into (when
ARCH=arm, so 32 bit):

   include/uapi/linux/perf_event.h:147:56: warning: cast truncates bits from constant value (8000000000000000 becomes 0)


 kernel/trace/trace_dynevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index dd1f43588d70..4f633476c307 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -74,7 +74,7 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
 static int create_dyn_event(int argc, char **argv)
 {
 	struct dyn_event_operations *ops;
-	int ret;
+	int ret = 0;
 
 	if (argv[0][0] == '-' || argv[0][0] == '!')
 		return dyn_event_release(argc, argv, NULL);
-- 
Frank Rowand <frank.rowand@sony.com>

