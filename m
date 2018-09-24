Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FEBC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7DC2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7DC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbeIXRkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:40:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50484 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbeIXRkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:40:12 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CBC1A8D4;
        Mon, 24 Sep 2018 11:38:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Chen <alexchen@synology.com>,
        Alex Wu <alexwu@synology.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        BingJing Chang <bingjingc@synology.com>,
        Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 041/105] md/raid5: fix data corruption of replacements after originals dropped
Date:   Mon, 24 Sep 2018 13:33:27 +0200
Message-Id: <20180924113118.180103471@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: BingJing Chang <bingjingc@synology.com>

[ Upstream commit d63e2fc804c46e50eee825c5d3a7228e07048b47 ]

During raid5 replacement, the stripes can be marked with R5_NeedReplace
flag. Data can be read from being-replaced devices and written to
replacing spares without reading all other devices. (It's 'replace'
mode. s.replacing = 1) If a being-replaced device is dropped, the
replacement progress will be interrupted and resumed with pure recovery
mode. However, existing stripes before being interrupted cannot read
from the dropped device anymore. It prints lots of WARN_ON messages.
And it results in data corruption because existing stripes write
problematic data into its replacement device and update the progress.

\# Erase disks (1MB + 2GB)
dd if=/dev/zero of=/dev/sda bs=1MB count=2049
dd if=/dev/zero of=/dev/sdb bs=1MB count=2049
dd if=/dev/zero of=/dev/sdc bs=1MB count=2049
dd if=/dev/zero of=/dev/sdd bs=1MB count=2049
mdadm -C /dev/md0 -amd -R -l5 -n3 -x0 /dev/sd[abc] -z 2097152
\# Ensure array stores non-zero data
dd if=/root/data_4GB.iso of=/dev/md0 bs=1MB
\# Start replacement
mdadm /dev/md0 -a /dev/sdd
mdadm /dev/md0 --replace /dev/sda

Then, Hot-plug out /dev/sda during recovery, and wait for recovery done.
echo check > /sys/block/md0/md/sync_action
cat /sys/block/md0/md/mismatch_cnt # it will be greater than 0.

Soon after you hot-plug out /dev/sda, you will see many WARN_ON
messages. The replacement recovery will be interrupted shortly. After
the recovery finishes, it will result in data corruption.

Actually, it's just an unhandled case of replacement. In commit
<f94c0b6658c7> (md/raid5: fix interaction of 'replace' and 'recovery'.),
if a NeedReplace device is not UPTODATE then that is an error, the
commit just simply print WARN_ON but also mark these corrupted stripes
with R5_WantReplace. (it means it's ready for writes.)

To fix this case, we can leverage 'sync and replace' mode mentioned in
commit <9a3e1101b827> (md/raid5: detect and handle replacements during
recovery.). We can add logics to detect and use 'sync and replace' mode
for these stripes.

Reported-by: Alex Chen <alexchen@synology.com>
Reviewed-by: Alex Wu <alexwu@synology.com>
Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid5.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3703,6 +3703,12 @@ static void analyse_stripe(struct stripe
 			s->failed++;
 			if (rdev && !test_bit(Faulty, &rdev->flags))
 				do_recovery = 1;
+			else if (!rdev) {
+				rdev = rcu_dereference(
+				    conf->disks[i].replacement);
+				if (rdev && !test_bit(Faulty, &rdev->flags))
+					do_recovery = 1;
+			}
 		}
 	}
 	if (test_bit(STRIPE_SYNCING, &sh->state)) {


