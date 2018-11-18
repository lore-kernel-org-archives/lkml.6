Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5210C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 02:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE9420817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 02:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE9420817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeKRNSi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 08:18:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:10749 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbeKRNSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 08:18:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2018 18:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,246,1539673200"; 
   d="scan'208";a="97144336"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Nov 2018 18:59:34 -0800
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 17 Nov 2018 18:59:32 -0800
Received: from orsmsx108.amr.corp.intel.com ([169.254.2.228]) by
 ORSMSX153.amr.corp.intel.com ([169.254.12.54]) with mapi id 14.03.0415.000;
 Sat, 17 Nov 2018 18:59:32 -0800
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: [GIT PULL] libnvdimm fixes for 4.20-rc3
Thread-Topic: [GIT PULL] libnvdimm fixes for 4.20-rc3
Thread-Index: AQHUfuq6M71Ai6RwMkyr/nzSXLRgEw==
Date:   Sun, 18 Nov 2018 02:59:31 +0000
Message-ID: <629da405d226a802394ba4e1cba4ff24b8589c85.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.136.215]
Content-Type: text/plain; charset="utf-7"
Content-ID: <D8CE84CF7D9CAC4F8D16492785FE0EF9@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-4.20-rc3

...to receive a small batch of fixes for v4.20-rc3.

These have soaked in -next for a few releases. The overflow
continuation fix addresses something that has been broken for several
releases. Arguably it could wait even longer, but it's a one line fix
and this finishes the last of the known address range scrub bug
reports. The revert addresses a lockdep regression. The unit tests are
not critical to fix, but no reason to hold this fix back.

---

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-4.20-rc3

for you to fetch changes up to 2121db09630113e67b51ae78c18115f1858f648a:

  Revert +ACI-acpi, nfit: Further restrict userspace ARS start requests+ACI- (2018-11-10 09:54:28 -0800)

----------------------------------------------------------------
libnvdimm 4.20-rc3

- Address Range Scrub overflow continuation handling has been broken
  since it was initially merged. It was only recently that error injection
  and platform-BIOS support enabled this corner case to be exercised.

- The recent attempt to provide more isolation for the kernel Address
  Range Scrub state machine from userapace initiated sessions triggers a
  lockdep report. Revert and try again at the next merge window.

- Fix a kasan reported buffer overflow in libnvdimm unit test
  infrastrucutre (nfit+AF8-test)

----------------------------------------------------------------
Dan Williams (2):
      acpi, nfit: Fix ARS overflow continuation
      Revert +ACI-acpi, nfit: Further restrict userspace ARS start requests+ACI-

Masayoshi Mizuma (1):
      tools/testing/nvdimm: Fix the array size for dimm devices.

 drivers/acpi/nfit/core.c         +AHw- 19 +-+-+-+-+---------------
 tools/testing/nvdimm/test/nfit.c +AHw-  8 +-+-+-+-----
 2 files changed, 9 insertions(+-), 18 deletions(-)
