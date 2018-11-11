Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB273C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A849520818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHZCTygi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A849520818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390749AbeKLIvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:51:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390655AbeKLIWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:30 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47EF1223C6;
        Sun, 11 Nov 2018 22:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975553;
        bh=UzGhMHVxC67UEAZ/QVnVHV310Hd77ZN7/y9hlc+mQDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHZCTygiyGq36BqNO9An4jqzJrrAu9bj0VaDGhwj8AK8kqjRw+I8VV9aBFKk68J8a
         TDuw9VLaIjlcJFQSklENkQ5hY7u671iO7jYu53PHD5WsjwzKABZfHfaZoBAp5OS9FK
         g2zRZsRdn8eeubdRzJooey2qAGQ2AIcXLzQBm5vY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 098/222] usb: chipidea: Prevent unbalanced IRQ disable
Date:   Sun, 11 Nov 2018 14:23:15 -0800
Message-Id: <20181111221656.695572410@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit 8b97d73c4d72a2abf58f8e49062a7ee1e5f1334e ]

The ChipIdea IRQ is disabled before scheduling the otg work and
re-enabled on otg work completion. However if the job is already
scheduled we have to undo the effect of disable_irq int order to
balance the IRQ disable-depth value.

Fixes: be6b0c1bd0be ("usb: chipidea: using one inline function to cover queue work operations")
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/chipidea/otg.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/chipidea/otg.h
+++ b/drivers/usb/chipidea/otg.h
@@ -20,7 +20,8 @@ void ci_handle_vbus_change(struct ci_hdr
 static inline void ci_otg_queue_work(struct ci_hdrc *ci)
 {
 	disable_irq_nosync(ci->irq);
-	queue_work(ci->wq, &ci->work);
+	if (queue_work(ci->wq, &ci->work) == false)
+		enable_irq(ci->irq);
 }
 
 #endif /* __DRIVERS_USB_CHIPIDEA_OTG_H */


