Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969085AbeE1PjE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031500AbeE1KSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:18:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
        Tony Lindgren <tony@atomide.com>, Bin Liu <b-liu@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 093/268] usb: musb: fix enumeration after resume
Date: Mon, 28 May 2018 12:01:07 +0200
Message-Id: <20180528100212.742559751@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Kemnade <andreas@kemnade.info>

[ Upstream commit 17539f2f4f0b7fa906b508765c8ada07a1e45f52 ]

On dm3730 there are enumeration problems after resume.
Investigation led to the cause that the MUSB_POWER_SOFTCONN
bit is not set. If it was set before suspend (because it
was enabled via musb_pullup()), it is set in
musb_restore_context() so the pullup is enabled. But then
musb_start() is called which overwrites MUSB_POWER and
therefore disables MUSB_POWER_SOFTCONN, so no pullup is
enabled and the device is not enumerated.

So let's do a subset of what musb_start() does
in the same way as musb_suspend() does it. Platform-specific
stuff it still called as there might be some phy-related stuff
which needs to be enabled.
Also interrupts are enabled, as it was the original idea
of calling musb_start() in musb_resume() according to
Commit 6fc6f4b87cb3 ("usb: musb: Disable interrupts on suspend,
enable them on resume")

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/musb/musb_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2522,7 +2522,8 @@ static int musb_resume(struct device *de
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	musb_start(musb);
+	musb_enable_interrupts(musb);
+	musb_platform_enable(musb);
 
 	return 0;
 }
