Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E332C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AD721486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AD721486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbeIXSrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:47:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59708 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388526AbeIXSrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:47:03 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1E881109A;
        Mon, 24 Sep 2018 12:45:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 226/235] block/DAC960.c: fix defined but not used build warnings
Date:   Mon, 24 Sep 2018 13:53:32 +0200
Message-Id: <20180924113125.675980077@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 3993e501bf853cce85c5114a704b86b8f486790c ]

Fix build warnings in DAC960.c when CONFIG_PROC_FS is not enabled
by marking the unused functions as __maybe_unused.

../drivers/block/DAC960.c:6429:12: warning: 'dac960_proc_show' defined but not used [-Wunused-function]
../drivers/block/DAC960.c:6449:12: warning: 'dac960_initial_status_proc_show' defined but not used [-Wunused-function]
../drivers/block/DAC960.c:6456:12: warning: 'dac960_current_status_proc_show' defined but not used [-Wunused-function]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/DAC960.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -21,6 +21,7 @@
 #define DAC960_DriverDate			"21 Aug 2007"
 
 
+#include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
@@ -6426,7 +6427,7 @@ static bool DAC960_V2_ExecuteUserCommand
   return true;
 }
 
-static int dac960_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused dac960_proc_show(struct seq_file *m, void *v)
 {
   unsigned char *StatusMessage = "OK\n";
   int ControllerNumber;
@@ -6446,14 +6447,16 @@ static int dac960_proc_show(struct seq_f
   return 0;
 }
 
-static int dac960_initial_status_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused dac960_initial_status_proc_show(struct seq_file *m,
+							  void *v)
 {
 	DAC960_Controller_T *Controller = (DAC960_Controller_T *)m->private;
 	seq_printf(m, "%.*s", Controller->InitialStatusLength, Controller->CombinedStatusBuffer);
 	return 0;
 }
 
-static int dac960_current_status_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused dac960_current_status_proc_show(struct seq_file *m,
+							  void *v)
 {
   DAC960_Controller_T *Controller = (DAC960_Controller_T *) m->private;
   unsigned char *StatusMessage =


