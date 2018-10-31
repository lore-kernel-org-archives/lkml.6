Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28322ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D4D20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yqGot5v2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D4D20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbeKAIHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729150AbeKAIHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC8D520830;
        Wed, 31 Oct 2018 23:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027258;
        bh=8YA0vWFhpY+Sn68jT8xm6ghQKKZys++ILysgTsBS9rE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yqGot5v2fHi4nTUaHEyg1SHYxD91jCt8nrTNewbBmZhmC0sTnjl7Whg/clZg7Hw3V
         19chwncKgQOi6j0Hmqry3YdTZ1NZsgRLlW/zKU3z2zEQx7wAQmUXCg1QpP+VEopeFT
         Bp+t6VkMrmZYi/95Go8KYp6OfV8u4ymIbWLWYWtw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 129/146] usb: chipidea: Prevent unbalanced IRQ disable
Date:   Wed, 31 Oct 2018 19:05:24 -0400
Message-Id: <20181031230541.28822-129-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/usb/chipidea/otg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/otg.h b/drivers/usb/chipidea/otg.h
index 7e7428e48bfa..4f8b8179ec96 100644
--- a/drivers/usb/chipidea/otg.h
+++ b/drivers/usb/chipidea/otg.h
@@ -17,7 +17,8 @@ void ci_handle_vbus_change(struct ci_hdrc *ci);
 static inline void ci_otg_queue_work(struct ci_hdrc *ci)
 {
 	disable_irq_nosync(ci->irq);
-	queue_work(ci->wq, &ci->work);
+	if (queue_work(ci->wq, &ci->work) == false)
+		enable_irq(ci->irq);
 }
 
 #endif /* __DRIVERS_USB_CHIPIDEA_OTG_H */
-- 
2.17.1

