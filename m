Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EFDC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679BC2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMm56oO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679BC2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeJYWoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbeJYWoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:00 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A20262054F;
        Thu, 25 Oct 2018 14:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476665;
        bh=74ySAQMBThih2FK3Rot/66i2+Wp8eF2sA/P/6jvoxGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMm56oO5DC881ZtyzHcwUkwY+UgZoTLyWJ9E6pPUJh9x+PUJt7LZjY9e/mZ3R0ybh
         50+B/Iw9Pvw8/yNYwYebgFFSr62Kh7QHp4PmSLE13zKWLIpaHBTfUdluEg9mchp3hz
         n8st+rZxFsyGEUQHXWnRS1FWJkSn6t3OYXlIqkjs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 07/46] scsi: aacraid: address UBSAN warning regression
Date:   Thu, 25 Oct 2018 10:10:14 -0400
Message-Id: <20181025141053.213330-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit d18539754d97876503275efc7d00a1901bb0cfad ]

As reported by Meelis Roos, my previous patch causes an incorrect
calculation of the timeout, through an undefined signed integer
overflow:

[   12.228155] UBSAN: Undefined behaviour in drivers/scsi/aacraid/commsup.c:2514:49
[   12.228229] signed integer overflow:
[   12.228283] 964297611 * 250 cannot be represented in type 'long int'

The problem is that doing a multiplication with HZ first and then
dividing by USEC_PER_SEC worked correctly for 32-bit microseconds,
but not for 32-bit nanoseconds, which would require up to 41 bits.

This reworks the calculation to first convert the nanoseconds into
jiffies, which should give us the same result as before and not overflow.

Unfortunately I did not understand the exact intention of the algorithm,
in particular the part where we add half a second, so it's possible that
there is still a preexisting problem in this function. I added a comment
that this would be handled more nicely using usleep_range(), which
generally works better for waking up at a particular time than the
current schedule_timeout() based implementation. I did not feel
comfortable trying to implement that without being sure what the
intent is here though.

Fixes: 820f18865912 ("scsi: aacraid: use timespec64 instead of timeval")
Tested-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/aacraid/commsup.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 998788a967be..3e38bae6ecde 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -2506,8 +2506,8 @@ int aac_command_thread(void *data)
 			/* Synchronize our watches */
 			if (((NSEC_PER_SEC - (NSEC_PER_SEC / HZ)) > now.tv_nsec)
 			 && (now.tv_nsec > (NSEC_PER_SEC / HZ)))
-				difference = (((NSEC_PER_SEC - now.tv_nsec) * HZ)
-				  + NSEC_PER_SEC / 2) / NSEC_PER_SEC;
+				difference = HZ + HZ / 2 -
+					     now.tv_nsec / (NSEC_PER_SEC / HZ);
 			else {
 				if (now.tv_nsec > NSEC_PER_SEC / 2)
 					++now.tv_sec;
@@ -2531,6 +2531,10 @@ int aac_command_thread(void *data)
 		if (kthread_should_stop())
 			break;
 
+		/*
+		 * we probably want usleep_range() here instead of the
+		 * jiffies computation
+		 */
 		schedule_timeout(difference);
 
 		if (kthread_should_stop())
-- 
2.17.1

