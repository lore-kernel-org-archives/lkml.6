Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04236C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBB1208A5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdIMSHsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBB1208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390653AbeHPMtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbeHPMtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:49:02 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 680B6208A5;
        Thu, 16 Aug 2018 09:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534413098;
        bh=OWsbrQ04NVLrFlxeygp3wC/xuQr/Njxo2Y40/YKeR3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdIMSHsE9xQpqqhZ9T13CJ9daDtuLuCFC4TpfGyxtdkhqJSjycEXSkwDhkg9nNNtO
         6FoaTp6BFe+2koCnzEjMjr+sqhtcH83IVF2VcGs+bZFamcfNTLjUlA/o2BET7X1p0g
         78dKyB+T6uc9s5SonANGEAcp4i+qjQq/apuJYWBo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH 2/2] tracing/blktrace: Fix to allow setting same value
Date:   Thu, 16 Aug 2018 18:51:15 +0900
Message-Id: <153441307534.6024.2684721209411781531.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153441301698.6024.1680500212551396320.stgit@devbox>
References: <153441301698.6024.1680500212551396320.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current trace-enable attribute in sysfs returns an error
if user writes the same setting value as current one,
e.g.

  # cat /sys/block/sda/trace/enable
  0
  # echo 0 > /sys/block/sda/trace/enable
  bash: echo: write error: Invalid argument
  # echo 1 > /sys/block/sda/trace/enable
  # echo 1 > /sys/block/sda/trace/enable
  bash: echo: write error: Device or resource busy

But this is not a preferred behavior, it should ignore
if new setting is same as current one. This fixes the
problem as below.

  # cat /sys/block/sda/trace/enable
  0
  # echo 0 > /sys/block/sda/trace/enable
  # echo 1 > /sys/block/sda/trace/enable
  # echo 1 > /sys/block/sda/trace/enable

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 kernel/trace/blktrace.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 987d9a9ae283..e67db1e8a000 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1602,11 +1602,11 @@ static int blk_trace_remove_queue(struct request_queue *q)
 	struct blk_trace *bt;
 
 	bt = xchg(&q->blk_trace, NULL);
-	if (bt == NULL)
-		return -EINVAL;
+	if (bt != NULL) {
+		put_probe_ref();
+		blk_trace_free(bt);
+	}
 
-	put_probe_ref();
-	blk_trace_free(bt);
 	return 0;
 }
 
@@ -1619,6 +1619,9 @@ static int blk_trace_setup_queue(struct request_queue *q,
 	struct blk_trace *bt = NULL;
 	int ret = -ENOMEM;
 
+	if (q->blk_trace)
+		return 0;
+
 	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
 	if (!bt)
 		return -ENOMEM;

