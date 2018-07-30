Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23337C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F1420857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F1420857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbeGaAjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:39:22 -0400
Received: from relay1.sgi.com ([192.48.180.66]:57864 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731961AbeGaAjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:39:22 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jul 2018 20:39:21 EDT
Received: from stormcage.americas.sgi.com (stormcage.americas.sgi.com [128.162.236.70])
        by relay1.corp.sgi.com (Postfix) with ESMTP id C1C5A8F8037;
        Mon, 30 Jul 2018 15:54:20 -0700 (PDT)
Received: by stormcage.americas.sgi.com (Postfix, from userid 5508)
        id 248F9202132CB; Mon, 30 Jul 2018 17:53:50 -0500 (CDT)
Message-Id: <20180730195548.580717146@stormcage.americas.sgi.com>
References: <20180730195545.795802877@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date:   Mon, 30 Jul 2018 14:55:46 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86, pmem, acpi: Remove excessive ACPI Large Reference Count warnings
Content-Disposition: inline; filename=incr-acpi-ref-cnt-warning
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the Intel BIOS support for 8 processor sockets with a full complement
of NVDIMMS potentially installable, and there are empty sockets without
NVDIMMS, there is an extremely large amount of the following warnings:

ACPI Warning: Large Reference Count (0x1001) in object ffff99453fc71750,
	Type=0x0A

On a 4 socket system with 4 NVDIMMs there were over 6000 of these warning
messages and it has been seem on systems from 4 to 32 sockets.

Through some guidance from the BIOS developers and testing, it appears
that simply bumping up the threshold for warnings from 0x1000 to 0x2000
eliminates these messages.  Changing them to be ACPI DEBUG messages, or
even removing them are other options, but it would then defeat the purpose
of the warnings as the problem would effectively be hidden.

Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Tested-by: Russ Anderson <russ.anderson@hpe.com>
Signed-off-by: Mike Travis <mike.travis@hpe.com>
---
 include/acpi/acconfig.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-4.12.orig/include/acpi/acconfig.h
+++ linux-4.12/include/acpi/acconfig.h
@@ -123,7 +123,7 @@
 
 /* Maximum object reference count (detects object deletion issues) */
 
-#define ACPI_MAX_REFERENCE_COUNT        0x1000
+#define ACPI_MAX_REFERENCE_COUNT        0x2000
 
 /* Default page size for use in mapping memory for operation regions */
 

-- 

