Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B84C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCCD20869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCCD20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeIDLlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:41:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:26456 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbeIDLlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:41:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 00:17:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="85812256"
Received: from xhao3-mobl.ccr.corp.intel.com ([10.249.171.25])
  by fmsmga004.fm.intel.com with ESMTP; 04 Sep 2018 00:17:47 -0700
Message-ID: <1536045465.2282.21.camel@intel.com>
Subject: [PATCH] ACPI / LPSS: Force lpss quirks on boot
From:   Zhang Rui <rui.zhang@intel.com>
To:     William Lieurance <william.lieurance@namikoda.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 04 Sep 2018 15:17:45 +0800
In-Reply-To: <1535942331.2072.5.camel@intel.com>
References: <20180901175916.28567-1-william.lieurance@namikoda.com>
         <1535942331.2072.5.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 一, 2018-09-03 at 10:38 +0800, Zhang Rui wrote:
> Hi, William,
> 
> On 六, 2018-09-01 at 12:59 -0500, William Lieurance wrote:
> > 
> > For some number of systems with lpss_quirks enabled, on boot the
> > system
> > goes through an acpi_lpss_resume() without a corresponding
> > acpi_lpss_suspend() having been called.
> I read the code but didn't find out why this could happen, but if it
> is
> true, please check if the below patch helps
> 
> From 27fda1ab0d800966b0ec1c444fe356812bd2f04e Mon Sep 17 00:00:00
> 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Mon, 3 Sep 2018 10:00:07 +0800
> Subject: [PATCH] ACPI / LPSS: Force lpss quirks on boot
> 
> Commit 12864ff8545f ("ACPI / LPSS: Avoid PM quirks on suspend and
> resume
> from hibernation") bypasses lpss quirks for S3 and S4, by setting a
> flag
> for S3/S4 in acpi_lpss_suspend(), and check that flag in
> acpi_lpss_resume().
> 
> But this overlooks the boot case where acpi_lpss_resume() may get
> called
> without a corresponding acpi_lpss_suspend() having been called.
> 
> Thus force setting the flag during boot.
> 
> Fixes: 12864ff8545f (ACPI / LPSS: Avoid PM quirks on suspend and
> resume from hibernation)
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200989
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

According to https://bugzilla.kernel.org/show_bug.cgi?id=200989#c6,
the patch has been confirmed to fix the problem.
Don't know why the patch does not show up in patchwork.
Let me resend.

From f07303f10e41c2b61d0d4da5f74e98a3bf8e7147 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Mon, 3 Sep 2018 10:00:07 +0800
Subject: [PATCH] ACPI / LPSS: Force lpss quirks on boot

Commit 12864ff8545f ("ACPI / LPSS: Avoid PM quirks on suspend and resume
from hibernation") bypasses lpss quirks for S3 and S4, by setting a flag
for S3/S4 in acpi_lpss_suspend(), and check that flag in
acpi_lpss_resume().

But this overlooks the boot case where acpi_lpss_resume() may get called
without a corresponding acpi_lpss_suspend() having been called.

Thus force setting the flag during boot.

Fixes: 12864ff8545f (ACPI / LPSS: Avoid PM quirks on suspend and resume from hibernation)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=200989
Reported-and-tested-by: William Lieurance <william.lieurance@namikoda.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/acpi_lpss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 9706613..bf64cfa 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -879,7 +879,7 @@ static void acpi_lpss_dismiss(struct device *dev)
 #define LPSS_GPIODEF0_DMA_LLP		BIT(13)
 
 static DEFINE_MUTEX(lpss_iosf_mutex);
-static bool lpss_iosf_d3_entered;
+static bool lpss_iosf_d3_entered = true;
 
 static void lpss_iosf_enter_d3_state(void)
 {
-- 
2.7.4

