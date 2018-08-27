Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DBEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B637C208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B637C208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=certi.org.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeH1Bbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:31:41 -0400
Received: from iridio.certi.org.br ([177.71.112.137]:40250 "EHLO
        iridio.certi.org.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH1Bbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:31:40 -0400
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Aug 2018 21:31:40 EDT
Received: from CPS-11710M.certi.org (unknown [177.71.116.77])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by iridio.certi.org.br (Postfix) with ESMTPSA id 8AAF260295;
        Mon, 27 Aug 2018 18:37:10 -0300 (-03)
From:   Bruno Meirelles Herrera <bmh@certi.org.br>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John.Youn@synopsys.com, alexandre.torgue@st.com,
        Bruno Meirelles Herrera <bmh@certi.org.br>
Subject: [PATCH] usb: dwc2: Fix call location of dwc2_check_core_endianness
Date:   Mon, 27 Aug 2018 18:36:38 -0300
Message-Id: <20180827213638.18890-1-bmh@certi.org.br>
X-Mailer: git-send-email 2.15.2 (Apple Git-101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoC/IP as STM32F469, the snpsid can only be read after clock is
enabled, otherwise it will read as 0, and the dwc2_check_core_endianness
will assume the core and AHB have opposite endianness, leading to the
following error:

[    1.976339] dwc2 50000000.usb: 50000000.usb supply vusb_d not found, using dummy regulator
[    1.986124] dwc2 50000000.usb: Linked as a consumer to regulator.0
[    1.992711] dwc2 50000000.usb: 50000000.usb supply vusb_a not found, using dummy regulator
[    2.003672] dwc2 50000000.usb: dwc2_core_reset: HANG! AHB Idle timeout GRSTCTL GRSTCTL_AHBIDLE
[    2.015176] dwc2: probe of 50000000.usb failed with error -16

The proposed patch changes the location where dwc2_check_core_endianness
is called, allowing the clock peripheral to be enabled first.

Signed-off-by: Bruno Meirelles Herrera <bmh@certi.org.br>
---
 drivers/usb/dwc2/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 9a53a58e676e..577642895b57 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -412,8 +412,6 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	dev_dbg(&dev->dev, "mapped PA %08lx to VA %p\n",
 		(unsigned long)res->start, hsotg->regs);
 
-	hsotg->needs_byte_swap = dwc2_check_core_endianness(hsotg);
-
 	retval = dwc2_lowlevel_hw_init(hsotg);
 	if (retval)
 		return retval;
@@ -438,6 +436,8 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	if (retval)
 		return retval;
 
+	hsotg->needs_byte_swap = dwc2_check_core_endianness(hsotg);
+
 	retval = dwc2_get_dr_mode(hsotg);
 	if (retval)
 		goto error;
-- 
2.15.2 (Apple Git-101.1)

