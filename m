Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F607C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D276221741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695282;
	bh=Qv1jpQmQptsKCFRnuLDVVu7VODCgHxCg55FPkAvvTtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0+Ff+sdiCu5PEgivtRnwHeTsXPPbx8VcTBewwaAaCIr6jhd0LyEwK//a2rQUSILrS
	 6UnTSIl1qkoomt5eqJNdlwOvPoRJ/mxD50m0oCcMT7QCfhkIj0DFEyUfrD5RT1jLDp
	 QAN8+zNDEaaayvnvX4cjHuVzlB8JKDuEqMmYXTpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbfA1QMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:12:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:40670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731135AbfA1QM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:12:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C5A2147A;
        Mon, 28 Jan 2019 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691948;
        bh=Qv1jpQmQptsKCFRnuLDVVu7VODCgHxCg55FPkAvvTtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZLrQF4GrKBVEO77SlVv7KELv0SlUSxYn8ByNcxX+XNmTQ/U1BrsC4bJCue5DL0qj
         FpNGvy+LBvHSYUagZq5I5DmNPDs22gHoJY/K24IVFjoyaJI3g6e8Yqi+h+BLN9UUHm
         CjvpceeM6SzztdmV+yFOImjWPnzL8CuxkzTmAx/c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 011/170] platform/x86: asus-nb-wmi: Map 0x35 to KEY_SCREENLOCK
Date:   Mon, 28 Jan 2019 11:09:21 -0500
Message-Id: <20190128161200.55107-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: João Paulo Rechi Vita <jprvita@gmail.com>

[ Upstream commit b3f2f3799a972d3863d0fdc2ab6287aef6ca631f ]

When the OS registers to handle events from the display off hotkey the
EC will send a notification with 0x35 for every key press, independent
of the backlight state.

The behavior of this key on Windows, with the ATKACPI driver from Asus
installed, is turning off the backlight of all connected displays with a
fading effect, and any cursor input or key press turning the backlight
back on. The key press or cursor input that wakes up the display is also
passed through to the application under the cursor or under focus.

The key that matches this behavior the closest is KEY_SCREENLOCK.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index a6a33327f5e7..2a697bf572c9 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -435,6 +435,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0x32, { KEY_MUTE } },
 	{ KE_KEY, 0x33, { KEY_DISPLAYTOGGLE } }, /* LCD on */
 	{ KE_KEY, 0x34, { KEY_DISPLAY_OFF } }, /* LCD off */
+	{ KE_KEY, 0x35, { KEY_SCREENLOCK } },
 	{ KE_KEY, 0x40, { KEY_PREVIOUSSONG } },
 	{ KE_KEY, 0x41, { KEY_NEXTSONG } },
 	{ KE_KEY, 0x43, { KEY_STOPCD } }, /* Stop/Eject */
-- 
2.19.1

