Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id WgqLK1dBGVuRawAAmS7hNA
	; Thu, 07 Jun 2018 14:29:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 081DC60909; Thu,  7 Jun 2018 14:29:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1CFCF607DC;
	Thu,  7 Jun 2018 14:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CFCF607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933731AbeFGO33 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:29:29 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40222 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933697AbeFGO30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:29:26 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbY-0005hO-RF; Thu, 07 Jun 2018 15:09:32 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-00036V-88; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Shaohua Li" <sh.li@alibaba-inc.com>,
        stable@decadent.org.uk, "NeilBrown" <neilb@suse.com>,
        "Yufen Yu" <yuyufen@huawei.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.638891120@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 272/410] md raid10: fix NULL deference in
 handle_write_completed()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yufen Yu <yuyufen@huawei.com>

commit 01a69cab01c184d3786af09e9339311123d63d22 upstream.

In the case of 'recover', an r10bio with R10BIO_WriteError &
R10BIO_IsRecover will be progressed by handle_write_completed().
This function traverses all r10bio->devs[copies].
If devs[m].repl_bio != NULL, it thinks conf->mirrors[dev].replacement
is also not NULL. However, this is not always true.

When there is an rdev of raid10 has replacement, then each r10bio
->devs[m].repl_bio != NULL in conf->r10buf_pool. However, in 'recover',
even if corresponded replacement is NULL, it doesn't clear r10bio
->devs[m].repl_bio, resulting in replacement NULL deference.

This bug was introduced when replacement support for raid10 was
added in Linux 3.3.

As NeilBrown suggested:
	Elsewhere the determination of "is this device part of the
	resync/recovery" is made by resting bio->bi_end_io.
	If this is end_sync_write, then we tried to write here.
	If it is NULL, then we didn't try to write.

Fixes: 9ad1aefc8ae8 ("md/raid10:  Handle replacement devices during resync.")
Cc: stable (V3.3+)
Suggested-by: NeilBrown <neilb@suse.com>
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Shaohua Li <sh.li@alibaba-inc.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/raid10.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2746,7 +2746,8 @@ static void handle_write_completed(struc
 		for (m = 0; m < conf->copies; m++) {
 			int dev = r10_bio->devs[m].devnum;
 			rdev = conf->mirrors[dev].rdev;
-			if (r10_bio->devs[m].bio == NULL)
+			if (r10_bio->devs[m].bio == NULL ||
+				r10_bio->devs[m].bio->bi_end_io == NULL)
 				continue;
 			if (test_bit(BIO_UPTODATE,
 				     &r10_bio->devs[m].bio->bi_flags)) {
@@ -2762,7 +2763,8 @@ static void handle_write_completed(struc
 					md_error(conf->mddev, rdev);
 			}
 			rdev = conf->mirrors[dev].replacement;
-			if (r10_bio->devs[m].repl_bio == NULL)
+			if (r10_bio->devs[m].repl_bio == NULL ||
+				r10_bio->devs[m].repl_bio->bi_end_io == NULL)
 				continue;
 			if (test_bit(BIO_UPTODATE,
 				     &r10_bio->devs[m].repl_bio->bi_flags)) {
