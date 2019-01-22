Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014BAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8AF217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170616;
	bh=GZPeWNn52oXpAQIYWecxSdnP01fKi3EDRLrDsmh2OVo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wy4CsU5ErPKIkd+BSQLZlR/+MI3jC7f33nWaxfhTgOKZpDDk/OvyOzc4lZeoRHxXb
	 LdVgNIAWYaQ1kbTH1zTagcCfgmIguPN1u6kWVY5OTOOwUw08RWjqQlHOfwguCyfjt4
	 q4zyvJn0HwbsAdmAI2GX12Mg8ydNBjHRN5Q/qQ34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfAVPXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:23:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728983AbfAVPXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:23:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8CAD217D6;
        Tue, 22 Jan 2019 15:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170613;
        bh=GZPeWNn52oXpAQIYWecxSdnP01fKi3EDRLrDsmh2OVo=;
        h=From:To:Cc:Subject:Date:From;
        b=07zOZdgMUdavCZuUMbbelivFgBxq9RGnxFkbCD6FzsMdTJCzMAn9LLWPT3fhhLKEP
         /h87RUN/6kZ47UWQjpSNT3ukdmVVsbEHAuoAib1uYQg83uTdHmWz7yHorYbSgReXfG
         OHoeV/38L9YDVzmO1+NiXFNqarANHx1+N0WArrgA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] timekeeping_debug: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:42 +0100
Message-Id: <20190122152151.16139-43-gregkh@linuxfoundation.org>
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

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/timekeeping_debug.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
index 86489950d690..b73e8850e58d 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -37,15 +37,8 @@ DEFINE_SHOW_ATTRIBUTE(tk_debug_sleep_time);
 
 static int __init tk_debug_sleep_time_init(void)
 {
-	struct dentry *d;
-
-	d = debugfs_create_file("sleep_time", 0444, NULL, NULL,
-		&tk_debug_sleep_time_fops);
-	if (!d) {
-		pr_err("Failed to create sleep_time debug file\n");
-		return -ENOMEM;
-	}
-
+	debugfs_create_file("sleep_time", 0444, NULL, NULL,
+			    &tk_debug_sleep_time_fops);
 	return 0;
 }
 late_initcall(tk_debug_sleep_time_init);
-- 
2.20.1

