Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F49C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E972083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E972083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbeIHCWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:22:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52714 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbeIHCWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:22:02 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 912A2D6B;
        Fri,  7 Sep 2018 21:39:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.9 30/63] tracing/blktrace: Fix to allow setting same value
Date:   Fri,  7 Sep 2018 23:10:01 +0200
Message-Id: <20180907211014.655232544@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907211012.965501324@linuxfoundation.org>
References: <20180907211012.965501324@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 757d9140072054528b13bbe291583d9823cde195 upstream.

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
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/blktrace.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1720,6 +1720,10 @@ static ssize_t sysfs_blk_trace_attr_stor
 	mutex_lock(&bdev->bd_mutex);
 
 	if (attr == &dev_attr_enable) {
+		if (!!value == !!q->blk_trace) {
+			ret = 0;
+			goto out_unlock_bdev;
+		}
 		if (value)
 			ret = blk_trace_setup_queue(q, bdev);
 		else


