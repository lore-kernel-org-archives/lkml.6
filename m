Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85825C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4896A20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4896A20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbeISDTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:19:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43255 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeISDTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:19:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8ILiXcg930153
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Sep 2018 14:44:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8ILiXIb930150;
        Tue, 18 Sep 2018 14:44:33 -0700
Date:   Tue, 18 Sep 2018 14:44:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-47d53b184aee983ab9492503da11b0a81b19145b@git.kernel.org>
Cc:     hpa@zytor.com, reinette.chatre@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, yu.c.chen@intel.com,
        tony.luck@intel.com, xiaochen.shen@intel.com, fenghua.yu@intel.com,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          reinette.chatre@intel.com, hpa@zytor.com, mingo@kernel.org,
          fenghua.yu@intel.com, xiaochen.shen@intel.com,
          tony.luck@intel.com, yu.c.chen@intel.com
In-Reply-To: <1537048707-76280-5-git-send-email-fenghua.yu@intel.com>
References: <1537048707-76280-5-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/intel_rdt: Fix invalid mode warning when
 multiple resources are managed
Git-Commit-ID: 47d53b184aee983ab9492503da11b0a81b19145b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  47d53b184aee983ab9492503da11b0a81b19145b
Gitweb:     https://git.kernel.org/tip/47d53b184aee983ab9492503da11b0a81b19145b
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Sat, 15 Sep 2018 14:58:22 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Sep 2018 23:38:05 +0200

x86/intel_rdt: Fix invalid mode warning when multiple resources are managed

When multiple resources are managed by RDT, the number of CLOSIDs used
is the minimum of the CLOSIDs supported by each resource. In the function
rdt_bit_usage_show(), the annotated bitmask is created to depict how the
CAT supporting caches are being used. During this annotated bitmask
creation, each resource group is queried for its mode that is used as a
label in the annotated bitmask.

The maximum number of resource groups is currently assumed to be the
number of CLOSIDs supported by the resource for which the information is
being displayed. This is incorrect since the number of active CLOSIDs is
the minimum across all resources.

If information for a cache instance with more CLOSIDs than another is
being generated we thus encounter a warning like:

invalid mode for closid 8
WARNING: CPU: 88 PID: 1791 at [SNIP]/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
:827 rdt_bit_usage_show+0x221/0x2b0

Fix this by ensuring that only the number of supported CLOSIDs are
considered.

Fixes: e651901187ab8 ("x86/intel_rdt: Introduce "bit_usage" to display cache allocations details")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Tony Luck" <tony.luck@intel.com>
Cc: "Xiaochen Shen" <xiaochen.shen@intel.com>
Cc: "Chen Yu" <yu.c.chen@intel.com>
Link: https://lkml.kernel.org/r/1537048707-76280-5-git-send-email-fenghua.yu@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index b372923eb209..ea91750ba27f 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -809,7 +809,7 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 		sw_shareable = 0;
 		exclusive = 0;
 		seq_printf(seq, "%d=", dom->id);
-		for (i = 0; i < r->num_closid; i++, ctrl++) {
+		for (i = 0; i < closids_supported(); i++, ctrl++) {
 			if (!closid_allocated(i))
 				continue;
 			mode = rdtgroup_mode_by_closid(i);
