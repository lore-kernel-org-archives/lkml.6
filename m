Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE864C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DE020862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DE020862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbeG1X1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 19:27:50 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:36422
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731325AbeG1X1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 19:27:49 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id jXEgfT4OZcdsPjXEgfEHSJ; Sat, 28 Jul 2018 14:58:50 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1fjXEg-0003bZ-3w; Sat, 28 Jul 2018 14:58:50 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/4] Drivers: hv: vmus: Fix the check for return value from kmsg get dump buffer
Date:   Sat, 28 Jul 2018 21:58:45 +0000
Message-Id: <20180728215848.13814-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180728215630.13712-1-kys@linuxonhyperv.com>
References: <20180728215630.13712-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfHpRW3skzL7BQ7fezs190zWih24vVFJGAOVhcP4/i7FTr5SyoOISDid5EppW7XU5THS/Eb+yyK5uQB+gUJJ7p3TfNvJ4lZyayGDeAwnsvGHKB7/IrLwQ
 QqUFwE1cSgjfiiB955AwHrZwKFPy3QOz3dmRB7Tnxo3FgDclCVJ+LxAmCwedooC53stllc0/xEs5C4NXIxYFA5OXmdL+0zHgJV2mLVeCXSJ7FqUOYJUZbzI7
 LRC3xBD+QCURuPTFeLbMjBussZ4r+2JqW2vGxCcD0bh/DP8kM2EjFyoHxPMpKqfX2dH55s+fhsAqsIQU6MjTmlb5/PimVqUCw7Cjyro3IpuXWgYI9zMREl0n
 pGB8o0tEZ34Q29BQkcGC0gfD9wOcLd+HC+vGANnIMLDWq5nj5E3eQAfb7UrfcFQBVK2nOJ2jeAC0gCvf1Dx7RMuY5cRxbiXzHmC9xguHwWl1AsAfgGmBPkxV
 u3C1Q207yHdL+3yckd9oQwOcKwmjP1CvYpsCGc3Pw0F3uniCEDnHcE9B9zuA1V3sWW15/2zfhXErggyttCj4nsMwdM3C52lrPT9cjA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>

The code to support panic control message was checking the return was
checking the return value from kmsg_dump_get_buffer as error value, which
is not what the routine returns. This fixes it.

Fixes: 81b18bce48af ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 05e37283d7c3..a7f33c1f42c5 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1047,13 +1047,10 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 	 * Write dump contents to the page. No need to synchronize; panic should
 	 * be single-threaded.
 	 */
-	if (!kmsg_dump_get_buffer(dumper, true, hv_panic_page,
-				  PAGE_SIZE, &bytes_written)) {
-		pr_err("Hyper-V: Unable to get kmsg data for panic\n");
-		return;
-	}
-
-	hyperv_report_panic_msg(panic_pa, bytes_written);
+	kmsg_dump_get_buffer(dumper, true, hv_panic_page, PAGE_SIZE,
+			     &bytes_written);
+	if (bytes_written)
+		hyperv_report_panic_msg(panic_pa, bytes_written);
 }
 
 static struct kmsg_dumper hv_kmsg_dumper = {
-- 
2.17.1

