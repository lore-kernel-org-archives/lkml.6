Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032948AbeE1KTl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032809AbeE1KTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:19:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Poirier <bpoirier@suse.com>,
        Sasha Neftin <sasha.neftin@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 124/268] e1000e: Fix check_for_link return value with autoneg off
Date: Mon, 28 May 2018 12:01:38 +0200
Message-Id: <20180528100216.139207275@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Poirier <bpoirier@suse.com>

[ Upstream commit 4e7dc08e57c95673d2edaba8983c3de4dd1f65f5 ]

When autoneg is off, the .check_for_link callback functions clear the
get_link_status flag and systematically return a "pseudo-error". This means
that the link is not detected as up until the next execution of the
e1000_watchdog_task() 2 seconds later.

Fixes: 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c |    2 +-
 drivers/net/ethernet/intel/e1000e/mac.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1574,7 +1574,7 @@ static s32 e1000_check_for_copper_link_i
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
