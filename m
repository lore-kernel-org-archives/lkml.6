Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC878C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A638D2148C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSJD3wXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A638D2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbeJEXRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbeJEXRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:17:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E63D214C2;
        Fri,  5 Oct 2018 16:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756266;
        bh=iKM8Lfwa36zh34JFtuFxA0oCCIm9RNlutvR4ZAFfsAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSJD3wXLelt3Kf/PYxdIppd7cQR4KAIskLWYNLYVU5UC2h7l2Z4QzAPzQim/mpgHR
         B2PXsQNzAp9C7w+EJovOP8Srxk0tL+2Krpia8I6e7O+H7cbTWJPeKOHgpY2CYta1kc
         TIsZnRPeb4a1wX5r1tF9H4FhClxc/OApqDRR1rrU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 09/11] floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl
Date:   Fri,  5 Oct 2018 12:17:34 -0400
Message-Id: <20181005161736.20765-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161736.20765-1-sashal@kernel.org>
References: <20181005161736.20765-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Whitcroft <apw@canonical.com>

[ Upstream commit 65eea8edc315589d6c993cf12dbb5d0e9ef1fe4e ]

The final field of a floppy_struct is the field "name", which is a pointer
to a string in kernel memory.  The kernel pointer should not be copied to
user memory.  The FDGETPRM ioctl copies a floppy_struct to user memory,
including this "name" field.  This pointer cannot be used by the user
and it will leak a kernel address to user-space, which will reveal the
location of kernel code and data and undermine KASLR protection.

Model this code after the compat ioctl which copies the returned data
to a previously cleared temporary structure on the stack (excluding the
name pointer) and copy out to userspace from there.  As we already have
an inparam union with an appropriate member and that memory is already
cleared even for read only calls make use of that as a temporary store.

Based on an initial patch by Brian Belleville.

CVE-2018-7755
Signed-off-by: Andy Whitcroft <apw@canonical.com>

Broke up long line.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/block/floppy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 331363e7de0f..2daa5b84abbc 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3459,6 +3459,9 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 					  (struct floppy_struct **)&outparam);
 		if (ret)
 			return ret;
+		memcpy(&inparam.g, outparam,
+				offsetof(struct floppy_struct, name));
+		outparam = &inparam.g;
 		break;
 	case FDMSGON:
 		UDP->flags |= FTD_MSG;
-- 
2.17.1

