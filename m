Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C4FECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BE720883
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab4ZF2K5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BE720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbeJYWyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731475AbeJYWyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:54:19 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F26A20870;
        Thu, 25 Oct 2018 14:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477281;
        bh=FyeVp7MmGrrv4SFsqrs2d0Jlnet07RRC5iLw8Z5w97g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ab4ZF2K5MqGJ0IbFa1CrZo7XJuwMNilCa+4P/84+ua2ppk7dT7AzPdlhQU/bLwnDQ
         hMjpHoJZ7eNEp8Nu9fKur6KLa+UtbOIhVw45ppcrgaUNMVMcGjTJioazGyT3O+qWli
         g5wfzfr1NuTYcoTPH3otx1XTyQ7MND0Ndw5KHJAw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 95/98] USB: hub: fix up early-exit pathway in hub_activate
Date:   Thu, 25 Oct 2018 10:18:50 -0400
Message-Id: <20181025141853.214051-95-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

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

