Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7E1C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344C522353
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNfa69sE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344C522353
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbeKLIQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:16:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729859AbeKLIQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:16:54 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8469C21104;
        Sun, 11 Nov 2018 22:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975219;
        bh=Dm+7vvDHL6yDavxr/GtmeoMgqkahksZQbaEboyzqNlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNfa69sEjrootOowRlU8BHrUEEkrBZ3gx5CSsnZWdSMYu+XRzpFqmyJK4YVaUslfD
         ijs1Hb4KYPWxiTHE2ZbxYt5oq8J82U9gng1CM3qsNVasckk+C3Hep7DYdXZOUJcse/
         602ItzeeYr/62sHXAArWbOaTqBCr/Prp4UcnJy6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4.19 021/361] cpufreq: conservative: Take limits changes into account properly
Date:   Sun, 11 Nov 2018 14:16:08 -0800
Message-Id: <20181111221622.648784556@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit da5e79bc70b84971d2b3a55fb252e34e51d81d48 upstream.

If the policy limits change between invocations of cs_dbs_update(),
the requested frequency value stored in dbs_info may not be updated
and the function may use a stale value of it next time.  Moreover, if
idle periods are takem into account by cs_dbs_update(), the requested
frequency value stored in dbs_info may be below the min policy limit,
which is incorrect.

To fix these problems, always update the requested frequency value
in dbs_info along with the local copy of it when the previous
requested frequency is beyond the policy limits and avoid decreasing
the requested frequency below the min policy limit when taking
idle periods into account.

Fixes: abb6627910a1 (cpufreq: conservative: Fix next frequency selection)
Fixes: 00bfe05889e9 (cpufreq: conservative: Decrease frequency faster for deferred updates)
Reported-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/cpufreq_conservative.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -80,8 +80,10 @@ static unsigned int cs_dbs_update(struct
 	 * changed in the meantime, so fall back to current frequency in that
 	 * case.
 	 */
-	if (requested_freq > policy->max || requested_freq < policy->min)
+	if (requested_freq > policy->max || requested_freq < policy->min) {
 		requested_freq = policy->cur;
+		dbs_info->requested_freq = requested_freq;
+	}
 
 	freq_step = get_freq_step(cs_tuners, policy);
 
@@ -92,7 +94,7 @@ static unsigned int cs_dbs_update(struct
 	if (policy_dbs->idle_periods < UINT_MAX) {
 		unsigned int freq_steps = policy_dbs->idle_periods * freq_step;
 
-		if (requested_freq > freq_steps)
+		if (requested_freq > policy->min + freq_steps)
 			requested_freq -= freq_steps;
 		else
 			requested_freq = policy->min;


