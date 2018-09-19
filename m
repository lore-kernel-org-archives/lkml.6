Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA99ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379E521533
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379E521533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbeISXI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:08:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:33317 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731762AbeISXI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:08:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 10:30:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,394,1531810800"; 
   d="scan'208";a="87551439"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga002.fm.intel.com with ESMTP; 19 Sep 2018 10:30:02 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V5 6/6] x86/intel_rdt: Re-enable pseudo-lock measurements
Date:   Wed, 19 Sep 2018 10:29:11 -0700
Message-Id: <bfb9fc31692e0c62d9ca39062e55eceb6a0635b5.1537377064.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1537377064.git.reinette.chatre@intel.com>
References: <cover.1537377064.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1537377064.git.reinette.chatre@intel.com>
References: <cover.1537377064.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4a7a54a55e72 ("x86/intel_rdt: Disable PMU access") disabled
measurements of pseudo-locked regions because of incorrect usage
of the performance monitoring hardware.

Cache pseudo-locking measurements are now done correctly with the
in-kernel perf API and its use can be re-enabled at this time.

The adjustment to the in-kernel perf API also separated the L2 and L3
measurements that can be triggered separately from user space. The
re-enabling of the measurements is thus not a simple revert of the
original disable in order to accommodate the additional parameter
possible.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index c35b975e3b1e..edf30c94c226 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -1237,7 +1237,7 @@ static ssize_t pseudo_lock_measure_trigger(struct file *file,
 	buf[buf_size] = '\0';
 	ret = kstrtoint(buf, 10, &sel);
 	if (ret == 0) {
-		if (sel != 1)
+		if (sel != 1 && sel != 2 && sel != 3)
 			return -EINVAL;
 		ret = debugfs_file_get(file->f_path.dentry);
 		if (ret)
-- 
2.17.0

