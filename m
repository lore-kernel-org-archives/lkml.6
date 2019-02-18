Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3252BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BD421902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498764;
	bh=pYMHqMWjRdAa5wE9slkCO3MIdRg1u/LQSEDpg1zX4uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fRtx34BFVbv77Eaw7KehfrAyiHeFTvRORkc5IqoTBkiiM79oP7eRhw1UUljbPXNqA
	 oBjGX1N+yI3+mLnwlCk7Cynf6rc/0Kjbnn0jz39QwouN1TB/wuwXh1unS/GVRd2dw0
	 F0oLwDeo7wrvzIxf6nwjDK02F0SSoIgb5WMFuU/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390314AbfBROGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:06:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:48960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390290AbfBROF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:05:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32FAB21901;
        Mon, 18 Feb 2019 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498758;
        bh=pYMHqMWjRdAa5wE9slkCO3MIdRg1u/LQSEDpg1zX4uQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkPb+8Y+GAsxnPDvn+hBBwUgG7KtE3HyrSEFVWR7hjgIeuTo4VGViE8cMxZzEdoql
         j8iwxotC9BAc755uN2WtZi5CslR9BTow8O9Hej4Gpv5FWUJNNH1AR59U7JBYl+k/sV
         Pmcl7tUrkd3YXvg/IUdbb995XxcBMThiqR3hgzFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 4.4 112/143] NFC: nxp-nci: Include unaligned.h instead of access_ok.h
Date:   Mon, 18 Feb 2019 14:44:00 +0100
Message-Id: <20190218133533.115879972@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 


