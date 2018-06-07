Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hK8sHLFBGVsjcgAAmS7hNA
	; Thu, 07 Jun 2018 14:31:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C8E0B608C8; Thu,  7 Jun 2018 14:31:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3E0C46063F;
	Thu,  7 Jun 2018 14:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E0C46063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933834AbeFGObt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:31:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40258 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933715AbeFGObp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:31:45 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbm-0005Zm-Ox; Thu, 07 Jun 2018 15:09:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb2-0002sQ-Vw; Thu, 07 Jun 2018 15:09:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "mulhern" <amulhern@redhat.com>,
        "Mike Snitzer" <snitzer@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.88765206@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 138/410] dm thin: fix documentation relative to low
 water mark threshold
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

From: mulhern <amulhern@redhat.com>

commit 9b28a1102efc75d81298198166ead87d643a29ce upstream.

Fixes:
1. The use of "exceeds" when the opposite of exceeds, falls below,
was meant.
2. Properly speaking, a table can not exceed a threshold.

It emphasizes the important point, which is that it is the userspace
daemon's responsibility to check for low free space when a device
is resumed, since it won't get a special event indicating low free
space in that situation.

Signed-off-by: mulhern <amulhern@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/device-mapper/thin-provisioning.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/Documentation/device-mapper/thin-provisioning.txt
+++ b/Documentation/device-mapper/thin-provisioning.txt
@@ -112,9 +112,11 @@ $low_water_mark is expressed in blocks o
 free space on the data device drops below this level then a dm event
 will be triggered which a userspace daemon should catch allowing it to
 extend the pool device.  Only one such event will be sent.
-Resuming a device with a new table itself triggers an event so the
-userspace daemon can use this to detect a situation where a new table
-already exceeds the threshold.
+
+No special event is triggered if a just resumed device's free space is below
+the low water mark. However, resuming a device always triggers an
+event; a userspace daemon should verify that free space exceeds the low
+water mark when handling this event.
 
 A low water mark for the metadata device is maintained in the kernel and
 will trigger a dm event if free space on the metadata device drops below
