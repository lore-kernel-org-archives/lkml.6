Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424004AbeE1LLG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423968AbeE1LLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:11:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 119/272] i40e: hold the RTNL lock while changing interrupt schemes
Date: Mon, 28 May 2018 12:02:32 +0200
Message-Id: <20180528100251.155863020@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit f0ee70a042e267a517e943220e18ae62d3c1995a ]

When we suspend and resume, we need to clear and re-enable the interrupt
scheme. This was previously not done while holding the RTNL lock, which
could be problematic, because we are actually destroying and re-creating
queues.

Hold the RTNL lock for the entire sequence of preparing for reset, and
when resuming. This additionally protects the flags related to interrupt
scheme under RTNL lock so that their modification is properly threaded.

This is part of a larger effort to remove the need for cmpxchg64 in
i40e_set_priv_flags().

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14216,7 +14216,13 @@ static int __maybe_unused i40e_suspend(s
 	if (pf->wol_en && (pf->hw_features & I40E_HW_WOL_MC_MAGIC_PKT_WAKE))
 		i40e_enable_mc_magic_wake(pf);
 
-	i40e_prep_for_reset(pf, false);
+	/* Since we're going to destroy queues during the
+	 * i40e_clear_interrupt_scheme() we should hold the RTNL lock for this
+	 * whole section
+	 */
+	rtnl_lock();
+
+	i40e_prep_for_reset(pf, true);
 
 	wr32(hw, I40E_PFPM_APM, (pf->wol_en ? I40E_PFPM_APM_APME_MASK : 0));
 	wr32(hw, I40E_PFPM_WUFC, (pf->wol_en ? I40E_PFPM_WUFC_MAG_MASK : 0));
@@ -14228,6 +14234,8 @@ static int __maybe_unused i40e_suspend(s
 	 */
 	i40e_clear_interrupt_scheme(pf);
 
+	rtnl_unlock();
+
 	return 0;
 }
 
@@ -14245,6 +14253,11 @@ static int __maybe_unused i40e_resume(st
 	if (!test_bit(__I40E_SUSPENDED, pf->state))
 		return 0;
 
+	/* We need to hold the RTNL lock prior to restoring interrupt schemes,
+	 * since we're going to be restoring queues
+	 */
+	rtnl_lock();
+
 	/* We cleared the interrupt scheme when we suspended, so we need to
 	 * restore it now to resume device functionality.
 	 */
@@ -14255,7 +14268,9 @@ static int __maybe_unused i40e_resume(st
 	}
 
 	clear_bit(__I40E_DOWN, pf->state);
-	i40e_reset_and_rebuild(pf, false, false);
+	i40e_reset_and_rebuild(pf, false, true);
+
+	rtnl_unlock();
 
 	/* Clear suspended state last after everything is recovered */
 	clear_bit(__I40E_SUSPENDED, pf->state);
