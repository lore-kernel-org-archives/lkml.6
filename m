Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804A3C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF63218AD
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976892;
	bh=67Ds67dngB+PcmeqRU8HmhknFjixjsSjlly1wVfr97Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aXNnr9rjVP4WNyk2+INyGvaS/5A+BfXS/ZjErV6nwgGcohmnLb5p/usT06dIuwCKg
	 FvnpwDD5ViH4eUN3X8CpqNNkWooOM63rzDW0wjivsPZhdo5CcvGf1ZHXAqOjIM1qpo
	 8Ehq/8Unz5caNjrAYtVmL6xsiDqKT7YbunV2RSic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbfAHTsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:48:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731364AbfAHTc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:32:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 565B720827;
        Tue,  8 Jan 2019 19:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975946;
        bh=67Ds67dngB+PcmeqRU8HmhknFjixjsSjlly1wVfr97Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixswbsau7J2jiPUngPoemsznQeSgmD6Mf93OgG9+/EsI+hsPxL2+Sxq6ub8CFdhCu
         ihb4JoQkTdHOINcSnPueVfZ1GOmkOBLswWzJ4Ek4/I+uuwu0j7FxXiY1Yw3TEpgFsi
         6EMg5JKODMDmY3cxnC5aYhokdmNwnMf35RoJId0E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 03/53] e1000e: allow non-monotonic SYSTIM readings
Date:   Tue,  8 Jan 2019 14:31:31 -0500
Message-Id: <20190108193222.123316-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miroslav Lichvar <mlichvar@redhat.com>

[ Upstream commit e1f65b0d70e9e5c80e15105cd96fa00174d7c436 ]

It seems with some NICs supported by the e1000e driver a SYSTIM reading
may occasionally be few microseconds before the previous reading and if
enabled also pass e1000e_sanitize_systim() without reaching the maximum
number of rereads, even if the function is modified to check three
consecutive readings (i.e. it doesn't look like a double read error).
This causes an underflow in the timecounter and the PHC time jumps hours
ahead.

This was observed on 82574, I217 and I219. The fastest way to reproduce
it is to run a program that continuously calls the PTP_SYS_OFFSET ioctl
on the PHC.

Modify e1000e_phc_gettime() to use timecounter_cyc2time() instead of
timecounter_read() in order to allow non-monotonic SYSTIM readings and
prevent the PHC from jumping.

Cc: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/e1000e/ptp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index b366885487a8..cd16b70a4e70 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -191,10 +191,14 @@ static int e1000e_phc_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 	struct e1000_adapter *adapter = container_of(ptp, struct e1000_adapter,
 						     ptp_clock_info);
 	unsigned long flags;
-	u64 ns;
+	u64 cycles, ns;
 
 	spin_lock_irqsave(&adapter->systim_lock, flags);
-	ns = timecounter_read(&adapter->tc);
+
+	/* Use timecounter_cyc2time() to allow non-monotonic SYSTIM readings */
+	cycles = adapter->cc.read(&adapter->cc);
+	ns = timecounter_cyc2time(&adapter->tc, cycles);
+
 	spin_unlock_irqrestore(&adapter->systim_lock, flags);
 
 	*ts = ns_to_timespec64(ns);
@@ -250,9 +254,12 @@ static void e1000e_systim_overflow_work(struct work_struct *work)
 						     systim_overflow_work.work);
 	struct e1000_hw *hw = &adapter->hw;
 	struct timespec64 ts;
+	u64 ns;
 
-	adapter->ptp_clock_info.gettime64(&adapter->ptp_clock_info, &ts);
+	/* Update the timecounter */
+	ns = timecounter_read(&adapter->tc);
 
+	ts = ns_to_timespec64(ns);
 	e_dbg("SYSTIM overflow check at %lld.%09lu\n",
 	      (long long) ts.tv_sec, ts.tv_nsec);
 
-- 
2.19.1

