Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E979DECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C13A2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C13A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbeIREht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731683AbeIREht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:49 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 21472C7D;
        Mon, 17 Sep 2018 23:08:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.18 032/158] ACPI / LPSS: Force LPSS quirks on boot
Date:   Tue, 18 Sep 2018 00:41:02 +0200
Message-Id: <20180917211712.495081607@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Rui <rui.zhang@intel.com>

commit f11fc4bc669b8622510c1039499f5a9d24248fec upstream.

Commit 12864ff8545f (ACPI / LPSS: Avoid PM quirks on suspend and resume
from hibernation) bypasses lpss quirks for S3 and S4, by setting a flag
for S3/S4 in acpi_lpss_suspend(), and check that flag in
acpi_lpss_resume().

But this overlooks the boot case where acpi_lpss_resume() may get called
without a corresponding acpi_lpss_suspend() having been called.

Thus force setting the flag during boot.

Fixes: 12864ff8545f (ACPI / LPSS: Avoid PM quirks on suspend and resume from hibernation)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=200989
Reported-and-tested-by: William Lieurance <william.lieurance@namikoda.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Cc: 4.15+ <stable@vger.kernel.org> # 4.15+: 12864ff8545f (ACPI / LPSS: Avoid ...)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpi_lpss.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -879,7 +879,7 @@ static void acpi_lpss_dismiss(struct dev
 #define LPSS_GPIODEF0_DMA_LLP		BIT(13)
 
 static DEFINE_MUTEX(lpss_iosf_mutex);
-static bool lpss_iosf_d3_entered;
+static bool lpss_iosf_d3_entered = true;
 
 static void lpss_iosf_enter_d3_state(void)
 {


