Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7123AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA912054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWWRQ2Jk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA912054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeKAIG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbeKAIG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3306F20840;
        Wed, 31 Oct 2018 23:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027176;
        bh=/2kSpEwGHLo2dhGBW8I3mkSDZ1pBLaswz3+kTHKuK+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWWRQ2JkubYG+ekYPa3uTIWYDqELU2CzJfEqJe5KpjISlADWwqcM2SnNj8I6b/pS7
         zd+E9DPMmMey9kpZy4ejpUSp89MzSQRmUtOg2P3cbOGW9QXmEVSOJdpz50ZVzIoeae
         tzLeiXmfUkkoe3cPFkXpcsId7j6P+mdCyrw4RxYY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiaochen Shen <xiaochen.shen@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 037/146] x86/intel_rdt: Show missing resctrl mount options
Date:   Wed, 31 Oct 2018 19:03:52 -0400
Message-Id: <20181031230541.28822-37-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaochen Shen <xiaochen.shen@intel.com>

[ Upstream commit 2cc81c6992248ea37d0241bc325977bab310bc3b ]

In resctrl filesystem, mount options exist to enable L3/L2 CDP and MBA
Software Controller features if the platform supports them:

 mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl

But currently only "cdp" option is displayed in /proc/mounts. "cdpl2" and
"mba_MBps" options are not shown even when they are active.

Before:
 # mount -t resctrl resctrl -o cdp,mba_MBps /sys/fs/resctrl
 # grep resctrl /proc/mounts
 /sys/fs/resctrl /sys/fs/resctrl resctrl rw,relatime,cdp 0 0

After:
 # mount -t resctrl resctrl -o cdp,mba_MBps /sys/fs/resctrl
 # grep resctrl /proc/mounts
 /sys/fs/resctrl /sys/fs/resctrl resctrl rw,relatime,cdp,mba_MBps 0 0

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Tony Luck" <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1536796118-60135-1-git-send-email-fenghua.yu@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index b140c68bc14b..643670fb8943 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2805,6 +2805,13 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
 {
 	if (rdt_resources_all[RDT_RESOURCE_L3DATA].alloc_enabled)
 		seq_puts(seq, ",cdp");
+
+	if (rdt_resources_all[RDT_RESOURCE_L2DATA].alloc_enabled)
+		seq_puts(seq, ",cdpl2");
+
+	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA]))
+		seq_puts(seq, ",mba_MBps");
+
 	return 0;
 }
 
-- 
2.17.1

