Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A602EC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756DD206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756DD206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeI2C45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:56:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:20136 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbeI2C44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:56:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 13:31:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,316,1534834800"; 
   d="scan'208";a="87623395"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2018 13:31:27 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>, stable@vger.kernel.org
Subject: [char-misc] mei: replace POLL* with EPOLL* for write queues.
Date:   Fri, 28 Sep 2018 23:27:48 +0300
Message-Id: <20180928202748.11235-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like during merging the bulk POLL* -> EPOLL* replacement
missed the patch
'commit af336cabe083 ("mei: limit the number of queued writes")'

Fix sparse warning:
drivers/misc/mei/main.c:602:13: warning: restricted __poll_t degrades to integer
drivers/misc/mei/main.c:605:30: warning: invalid assignment: |=
drivers/misc/mei/main.c:605:30:    left side has type restricted __poll_t
drivers/misc/mei/main.c:605:30:    right side has type int

Cc: <stable@vger.kernel.org> #v4.17+
Fixes: 'commit af336cabe083 ("mei: limit the number of queued writes")'
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 4d77a6ae183a..87281b3695e6 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -599,10 +599,10 @@ static __poll_t mei_poll(struct file *file, poll_table *wait)
 			mei_cl_read_start(cl, mei_cl_mtu(cl), file);
 	}
 
-	if (req_events & (POLLOUT | POLLWRNORM)) {
+	if (req_events & (EPOLLOUT | EPOLLWRNORM)) {
 		poll_wait(file, &cl->tx_wait, wait);
 		if (cl->tx_cb_queued < dev->tx_queue_limit)
-			mask |= POLLOUT | POLLWRNORM;
+			mask |= EPOLLOUT | EPOLLWRNORM;
 	}
 
 out:
-- 
2.14.4

