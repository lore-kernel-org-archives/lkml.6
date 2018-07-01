Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB4DC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 05:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EAE25189
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 05:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EAE25189
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeGAFDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 01:03:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:48739 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751136AbeGAFDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 01:03:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jun 2018 22:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,293,1526367600"; 
   d="scan'208";a="241698242"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2018 22:03:20 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 0/2] x86/intel_rdt: Fix cache pseudo-locking error path cleanup
Date:   Sat, 30 Jun 2018 22:03:01 -0700
Message-Id: <cover.1530421026.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers,

A bug exists in the error handling code during pseudo-lock region creation.
When an error occurs early during pseudo-lock region creation the
pseudo_lock_region struct is not cleaned up properly but remains associated
with the resource group (since it remains in pseudo-locksetup mode).
This partially initialized struct causes problems when other areas
need to obtain resource group data - when partially initialized the
resource group is treated as a pseudo-locked region.

Following is an example of the error being encountered. First a
pseudo-locked region of larger than 4MB is attempted. This fails early
because of lack for support. Since this is not cleaned up properly,
a subsequent attempt fails because it is (incorrectly) believed that
a pseudo-locked region already exists, also the bit_usage file
reports incorrect data.

# mount -t resctrl resctrl /sys/fs/resctrl
# cd /sys/fs/resctrl/
# mkdir p1
# echo 'L3:1=0xffff0' > schemata
# echo pseudo-locksetup > p1/mode
# echo 'L3:1=0xf' > p1/schemata
-bash: echo: write error: Argument list too long
# cat info/last_cmd_status
requested region exceeds maximum size
# echo 'L3:1=0x1' > p1/schemata
-bash: echo: write error: Invalid argument
# cat info/last_cmd_status
pseudo-locked region in hierarchy
# cat info/L3/bit_usage
0=XXSSSSSSSSSSSSSSSSSS;1=XXSSSSSSSSSSSSSSPPPP

After the fixes in this series have been applied:
# mount -t resctrl resctrl /sys/fs/resctrl/
# cd /sys/fs/resctrl/
# mkdir p1
# echo pseudo-locksetup > p1/mode
# echo 'L3:1=0xffff0' > schemata
# echo 'L3:1=0xf' > p1/schemata
-bash: echo: write error: Argument list too long
# cat info/last_cmd_status
requested region exceeds maximum size
# cat info/L3/bit_usage
0=XXSSSSSSSSSSSSSSSSSS;1=XXSSSSSSSSSSSSSS0000
# echo 'L3:1=0x1' > p1/schemata
# cat info/L3/bit_usage
0=XXSSSSSSSSSSSSSSSSSS;1=XXSSSSSSSSSSSSSS000P


Reinette Chatre (2):
  x86/intel_rdt: Move pseudo_lock_region_clear
  x86/intel_rdt: Fix cleanup of plr structure on error

 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 68 ++++++++++++---------
 1 file changed, 40 insertions(+), 28 deletions(-)

-- 
2.17.0

