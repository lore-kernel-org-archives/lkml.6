Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69323C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A51C2244D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A51C2244D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933442AbeGCHXL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:23:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45491 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932604AbeGCHXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:23:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1faFeU-0000Vy-DA; Tue, 03 Jul 2018 07:23:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     Cliff Whickman <cpw@sgi.com>, Robin Holt <robinmholt@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sgi-xp: remove redundant pointers ch and rp
Date:   Tue,  3 Jul 2018 08:23:05 +0100
Message-Id: <20180703072305.29169-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointers ch and rp are set but are never used hence they are
redundant and can be removed.

Cleans up clang warnings:
warning: variable 'ch' set but not used [-Wunused-but-set-variable]
warning: variable 'rp' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/sgi-xp/xpc_channel.c   | 3 ---
 drivers/misc/sgi-xp/xpc_partition.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/misc/sgi-xp/xpc_channel.c b/drivers/misc/sgi-xp/xpc_channel.c
index 128d5615c804..05a890ce2ab8 100644
--- a/drivers/misc/sgi-xp/xpc_channel.c
+++ b/drivers/misc/sgi-xp/xpc_channel.c
@@ -656,7 +656,6 @@ xpc_initiate_connect(int ch_number)
 {
 	short partid;
 	struct xpc_partition *part;
-	struct xpc_channel *ch;
 
 	DBUG_ON(ch_number < 0 || ch_number >= XPC_MAX_NCHANNELS);
 
@@ -664,8 +663,6 @@ xpc_initiate_connect(int ch_number)
 		part = &xpc_partitions[partid];
 
 		if (xpc_part_ref(part)) {
-			ch = &part->channels[ch_number];
-
 			/*
 			 * Initiate the establishment of a connection on the
 			 * newly registered channel to the remote partition.
diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_partition.c
index 7284413dabfd..4e59b01ad7eb 100644
--- a/drivers/misc/sgi-xp/xpc_partition.c
+++ b/drivers/misc/sgi-xp/xpc_partition.c
@@ -415,7 +415,6 @@ xpc_discovery(void)
 	int region_size;
 	int max_regions;
 	int nasid;
-	struct xpc_rsvd_page *rp;
 	unsigned long *discovered_nasids;
 	enum xp_retval ret;
 
@@ -432,8 +431,6 @@ xpc_discovery(void)
 		return;
 	}
 
-	rp = (struct xpc_rsvd_page *)xpc_rsvd_page;
-
 	/*
 	 * The term 'region' in this context refers to the minimum number of
 	 * nodes that can comprise an access protection grouping. The access
-- 
2.17.1

