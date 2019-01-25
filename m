Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165D9C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D885E2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfAYT7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:59:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:12806 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfAYT7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:59:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 11:59:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,522,1539673200"; 
   d="scan'208";a="117510317"
Received: from agluck-desk.sc.intel.com ([10.3.52.160])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jan 2019 11:59:02 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] EDAC driver for Jacobsville microserver
Date:   Fri, 25 Jan 2019 11:58:58 -0800
Message-Id: <20190125195902.17109-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver can share a lot of the code from the Skylake driver. But
instead of turning that driver into a maze of twisty function pointers
as we did to share sb_edac.c across several generations we are taking
a different approach. Splitting out the common code into a source file
that can be linked with each driver (when they are modules) or built in
to kernel if the drivers are built in.

Four patches in the series (only part 3 of interest to general LKML audience)

1) Create new files skx_comm_edac.[ch] with all the common functions and
   #defines.
2) Delete all that common code from skx_edac.c an rename what is left as
   skx_base.c. Update Makefile to build driver from common+base.
3) New CPU model number for Jacobsville.
4) Add new EDAC driver for Jacobsville.

Kan Liang (1):
  x86: intel-family.h: Add Atom Tremont (Jacobsville)

Qiuxu Zhuo (3):
  EDAC, skx_comm_edac: Separate common codes from the skx_edac driver
  EDAC, skx_edac: Delete the duplicated codes
  EDAC, i10nm_edac: Add EDAC driver for Intel 10nm server processors

 arch/x86/include/asm/intel-family.h |    3 +-
 drivers/edac/Kconfig                |   12 +
 drivers/edac/Makefile               |    7 +-
 drivers/edac/i10nm_base.c           |  279 ++++++
 drivers/edac/skx_base.c             |  673 +++++++++++++
 drivers/edac/skx_comm_edac.c        |  693 ++++++++++++++
 drivers/edac/skx_comm_edac.h        |  158 ++++
 drivers/edac/skx_edac.c             | 1358 ---------------------------
 8 files changed, 1823 insertions(+), 1360 deletions(-)
 create mode 100644 drivers/edac/i10nm_base.c
 create mode 100644 drivers/edac/skx_base.c
 create mode 100644 drivers/edac/skx_comm_edac.c
 create mode 100644 drivers/edac/skx_comm_edac.h
 delete mode 100644 drivers/edac/skx_edac.c

-- 
2.19.1

