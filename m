Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43187ECDFC0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFE620893
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFE620893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeIKWPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:15:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:31116 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbeIKWPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:15:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 10:14:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,361,1531810800"; 
   d="scan'208";a="79642220"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2018 10:14:58 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 6/6] x86/intel_rdt: Re-enable pseudo-lock measurements
Date:   Tue, 11 Sep 2018 10:14:37 -0700
Message-Id: <b0e79afd7832b5ebe3f2a2ebafc16dcf0b3f77dd.1536685533.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1536685533.git.reinette.chatre@intel.com>
References: <cover.1536685533.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1536685533.git.reinette.chatre@intel.com>
References: <cover.1536685533.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4a7a54a55e ("x86/intel_rdt: Disable PMU access") disabled
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
index 5a294fe080d7..e2bd212f382f 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -1226,7 +1226,7 @@ static ssize_t pseudo_lock_measure_trigger(struct file *file,
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

