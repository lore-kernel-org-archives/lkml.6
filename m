Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB5DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F98921473
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F98921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeHWL1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:27:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeHWL1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:27:43 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E92B7ACC;
        Thu, 23 Aug 2018 07:59:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Chen <alexchen@synology.com>,
        Alex Wu <alexwu@synology.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        BingJing Chang <bingjingc@synology.com>,
        Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 33/79] md/raid10: fix that replacement cannot complete recovery after reassemble
Date:   Thu, 23 Aug 2018 09:53:09 +0200
Message-Id: <20180823074920.875469452@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: BingJing Chang <bingjingc@synology.com>

[ Upstream commit bda3153998f3eb2cafa4a6311971143628eacdbc ]

During assemble, the spare marked for replacement is not checked.
conf->fullsync cannot be updated to be 1. As a result, recovery will
treat it as a clean array. All recovering sectors are skipped. Original
device is replaced with the not-recovered spare.

mdadm -C /dev/md0 -l10 -n4 -pn2 /dev/loop[0123]
mdadm /dev/md0 -a /dev/loop4
mdadm /dev/md0 --replace /dev/loop0
mdadm -S /dev/md0 # stop array during recovery

mdadm -A /dev/md0 /dev/loop[01234]

After reassemble, you can see recovery go on, but it completes
immediately. In fact, recovery is not actually processed.

To solve this problem, we just add the missing logics for replacment
spares. (In raid1.c or raid5.c, they have already been checked.)

Reported-by: Alex Chen <alexchen@synology.com>
Reviewed-by: Alex Wu <alexwu@synology.com>
Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid10.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3691,6 +3691,13 @@ static int run(struct mddev *mddev)
 			    disk->rdev->saved_raid_disk < 0)
 				conf->fullsync = 1;
 		}
+
+		if (disk->replacement &&
+		    !test_bit(In_sync, &disk->replacement->flags) &&
+		    disk->replacement->saved_raid_disk < 0) {
+			conf->fullsync = 1;
+		}
+
 		disk->recovery_disabled = mddev->recovery_disabled - 1;
 	}
 


