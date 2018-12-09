Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDED4C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9660920837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9660920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeLIGSE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:18:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:15557 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbeLIGSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 01:18:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2018 22:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,333,1539673200"; 
   d="scan'208";a="128361314"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga001.fm.intel.com with ESMTP; 08 Dec 2018 22:18:03 -0800
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 8 Dec 2018 22:18:03 -0800
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.51]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.49]) with mapi id 14.03.0415.000;
 Sat, 8 Dec 2018 22:18:03 -0800
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: [GIT PULL] libnvdimm fixes for 4.20-rc6
Thread-Topic: [GIT PULL] libnvdimm fixes for 4.20-rc6
Thread-Index: AQHUj4bwAJOajnoimEK3c86q2ci1EQ==
Date:   Sun, 9 Dec 2018 06:18:02 +0000
Message-ID: <705f91734ecb4ffbddb2470a797541c876745c6e.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.6.38]
Content-Type: text/plain; charset="utf-7"
Content-ID: <103E65E7473D4945B0049B4CE4477988@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-4.20-rc6

...to receive a regression fix for the Address Range Scrub
implementation, yes another one, and support for platforms that
misalign persistent memory relative to the Linux memory hotplug section
constraint. Longer term, support for sub-section memory hotplug would
alleviate alignment waste, but until then this hack allows a 'struct
page' memmap to be established for these misaligned memory regions.

These have all appeared in a -next release, and thanks to Patrick for
reporting and testing the alignment padding fix.

---

The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:

  Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-4.20-rc6

for you to fetch changes up to b5fd2e00a60248902315fb32210550ac3cb9f44c:

  acpi/nfit: Fix user-initiated ARS to be +ACI-ARS-long+ACI- rather than +ACI-ARS-short+ACI- (2018-12-05 14:16:13 -0800)

----------------------------------------------------------------
libnvdimm fixes 4.20-rc6

+ACo- Unless and until the core mm handles memory hotplug units smaller than
  a section (128M), persistent memory namespaces must be padded to
  section alignment. The libnvdimm core already handled section
  collision with +ACI-System RAM+ACI-, but some configurations overlap
  independent +ACI-Persistent Memory+ACI- ranges within a section, so additional
  padding injection is added for that case.

+ACo- The recent reworks of the ARS (address range scrub) state machine to
  reduce the number of state flags inadvertantly missed a conversion of
  acpi+AF8-nfit+AF8-ars+AF8-rescan() call sites. Fix the regression whereby
  user-requested ARS results in a +ACI-short+ACI- scrub rather than a +ACI-long+ACI-
  scrub.

+ACo- Fixup the unit tests to handle / test the 128M section alignment of
  mocked test resources.

----------------------------------------------------------------
Dan Williams (3):
      tools/testing/nvdimm: Align test resources to 128M
      libnvdimm, pfn: Pad pfn namespaces relative to other regions
      acpi/nfit: Fix user-initiated ARS to be +ACI-ARS-long+ACI- rather than +ACI-ARS-short+ACI-

 drivers/acpi/nfit/core.c         +AHw-  2 +--
 drivers/nvdimm/nd-core.h         +AHw-  2 +-+-
 drivers/nvdimm/pfn+AF8-devs.c        +AHw- 64 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+------------------
 drivers/nvdimm/region+AF8-devs.c     +AHw- 41 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
 tools/testing/nvdimm/test/nfit.c +AHw- 35 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+---
 5 files changed, 114 insertions(+-), 30 deletions(-)
