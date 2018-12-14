Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF54AC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921DA20879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790338;
	bh=+XMpdV74CbGtc+pioc7TMg416GzGI2CoHPaIK51zUaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Bz5eCf0h05YSImnr43HfBjQBqaYFswyo+r0cOgNltFLUIJ53SZlU29UU+QH5rz11
	 lbIAm+rqJH5xYKe9QgE/kVF1tHH4SB5VYQRmmDz+ZItPiSzR1oLwFbJ778s09/INAP
	 Ith/x21sktAf+lk+4MhZiwR5YIU9L4lUiFQmYKCg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921DA20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbeLNMZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:25:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731915AbeLNMMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:12:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B63214DE;
        Fri, 14 Dec 2018 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789538;
        bh=+XMpdV74CbGtc+pioc7TMg416GzGI2CoHPaIK51zUaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMJ1vSN2O4KB2KYC+DL6ZJPgZ/6qq01R54nk9j67JJFGHgQKineGsAHNiBQV43iiN
         gVQbOeilndZSNgwEH+/7kQh6/zCJflPT8/81aPP6xyz1vI6Qpzgo08DGKRCK1zZbvI
         amLDhm7QSGrTESK6UVSOU1+eiN9AD3EPVe+Bb618=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 32/51] USB: omap_udc: fix omap_udc_start() on 15xx machines
Date:   Fri, 14 Dec 2018 13:00:34 +0100
Message-Id: <20181214115716.181319045@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115713.244259772@linuxfoundation.org>
References: <20181214115713.244259772@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6ca6695f576b8453fe68865e84d25946d63b10ad ]

On OMAP 15xx machines there are no transceivers, and omap_udc_start()
always fails as it forgot to adjust the default return value.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/omap_udc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 2a23b21fe153..8f044caa8ad4 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2045,7 +2045,7 @@ static inline int machine_without_vbus_sense(void)
 static int omap_udc_start(struct usb_gadget *g,
 		struct usb_gadget_driver *driver)
 {
-	int		status = -ENODEV;
+	int		status;
 	struct omap_ep	*ep;
 	unsigned long	flags;
 
@@ -2083,6 +2083,7 @@ static int omap_udc_start(struct usb_gadget *g,
 			goto done;
 		}
 	} else {
+		status = 0;
 		if (can_pullup(udc))
 			pullup_enable(udc);
 		else
-- 
2.19.1



