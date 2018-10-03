Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3525C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0631213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0631213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJDFI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:08:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:62846 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbeJDFI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:08:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 15:18:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,337,1534834800"; 
   d="scan'208";a="91965083"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2018 15:17:41 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc:     jithu.joseph@intel.com, gavin.hindman@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 0/3] x86/intel_rdt: Fix exclusive mode with CDP resources
Date:   Wed,  3 Oct 2018 15:17:00 -0700
Message-Id: <cover.1538603665.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V2:
- Have the new rdt_cdp_peer_get() return EINVAL instead of ENOENT when
  only one of the CDP peers have a rdt_domain associated with it.
- Rename _rdtgroup_cbm_overlaps() to __rdtgroup_cbm_overlaps() to stand out
  more.
- Fix kernel-doc to match function parameter name.
- Rename rdtgroup_cbm_overlaps()'s _cbm function parameter to cbm.
- Simplify the code in rdtgroup_cbm_overlaps() to make the flow more
  obvious.

Nothing (apart from diffstat) changed below since original submission.

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
 1 file changed, 127 insertions(+), 6 deletions(-)

-- 
2.17.0

