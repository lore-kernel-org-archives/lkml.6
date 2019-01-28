Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB7DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAC621741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694724;
	bh=1iuavP3cGwhbiW1JcqvvANLsEovUhOIOyUFHsxHJoQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XYe0JDJP3eklViMVPlz64lft+sLCBCwDYvN1gifUjAYv8I5vubbDwwT4FmsAssdTS
	 UTqmylPmd+7ZoNaUsjal0ESVMmjWOxsrso6TqLvfl8Fq20zEPdcDjG6PFruX/6SpV2
	 gMN7FTAkUlG6DcazhmYCAtSRpEsuMkECKSKGIK/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387704AbfA1Q6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:58:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388049AbfA1QQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:16:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53CC32086C;
        Mon, 28 Jan 2019 16:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692209;
        bh=1iuavP3cGwhbiW1JcqvvANLsEovUhOIOyUFHsxHJoQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xC86kzEnmHMpSt+kaDPQQ9SDvQMkCvX8RB0vBpY500Wffw7eSFIyiCAx83jN/iphz
         kx3UT0mDiPQjfgfK//9gj18eNwbd/kfl8lveKc1rjSlSnw8Caq0slHrezrAXKmNqFO
         xLoRBP5xoYcjb9tYX9Mi4VODg7rxdN6a+tL2FKZM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 111/170] usb: musb: dsps: fix otg state machine
Date:   Mon, 28 Jan 2019 11:11:01 -0500
Message-Id: <20190128161200.55107-111-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Liu <b-liu@ti.com>

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
index dbb482b7e0ba..b7d460adaa61 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -242,8 +242,13 @@ static int dsps_check_status(struct musb *musb, void *unused)
 
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
 		if (musb->port_mode == MUSB_PORT_MODE_HOST) {
-- 
2.19.1

