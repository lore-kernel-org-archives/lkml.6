Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3CEC676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF62820878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SDVOgss/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bCml3t17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF62820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeJHUKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:10:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49132 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJHUKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:10:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C5C9560B7F; Mon,  8 Oct 2018 12:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539003537;
        bh=WrICnaO66H8LrFR+sb3Y5sGjTTFNRJduLthwZ28gJEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDVOgss/huO1gs6aHjEzAuklolRo1xl+94v6YXmxuIKlbrU1XVySu7fT7af2ENEBc
         EWtxvX6UyDOfYruetCTvAMCn94fgiGzAeWlczJ7BTmQ6uqTXkX5LhVArKovHEO7beY
         ua8pUf+L7c0mSY+nyeBDbJ4HEb8MXY2tfH114gF8=
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE00F60C1D;
        Mon,  8 Oct 2018 12:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539003534;
        bh=WrICnaO66H8LrFR+sb3Y5sGjTTFNRJduLthwZ28gJEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCml3t17X1DA+vmAZerB33gxpyC01n9nE6k10U04WJg1LJY9kQDtBsTSuoVGwYpX3
         NH8tfzYeLcqBVpLaa6x+VIyaJAo8uuyEvsX7Ly/MHJqnd3nfBpCvTcsJbabr46YVCq
         blpqYvAo0UofhujQeSBURpDVB6qL/DMmp0jwnX7I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE00F60C1D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, vviswana@codeaurora.org,
        bjorn.andersson@linaro.org, riteshh@codeaurora.org,
        vbadigan@codeaurora.org, dianders@google.com,
        sayalil@codeaurora.org,
        Sujit Reddy Thumma <sthumma@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>
Subject: [PATCH V1 3/7] mmc: core: Add sysfs entries for dynamic control of clock scaling
Date:   Mon,  8 Oct 2018 18:28:02 +0530
Message-Id: <1539003486-24087-4-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539003486-24087-1-git-send-email-sayalil@codeaurora.org>
References: <1539003486-24087-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs attributes to allow dynamic control of clock scaling
parameters. These attributes are used to enable/disable clock
scaling at runtime and change the up_threshold, down_threshold,
and polling_interval values. Complete documentation for these
sysfs entries are provided at "Documentation/mmc/mmc-dev-attrs.txt".

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 Documentation/mmc/mmc-dev-attrs.txt |  38 +++++++++
 drivers/mmc/core/host.c             | 151 +++++++++++++++++++++++++++++++++++-
 2 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
index 4ad0bb1..b02b2b4 100644
--- a/Documentation/mmc/mmc-dev-attrs.txt
+++ b/Documentation/mmc/mmc-dev-attrs.txt
@@ -75,3 +75,41 @@ Note on raw_rpmb_size_mult:
 	"raw_rpmb_size_mult" is a multiple of 128kB block.
 	RPMB size in byte is calculated by using the following equation:
 	RPMB partition size = 128kB x raw_rpmb_size_mult
+
+SD/MMC Clock Scaling Attributes
+====================================
+
+Read and write accesses are provided to following attributes.
+
+	polling_interval	Measured in milliseconds, this attribute
+				defines how often we need to check the card
+				usage and make decisions on frequency scaling.
+
+	up_threshold		This attribute defines what should be the
+				average card usage between the polling
+				interval for the mmc core to make a decision
+				on whether it should increase the frequency.
+				For example when it is set to '35' it means
+				that between the checking intervals the card
+				needs to be on average more than 35% in use to
+				scale up the frequency. The value should be
+				between 0 - 100 so that it can be compared
+				against load percentage.
+
+	down_threshold		Similar to up_threshold, but on lowering the
+				frequency. For example, when it is set to '2'
+				it means that between the checking intervals
+				the card needs to be on average less than 2%
+				in use to scale down the clocks to minimum
+				frequency. The value should be between 0 - 100
+				so that it can be compared against load
+				percentage.
+
+	enable			Enable clock scaling for hosts (and cards)
+				that support ultrahigh speed modes
+				(SDR104, DDR50, HS200).
+
+echo <desired value> > /sys/class/mmc_host/mmcX/clk_scaling/polling_interval
+echo <desired value> > /sys/class/mmc_host/mmcX/clk_scaling/up_threshold
+echo <desired value> > /sys/class/mmc_host/mmcX/clk_scaling/down_threshold
+echo <desired value> > /sys/class/mmc_host/mmcX/clk_scaling/enable
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 1e46aa4..0504610 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -419,6 +419,151 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 EXPORT_SYMBOL(mmc_alloc_host);
 
