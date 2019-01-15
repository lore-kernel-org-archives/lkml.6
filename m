Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D632C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0572A214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391189AbfAOWqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:46:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:38348 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729846AbfAOWqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:46:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2019 14:46:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,483,1539673200"; 
   d="scan'208";a="118785411"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2019 14:46:33 -0800
Subject: [PATCH v3 0/2] acpi/nfit: Fix command-supported detection
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, stuart hayes <stuart.w.hayes@gmail.com>,
        Sujith Pandel <sujith_pandel@dell.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com
Date:   Tue, 15 Jan 2019 14:33:56 -0800
Message-ID: <154759163682.1953028.16995572958827750312.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2 [1]:
* Don't allow ND_CMD_CALL to bypass dsm_mask restrictions (Jeff)

[1]: https://lists.01.org/pipermail/linux-nvdimm/2019-January/019498.html

---

One last resend to make sure all the last bits of thrash have settled.

Quote patch2 changelog:

The _DSM function number validation only happens to succeed when the
generic Linux command number translation corresponds with a
DSM-family-specific function number. This breaks NVDIMM-N
implementations that correctly implement _LSR, _LSW, and _LSI, but do
not happen to publish support for DSM function numbers 4, 5, and 6.

Recall that the support for _LS{I,R,W} family of methods results in the
DIMM being marked as supporting those command numbers at
acpi_nfit_register_dimms() time. The DSM function mask is only used for
ND_CMD_CALL support of non-NVDIMM_FAMILY_INTEL devices.

---

Dan Williams (2):
      acpi/nfit: Block function zero DSMs
      acpi/nfit: Fix command-supported detection


 drivers/acpi/nfit/core.c |   59 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 14 deletions(-)
