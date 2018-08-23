Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4889FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C34520839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C34520839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbeHWMTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:19:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51462 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbeHWMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:19:31 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 48499BE0;
        Thu, 23 Aug 2018 08:50:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Chen <alexchen@synology.com>,
        Alex Wu <alexwu@synology.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        BingJing Chang <bingjingc@synology.com>,
        Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 140/324] md/raid10: fix that replacement cannot complete recovery after reassemble
Date:   Thu, 23 Aug 2018 09:53:26 +0200
Message-Id: <20180823075002.947261150@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3892,6 +3892,13 @@ static int raid10_run(struct mddev *mdde
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
 


