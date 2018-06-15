Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 11106C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB44220896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 00:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB44220896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965404AbeFOArQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 20:47:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:44122 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965218AbeFOArN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 20:47:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 17:47:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="63313360"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2018 17:47:11 -0700
Subject: [PATCH 0/3] libvdimm: Support namespace enumeration while locked
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 Jun 2018 17:37:14 -0700
Message-ID: <152902303439.10541.13027910074116606464.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NVDIMM_FAMILY_INTEL DSM path for manipulating labels explicitly
allows reading the namespace label area while the DIMM is locked. In
contrast the ACPI _LSR method for reading labels only indicates if the
label area is locked and returns no data.

It naturally follows that if the namespace label area is locked, the
DIMM is locked since the driver is prevented from discovering namespace
boundaries.

On platforms where both mechanisms are available, prefer the
NVDIMM_FAMILY_INTEL implementation and support enumerating namespace
boundaries while the DIMM is locked.

In addition to ACPI capability detection and the libnvdimm core change
to fail probe of locked namespaces, provide a capability to inject this
semantic difference via nfit_test.

---

Dan Williams (3):
      libnvdimm: Introduce locked DIMM capacity support
      acpi, nfit: Prefer _DSM over _LSR for namespace label reads
      tools/testing/nvdimm: Make DSM failure code injection an override


 drivers/acpi/nfit/core.c         |   12 +++++++++
 drivers/nvdimm/dimm.c            |   24 +++++++++++++++++--
 drivers/nvdimm/namespace_devs.c  |   23 ++++++++++++++++++
 drivers/nvdimm/nd.h              |    1 +
 tools/testing/nvdimm/test/nfit.c |   49 +++++++++++++++++++++++++-------------
 5 files changed, 89 insertions(+), 20 deletions(-)
