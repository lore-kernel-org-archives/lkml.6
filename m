Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 99422C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8CF208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8CF208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936060AbeFNN4k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:56:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:55499 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755208AbeFNN4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:56:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 06:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,222,1526367600"; 
   d="scan'208";a="63152194"
Received: from mucrsa0015.imu.intel.com ([10.62.163.98])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2018 06:56:37 -0700
From:   Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM / OPP: Update voltage in case freq == old_freq
Date:   Thu, 14 Jun 2018 15:56:08 +0200
Message-Id: <20180614135609.20574-1-waldemar.rymarkiewicz@gmail.com>
X-Mailer: git-send-email 2.10.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes a rare but possible case when the clk rate is updated
without update of the regulator voltage.

At boot up, CPUfreq checks if the system is running at the right freq. This
is a sanity check in case a bootloader set clk rate that is outside of freq
table present with cpufreq core. In such cases system can be unstable so
better to change it to a freq that is preset in freq-table.

The CPUfreq takes next freq that is >= policy->cur and this is our
target_freq that needs to be set now.

dev_pm_opp_set_rate(dev, target_freq) checks the target_freq and the
old_freq (a current rate). If these are equal it returns early. If not,
it searches for OPP (old_opp) that fits best to old_freq (not listed in
the table) and updates old_freq (!).

Here, we can end up with old_freq = old_opp.rate = target_freq, which
is not handled in _generic_set_opp_regulator(). It's supposed to update
voltage only when freq > old_freq  || freq > old_freq.

if (freq > old_freq) {
		ret = _set_opp_voltage(dev, reg, new_supply);
[...]
if (freq < old_freq) {
		ret = _set_opp_voltage(dev, reg, new_supply);
		if (ret)

It results in, no voltage update while clk rate is updated.

Example:
freq-table = {
	1000MHz   1.15V
	 666MHZ   1.10V
	 333MHz   1.05V
}
boot-up-freq        = 800MHz   # not listed in freq-table
freq = target_freq  = 1GHz
old_freq            = 800Mhz
old_opp = _find_freq_ceil(opp_table, &old_freq);  #(old_freq is modified!)
old_freq            = 1GHz

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ab2f3fe..31ff03d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -598,7 +598,7 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 	}
 
 	/* Scaling up? Scale voltage before frequency */
-	if (freq > old_freq) {
+	if (freq >= old_freq) {
 		ret = _set_opp_voltage(dev, reg, new_supply);
 		if (ret)
 			goto restore_voltage;
-- 
2.10.1

