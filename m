Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8B8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549A12080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549A12080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbeKAGHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:07:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:6767 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbeKAGHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:07:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 14:07:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,449,1534834800"; 
   d="scan'208";a="102369361"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 31 Oct 2018 14:07:17 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 0/8] selftests/resctrl: Add resctrl selftest
Date:   Wed, 31 Oct 2018 14:02:26 -0700
Message-Id: <1541019754-192204-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With more and more resctrl features are being added by Intel, AMD
and ARM, a test tool is becoming more and more useful to validate
that both hardware and software functionalities work as expected.

We introduce resctrl selftest to cover resctrl features on both
X86 and ARM architectures. It first implements MBM (Memory Bandwidth
Monitoring) and MBA (Memory Bandwidth Allocation) tests. We can enhance
the selftest tool to include more functionality tests in future.

There is an existing resctrl test suit 'intel_cmt_cat'. But the major
purpose of the tool is to test Intel(R) RDT hardware via writing and
reading MSR registers. It does access resctrl file system; but the
functionalities are very limited. And it doesn't support automatic test
and a lot of manual verifications are involved.

So the selftest tool we are introducing here provides a convenient
tool which does automatic resctrl testing, is easily available in kernel
tree, and will be extended to AMD QoS and ARM MPAM.

The selftest tool is in tools/testing/selftests/resctrl in order to have
generic test code for all architectures.

Changelog:
v3:
- Change code based on comments from Babu Moger
- Remove some unnessary code and use pipe to communicate b/w processes

v2:
- Change code based on comments from Babu Moger
- Clean up other places.

Arshiya Hayatkhan Pathan (2):
  selftests/resctrl: Add MBM test
  selftests/resctrl: Add MBA test

Fenghua Yu (2):
  selftests/resctrl: Add README for resctrl tests
  selftests/resctrl: Add the test in MAINTAINERS

Sai Praneeth Prakhya (4):
  selftests/resctrl: Add basic resctrl file system operations and data
  selftests/resctrl: Read memory bandwidth from perf IMC counter and
    from resctrl file system
  selftests/resctrl: Add callback to start a benchmark
  selftests/resctrl: Add built in benchmark

 MAINTAINERS                                     |   1 +
 tools/testing/selftests/resctrl/Makefile        |  16 +
 tools/testing/selftests/resctrl/README          |  53 ++
 tools/testing/selftests/resctrl/fill_buf.c      | 175 ++++++
 tools/testing/selftests/resctrl/mba_test.c      | 173 ++++++
 tools/testing/selftests/resctrl/mbm_test.c      | 145 +++++
 tools/testing/selftests/resctrl/membw.c         | 705 ++++++++++++++++++++++++
 tools/testing/selftests/resctrl/resctrl.h       |  79 +++
 tools/testing/selftests/resctrl/resctrl_tests.c | 136 +++++
 tools/testing/selftests/resctrl/resctrlfs.c     | 454 +++++++++++++++
 10 files changed, 1937 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/Makefile
 create mode 100644 tools/testing/selftests/resctrl/README
 create mode 100644 tools/testing/selftests/resctrl/fill_buf.c
 create mode 100644 tools/testing/selftests/resctrl/mba_test.c
 create mode 100644 tools/testing/selftests/resctrl/mbm_test.c
 create mode 100644 tools/testing/selftests/resctrl/membw.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl.h
 create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c
 create mode 100644 tools/testing/selftests/resctrl/resctrlfs.c

-- 
2.5.0

