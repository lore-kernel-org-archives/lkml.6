Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96729C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C66D2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570558;
	bh=OV8bmUQ8z5C0TKNSZANTAwhhAjU+Efq1F2jAYmaXA1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zhpfIbRoASZxuzMWRi7rALm8W3y9G6ULcj0NqOaDbQy1pyg98b6PvvmhXP1fy4hNN
	 OcIhLJpapXqsDHZ2VHgF5q7Mq44On+Aaba52Y6ce9Hall7ZYLCN6DMOxxT9lDjhvO6
	 s9098c4Wf1oHHRTLvt0nEw5OgnXZwvwOnRQpOEr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733025AbfAOQmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:42:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730657AbfAOQmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:42:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C955E2054F;
        Tue, 15 Jan 2019 16:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570554;
        bh=OV8bmUQ8z5C0TKNSZANTAwhhAjU+Efq1F2jAYmaXA1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gUR0AOqGzH1cnCKPzXUYutp9GZp5u+IgDOJHmcQ0KvMZ6OknFBia5rY+3CZ5bd08g
         xKGgsTeUggNzSaOpVFEmfxCY/FTBpxpJo2DfvHPza1lUF576Bn2lfnbAPYuXEQXVzH
         fvKkm06S+xlOZHnz8u9uQi/KSbmidFuOIwje3YaQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.19 04/50] cpufreq: scmi: Fix frequency invariance in slow path
Date:   Tue, 15 Jan 2019 17:35:40 +0100
Message-Id: <20190115154910.236217166@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


