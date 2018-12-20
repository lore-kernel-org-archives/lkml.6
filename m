Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BA4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8882186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298010;
	bh=+1ZjmLNRcrFm1onXxkJyJB6hMC62/4eI09rO5RBytho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=myl1bFz4YpEQxZRetLf/m7Wf8gWvWE+XCeKMDXVNKK9F1ihN3jQQ+FCylIAXMA8AT
	 gHoWLOtCGxmSezCDVQKvor/faoGNsJoFOJk7155t8tTx+YxdHF8HUcn9si2ALe/OuB
	 5C5W8Vn5u3bSSzlTHGd6ou2Vb5Fv8W4m38tpA/2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbeLTJ0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:26:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732166AbeLTJ0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:26:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E40E2186A;
        Thu, 20 Dec 2018 09:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298006;
        bh=+1ZjmLNRcrFm1onXxkJyJB6hMC62/4eI09rO5RBytho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zG7yjDmMfwpVcbIBf4/YsLcbFCuO8FSvFL6dZ3GLFZVfX8H5uCF+9L6nyNtF/xzlX
         ze/NCe09NRUIx5PTHixkgk+RMR2guFVkXIvC9Y029T07LA7cCaXhUwnT3wg/FMQ2nk
         DIHDpLIg9y7KNVWBs8a2aYk1KAHK/dcsAxsMdTe4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 37/72] Input: hyper-v - fix wakeup from suspend-to-idle
Date:   Thu, 20 Dec 2018 10:18:36 +0100
Message-Id: <20181220085923.804253512@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



