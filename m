Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317A0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DEF2150C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DEF2150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeI0BPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:15:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:64733 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbeI0BPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:15:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 12:00:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="76436979"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga008.jf.intel.com with ESMTP; 26 Sep 2018 12:00:39 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc:     jithu.joseph@intel.com, gavin.hindman@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 0/3] x86/intel_rdt: Fix exclusive mode with CDP resources
Date:   Wed, 26 Sep 2018 11:59:42 -0700
Message-Id: <cover.1537987801.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainers,

CDP resources do not currently behave as expected when there are resource
groups with mode 'exclusive'.

In the example below it was possible to create two resource groups,
p1 and p2, that are both in exclusive mode but their usage of the
underlying L2 cache actually overlaps.

root@glk:/sys/fs/resctrl# ls
cpus  cpus_list  info  mode  p1  p2  schemata  size  tasks
root@glk:/sys/fs/resctrl# cat schemata
L2DATA:0=fff0
L2CODE:0=fff0
root@glk:/sys/fs/resctrl# cat mode
shareable

root@glk:/sys/fs/resctrl# cat p1/schemata
L2DATA:0=0003
L2CODE:0=000c
root@glk:/sys/fs/resctrl# cat p1/mode
exclusive

root@glk:/sys/fs/resctrl# cat p2/schemata
L2DATA:0=000c
L2CODE:0=0003
root@glk:/sys/fs/resctrl# cat p2/mode
exclusive

root@glk:/sys/fs/resctrl# cat info/L2CODE/bit_usage
0=SSSSSSSSSSSSEEEE
root@glk:/sys/fs/resctrl# cat info/L2DATA/bit_usage
0=SSSSSSSSSSSSEEEE
root@glk:/sys/fs/resctrl#

In the above example, the CBM of L2DATA in p1 overlaps with the CBM of
L2CODE in p2 while they are both in exclusive mode. While it may reflect no
overlap among the L2DATA resources specifically it does actually imply
overlap of use of the underlying hardware that is not the intention of
'exclusive' mode. This happens because the current implementation treats
L2CODE and L2DATA as totally independent, when it is actually referring to
the same underlying hardware.

This series fixes the potential for overlap of hardware resource use when
resource groups are in 'exclusive' mode by ensuring that if there is a CDP
peer on the same hardware then any overlap test would consider it also.

Allocations of data and code resources within the same exclusive resource
group are allowed to overlap.

Your feedback will be greatly appreciated.

Reinette

Reinette Chatre (3):
  x86/intel_rdt: Introduce utility to obtain CDP peer
  x86/intel_rdt: CBM overlap should also check for overlap with CDP peer
  x86/intel_rdt: Fix initial allocation to consider CDP

 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 133 ++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 5 deletions(-)

-- 
2.17.0

