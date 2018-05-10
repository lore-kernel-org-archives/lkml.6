Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934471AbeEJH3Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 03:29:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:49240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934314AbeEJH3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 03:29:15 -0400
From: Benjamin Poirier <bpoirier@suse.com>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Achim Mildenberger <admin@fph.physik.uni-karlsruhe.de>,
        olouvignes@gmail.com, jayanth@goubiq.com, ehabkost@redhat.com,
        postmodern.mod3@gmail.com, Bart.VanAssche@wdc.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] e1000e: Ignore TSYNCRXCTL when getting I219 clock attributes
Date: Thu, 10 May 2018 16:28:35 +0900
Message-Id: <20180510072835.5549-1-bpoirier@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <02874ECE860811409154E81DA85FBB5882D918F3@ORSMSX115.amr.corp.intel.com>
References: <02874ECE860811409154E81DA85FBB5882D918F3@ORSMSX115.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been multiple reports of crashes that look like
kernel: RIP: 0010:[<ffffffff8110303f>] timecounter_read+0xf/0x50
[...]
kernel: Call Trace:
kernel:  [<ffffffffa0806b0f>] e1000e_phc_gettime+0x2f/0x60 [e1000e]
kernel:  [<ffffffffa0806c5d>] e1000e_systim_overflow_work+0x1d/0x80 [e1000e]
kernel:  [<ffffffff810992c5>] process_one_work+0x155/0x440
kernel:  [<ffffffff81099e16>] worker_thread+0x116/0x4b0
kernel:  [<ffffffff8109f422>] kthread+0xd2/0xf0
kernel:  [<ffffffff8163184f>] ret_from_fork+0x3f/0x70

These can be traced back to the fact that e1000e_systim_reset() skips the
timecounter_init() call if e1000e_get_base_timinca() returns -EINVAL, which
leads to a null deref in timecounter_read().

Commit 83129b37ef35 ("e1000e: fix systim issues", v4.2-rc1) reworked
e1000e_get_base_timinca() in such a way that it can return -EINVAL for
e1000_pch_spt if the SYSCFI bit is not set in TSYNCRXCTL.

Some experimentation has shown that on I219 (e1000_pch_spt, "MAC: 12")
adapters, the E1000_TSYNCRXCTL_SYSCFI flag is unstable; TSYNCRXCTL reads
sometimes don't have the SYSCFI bit set. Retrying the read shortly after
finds the bit to be set. This was observed at boot (probe) but also link up
and link down.

Moreover, the phc (PTP Hardware Clock) seems to operate normally even after
reads where SYSCFI=0. Therefore, remove this register read and
unconditionally set the clock parameters.

Reported-by: Achim Mildenberger <admin@fph.physik.uni-karlsruhe.de>
Message-Id: <20180425065243.g5mqewg5irkwgwgv@f2>
Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1075876
Fixes: 83129b37ef35 ("e1000e: fix systim issues")
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index ec4a9759a6f2..3afb1f3b6f91 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3546,15 +3546,12 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
 		}
 		break;
 	case e1000_pch_spt:
-		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
-			/* Stable 24MHz frequency */
-			incperiod = INCPERIOD_24MHZ;
-			incvalue = INCVALUE_24MHZ;
-			shift = INCVALUE_SHIFT_24MHZ;
-			adapter->cc.shift = shift;
-			break;
-		}
-		return -EINVAL;
+		/* Stable 24MHz frequency */
+		incperiod = INCPERIOD_24MHZ;
+		incvalue = INCVALUE_24MHZ;
+		shift = INCVALUE_SHIFT_24MHZ;
+		adapter->cc.shift = shift;
+		break;
 	case e1000_pch_cnp:
 		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
 			/* Stable 24MHz frequency */
-- 
2.16.3
