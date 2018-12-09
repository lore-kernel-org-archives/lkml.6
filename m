Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5F4C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0064F2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0064F2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLIG0l convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:26:41 -0500
Received: from mga03.intel.com ([134.134.136.65]:36596 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbeLIG0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 01:26:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2018 22:26:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,333,1539673200"; 
   d="scan'208";a="128362305"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga001.fm.intel.com with ESMTP; 08 Dec 2018 22:26:40 -0800
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 8 Dec 2018 22:26:40 -0800
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.51]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.208]) with mapi id 14.03.0415.000;
 Sat, 8 Dec 2018 22:26:40 -0800
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: [GIT PULL] dax fixes for 4.20-rc6
Thread-Topic: [GIT PULL] dax fixes for 4.20-rc6
Thread-Index: AQHUj4gkXkR6rBtI0k+rccQjCGGCmw==
Date:   Sun, 9 Dec 2018 06:26:39 +0000
Message-ID: <6be0835bf256755375f3b5822bf70d74538d1d6e.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.6.38]
Content-Type: text/plain; charset="utf-7"
Content-ID: <28CE27909824804BA8532653A15FCF6F@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-4.20-rc6

...to receive the last of the known regression fixes and fallout from
the Xarray conversion of the filesystem-dax implementation. On the path
to debugging why the dax memory-failure injection test started failing
after the Xarray conversion a couple more fixes for the
dax+AF8-lock+AF8-mapping+AF8-entry(), now called dax+AF8-lock+AF8-page(), surfaced. Those
plus the bug that started the hunt are now addressed. These patches
have appeared in a -next release with no issues reported.

Note the touches to mm/memory-failure.c are just the conversion to the
new function signature for dax+AF8-lock+AF8-page().

---

The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-4.20-rc6

for you to fetch changes up to 27359fd6e5f3c5db8fe544b63238b6170e8806d8:

  dax: Fix unlock mismatch with updated API (2018-12-04 21:32:00 -0800)

----------------------------------------------------------------
dax fixes 4.20-rc6

+ACo- Fix the Xarray conversion of fsdax to properly handle
dax+AF8-lock+AF8-mapping+AF8-entry() in the presense of pmd entries.

+ACo- Fix inode destruction racing a new lock request.

----------------------------------------------------------------
Matthew Wilcox (3):
      dax: Check page-+AD4-mapping isn't NULL
      dax: Don't access a freed inode
      dax: Fix unlock mismatch with updated API

 fs/dax.c            +AHw- 55 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+------------------
 include/linux/dax.h +AHw- 14 +-+-+-+-+-+-+-+-------
 mm/memory-failure.c +AHw-  6 +-+-+-+---
 3 files changed, 50 insertions(+-), 25 deletions(-)
