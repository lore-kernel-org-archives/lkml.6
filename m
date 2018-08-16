Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CADC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C3B2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 20:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C3B2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeHPXSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 19:18:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:43390 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbeHPXSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 19:18:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 13:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,248,1531810800"; 
   d="scan'208";a="225248293"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2018 13:16:34 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 6/6] x86/intel_rdt: Re-enable pseudo-lock measurements
Date:   Thu, 16 Aug 2018 13:16:09 -0700
Message-Id: <531fca4b63b3540df48274c634ab5f9a1ad54e85.1534450299.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1534450299.git.reinette.chatre@intel.com>
References: <cover.1534450299.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1534450299.git.reinette.chatre@intel.com>
References: <cover.1534450299.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Measurements of pseudo-locked regions were disabled because of their
incorrect usage of the performance monitoring hardware.

Cache pseudo-locking measurements are now done correctly with the
in-kernel perf API and its use can be re-enabled at this time.

The adjustment to the in-kernel perf API also separated the L2 and L3
measurements that can be triggered separately from user space.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index aa27e8081bae..ab371eb819fd 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -1332,7 +1332,7 @@ static ssize_t pseudo_lock_measure_trigger(struct file *file,
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

