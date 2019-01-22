Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C22C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85D1217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170597;
	bh=/mvrgN4AQieuY0lFZOxqKUAa3lbcurGgdfie/Ip2tHY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nBxi3/9c7DKlgM3D5ETu45CuwH+O7+Uo7N1Ew/1GpHA8yan2E3+Nz6adV+PzTK24Q
	 EEkDxyYxA36BLooHVZEdxuT82rBKnleoPWERNbMbItZUM8gendyEt7eRH3AGnJA3B8
	 qYZn+WdRJsKz7bawhF1AXrZ+uuynNXr1LGUlVKdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfAVPXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729133AbfAVPXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2F27217D6;
        Tue, 22 Jan 2019 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170593;
        bh=/mvrgN4AQieuY0lFZOxqKUAa3lbcurGgdfie/Ip2tHY=;
        h=From:To:Cc:Subject:Date:From;
        b=N1q2z1HasH4cNo6Un5EqBM78MqqU6M76FbMIOmQQc67oLvwHzrpO6dIlqyO1B9WLn
         yCZLqUIh1u/o0hTKibdNzyccPqx6d9RVUaGB9JATM6m3IUuGDYrT362Hmm3H0jIIAh
         uw5WU2R/HSgK9472LDeLQOuQl5UpT+DFoGmV8Fd0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH] power: domain: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:05 +0100
Message-Id: <20190122152151.16139-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/power/domain.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 500de1dee967..45eafe8cf7dd 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2948,18 +2948,11 @@ static int __init genpd_debug_init(void)
 
 	genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
 
-	if (!genpd_debugfs_dir)
-		return -ENOMEM;
-
-	d = debugfs_create_file("pm_genpd_summary", S_IRUGO,
-			genpd_debugfs_dir, NULL, &summary_fops);
-	if (!d)
-		return -ENOMEM;
+	debugfs_create_file("pm_genpd_summary", S_IRUGO, genpd_debugfs_dir,
+			    NULL, &summary_fops);
 
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
 		d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
-		if (!d)
-			return -ENOMEM;
 
 		debugfs_create_file("current_state", 0444,
 				d, genpd, &status_fops);
-- 
2.20.1

