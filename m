Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE9EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFDC2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895424;
	bh=lGC46SELDaHGcscUIZsLT8Gum4j2EwovZTtp7ZHGgKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YmpZMjJ3Th9326CTycl7Z64Y2bv7vW8sNQ0vQjTdTSleePuJ4yA/aQdFAiMCJQGgH
	 VjqNSzr2YBIkfODK6MAcMyqIIx0+kqKjrAm9wSECO/bOYe0TBp8lvf+WKBPnez0APp
	 BGOGYLFoS7megSkvHbKhyJIVPlGNUbxmnZaRSpH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfBKOaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:30:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:36734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbfBKOaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:30:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8563820675;
        Mon, 11 Feb 2019 14:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895421;
        bh=lGC46SELDaHGcscUIZsLT8Gum4j2EwovZTtp7ZHGgKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHW+gw3Hn5h/+GNQhCKWx/Osqec9aPryvIWwWGzPE1jxPdXhNWXw/8Jsi5SM4PDUL
         2tXGXG6LuYB5NgkcOqGp0vCFAOjK6UPTiIIjlNQuL5TZ7Lo4XCJGOTQqb14f3ImC9e
         H0ce3iydUP9Yp63egDf/bXsQAD15YhhghVuAs9pA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Liu <b-liu@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 199/352] usb: musb: dsps: fix otg state machine
Date:   Mon, 11 Feb 2019 15:17:06 +0100
Message-Id: <20190211141859.804718831@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6010abf2c2c0e382d7e8ee44bd11f343aae90cce ]

Due to lack of ID pin interrupt event on AM335x devices, the musb dsps
driver uses polling to detect usb device attach for dual-role port.

But in the case if a micro-A cable adapter is attached without a USB device
attached to the cable, the musb state machine gets stuck in a_wait_vrise
state waiting for the MUSB_CONNECT interrupt which won't happen due to the
usb device is not attached. The state is stuck in a_wait_vrise even after
the micro-A cable is detached, which could cause VBUS retention if then the
dual-role port is attached to a host port.

To fix the problem, make a_wait_vrise as a transient state, then move the
state to either a_wait_bcon for host port or a_idle state for dual-role
port, if no usb device is attached to the port.

Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/musb_dsps.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 23a0df79ef21..1e6d78b1334e 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -227,8 +227,13 @@ static int dsps_check_status(struct musb *musb, void *unused)
 
 	switch (musb->xceiv->otg->state) {
 	case OTG_STATE_A_WAIT_VRISE:
-		dsps_mod_timer_optional(glue);
-		break;
+		if (musb->port_mode == MUSB_HOST) {
+			musb->xceiv->otg->state = OTG_STATE_A_WAIT_BCON;
+			dsps_mod_timer_optional(glue);
+			break;
+		}
+		/* fall through */
+
 	case OTG_STATE_A_WAIT_BCON:
 		/* keep VBUS on for host-only mode */
 		if (musb->port_mode == MUSB_HOST) {
-- 
2.19.1



