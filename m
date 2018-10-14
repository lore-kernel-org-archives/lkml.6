Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE79C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E568D205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E568D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeJNXh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:37:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37545 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727718AbeJNXhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:37:25 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiME-0004cd-RB; Sun, 14 Oct 2018 16:31:06 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000Cy-1N; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Tony Lindgren" <tony@atomide.com>,
        "David Lechner" <david@lechnology.com>
Date:   Sun, 14 Oct 2018 16:25:40 +0100
Message-ID: <lsq.1539530740.93037236@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 055/366] pinctrl: pinctrl-single: Fix pcs_request_gpio()
 when bits_per_mux != 0
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Lechner <david@lechnology.com>

commit 45dcb54f014d3d1f5cc3919b5f0c97087d7cb3dd upstream.

This fixes pcs_request_gpio() in the pinctrl-single driver when
bits_per_mux != 0. It appears this was overlooked when the multiple
pins per register feature was added.

Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
Signed-off-by: David Lechner <david@lechnology.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/pinctrl/pinctrl-single.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -562,9 +562,25 @@ static int pcs_request_gpio(struct pinct
 			|| pin < frange->offset)
 			continue;
 		mux_bytes = pcs->width / BITS_PER_BYTE;
-		data = pcs->read(pcs->base + pin * mux_bytes) & ~pcs->fmask;
-		data |= frange->gpiofunc;
-		pcs->write(data, pcs->base + pin * mux_bytes);
+
+		if (pcs->bits_per_mux) {
+			int byte_num, offset, pin_shift;
+
+			byte_num = (pcs->bits_per_pin * pin) / BITS_PER_BYTE;
+			offset = (byte_num / mux_bytes) * mux_bytes;
+			pin_shift = pin % (pcs->width / pcs->bits_per_pin) *
+				    pcs->bits_per_pin;
+
+			data = pcs->read(pcs->base + offset);
+			data &= ~(pcs->fmask << pin_shift);
+			data |= frange->gpiofunc << pin_shift;
+			pcs->write(data, pcs->base + offset);
+		} else {
+			data = pcs->read(pcs->base + pin * mux_bytes);
+			data &= ~pcs->fmask;
+			data |= frange->gpiofunc;
+			pcs->write(data, pcs->base + pin * mux_bytes);
+		}
 		break;
 	}
 	return 0;

