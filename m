Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF28FC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7632520849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676323;
	bh=lN4gjZEO5fVofN1wwxwG9rt7o19SV6CrINsisFHHA38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TN93PSESCIsUmtckhaf00B+H0/uzwzDIh1LXHSeF+9DLiU2XWx2qtY2NKbwP3hq42
	 HBSdgQOX11aR5DTc6SwPX0bKCv/1ebjeVRMgRxxonYJJRkayx7y90SqBOHDyccKXpc
	 74tBsLlXEr8wn8YJt2A/9gPAnCf2KfY2NQ2Ed7R4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7632520849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbeLMEpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:45:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727449AbeLMEa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7374420873;
        Thu, 13 Dec 2018 04:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675457;
        bh=lN4gjZEO5fVofN1wwxwG9rt7o19SV6CrINsisFHHA38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AAc2kIbQ1HURXp22uXfg6oBebSDCOK4K1eq/crqLK+v8IXUE7Kt7Ty3wvb/ZqtJmL
         tn8jWwJxi3H1Ss80VlhCmvEWQUIkFFE6Q5Vj28cJTWhnbM0dUy7WmlXdCwB3GAK1pF
         LzVAmlJyXI+WP96+t/VWC/DLS44vfx/VxO9C/8e0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, devel@linuxdriverproject.org,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 02/41] Input: hyper-v - fix wakeup from suspend-to-idle
Date:   Wed, 12 Dec 2018 23:30:15 -0500
Message-Id: <20181213043054.75891-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043054.75891-1-sashal@kernel.org>
References: <20181213043054.75891-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 10f91c73cc41ceead210a905dbd196398e99c7d2 ]

It makes little sense but still possible to put Hyper-V guests into
suspend-to-idle state. To wake them up two wakeup sources were registered
in the past: hyperv-keyboard and hid-hyperv. However, since
commit eed4d47efe95 ("ACPI / sleep: Ignore spurious SCI wakeups from
suspend-to-idle") pm_wakeup_event() from these devices is ignored. Switch
to pm_wakeup_hard_event() API as these devices are actually the only
possible way to wakeup Hyper-V guests.

Fixes: eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle)
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-hyperv.c              | 2 +-
 drivers/input/serio/hyperv-keyboard.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 6039f071fab1..5f1de24206ab 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -309,7 +309,7 @@ static void mousevsc_on_receive(struct hv_device *device,
 		hid_input_report(input_dev->hid_device, HID_INPUT_REPORT,
 				 input_dev->input_buf, len, 1);
 
-		pm_wakeup_event(&input_dev->device->device, 0);
+		pm_wakeup_hard_event(&input_dev->device->device);
 
 		break;
 	default:
diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index 25151d9214e0..55288a026e4e 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -177,7 +177,7 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
 		 * state because the Enter-UP can trigger a wakeup at once.
 		 */
 		if (!(info & IS_BREAK))
-			pm_wakeup_event(&hv_dev->device, 0);
+			pm_wakeup_hard_event(&hv_dev->device);
 
 		break;
 
-- 
2.19.1

