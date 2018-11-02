Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC61C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEBC20848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8MG5K6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEBC20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbeKCD6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730851AbeKCD6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:58:53 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A77102082D;
        Fri,  2 Nov 2018 18:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184638;
        bh=+ZKNUCFXSuCzkfNrkVUR7mijOe2zT+1K8u7VY+O6pfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D8MG5K6bcLnP+KLuozxJucI5LXZFpx9x5SMJ6iyFReMRQlpdVod3meWctLif9QvTB
         hTgLNEbXzangejNe4FPfo6Ufj4lP4qXbAtmoEuuvORyrvMdQP7A5Y6j5UTtHmGnKTt
         HlM8YIS4VmWrzEJlpdVD85+QinFcDIeVZzW7yD/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Arnd Bergmann <arnd@arndb.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 056/143] scsi: aacraid: address UBSAN warning regression
Date:   Fri,  2 Nov 2018 19:34:01 +0100
Message-Id: <20181102182901.543973107@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



