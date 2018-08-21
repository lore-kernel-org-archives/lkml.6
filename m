Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88B6C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAF22174D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAF22174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeHUJqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:46:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56456 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeHUJp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:45:59 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 822659D7;
        Tue, 21 Aug 2018 06:27:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 21/29] ACPI / PM: save NVS memory for ASUS 1025C laptop
Date:   Tue, 21 Aug 2018 08:21:14 +0200
Message-Id: <20180821055109.243576845@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055108.333930282@linuxfoundation.org>
References: <20180821055108.333930282@linuxfoundation.org>
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

From: Willy Tarreau <w@1wt.eu>

commit 231f9415001138a000cd0f881c46654b7ea3f8c5 upstream.

Every time I tried to upgrade my laptop from 3.10.x to 4.x I faced an
issue by which the fan would run at full speed upon resume. Bisecting
it showed me the issue was introduced in 3.17 by commit 821d6f0359b0
(ACPI / sleep: Do not save NVS for new machines to accelerate S3). This
code only affects machines built starting as of 2012, but this Asus
1025C laptop was made in 2012 and apparently needs the NVS data to be
saved, otherwise the CPU's thermal state is not properly reported on
resume and the fan runs at full speed upon resume.

Here's a very simple way to check if such a machine is affected :

  # cat /sys/class/thermal/thermal_zone0/temp
  55000

  ( now suspend, wait one second and resume )

  # cat /sys/class/thermal/thermal_zone0/temp
  0

  (and after ~15 seconds the fan starts to spin)

Let's apply the same quirk as commit cbc00c13 (ACPI: save NVS memory
for Lenovo G50-45) and reuse the function it provides. Note that this
commit was already backported to 4.9.x but not 4.4.x.

Cc: 3.17+ <stable@vger.kernel.org> # 3.17+: requires cbc00c13
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/sleep.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -338,6 +338,14 @@ static const struct dmi_system_id acpisl
 		DMI_MATCH(DMI_PRODUCT_NAME, "K54HR"),
 		},
 	},
+	{
+	.callback = init_nvs_save_s3,
+	.ident = "Asus 1025C",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "1025C"),
+		},
+	},
 	/*
 	 * https://bugzilla.kernel.org/show_bug.cgi?id=189431
 	 * Lenovo G50-45 is a platform later than 2012, but needs nvs memory


