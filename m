Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6B6C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED7621502
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED7621502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbeHPCs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:48:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:61123 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbeHPCs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:48:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2018 16:53:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,245,1531810800"; 
   d="scan'208";a="75694058"
Received: from cschaufl-mobl.amr.corp.intel.com ([10.252.130.105])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2018 16:53:56 -0700
From:   Casey Schaufler <casey.schaufler@intel.com>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        SMACK-discuss@lists.01.org, casey.schaufler@intel.com,
        dave.hansen@intel.com, deneen.t.dock@intel.com,
        kristen@linux.intel.com, arjan@linux.intel.com
Subject: [PATCH RFC 0/5] LSM: Add and use a hook for side-channel safety checks
Date:   Wed, 15 Aug 2018 16:53:50 -0700
Message-Id: <20180815235355.14908-1-casey.schaufler@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset provide a mechanism by which a security module
can advise the system about potential side-channel vulnerabilities.
If security_task_safe_sidechannel() returns 0 the security modules do
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
