Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613EEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297C62084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjHAeZbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297C62084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388723AbeKLJY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:24:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731094AbeKLIUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:10 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F712175B;
        Sun, 11 Nov 2018 22:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975413;
        bh=EOUa2nG/frBmhp9UCAp7jrY5Jjk7RdZ0LPZLP1Sjeyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjHAeZbsd7q2hCNNoqEGMjao4iwpetfZibawXyPmcLl35I+48HZ4K1REBaxYsGpSI
         rubqcy8GM201jjGZAQjfQdSr/eh/ceTni45GmBsOqsihlLwNBWdj3Su0z2Xgi0uh8Z
         LPQtuwb6kz+0lHatX2c99JBC4m2PExyoInlFsdaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaochen Shen <xiaochen.shen@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 095/350] x86/intel_rdt: Show missing resctrl mount options
Date:   Sun, 11 Nov 2018 14:19:19 -0800
Message-Id: <20181111221711.080452406@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2032,6 +2032,13 @@ static int rdtgroup_show_options(struct
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
 


