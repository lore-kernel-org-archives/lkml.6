Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC19C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9C82171F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2Rav2+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbeLOIpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:45:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39851 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeLOIpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:45:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id c72so3968142pfc.6;
        Sat, 15 Dec 2018 00:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mf080+UEcKkdJ00Svvi/CWnm/Qtg8hEBXJGuRoq1cAQ=;
        b=A2Rav2+YZcZ0+ylk5NSBHxvGGZOe8MMIm32DqImdM1ZoyPt4W3O599p4KzaH1aaMdk
         IB8Y7Deq3ud1voJvoJUxgwD4GfVj8m6b915c8YmM32bM3P33X/xa1cazSBqCPo2bY740
         aElNSzDsSJ6REZOXgw/mTAH8ZXJZIqP0k8zMXgnubBjKXmjfLUdqVquYdEKor63rMeUy
         fV/kacOdTHsfdrff/e6ZL4RsRbHaiSJApjb09STyjYEg6KXOUgtvBNfmN5x7yTHpWANF
         CQMC8ayh29be2n/X2ieu5km4Tw6Y7bwId/LcmD83pwXdnagCX/2Q/qjH2HXFCaS0tqmK
         hckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mf080+UEcKkdJ00Svvi/CWnm/Qtg8hEBXJGuRoq1cAQ=;
        b=LhRr2ASas/oDirHT/POZ/GofL3crZKiHiPQ+MStkzfHop6ewSFGf/gxdVLDho5S1L+
         7jeNlg99wCGKzT10YvLDwXITHYxz6zKk9PvbJjY1eoRktJbyYmlEU4HG0fhdE9t1KsGN
         zJh82MqduFV+0hImP5MCvbVD3IX5pOUuxC3S/dhrx9nphtqyL6/gh5g82BefCxjKHgUB
         k5t+lrn6Yl0JK5QFV7hcNXiG5K0wgMDNFJa4Z0XQMPi9/Rj9iPow2eMJkFj6MqkJ4jBM
         SmSQGnc7uin7WFe4SaRjRvy941GhmoiSceawlHavOT+4mpqMCfh/GyQ9yT2CKQWgEF9Z
         ME3A==
X-Gm-Message-State: AA+aEWZTteiWR2rsmE61M2ABh/RscMztu1jd9A0j5T2J6nTPXs6OBWa6
        eCCtGfK4ySi5M8rnl8YG6M0=
X-Google-Smtp-Source: AFSGD/VxZFtzIRucQtwHnZjJwsTOGM9Dg3GoOLdH1+oLwJbcFYxTr8th4DcwdJgv9MXZthwTlHrGag==
X-Received: by 2002:a62:19d5:: with SMTP id 204mr5733652pfz.33.1544863528331;
        Sat, 15 Dec 2018 00:45:28 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id x27sm15101373pfe.178.2018.12.15.00.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 00:45:27 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND] PM / Domains: remove define_genpd_open_function() and define_genpd_debugfs_fops()
Date:   Sat, 15 Dec 2018 03:45:26 -0500
Message-Id: <20181215084526.27210-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already have the DEFINE_SHOW_ATTRIBUTE, There is no need to define
such a macro, so remove define_genpd_open_function and
define_genpd_debugfs_fops.

Convert them to DEFINE_SHOW_ATTRIBUTE.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/domain.c | 71 +++++++++++++------------------------
 1 file changed, 24 insertions(+), 47 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7f38a92b444a..10a61d6147d0 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2671,7 +2671,7 @@ static int genpd_summary_one(struct seq_file *s,
 	return 0;
 }
 
-static int genpd_summary_show(struct seq_file *s, void *data)
+static int summary_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd;
 	int ret = 0;
