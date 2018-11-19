Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E07C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2D8214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxM85ATA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2D8214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404540AbeKTDVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:21:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403956AbeKTDVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:21:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3682E21104;
        Mon, 19 Nov 2018 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646646;
        bh=bptRtcMjBODHxuoqzNZLJ86B+FPGKL7YyXfVx0Mit34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LxM85ATAdYNnh+8i8n8xJmVxLBG6HIXcHNFLcBinmFJD5EsiFlkv+Ju7t0Q1jbGQn
         TroI3RStSaJ1nslm6S0uoy2ryJO3a8dgJC6HdU1EplTxNJoO2REAL9Nbxd7qvTfq5u
         n3KHnSZe9Se7KkHZ/dNoKjGlkmkxFqAadNh+52uU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 037/160] usb: chipidea: Prevent unbalanced IRQ disable
Date:   Mon, 19 Nov 2018 17:27:56 +0100
Message-Id: <20181119162634.677700751@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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


