Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FE5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B345D219CD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B345D219CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeHRBVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 21:21:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:58247 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbeHRBVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 21:21:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Aug 2018 15:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,253,1531810800"; 
   d="scan'208";a="67079607"
Received: from cschaufl-mobl.amr.corp.intel.com ([10.254.9.75])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2018 15:16:24 -0700
From:   Casey Schaufler <casey.schaufler@intel.com>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        casey.schaufler@intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        arjan@linux.intel.com
Subject: [PATCH RFC v2 0/5] LSM: Add and use a hook for side-channel safety checks
Date:   Fri, 17 Aug 2018 15:16:19 -0700
Message-Id: <20180817221624.10232-1-casey.schaufler@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 security/selinux/hooks.c           |   9 +++
 security/sidechannel/Kconfig       |  60 ++++++++++++++
 security/sidechannel/Makefile      |   1 +
 security/sidechannel/sidechannel.c | 156 +++++++++++++++++++++++++++++++++++++
 security/smack/smack_lsm.c         |  18 +++++
 12 files changed, 280 insertions(+), 4 deletions(-)
