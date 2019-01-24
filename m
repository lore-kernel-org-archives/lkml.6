Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1213C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BBF218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360647;
	bh=qThyLbD2bzQPrlpLeUl8efdRqHdOHbRBEWVKTv60b10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yj0EOTibx9wS3L/NwnJifWFOnK9MxUJbLJNIXj4k42+gj+XjSPFuuHFUux1o76AMn
	 KRF6E1f8M9dkKIM2hFBfZL6yzYI0ES1fYz9wdfYlzvG+gpxOc/OYtQSIHqwHhijwI4
	 QZkCQl0si7e3+X7hTy2kme5l9X83SXvDv7EfsNic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfAXUKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:10:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730154AbfAXT1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:27:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD2A721902;
        Thu, 24 Jan 2019 19:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358050;
        bh=qThyLbD2bzQPrlpLeUl8efdRqHdOHbRBEWVKTv60b10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7inPv9OENayyomRLKH4HWv+7nhFag5WzlnPZUUM4bqw9cmInDsgrmP1YBuX/2fGF
         REliLfENlmZWfcAv5VkX1qegMk7O4EO9e6K09jnx5mPGyVvU1UKdz7WPARUHBNM+cL
         OvAbU4XT0Y2uwfJdARmTBx+3FsnVBleHlYohWKJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 078/104] e1000e: allow non-monotonic SYSTIM readings
Date:   Thu, 24 Jan 2019 20:20:07 +0100
Message-Id: <20190124190203.953799152@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 25a0ad5102d6..855cf8c15c8a 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -111,10 +111,14 @@ static int e1000e_phc_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
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
@@ -170,9 +174,12 @@ static void e1000e_systim_overflow_work(struct work_struct *work)
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



