Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB8AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DEF208EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DEF208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeHYCSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:18:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:59921 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbeHYCSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:18:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Aug 2018 15:41:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,284,1531810800"; 
   d="scan'208";a="84307210"
Received: from cschaufl-mobl.amr.corp.intel.com ([10.254.2.129])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2018 15:41:17 -0700
From:   Casey Schaufler <casey.schaufler@intel.com>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        casey.schaufler@intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        arjan@linux.intel.com
Subject: [PATCH v4 0/5] LSM: Add and use a hook for side-channel safety checks
Date:   Fri, 24 Aug 2018 15:41:12 -0700
Message-Id: <20180824224117.3356-1-casey.schaufler@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4: select namespace checks if user namespaces are enabled
    and credential checks are request.
v3: get_task_cred wasn't a good choice due to refcounts.
    Use lower level protection instead
v2: SELinux access policy corrected.
    Use real_cred instead of cred.

This patchset provide a mechanism by which a security module
can advise the system about potential side-channel vulnerabilities.
If security_safe_sidechannel() returns 0 the security modules do
not know of any data that would be subject to a side-channel
attack. If the security module maintains data that it believes
may be susceptible to a side-channel attack it will return -EACCES.

Simple hooks are provided for SELinux and Smack. A new security
module is provided to make determinations regarding traditional
task attributes, including user IDs, capability sets and namespaces.

Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>

---
 MAINTAINERS                        |   6 ++
 arch/x86/mm/tlb.c                  |  12 ++-
 include/linux/lsm_hooks.h          |  12 +++
 include/linux/security.h           |   1 +
 security/Kconfig                   |   1 +
 security/Makefile                  |   2 +
 security/security.c                |   6 ++
 security/selinux/hooks.c           |   9 ++
 security/sidechannel/Kconfig       |  65 +++++++++++++
 security/sidechannel/Makefile      |   1 +
 security/sidechannel/sidechannel.c | 184 +++++++++++++++++++++++++++++++++++++
 security/smack/smack_lsm.c         |  18 ++++
 12 files changed, 313 insertions(+), 4 deletions(-)
