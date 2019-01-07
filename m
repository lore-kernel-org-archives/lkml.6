Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56024C43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24458217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866293;
	bh=l50d+kx+CpnkvD0BepZJPbl4gAB4UU+XX5TurTx6J04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VXRjckmdeCdl0//QIWrXGj1njUAzfsHjHeJ4GVrMOABTfeiKeLVDR/BQYb3/p1jlE
	 7mibr/yO8+zt9/F9vCHDcvoQ9OO8GCajLK+UMFLdyDpulMqgctpTFtcs7jjN76I0qY
	 WnytP9t5A8Ph8mnaDvi1ANrMAvtBCIsrfKt/uusQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfAGNEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:04:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731274AbfAGNEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:04:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D863121736;
        Mon,  7 Jan 2019 13:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866288;
        bh=l50d+kx+CpnkvD0BepZJPbl4gAB4UU+XX5TurTx6J04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ntJhb7b4kfJ5qTmk5jT7KWlBkExrE8Vc9OANKf7xtVsdXkWY7QZo2XR84kXaGf4KY
         GF2q+F9UlPIowNDdmRK19HWXyfwKHSsIv1U5p6aHrz88iTIUSYjARekxJd8w8bLFGQ
         xhkAcvk6xlLQyPGv8z32fYB1mdC4/0GIR42ioek4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 4.9 01/71] NFC: nxp-nci: Include unaligned.h instead of access_ok.h
Date:   Mon,  7 Jan 2019 13:32:30 +0100
Message-Id: <20190107105330.362659021@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit 2eee74b7e2a496dea49847c36fd09320505f45b7 upstream.

Directly including access_ok.h can result in the following compile errors
if an architecture such as ia64 does not support direct unaligned accesses.

include/linux/unaligned/access_ok.h:7:19: error:
	redefinition of 'get_unaligned_le16'
include/linux/unaligned/le_struct.h:6:19: note:
	previous definition of 'get_unaligned_le16' was here
include/linux/unaligned/access_ok.h:12:19: error:
	redefinition of 'get_unaligned_le32'
include/linux/unaligned/le_struct.h:11:19: note:
	previous definition of 'get_unaligned_le32' was here

Include asm/unaligned.h instead and let the architecture decide which
access functions to use.

Cc: Clément Perrochaud <clement.perrochaud@effinnov.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nfc/nxp-nci/firmware.c |    2 +-
 drivers/nfc/nxp-nci/i2c.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/nfc/nxp-nci/firmware.c
+++ b/drivers/nfc/nxp-nci/firmware.c
@@ -24,7 +24,7 @@
 #include <linux/completion.h>
 #include <linux/firmware.h>
 #include <linux/nfc.h>
-#include <linux/unaligned/access_ok.h>
+#include <asm/unaligned.h>
 
 #include "nxp-nci.h"
 
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -36,7 +36,7 @@
 #include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/platform_data/nxp-nci.h>
-#include <linux/unaligned/access_ok.h>
+#include <asm/unaligned.h>
 
 #include <net/nfc/nfc.h>
 


