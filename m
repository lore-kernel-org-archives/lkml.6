Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE27C282C4
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 02:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCA021929
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 02:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfBJC51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 21:57:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:14368 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfBJC51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 21:57:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2019 18:57:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,353,1544515200"; 
   d="scan'208";a="319090702"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga005.fm.intel.com with ESMTP; 09 Feb 2019 18:57:26 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v7 00/13] selftests/resctrl: Add resctrl selftest
Date:   Sat,  9 Feb 2019 18:50:29 -0800
Message-Id: <1549767042-95827-1-git-send-email-fenghua.yu@intel.com>
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
Monitoring), MBA (Memory Bandwidth Allocation), L3 CAT (Cache Allocation
Technology), and CQM (Cache QoS Monitoring)  tests. We can enhance
the selftest tool to include more functionality tests in future.

The tool has been tested on both Intel RDT and AMD QoS.

There is an existing resctrl test suite 'intel_cmt_cat'. But the major
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
v7:
- Fix a few warnings when compiling patches separately, pointed by Babu 

v6:
- Fix a benchmark reading optimized out issue in newer GCC.
- Fix a few coding style issues.
- Re-arrange code among patches to make cleaner code. No change in patches
structure.

v5:
- Based the v4 patches submitted by Fenghua Yu and added changes to support
  AMD.
- Changed the function name get_sock_num to get_resource_id. Intel uses
  socket number for schemata and AMD uses l3 index id. To generalize,
  changed the function name to get_resource_id.
- Added the code to detect vendor.
- Disabled the few tests for AMD where the test results are not clear.
  Also AMD does not have IMC.
- Fixed few compile issues.
- Some cleanup to make each patch independent.
- Tested the patches on AMD system. Fenghua, Need your help to test on
  Intel box. Please feel free to change and resubmit if something
   broken.
- Here is the link for previous version.
  https://lore.kernel.org/lkml/1545438038-75107-1-git-send-email-fenghua.yu=
@intel.com/

v4:
- address comments from Balu and Randy
- Add CAT and CQM tests

v3:
- Change code based on comments from Babu Moger
- Remove some unnessary code and use pipe to communicate b/w processes

v2:
- Change code based on comments from Babu Moger
- Clean up other places.

Arshiya Hayatkhan Pathan (4):
  selftests/resctrl: Add MBM test
  selftests/resctrl: Add MBA test
  selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest
  selftests/resctrl: Add Cache Allocation Technology (CAT) selftest

Babu Moger (3):
  selftests/resctrl: Add vendor detection mechanism
  selftests/resctrl: Use cache index3 id for AMD schemata masks
  selftests/resctrl: Disable MBA and MBM tests for AMD

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
 tools/testing/selftests/resctrl/README          |  54 ++
 tools/testing/selftests/resctrl/cache.c         | 274 +++++++++
 tools/testing/selftests/resctrl/cat_test.c      | 242 ++++++++
 tools/testing/selftests/resctrl/cqm_test.c      | 173 ++++++
 tools/testing/selftests/resctrl/fill_buf.c      | 210 +++++++
 tools/testing/selftests/resctrl/mba_test.c      | 178 ++++++
 tools/testing/selftests/resctrl/mbm_test.c      | 150 +++++
 tools/testing/selftests/resctrl/resctrl.h       | 117 ++++
 tools/testing/selftests/resctrl/resctrl_tests.c | 238 ++++++++
 tools/testing/selftests/resctrl/resctrl_val.c   | 723 ++++++++++++++++++++++++
 tools/testing/selftests/resctrl/resctrlfs.c     | 668 ++++++++++++++++++++++
 13 files changed, 3044 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/Makefile
 create mode 100644 tools/testing/selftests/resctrl/README
 create mode 100644 tools/testing/selftests/resctrl/cache.c
 create mode 100644 tools/testing/selftests/resctrl/cat_test.c
 create mode 100644 tools/testing/selftests/resctrl/cqm_test.c
 create mode 100644 tools/testing/selftests/resctrl/fill_buf.c
 create mode 100644 tools/testing/selftests/resctrl/mba_test.c
 create mode 100644 tools/testing/selftests/resctrl/mbm_test.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl.h
 create mode 100644 tools/testing/selftests/resctrl/resctrl_tests.c
 create mode 100644 tools/testing/selftests/resctrl/resctrl_val.c
 create mode 100644 tools/testing/selftests/resctrl/resctrlfs.c

-- 
2.7.4

