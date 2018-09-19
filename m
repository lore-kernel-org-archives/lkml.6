Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED8EECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD5F2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD5F2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbeISXx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:53:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbeISXx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:53:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3013530832E6;
        Wed, 19 Sep 2018 18:14:54 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-51.ams2.redhat.com [10.36.116.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1361D2A2C8;
        Wed, 19 Sep 2018 18:14:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: intel_int0002_vgpio: Enable the driver on Bay Trail platforms
Date:   Wed, 19 Sep 2018 20:14:51 +0200
Message-Id: <20180919181451.8771-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 19 Sep 2018 18:14:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intel_int0002_vgpio driver was added to avoid an IRQ 9 storm on Cherry
Trail platforms.

When originally merged the CPU ID for Bay Trail SoCs was commented out
of the list of valid CPU IDs because we did not have any reports of the
IRQ storm on Bay Trail platforms.

We now have a report of the IRQ 9 storm on the Bay Trail based Thinkpad
Tablet 10 which is fixed by enabling this driver, so lets enable it on
Bay Trail too.

I've tested various other Bay Trail device with this driver enabled
without adverse side-effects.

BugLink: https://www.dpin.de/nf/finally-s0i3-is-there-thinkpad-tablet-10-sleeps-deeply-with-linux-kernel-4-15rc/#comments
Reported-and-tested-by: Nicole Faerber <nicole@id3p.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel_int0002_vgpio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
index a473dc51b18d..987a3b03f225 100644
--- a/drivers/platform/x86/intel_int0002_vgpio.c
+++ b/drivers/platform/x86/intel_int0002_vgpio.c
@@ -57,11 +57,7 @@
 #define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
 
 static const struct x86_cpu_id int0002_cpu_ids[] = {
-/*
- * Limit ourselves to Cherry Trail for now, until testing shows we
- * need to handle the INT0002 device on Baytrail too.
- *	ICPU(INTEL_FAM6_ATOM_SILVERMONT1),	 * Valleyview, Bay Trail *
- */
+	ICPU(INTEL_FAM6_ATOM_SILVERMONT1),	/* Valleyview, Bay Trail  */
 	ICPU(INTEL_FAM6_ATOM_AIRMONT),		/* Braswell, Cherry Trail */
 	{}
 };
-- 
2.19.0.rc1

