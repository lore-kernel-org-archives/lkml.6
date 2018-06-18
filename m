Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FB8C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961B220864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961B220864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967330AbeFRIci (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:32:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34648 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966870AbeFRIcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:32:35 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 12E5EC9F;
        Mon, 18 Jun 2018 08:32:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 051/189] ACPI / PM: Blacklist Low Power S0 Idle _DSM for ThinkPad X1 Tablet(2016)
Date:   Mon, 18 Jun 2018 10:12:27 +0200
Message-Id: <20180618081211.384348511@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Yu <yu.c.chen@intel.com>

[ Upstream commit 855c1c2fce8bdbd796cba1d1456ca8f0e876c2f1 ]

ThinkPad X1 Tablet(2016) is reported to have issues with
the Low Power S0 Idle _DSM interface and since this machine
model generally can do ACPI S3 just fine, and user would
like to use S3 as default sleep model, add a blacklist
entry to disable that interface for ThinkPad X1 Tablet(2016).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199057
Reported-and-tested-by: Robin Lee <robinlee.sysu@gmail.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/sleep.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -364,6 +364,19 @@ static const struct dmi_system_id acpisl
 		DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9360"),
 		},
 	},
+	/*
+	 * ThinkPad X1 Tablet(2016) cannot do suspend-to-idle using
+	 * the Low Power S0 Idle firmware interface (see
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=199057).
+	 */
+	{
+	.callback = init_no_lps0,
+	.ident = "ThinkPad X1 Tablet(2016)",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
+		},
+	},
 	{},
 };
 


