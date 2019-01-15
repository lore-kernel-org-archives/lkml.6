Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC606C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9783620651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfAOCJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:09:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:21459 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfAOCJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 21:09:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 18:09:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,480,1539673200"; 
   d="scan'208";a="127756151"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2019 18:09:40 -0800
Subject: [PATCH v2 0/2] acpi/nfit: Fix command-supported detection
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     stable@vger.kernel.org, stuart hayes <stuart.w.hayes@gmail.com>,
        Sujith Pandel <sujith_pandel@dell.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com
Date:   Mon, 14 Jan 2019 17:57:04 -0800
Message-ID: <154751742416.1617064.8252289468130584022.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1 [1]:
* Include another patch make sure that function-number zero can be
  safely used as an invalid function number (Jeff)
* Add a comment clarifying why zero is an invalid function number (Jeff)
* Pass nfit_mem to cmd_to_func() (Jeff)
* Collect a Tested-by from Sujith
[1]: https://lists.01.org/pipermail/linux-nvdimm/2019-January/019435.html

---

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


 drivers/acpi/nfit/core.c |   53 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 14 deletions(-)
