Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C8AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D8C20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D8C20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbeKFE0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:26:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:23416 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387612AbeKFE0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:26:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 11:05:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,468,1534834800"; 
   d="scan'208";a="271567339"
Received: from cschaufl-mobl.amr.corp.intel.com ([10.254.103.117])
  by orsmga005.jf.intel.com with ESMTP; 05 Nov 2018 11:05:04 -0800
From:   Casey Schaufler <casey.schaufler@intel.com>
To:     kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        casey.schaufler@intel.com, dave.hansen@intel.com,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        arjan@linux.intel.com
Subject: [PATCH v6 0/5] LSM: Support ptrace sidechannel access checks
Date:   Mon,  5 Nov 2018 11:04:59 -0800
Message-Id: <20181105190504.500-1-casey.schaufler@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V6: Based on Tim Chen's "[Patch v4 00/18] Provide process property
    based options to enable Spectre v2 userspace-userspace protection*"
    patch set.
v5: Revamped to match Jiri Kosina <jkosina@suse.cz>
    Harden spectrev2 userspace-userspace protection v7
    Fixed locking issues in the LSM code.
    Dropped the new LSM hook and use a ptrace hook instead.
v4: select namespace checks if user namespaces are enabled
    and credential checks are request.
v3: get_task_cred wasn't a good choice due to refcounts.
    Use lower level protection instead
v2: SELinux access policy corrected.
    Use real_cred instead of cred.

This patchset provide a mechanism by which a security module
can advise the system about potential side-channel vulnerabilities.
The existing security modules have been updated to avoid locking
issues in the face of PTRACE_MODE_SCHED. A new security
module is provided to make determinations regarding task attributes
including namespaces.

Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
---
 include/linux/lsm_hooks.h          |  5 +++
 kernel/ptrace.c                    |  2 -
 security/Kconfig                   |  1 +
 security/Makefile                  |  2 +
 security/apparmor/domain.c         |  2 +-
 security/apparmor/include/ipc.h    |  2 +-
 security/apparmor/ipc.c            |  8 ++--
 security/apparmor/lsm.c            |  5 ++-
 security/commoncap.c               |  3 +-
 security/security.c                |  1 +
 security/selinux/hooks.c           |  2 +
 security/sidechannel/Kconfig       | 13 ++++++
 security/sidechannel/Makefile      |  1 +
 security/sidechannel/sidechannel.c | 88 ++++++++++++++++++++++++++++++++++++++
 security/smack/smack_lsm.c         |  3 +-
 15 files changed, 127 insertions(+), 11 deletions(-)
