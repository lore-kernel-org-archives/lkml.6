Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0744C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869BD2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570693;
	bh=NTmBDdXPRGSej3dh3gdJQhXc2efILJUEdO3ANsK+fuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BNXor9BnHadkp2AsLWaeEf9yI6GeMtZhJGMXT7gBhCcTlenaVFGAiKny/2KYZd8mr
	 qXJ2x7elx9uZ/3cNQwmsHeU5pvgm7U6FY4aBlEl53o33P6Z6/qJ2fsP5MyYvlXtOjd
	 /D3SG2SW2hMiga4uyD87IIxNCYUl7MNN6yxJ4WME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbfAOQow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:44:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729683AbfAOQor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:44:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E71820859;
        Tue, 15 Jan 2019 16:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570686;
        bh=NTmBDdXPRGSej3dh3gdJQhXc2efILJUEdO3ANsK+fuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zAdBGpdK+BRf3If16Npdha2/5ng3wcoRsmjFsaadmCtuGVxp03De1a3v+kTtxCR8U
         OANARquo7iLVcs/hvfNiLbzbxYDlytWP8XYoo12E/OrzSYBGBS0N3+9d3C6lAxzOZw
         T4BQxnJY2hIhDcystwCOT23VGuWrnF234iOQriEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.20 07/57] cpufreq: scmi: Fix frequency invariance in slow path
Date:   Tue, 15 Jan 2019 17:35:48 +0100
Message-Id: <20190115154911.125770571@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quentin Perret <quentin.perret@arm.com>

commit 0e141d1c65c1dd31c914eb2e11651adcc1a15912 upstream.

The scmi-cpufreq driver calls the arch_set_freq_scale() callback on
frequency changes to provide scale-invariant load-tracking signals to
the scheduler. However, in the slow path, it does so while specifying
the current and max frequencies in different units, hence resulting in a
broken freq_scale factor.

Fix this by passing all frequencies in KHz, as stored in the CPUFreq
frequency table.

Fixes: 99d6bdf33877 (cpufreq: add support for CPU DVFS based on SCMI message protocol)
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: 4.17+ <stable@vger.kernel.org> # v4.17+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/scmi-cpufreq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -52,9 +52,9 @@ scmi_cpufreq_set_target(struct cpufreq_p
 	int ret;
 	struct scmi_data *priv = policy->driver_data;
 	struct scmi_perf_ops *perf_ops = handle->perf_ops;
-	u64 freq = policy->freq_table[index].frequency * 1000;
+	u64 freq = policy->freq_table[index].frequency;
 
-	ret = perf_ops->freq_set(handle, priv->domain_id, freq, false);
+	ret = perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
 	if (!ret)
 		arch_set_freq_scale(policy->related_cpus, freq,
 				    policy->cpuinfo.max_freq);


