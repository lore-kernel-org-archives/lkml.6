Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFCFECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F8B20892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uObEspJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F8B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbeKIHf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:35:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:52232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbeKIHfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:35:24 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 091EA208E3;
        Thu,  8 Nov 2018 21:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714276;
        bh=xKiBVGU9ctkN3ddwrSl/+hEQwX0yWiijSqzPl94auqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uObEspJ31ldWsOYUc7ucz17oFNZIZ5pV8rtU8Q/E57cc37xfxs4ScHxv0NxP3J053
         0Oo528wxJ81moIfxNIQIQfpGwyGZUcYpEobJs+J8nxdLutdJiYigxeXYsyL5mexucI
         SMcGorS9gmWRdYHgNV9KWiEUnNnG2FAbSyXp6IgU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 123/144] USB: hub: fix up early-exit pathway in hub_activate
Date:   Thu,  8 Nov 2018 13:51:34 -0800
Message-Id: <20181108215106.965493025@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ca5cbc8b02f9b21cc8cd1ab36668763ec34f9ee8 ]

The early-exit pathway in hub_activate, added by commit e50293ef9775
("USB: fix invalid memory access in hub_activate()") needs
improvement.  It duplicates code that is already present at the end of
the subroutine, and it neglects to undo the effect of a
usb_autopm_get_interface_no_resume() call.

This patch fixes both problems by making the early-exit pathway jump
directly to the end of the subroutine.  It simplifies the code at the
end by merging two conditionals that actually test the same condition
although they appear different: If type < HUB_INIT3 then type must be
either HUB_INIT2 or HUB_INIT, and it can't be HUB_INIT because in that
case the subroutine would have exited earlier.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: <stable@vger.kernel.org> #4.4+
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/hub.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 164fdeddfc05..9a47a9c8ebb4 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1000,11 +1000,8 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 		device_lock(hub->intfdev);
 
 		/* Was the hub disconnected while we were waiting? */
-		if (hub->disconnected) {
-			device_unlock(hub->intfdev);
-			kref_put(&hub->kref, hub_release);
-			return;
-		}
+		if (hub->disconnected)
+			goto disconnected;
 		if (type == HUB_INIT2)
 			goto init2;
 		goto init3;
@@ -1230,12 +1227,12 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 	/* Scan all ports that need attention */
 	kick_hub_wq(hub);
 
-	/* Allow autosuspend if it was suppressed */
-	if (type <= HUB_INIT3)
+	if (type == HUB_INIT2 || type == HUB_INIT3) {
+		/* Allow autosuspend if it was suppressed */
+ disconnected:
 		usb_autopm_put_interface_async(to_usb_interface(hub->intfdev));
-
-	if (type == HUB_INIT2 || type == HUB_INIT3)
 		device_unlock(hub->intfdev);
+	}
 
 	kref_put(&hub->kref, hub_release);
 }
-- 
2.17.1



