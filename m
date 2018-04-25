Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZqWyfgi4HxRgOT1LaWHSGAOjyHlM3aQEGUMe3P3fPTqTW/HyrdPXInFtcFRRzSxiha0Gd7E
ARC-Seal: i=1; a=rsa-sha256; t=1524652810; cv=none;
        d=google.com; s=arc-20160816;
        b=kfrTQG3HOKd0xHW22+vy9bm4dWM9kU9wHFz1x8yydb94jH2NOnr5oNhMGet/UA5NGx
         7q1dWwbUb4G34JXCLjM2zxgd//ygL6aYzXy911Y/ZnCfPeydpM3ypeToeum8/xwSavAS
         f1x9GbRrN35CMIKss6jALD+pVu1rd1dJDkZ3rzlVt0B7sZEJOliQ8JWThq28Oh7t2aSi
         FVjAnhONJKDkCC7dm5vJmNAnXtm0uYKCGB7ypLvRV9qTkdqnml6PmVq1BgVi5+1Qm4S6
         Qvx0mk6LhKm1JVOpEyT3em9/DOPtoTW7PWDBw5/3H+zOjAw+2AUa9+qC8VElyS37yRrm
         L4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8HX0zdOj7dRkCPjRs7jD1pKO71rqGqXekddRIUEdJus=;
        b=uTVA+cOfNrMuiTf01REh8utl4sQyuAlRewKIhNa687IpAQnivkE/Q7gSGtPmSuzdJX
         /NMDaIqXU0B6PnPX7oRuXSYmkqfmkuG25uIf8ADKAuZOtGWNBtuocbyFZ1JkbgI0CKpF
         iE1q0tis70lAgCpZKvRwM4zEjyV0DNqdDxxbOxPTSc/Sb93mvIMTDcKhRUAPjDC2mK+o
         zZu/0r2d18e3r6Bj++Ccw7uXvKSDuaqTS8AxE5zeAEV0NzHMSMBiGl3Ok9DQmXRDpZFt
         S0tAqScjXAlegFeGdmkf431oKqI8xZMAL2J/L2iXBBwibk07o19xRzxz+Ru1/K3qQrYI
         yOoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Avinash Dayanand <avinash.dayanand@intel.com>,
	Andrew Bowers <andrewx.bowers@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 078/183] i40evf: Dont schedule reset_task when device is being removed
Date: Wed, 25 Apr 2018 12:34:58 +0200
Message-Id: <20180425103245.641107824@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714346219075023?=
X-GMAIL-MSGID: =?utf-8?q?1598714346219075023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Avinash Dayanand <avinash.dayanand@intel.com>


[ Upstream commit 06aa040f039404a0039a5158cd12f41187487a1f ]

When a host disables and enables a PF device, all the associated
VFs are removed and added back in. It also generates a PFR which in turn
resets all the connected VFs. This behaviour is different from that of
Linux guest on Linux host. Hence we end up in a situation where there's
a PFR and device removal at the same time. And watchdog doesn't have a
clue about this and schedules a reset_task. This patch adds code to send
signal to reset_task that the device is currently being removed.

Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40evf/i40evf.h      |    1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -186,6 +186,7 @@ enum i40evf_state_t {
 enum i40evf_critical_section_t {
 	__I40EVF_IN_CRITICAL_TASK,	/* cannot be interrupted */
 	__I40EVF_IN_CLIENT_TASK,
+	__I40EVF_IN_REMOVE_TASK,	/* device being removed */
 };
 
 /* board specific private data structure */
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1839,6 +1839,12 @@ static void i40evf_reset_task(struct wor
 	int i = 0, err;
 	bool running;
 
+	/* When device is being removed it doesn't make sense to run the reset
+	 * task, just return in such a case.
+	 */
+	if (test_bit(__I40EVF_IN_REMOVE_TASK, &adapter->crit_section))
+		return;
+
 	while (test_and_set_bit(__I40EVF_IN_CLIENT_TASK,
 				&adapter->crit_section))
 		usleep_range(500, 1000);
@@ -3022,7 +3028,8 @@ static void i40evf_remove(struct pci_dev
 	struct i40evf_mac_filter *f, *ftmp;
 	struct i40e_hw *hw = &adapter->hw;
 	int err;
-
+	/* Indicate we are in remove and not to run reset_task */
+	set_bit(__I40EVF_IN_REMOVE_TASK, &adapter->crit_section);
 	cancel_delayed_work_sync(&adapter->init_task);
 	cancel_work_sync(&adapter->reset_task);
 	cancel_delayed_work_sync(&adapter->client_task);
