Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A227AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A5120855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548168103;
	bh=JBjLL9TSk/DcRzx3WlQjotQ/M37jVyqq/YrBoWKS0Hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wyhx6ameFWx2hMAXQvnjAqMcYACPmaMtqlklE1B1hsmZtsTgitXMiMflHKvzS7F5Y
	 sJzLxQG9ofOMKY2jfULcWvb+NVM9eCPaIUgsMhj/4ZJ3/Ewm9hhT7bu6ZF/4F6Gvx1
	 aNlrHpnyQTvZFO/HsnuP9g7vxZpgDxlhfpf7wZRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfAVOlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:41:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbfAVOlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:41:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45B4F217D6;
        Tue, 22 Jan 2019 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548168095;
        bh=JBjLL9TSk/DcRzx3WlQjotQ/M37jVyqq/YrBoWKS0Hw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Oc9LH+bwETYqPMMPYduzLxssl/TIEgtp1+BPNOdaigJ/2Qk+2eUcIg8Im/wWtq0e2
         r3xFsDBRre/lXreJUM/3KLk9Za1Xd03RyhtglET+bVURiYw668ijKBA3s+WofCQwRg
         qLnFk7n22/489T8Tw4C6D0bz0arDhf5qdO9eJAkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: [PATCH 4/4] arm: omap2: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 15:41:14 +0100
Message-Id: <20190122144114.9816-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122144114.9816-1-gregkh@linuxfoundation.org>
References: <20190122144114.9816-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Kevin Hilman <khilman@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/pm-debug.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 5a8839203958..1f9334a3d611 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -193,9 +193,8 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *dir)
 		return 0;
 
 	d = debugfs_create_dir(pwrdm->name, (struct dentry *)dir);
-	if (d)
-		(void) debugfs_create_file("suspend", S_IRUGO|S_IWUSR, d,
-			(void *)pwrdm, &pwrdm_suspend_fops);
+	debugfs_create_file("suspend", S_IRUGO|S_IWUSR, d, pwrdm,
+			    &pwrdm_suspend_fops);
 
 	return 0;
 }
@@ -233,16 +232,14 @@ static int __init pm_dbg_init(void)
 		return 0;
 
 	d = debugfs_create_dir("pm_debug", NULL);
-	if (!d)
-		return -EINVAL;
 
-	(void) debugfs_create_file("count", 0444, d, NULL, &pm_dbg_counters_fops);
-	(void) debugfs_create_file("time", 0444, d, NULL, &pm_dbg_timers_fops);
+	debugfs_create_file("count", 0444, d, NULL, &pm_dbg_counters_fops);
+	debugfs_create_file("time", 0444, d, NULL, &pm_dbg_timers_fops);
 
 	pwrdm_for_each(pwrdms_setup, (void *)d);
 
-	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
-				   &enable_off_mode, &pm_dbg_option_fops);
+	debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
+			    &enable_off_mode, &pm_dbg_option_fops);
 	pm_dbg_init_done = 1;
 
 	return 0;
-- 
2.20.1

