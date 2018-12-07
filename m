Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FCFC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A42208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544195162;
	bh=qcZKixJD19DCjaXVIJu5vsvSOE7OgXjEEA3klsqSWzs=;
	h=From:Date:Subject:To:Cc:Reply-to:List-ID:From;
	b=xRm7LKMgC5pNRKYjLdKlqT2yhmOjhP0L3Adz+rUEjeJzIWNbboilzxF32sJcPb2e8
	 dEnbsF1MlfQPffQLQ1QtpRjh2mY9r9+c9rwl0ISzGC7g0vNa5MUWf3ylg4cJFn7g4Q
	 yrC2Ji14mav7gW0v9f4ctMN7cxSkY7MGLgal+2gg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A42208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbeLGPGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:06:00 -0500
Received: from www.linuxtv.org ([130.149.80.248]:44637 "EHLO www.linuxtv.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeLGPGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:06:00 -0500
X-Greylist: delayed 943 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Dec 2018 10:05:59 EST
Received: from mchehab by www.linuxtv.org with local (Exim 4.84_2)
        (envelope-from <mchehab@linuxtv.org>)
        id 1gVHSI-0002qP-UZ; Fri, 07 Dec 2018 14:50:14 +0000
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Date:   Fri, 07 Dec 2018 14:42:18 +0000
Subject: [git:media_tree/master] media: siano: Use kmemdup instead of duplicating its function
To:     linuxtv-commits@linuxtv.org
Cc:     Tomoki Sekiyama <tomoki.sekiyama@gmail.com>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1gVHSI-0002qP-UZ@www.linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: siano: Use kmemdup instead of duplicating its function
Author:  Wen Yang <wen.yang99@zte.com.cn>
Date:    Thu Dec 6 07:29:10 2018 -0500

kmemdup has implemented the function that kmalloc() + memcpy().
We prefer to kmemdup rather than code opened implementation.

This issue was detected with the help of coccinelle.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Tomoki Sekiyama <tomoki.sekiyama@gmail.com>
CC: linux-kernel@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

 drivers/media/usb/siano/smsusb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

---

diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index be3634407f1f..2ffded08407b 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -225,10 +225,9 @@ static int smsusb_sendrequest(void *context, void *buffer, size_t size)
 		return -ENOENT;
 	}
 
-	phdr = kmalloc(size, GFP_KERNEL);
+	phdr = kmemdup(buffer, size, GFP_KERNEL);
 	if (!phdr)
 		return -ENOMEM;
-	memcpy(phdr, buffer, size);
 
 	pr_debug("sending %s(%d) size: %d\n",
 		  smscore_translate_msg(phdr->msg_type), phdr->msg_type,
