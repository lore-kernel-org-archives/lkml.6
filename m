Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA60DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6388D214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6388D214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbeIUDFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:05:32 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:35140
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387962AbeIUDFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:05:31 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id 36Lng3H9Csezk36Lng9YoC; Thu, 20 Sep 2018 14:19:03 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1g36Ln-0003bA-An; Thu, 20 Sep 2018 14:19:03 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH V3 (resend) 5/7] CIFS: Add direct I/O functions to file_operations
Date:   Thu, 20 Sep 2018 21:18:42 +0000
Message-Id: <20180920211842.13721-5-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920211842.13721-1-longli@linuxonhyperv.com>
References: <20180920211842.13721-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfGMOz4yGZbejkNdOBmsS/ltZBtRrer5AJ729Fx5pMoC181e2l6DPb749qhfiEePFuLWWro89Sxvs4XZ5JgorV20lRokQcdiqbEPtqsLw8jvW/+O/om2w
 SotKTPWJLhUyqbhS9kapr5dSJ1+hsYW17TVGlHFYWFa9c1fOrj3Ih9INI5qawUSbx6rEmZ8V/EmolcmDlXNgQXyW3ckAQxu/7cTH3/9c0nXZNRb3lxUj9IPG
 nCzn28w1VYMwDOC4f1SFI7w+3D7lWWiMPblyMaD6iXEN3pPH5rd3wDfq8L2gYySX26GriPWasWW063xIuruIvV41z5udxqGHQn9bmtvwlPgFMTSo6e3U3kTi
 CdvyC6Yx5+2BEagW2uc68eBBDB7JGoks9FlRJL4RQ4Oxfr79PTGEQsLSLgFmHq8WaWjgCftf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

With direct read/write functions implemented, add them to file_operations.

Dircet I/O is used under two conditions:
1. When mounting with "cache=none", CIFS uses direct I/O for all user file
data transfer.
2. When opening a file with O_DIRECT, CIFS uses direct I/O for all data
transfer on this file.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifsfs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 7065426..3ba44f1 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1159,9 +1159,8 @@ const struct file_operations cifs_file_strict_ops = {
 };
 
 const struct file_operations cifs_file_direct_ops = {
-	/* BB reevaluate whether they can be done with directio, no cache */
-	.read_iter = cifs_user_readv,
-	.write_iter = cifs_user_writev,
+	.read_iter = cifs_direct_readv,
+	.write_iter = cifs_direct_writev,
 	.open = cifs_open,
 	.release = cifs_close,
 	.lock = cifs_lock,
@@ -1215,9 +1214,8 @@ const struct file_operations cifs_file_strict_nobrl_ops = {
 };
 
 const struct file_operations cifs_file_direct_nobrl_ops = {
-	/* BB reevaluate whether they can be done with directio, no cache */
-	.read_iter = cifs_user_readv,
-	.write_iter = cifs_user_writev,
+	.read_iter = cifs_direct_readv,
+	.write_iter = cifs_direct_writev,
 	.open = cifs_open,
 	.release = cifs_close,
 	.fsync = cifs_fsync,
-- 
2.7.4