@@ -2694,7 +2694,7 @@ static int genpd_summary_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_status_show(struct seq_file *s, void *data)
+static int status_show(struct seq_file *s, void *data)
 {
 	static const char * const status_lookup[] = {
 		[GPD_STATE_ACTIVE] = "on",
@@ -2721,7 +2721,7 @@ static int genpd_status_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_sub_domains_show(struct seq_file *s, void *data)
+static int sub_domains_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	struct gpd_link *link;
@@ -2738,7 +2738,7 @@ static int genpd_sub_domains_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_idle_states_show(struct seq_file *s, void *data)
+static int idle_states_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	unsigned int i;
@@ -2767,7 +2767,7 @@ static int genpd_idle_states_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_active_time_show(struct seq_file *s, void *data)
+static int active_time_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	ktime_t delta = 0;
@@ -2787,7 +2787,7 @@ static int genpd_active_time_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_total_idle_time_show(struct seq_file *s, void *data)
+static int total_idle_time_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	ktime_t delta = 0, total = 0;
@@ -2815,7 +2815,7 @@ static int genpd_total_idle_time_show(struct seq_file *s, void *data)
 }
 
 
-static int genpd_devices_show(struct seq_file *s, void *data)
+static int devices_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	struct pm_domain_data *pm_data;
@@ -2841,7 +2841,7 @@ static int genpd_devices_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_perf_state_show(struct seq_file *s, void *data)
+static int perf_state_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 
@@ -2854,37 +2854,14 @@ static int genpd_perf_state_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-#define define_genpd_open_function(name) \
-static int genpd_##name##_open(struct inode *inode, struct file *file) \
-{ \
-	return single_open(file, genpd_##name##_show, inode->i_private); \
-}
-
-define_genpd_open_function(summary);
-define_genpd_open_function(status);
-define_genpd_open_function(sub_domains);
-define_genpd_open_function(idle_states);
-define_genpd_open_function(active_time);
-define_genpd_open_function(total_idle_time);
-define_genpd_open_function(devices);
-define_genpd_open_function(perf_state);
-
-#define define_genpd_debugfs_fops(name) \
-static const struct file_operations genpd_##name##_fops = { \
-	.open = genpd_##name##_open, \
-	.read = seq_read, \
-	.llseek = seq_lseek, \
-	.release = single_release, \
-}
-
-define_genpd_debugfs_fops(summary);
-define_genpd_debugfs_fops(status);
-define_genpd_debugfs_fops(sub_domains);
-define_genpd_debugfs_fops(idle_states);
-define_genpd_debugfs_fops(active_time);
-define_genpd_debugfs_fops(total_idle_time);
-define_genpd_debugfs_fops(devices);
-define_genpd_debugfs_fops(perf_state);
+DEFINE_SHOW_ATTRIBUTE(summary);
+DEFINE_SHOW_ATTRIBUTE(status);
+DEFINE_SHOW_ATTRIBUTE(sub_domains);
+DEFINE_SHOW_ATTRIBUTE(idle_states);
+DEFINE_SHOW_ATTRIBUTE(active_time);
+DEFINE_SHOW_ATTRIBUTE(total_idle_time);
+DEFINE_SHOW_ATTRIBUTE(devices);
+DEFINE_SHOW_ATTRIBUTE(perf_state);
 
 static int __init genpd_debug_init(void)
 {
@@ -2897,7 +2874,7 @@ static int __init genpd_debug_init(void)
 		return -ENOMEM;
 
 	d = debugfs_create_file("pm_genpd_summary", S_IRUGO,
-			genpd_debugfs_dir, NULL, &genpd_summary_fops);
+			genpd_debugfs_dir, NULL, &summary_fops);
 	if (!d)
 		return -ENOMEM;
 
@@ -2907,20 +2884,20 @@ static int __init genpd_debug_init(void)
 			return -ENOMEM;
 
 		debugfs_create_file("current_state", 0444,
-				d, genpd, &genpd_status_fops);
+				d, genpd, &status_fops);
 		debugfs_create_file("sub_domains", 0444,
-				d, genpd, &genpd_sub_domains_fops);
+				d, genpd, &sub_domains_fops);
 		debugfs_create_file("idle_states", 0444,
-				d, genpd, &genpd_idle_states_fops);
+				d, genpd, &idle_states_fops);
 		debugfs_create_file("active_time", 0444,
-				d, genpd, &genpd_active_time_fops);
+				d, genpd, &active_time_fops);
 		debugfs_create_file("total_idle_time", 0444,
-				d, genpd, &genpd_total_idle_time_fops);
+				d, genpd, &total_idle_time_fops);
 		debugfs_create_file("devices", 0444,
-				d, genpd, &genpd_devices_fops);
+				d, genpd, &devices_fops);
 		if (genpd->set_performance_state)
 			debugfs_create_file("perf_state", 0444,
-					    d, genpd, &genpd_perf_state_fops);
+					    d, genpd, &perf_state_fops);
 	}
 
 	return 0;
-- 
2.17.0

