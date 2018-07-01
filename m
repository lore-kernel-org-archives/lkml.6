Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D04C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 05:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311462521E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 05:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311462521E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeGAFRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 01:17:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:16836 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751535AbeGAFRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 01:17:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jun 2018 22:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,293,1526367600"; 
   d="scan'208";a="54226733"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga006.jf.intel.com with ESMTP; 30 Jun 2018 22:17:50 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 0/2] x86/intel_rdt: Display CPUs associated with pseudo-locked region
Date:   Sat, 30 Jun 2018 22:17:31 -0700
Message-Id: <cover.1530421961.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers,

The cpus and cpus_list resctrl files are locked down when the resource
group enters pseudo-locksetup mode and remains locked down when the
resource group transitions to pseudo-locked mode. This was done to ensure a
resource group in pseudo-locksetup mode is and remain unused until it
transitions to pseudo-locked mode.

With this series read (but not write) access is restored to the cpus and
cpus_list files after a resource group enters pseudo-locked mode. The
information displayed is also adjusted appropriately. It is now possible
for users to view which cpus are associated with a pseudo-locked region
through the existing cpus and cpus_list resctrl files. Only the tasks file
remains locked down.

For example:
# mount -t resctrl resctrl /sys/fs/resctrl
# cd /sys/fs/resctrl
# echo 'L2:1=0xfc' > schemata
# mkdir p1
# ls -l p1/cpus* p1/tasks
-rw-r--r-- 1 root root 0 Jun 30 06:30 p1/cpus
-rw-r--r-- 1 root root 0 Jun 30 06:30 p1/cpus_list
-rw-r--r-- 1 root root 0 Jun 30 06:30 p1/tasks
# echo pseudo-locksetup > p1/mode
# ls -l p1/cpus* p1/tasks
---------- 1 root root 0 Jun 30 06:30 p1/cpus
---------- 1 root root 0 Jun 30 06:30 p1/cpus_list
---------- 1 root root 0 Jun 30 06:30 p1/tasks
# echo 'L2:1=0x3' > p1/schemata
# ls -l p1/cpus* p1/tasks
-r--r--r-- 1 root root 0 Jun 30 06:30 p1/cpus
-r--r--r-- 1 root root 0 Jun 30 06:30 p1/cpus_list
---------- 1 root root 0 Jun 30 06:30 p1/tasks
# grep . p1/*
p1/cpus:c
p1/cpus_list:2-3
p1/mode:pseudo-locked
p1/schemata:L2:1=3
p1/size:L2:1=262144
grep: p1/tasks: Permission denied

Reinette Chatre (2):
  x86/intel_rdt: Support restoration of subset of permissions
  x86/intel_rdt: cpu information accessible for pseudo-locked regions

 Documentation/x86/intel_rdt_ui.txt          |  3 +++
 arch/x86/kernel/cpu/intel_rdt.h             |  3 ++-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 17 ++++++++++-------
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 14 ++++++++++----
 4 files changed, 25 insertions(+), 12 deletions(-)

-- 
2.17.0

