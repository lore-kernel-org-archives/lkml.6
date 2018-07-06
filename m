Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F614C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2515C23FBE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2515C23FBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933464AbeGFQSZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:18:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:32689 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932483AbeGFQSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:18:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jul 2018 09:18:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,316,1526367600"; 
   d="scan'208";a="54551860"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2018 09:17:53 -0700
Subject: [PATCH v2 0/2] x86/numa_emulation: Introduce uniform split
 capability
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@kernel.org
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        David Rientjes <rientjes@google.com>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Fri, 06 Jul 2018 09:07:55 -0700
Message-ID: <153089327581.27680.11402583130804677094.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1 [1]:
* Fix a pair of compile errors in 32-bit builds for 64-bit divides.

[1]: https://lkml.org/lkml/2018/5/26/190

---

The current numa emulation capabilities for splitting System RAM by a
fixed size or by a set number of nodes may result in some nodes being
larger than others. The implementation prioritizes establishing a
minimum usable memory size over satisfying the requested number of numa
nodes.

Introduce a uniform split capability that evenly partitions each
physical numa node into N emulated nodes. For example numa=fake=3U
creates 6 emulated nodes total on a system that has 2 physical nodes.

This capability is useful for debugging and evaluating platform
memory-side-cache capabilities as described by the ACPI HMAT (see
5.2.27.5 Memory Side Cache Information Structure in ACPI 6.2a)

See more details in patch2.

---

Dan Williams (2):
      x86/numa_emulation: Fix emulated-to-physical node mapping
      x86/numa_emulation: Introduce uniform split capability


 Documentation/x86/x86_64/boot-options.txt |    4 +
 arch/x86/mm/numa_emulation.c              |  107 ++++++++++++++++++++++++-----
 2 files changed, 91 insertions(+), 20 deletions(-)
