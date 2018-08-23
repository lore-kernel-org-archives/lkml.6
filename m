Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B771C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF8B208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF8B208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388018AbeHWMVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:21:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51922 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbeHWMVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:21:47 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A6684C74;
        Thu, 23 Aug 2018 08:53:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 159/324] tools/testing/nvdimm: advertise a write cache for nfit_test
Date:   Thu, 23 Aug 2018 09:53:45 +0200
Message-Id: <20180823075004.001173976@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vishal Verma <vishal.l.verma@intel.com>

[ Upstream commit 1273c253c32b9a073a4d8921ed079177ccc7c8af ]

Commit 546eb0317cfa "libnvdimm, pmem: Do not flush power-fail protected CPU caches"
fixed the write_cache detection to correctly show the lack of a write
cache based on the platform capabilities described in the ACPI NFIT. The
nfit_test unit tests expected a write cache to be present, so change the
nfit test namespaces to only advertise a persistence domain limited to
the memory controller. This allows the kernel to show a write_cache
attribute, and the test behaviour remains unchanged.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/nvdimm/test/nfit.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1989,8 +1989,7 @@ static void nfit_test0_setup(struct nfit
 	pcap->header.type = ACPI_NFIT_TYPE_CAPABILITIES;
 	pcap->header.length = sizeof(*pcap);
 	pcap->highest_capability = 1;
-	pcap->capabilities = ACPI_NFIT_CAPABILITY_CACHE_FLUSH |
-		ACPI_NFIT_CAPABILITY_MEM_FLUSH;
+	pcap->capabilities = ACPI_NFIT_CAPABILITY_MEM_FLUSH;
 	offset += pcap->header.length;
 
 	if (t->setup_hotplug) {


