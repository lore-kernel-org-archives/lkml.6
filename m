Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494FCC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D2B20855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D2B20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeIHG7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:59:34 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:47266
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727217AbeIHG7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:59:33 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ySlqfRM9nWFPMySlqffd3l; Fri, 07 Sep 2018 19:14:46 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1fySlq-0005Ey-42; Fri, 07 Sep 2018 19:14:46 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 16/16] CIFS: Add direct I/O functions to file_operations
Date:   Sat,  8 Sep 2018 02:13:48 +0000
Message-Id: <20180908021348.19956-17-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908021348.19956-1-longli@linuxonhyperv.com>
References: <20180908021348.19956-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfO9i9NkqDAVnk9AUXf8aXYuIqSKVyxyuBE8JZPQj4tPiLTTpFL0EeIglNOuq0Epr7ZXKD8Ew/BqZkyvE4DdhGMk6nTAMk6eNQobESPKDhODEZU2+XhPd
 D8bgll7gtGYWqVSxIxsgCCu/vIukb/YbL9MjWg8+p3whwrHOvcGkKASbPo3lU6O3yf/9LZQMuScHGLpjm25KiTis1o/MZyoWhYnda/xJsrUP7mMlyFSsEFuy
 038sBdZ7CS7Qf7f1tc1XDKcqEugl7jPIHWNPiJ9VF6jyCel5htdYLGg4DaUdHA0kqj0fWfJlmLDuccvqVV3ub7D7B+zQP6eh9LBqE+JHra/7+cHNUUZ4Bwjx
 OPZp9xEmGLOF9q2qEP+pLNXUFKeTGUOGaWUsx7IRht0ydG+358plbRe2Ozgsy18Txb1KLhQc
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
index 62f1662..f18091b 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1113,9 +1113,8 @@ const struct file_operations cifs_file_strict_ops = {
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
@@ -1169,9 +1168,8 @@ const struct file_operations cifs_file_strict_nobrl_ops = {
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