+static ssize_t show_enable(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+
+	if (!host)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", mmc_can_scale_clk(host));
+}
+
+static ssize_t store_enable(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	unsigned long value;
+
+	if (!host || !host->card || kstrtoul(buf, 0, &value))
+		return -EINVAL;
+
+	mmc_get_card(host->card, NULL);
+
+	if (!value) {
+		/* mask host capability */
+		host->caps2 &= ~MMC_CAP2_CLK_SCALE;
+		host->clk_scaling.state = MMC_LOAD_HIGH;
+		/* Set to max. frequency when disabling */
+		mmc_clk_update_freq(host, host->card->clk_scaling_highest,
+					host->clk_scaling.state);
+	} else if (value) {
+		/* Unmask host capability*/
+		host->caps2 |= MMC_CAP2_CLK_SCALE;
+	}
+
+	mmc_put_card(host->card, NULL);
+
+	return count;
+}
+
+static ssize_t show_up_threshold(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+
+	if (!host)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", host->clk_scaling.upthreshold);
+}
+
+#define MAX_PERCENTAGE	100
+static ssize_t store_up_threshold(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	unsigned long value;
+
+	if (!host || kstrtoul(buf, 0, &value) || (value > MAX_PERCENTAGE))
+		return -EINVAL;
+
+	host->clk_scaling.upthreshold = value;
+
+	pr_debug("%s: clkscale_up_thresh set to %lu\n",
+			mmc_hostname(host), value);
+	return count;
+}
+
+static ssize_t show_down_threshold(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+
+	if (!host)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			host->clk_scaling.downthreshold);
+}
+
+static ssize_t store_down_threshold(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	unsigned long value;
+
+	if (!host || kstrtoul(buf, 0, &value) || (value > MAX_PERCENTAGE))
+		return -EINVAL;
+
+	host->clk_scaling.downthreshold = value;
+
+	pr_debug("%s: clkscale_down_thresh set to %lu\n",
+			mmc_hostname(host), value);
+	return count;
+}
+
+static ssize_t show_polling(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+
+	if (!host)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "%lu milliseconds\n",
+			host->clk_scaling.polling_delay_ms);
+}
+
+static ssize_t store_polling(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	unsigned long value;
+
+	if (!host || kstrtoul(buf, 0, &value))
+		return -EINVAL;
+
+	host->clk_scaling.polling_delay_ms = value;
+
+	pr_debug("%s: clkscale_polling_delay_ms set to %lu\n",
+			mmc_hostname(host), value);
+	return count;
+}
+
+DEVICE_ATTR(enable, 0644,
+		show_enable, store_enable);
+DEVICE_ATTR(polling_interval, 0644,
+		show_polling, store_polling);
+DEVICE_ATTR(up_threshold, 0644,
+		show_up_threshold, store_up_threshold);
+DEVICE_ATTR(down_threshold, 0644,
+		show_down_threshold, store_down_threshold);
+
+static struct attribute *clk_scaling_attrs[] = {
+	&dev_attr_enable.attr,
+	&dev_attr_up_threshold.attr,
+	&dev_attr_down_threshold.attr,
+	&dev_attr_polling_interval.attr,
+	NULL,
+};
+
+static struct attribute_group clk_scaling_attr_grp = {
+	.name = "clk_scaling",
+	.attrs = clk_scaling_attrs,
+};
+
 /**
  *	mmc_add_host - initialise host hardware
  *	@host: mmc host
@@ -447,6 +592,10 @@ int mmc_add_host(struct mmc_host *host)
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_host_debugfs(host);
 #endif
+	err = sysfs_create_group(&host->class_dev.kobj, &clk_scaling_attr_grp);
+	if (err)
+		pr_err("%s: failed to create clk scale sysfs group with err %d\n",
+				__func__, err);
 
 	mmc_start_host(host);
 	mmc_register_pm_notifier(host);
@@ -472,7 +621,7 @@ void mmc_remove_host(struct mmc_host *host)
 #ifdef CONFIG_DEBUG_FS
 	mmc_remove_host_debugfs(host);
 #endif
-
+	sysfs_remove_group(&host->class_dev.kobj, &clk_scaling_attr_grp);
 	device_del(&host->class_dev);
 
 	led_trigger_unregister_simple(host->led);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

