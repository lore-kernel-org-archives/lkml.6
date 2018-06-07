Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id guA9KAtFGVvjGgAAmS7hNA
	; Thu, 07 Jun 2018 14:46:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 09C0F6089E; Thu,  7 Jun 2018 14:46:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 84C02602FC;
	Thu,  7 Jun 2018 14:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84C02602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934986AbeFGOq2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:46:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40766 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934083AbeFGOqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:46:25 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbU-0005Zw-2y; Thu, 07 Jun 2018 15:09:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbB-0003BN-Ez; Thu, 07 Jun 2018 15:09:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Aaron Brown" <aaron.f.brown@intel.com>,
        "Benjamin Poirier" <bpoirier@suse.com>,
        "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>,
        "Sasha Neftin" <sasha.neftin@intel.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.143459743@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 321/410] e1000e: Fix check_for_link return value with
 autoneg off
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

From: Benjamin Poirier <bpoirier@suse.com>

commit 4e7dc08e57c95673d2edaba8983c3de4dd1f65f5 upstream.

When autoneg is off, the .check_for_link callback functions clear the
get_link_status flag and systematically return a "pseudo-error". This means
that the link is not detected as up until the next execution of the
e1000_watchdog_task() 2 seconds later.

Fixes: 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
 drivers/net/ethernet/intel/e1000e/mac.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1442,7 +1442,7 @@ static s32 e1000_check_for_copper_link_i
 	 * we have already determined whether we have link or not.
 	 */
 	if (!mac->autoneg)
-		return -E1000_ERR_CONFIG;
+		return 1;
 
 	/* Auto-Neg is enabled.  Auto Speed Detection takes care
 	 * of MAC speed/duplex configuration.  So we only need to
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -450,7 +450,7 @@ s32 e1000e_check_for_copper_link(struct
 	 * we have already determined whether we have link or not.
 	 */
 	if (!mac->autoneg)
-		return -E1000_ERR_CONFIG;
+		return 1;
 
 	/* Auto-Neg is enabled.  Auto Speed Detection takes care
 	 * of MAC speed/duplex configuration.  So we only need to
