Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E65C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44546214C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44546214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeHUMcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 08:32:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37646 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbeHUMcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 08:32:11 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fs2iX-000809-64; Tue, 21 Aug 2018 09:12:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block/DAC960.c: make some arrays static const, shrinks object size
Date:   Tue, 21 Aug 2018 10:12:48 +0100
Message-Id: <20180821091248.8669-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the arrays ReadCacheStatus, WriteCacheStatus and
SenseErrors on the stack but instead make them static const. Makes
the object code smaller by 47 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
 160974	  34628	    832	 196434	  2ff52	drivers/block/DAC960.o

After:
   text	   data	    bss	    dec	    hex	filename
 160671	  34884	    832	 196387	  2ff23	drivers/block/DAC960.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/DAC960.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index f99e5c883368..581312ac375f 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -2428,16 +2428,20 @@ static bool DAC960_V2_ReportDeviceConfiguration(DAC960_Controller_T
     {
       DAC960_V2_LogicalDeviceInfo_T *LogicalDeviceInfo =
 	Controller->V2.LogicalDeviceInformation[LogicalDriveNumber];
-      unsigned char *ReadCacheStatus[] = { "Read Cache Disabled",
-					   "Read Cache Enabled",
-					   "Read Ahead Enabled",
-					   "Intelligent Read Ahead Enabled",
-					   "-", "-", "-", "-" };
-      unsigned char *WriteCacheStatus[] = { "Write Cache Disabled",
-					    "Logical Device Read Only",
-					    "Write Cache Enabled",
-					    "Intelligent Write Cache Enabled",
-					    "-", "-", "-", "-" };
+      static const unsigned char *ReadCacheStatus[] = {
+        "Read Cache Disabled",
+        "Read Cache Enabled",
+        "Read Ahead Enabled",
+        "Intelligent Read Ahead Enabled",
+        "-", "-", "-", "-"
+      };
+      static const unsigned char *WriteCacheStatus[] = {
+        "Write Cache Disabled",
+        "Logical Device Read Only",
+        "Write Cache Enabled",
+        "Intelligent Write Cache Enabled",
+        "-", "-", "-", "-"
+      };
       unsigned char *GeometryTranslation;
       if (LogicalDeviceInfo == NULL) continue;
       switch (LogicalDeviceInfo->DriveGeometry)
@@ -4339,14 +4343,16 @@ static void DAC960_V1_ProcessCompletedCommand(DAC960_Command_T *Command)
 static void DAC960_V2_ReadWriteError(DAC960_Command_T *Command)
 {
   DAC960_Controller_T *Controller = Command->Controller;
-  unsigned char *SenseErrors[] = { "NO SENSE", "RECOVERED ERROR",
-				   "NOT READY", "MEDIUM ERROR",
-				   "HARDWARE ERROR", "ILLEGAL REQUEST",
-				   "UNIT ATTENTION", "DATA PROTECT",
-				   "BLANK CHECK", "VENDOR-SPECIFIC",
-				   "COPY ABORTED", "ABORTED COMMAND",
-				   "EQUAL", "VOLUME OVERFLOW",
-				   "MISCOMPARE", "RESERVED" };
+  static const unsigned char *SenseErrors[] = {
+    "NO SENSE", "RECOVERED ERROR",
+    "NOT READY", "MEDIUM ERROR",
+    "HARDWARE ERROR", "ILLEGAL REQUEST",
+    "UNIT ATTENTION", "DATA PROTECT",
+    "BLANK CHECK", "VENDOR-SPECIFIC",
+    "COPY ABORTED", "ABORTED COMMAND",
+    "EQUAL", "VOLUME OVERFLOW",
+    "MISCOMPARE", "RESERVED"
+  };
   unsigned char *CommandName = "UNKNOWN";
   switch (Command->CommandType)
     {
-- 
2.17.1

