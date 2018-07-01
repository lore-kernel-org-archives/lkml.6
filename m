Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21880C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D370925330
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D370925330
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031459AbeGAQhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:37:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36270 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031397AbeGAQh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:37:27 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5735FACD;
        Sun,  1 Jul 2018 16:37:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4.17 022/220] PM / OPP: Update voltage in case freq == old_freq
Date:   Sun,  1 Jul 2018 18:20:46 +0200
Message-Id: <20180701160909.276606362@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>

commit c5c2a97b3ac7d1ec19e7cff9e38caca6afefc3de upstream.

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

Fixes: 6a0712f6f199 ("PM / OPP: Add dev_pm_opp_set_rate()")
Cc: 4.6+ <stable@vger.kernel.org> # v4.6+
Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/opp/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -591,7 +591,7 @@ static int _generic_set_opp_regulator(co
 	}
 
 	/* Scaling up? Scale voltage before frequency */
-	if (freq > old_freq) {
+	if (freq >= old_freq) {
 		ret = _set_opp_voltage(dev, reg, new_supply);
 		if (ret)
 			goto restore_voltage;


