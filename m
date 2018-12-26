Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC51C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6039F2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864108;
	bh=SIckV+PU2Yy146X3INrWBdvQzqFEacTTD8Ewexp07OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c2g61icMIF3jMj22MGp49YWNa7nqOSEJXkALkK4xOnCbmNf4sHz4U1oxAFRlKmZg5
	 ADJLehFz3wrOtBC/16+eTJwwzAeim3Daed79tByOxfzbzTX60RYtTjfghVB9JEy6Qh
	 spdLxIep8dW22fFGxcoUzIOTCKi8NEWVs69XiEUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbeLZWlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:41:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729504AbeLZWli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:41:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5EC82054F;
        Wed, 26 Dec 2018 22:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864097;
        bh=SIckV+PU2Yy146X3INrWBdvQzqFEacTTD8Ewexp07OA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lIE9GOy+mO2Iew3/Df9/mo0TP7KF8MQoKeYXaSK640kw9SByme9jCTcn3xlJlOT69
         dGB7uzGhD+syJiryvMfUJcmezN2g4C+zon3qGf8DkyfxI2bxuCCgjwMD1RDJ5bwpIG
         BhWYzGqHD3xSSrzd6Tf4Pe08JF/08VCFZtCLlklc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Mantas=20Mikul=C4=97nas?= <grawity@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 56/59] Input: synaptics - enable SMBus for HP EliteBook 840 G4
Date:   Wed, 26 Dec 2018 17:38:36 -0500
Message-Id: <20181226223839.150262-56-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mantas Mikulėnas <grawity@gmail.com>

[ Upstream commit 7a71712293ba303aad928f580b89addb0be2892e ]

dmesg reports that "Your touchpad (PNP: SYN3052 SYN0100 SYN0002 PNP0f13)
says it can support a different bus."

I've tested the offered psmouse.synaptics_intertouch=1 with 4.18.x and
4.19.x and it seems to work well. No problems seen with suspend/resume.

Also, it appears that RMI/SMBus mode is actually required for 3-4 finger
multitouch gestures to work -- otherwise they are not reported at all.

Information from dmesg in both modes:

  psmouse serio3: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1,
      caps: 0xf00123/0x840300/0x2e800/0x0, board id: 3139, fw id: 2000742

  psmouse serio3: synaptics: Trying to set up SMBus access
  rmi4_smbus 6-002c: registering SMbus-connected sensor
  rmi4_f01 rmi4-00.fn01: found RMI device,
      manufacturer: Synaptics, product: TM3139-001, fw id: 2000742

Signed-off-by: Mantas Mikulėnas <grawity@gmail.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 515a0b0d48bf..e9ec5d10e0a9 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -179,6 +179,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN200f", /* T450s */
+	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
 	NULL
 };
-- 
2.19.1

