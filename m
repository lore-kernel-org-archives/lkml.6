Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CACC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9866E25BB4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d62rCpti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9866E25BB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933740AbeGBIuI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:50:08 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37317 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753387AbeGBIuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:50:01 -0400
Received: by mail-pg0-f68.google.com with SMTP id n15-v6so3599217pgv.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 01:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KKaFUVhtuRqtVBV3i0eeLybqPWvydvRsjt797gmNCFU=;
        b=d62rCptixIqXQHkYV9WyI97h3un2L1W/c291kBG+rb/3xpqY56wr/BATX2nZpQLgP7
         oqsWjqJ3pPnro2dvCyPWOBmjzY9yASaAnv8bfkyDYY5GDij4b/4n49f3ZMtUSAlthMYZ
         d+otlrqNlc6eRE26iFlUCAYAvtWCGQK07GHGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KKaFUVhtuRqtVBV3i0eeLybqPWvydvRsjt797gmNCFU=;
        b=UgYipGqBDhYusPcySP3cWOAzHnV5fo00MG4E4T9NYXyle5fkkxTG5FCHATXaZMFRve
         NpGc5ZQW56RKJlCOwco5YYOQ9Oeyt0bKVUGPFklntAq9cWhkEuGJHeBRJYNrU6+Gr9IF
         Ipk1+9yLVoMFZdUHfsPfPhOUXJGENXyWM2/uSKwfgGOfeXmFRAzz1cKIgC8Dg9gIEz52
         g/PdLG96LkOuHXlpulIPtP9OwtwzBTKBWWVAB96un2fd1EFJbLwHYlMZbvmUxpRxlnNM
         SXNeiMHIB3a8RWYV3RrftAYf9XzuKHEHamNUeoFXpXckvNvsBITndhu2l3sOSoqhqn32
         USug==
X-Gm-Message-State: APt69E2Y57+WTxQWcfdGhCco2g+hSWzoMobeeCZ3exg8V3OniJoxzNjl
        jV1ZkuULcC/IjVdXJPdQB4Gefw==
X-Google-Smtp-Source: AAOMgpdepbLyiBWjzPQwtQentLMvHi8FWchd7Onz7ZJzzge2ZVOdUNRtHCTW5EgYsfoWBZLN/TNKkQ==
X-Received: by 2002:a65:4d85:: with SMTP id p5-v6mr21103058pgq.249.1530521400577;
        Mon, 02 Jul 2018 01:50:00 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id p76-v6sm29441810pfk.147.2018.07.02.01.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 01:49:59 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>,
        "4 . 6+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4.9] PM / OPP: Update voltage in case freq == old_freq
Date:   Mon,  2 Jul 2018 14:19:47 +0530
Message-Id: <3717ee50c1f1f48cffcb1a2e41c04e28881776d1.1530521347.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>

Original commit c5c2a97b3ac7 ("PM / OPP: Update voltage in case freq ==
old_freq").

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
---
Sending it for stable kernels from 4.6 until 4.9.

 drivers/base/power/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 4c7c6da7a989..0580cbe5bd1c 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -642,7 +642,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	rcu_read_unlock();
 
 	/* Scaling up? Scale voltage before frequency */
-	if (freq > old_freq) {
+	if (freq >= old_freq) {
 		ret = _set_opp_voltage(dev, reg, u_volt, u_volt_min,
 				       u_volt_max);
 		if (ret)
-- 
2.18.0.rc1.242.g61856ae69a2c

