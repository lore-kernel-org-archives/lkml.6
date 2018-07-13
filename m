Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E24DECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046CF20858
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jvB8i4HA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AySif/FA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046CF20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeGMKIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:08:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50416 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeGMKIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:08:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 354B360B74; Fri, 13 Jul 2018 09:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531475664;
        bh=A4vqSNmkJ6M0okyY7xZNgzUoUCkAhEFtwShfK4XsboI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvB8i4HAB3+QRkHmV7IDRm4360PVYfz+4Ki4j4X9a4epP/aXoBzNMFMcGYw1nov6b
         wo/645ercFD9sgUh6FZ3PzT20AjHzvnQ77c5Fly6wVm4fUENvB3A7VGIIz+I+Awnz9
         ZSQCXaZOCOUxhpq7cK9BxxIghHIZ/mU8WdqnpJS0=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D08D60B83;
        Fri, 13 Jul 2018 09:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531475663;
        bh=A4vqSNmkJ6M0okyY7xZNgzUoUCkAhEFtwShfK4XsboI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AySif/FAXK3+401mNUGOlDoLHoVOingJqIeXV8ZSNsql79dQjDJJ/5rwJUxDbHU8z
         yqNGXNvyexjl9fIEHBEPK2A9HU5yTR+06T8myQ7tVg+eYxOdUGffaGf6lGt3xudeKn
         DVraAiDYTGHUnIZ7ySm76yccAFv8e5O4ZQQzUUZo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D08D60B83
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, vviswana@codeaurora.org,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, sayalil@codeaurora.org,
        Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: [PATCH RFC 7/7] mmc: core: Add a debugfs entry to set max clock rate
Date:   Fri, 13 Jul 2018 15:23:03 +0530
Message-Id: <1531475583-7050-8-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
References: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Limiting the max frequency supported by host controller
to a certain value can be useful for testing power consumption
at various frequencies that are supported by the host.
Note: If the card supports less than desired value then the
frequency of operation would be limited to that frequency.
Usage:
mount -t debugfs none /sys/kernel/debug
echo <desired_frequency> > /sys/kernel/debug/mmcX/max_clock
cat /sys/kernel/debug/mmcX/max_clock

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 drivers/mmc/core/debugfs.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 630ca8e..26499f7 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -262,6 +262,46 @@ static int mmc_scale_set(void *data, u64 val)
 DEFINE_SIMPLE_ATTRIBUTE(mmc_scale_fops, mmc_scale_get, mmc_scale_set,
 	"%llu\n");
 
+static int mmc_max_clock_get(void *data, u64 *val)
+{
+	struct mmc_host *host = data;
+
+	if (!host)
+		return -EINVAL;
+
+	*val = host->f_max;
+
+	return 0;
+}
+
+static int mmc_max_clock_set(void *data, u64 val)
+{
+	struct mmc_host *host = data;
+	int err = -EINVAL;
+	unsigned long freq = val;
+	unsigned int old_freq;
+
+	if (!host || (val < host->f_min))
+		goto out;
+
+	mmc_claim_host(host);
+	if (host->bus_ops && host->bus_ops->change_bus_speed) {
+		old_freq = host->f_max;
+		host->f_max = freq;
+
+		err = host->bus_ops->change_bus_speed(host, &freq);
+
+		if (err)
+			host->f_max = old_freq;
+	}
+	mmc_release_host(host);
+out:
+	return err;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(mmc_max_clock_fops, mmc_max_clock_get,
+		mmc_max_clock_set, "%llu\n");
+
 void mmc_add_host_debugfs(struct mmc_host *host)
 {
 	struct dentry *root;
@@ -290,6 +330,10 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 			&mmc_clock_fops))
 		goto err_node;
 
+	if (!debugfs_create_file("max_clock", 0600, root, host,
+		&mmc_max_clock_fops))
+		goto err_node;
+
 	if (!debugfs_create_file("scale", 0600, root, host,
 		&mmc_scale_fops))
 		goto err_node;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

