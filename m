Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3376DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E967D21473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E967D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeHPXJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbeHPXJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:09:07 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9258621473;
        Thu, 16 Aug 2018 20:08:38 +0000 (UTC)
Date:   Thu, 16 Aug 2018 16:08:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] tracing/blktrace: Fix to allow setting same value
Message-ID: <20180816160837.30cb63cf@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[
  Jens, you want to take this one, or do you want me to?
]

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Masami Hiramatsu reported:

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

Link: http://lkml.kernel.org/r/20180816103802.08678002@gandalf.local.home

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: cd649b8bb830d ("blktrace: remove sysfs_blk_trace_enable_show/store()")
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/blktrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index b82e546083e1..614b5f0decd6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1829,6 +1829,10 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	mutex_lock(&q->blk_trace_mutex);
 
 	if (attr == &dev_attr_enable) {
+		if (!!value == !!q->blk_trace) {
+			ret = 0;
+			goto out_unlock_bdev;
+		}
 		if (value)
 			ret = blk_trace_setup_queue(q, bdev);
 		else
-- 
2.13.6

