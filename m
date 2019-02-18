Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54818C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F3F2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390320AbfBRQyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:54:46 -0500
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:46388 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390284AbfBRQyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:54:46 -0500
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id x1IGrkBD031334;
        Mon, 18 Feb 2019 19:53:51 +0300
Received: from localhost.localdomain (unknown [213.87.149.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 9567E33EE2;
        Mon, 18 Feb 2019 19:45:55 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     b-liu@ti.com, gregkh@linuxfoundation.org
Cc:     matwey.kornilov@gmail.com,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: musb: Fix urb->hcpriv value
Date:   Mon, 18 Feb 2019 19:44:39 +0300
Message-Id: <20190218164439.27204-1-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <CAJs94Eb-ERrfAEONK=_14f=kMsqVBT-XkcwfWZXwUgspraD9QA@mail.gmail.com>
References: <CAJs94Eb-ERrfAEONK=_14f=kMsqVBT-XkcwfWZXwUgspraD9QA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

urb->hcpriv != NULL is used to indicate that the URB is queued [1].
Also see __usb_hcd_giveback_urb() and usb_hcd_submit_urb() for
the reference.

In this code path, the URB is actually queued and valid qh is hep->hcpriv.

[1] https://lkml.org/lkml/2019/1/25/750

Fixes: 714bc5ef3eda ("musb: potential use after free")
Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/usb/musb/musb_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index b59ce9ad14ce..a60d52c7e112 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2302,7 +2302,7 @@ static int musb_urb_enqueue(
 		 * odd, rare, error prone, but legal.
 		 */
 		kfree(qh);
-		qh = NULL;
+		qh = hep->hcpriv;
 		ret = 0;
 	} else
 		ret = musb_schedule(musb, qh,
-- 
2.16.4

