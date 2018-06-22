Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDCAC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575C724087
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxXcyRpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575C724087
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932963AbeFVMEl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:04:41 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43095 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbeFVMEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:04:39 -0400
Received: by mail-lf0-f68.google.com with SMTP id l15-v6so1881776lfc.10;
        Fri, 22 Jun 2018 05:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ffM7Z3YskDRn4qbLyyIA5VmYZmTY1V9P3jrcSyJkiD4=;
        b=YxXcyRpt1DTJm+DGTSJGdR1VhVxZxjjI81EwQuUxW23ql2CRdzcGq+jb66YqoTq7Hy
         obxrqtXKDMwOuqH8Gv/bxn7kM9P4kYW0yM7x6wHU1InlRG6xSaHLKnVDpPCxGn6GPbMz
         HXyPtfgfZGdOBrImmLC2BqsX67gKOm0kmO5xGoWO+6y1DDLDWYjxeuZ/US4hnwPG0E/l
         cpAG6da7vPnGO3JS71OCvY3P6SrvHs51Z4NrgfAO+ENhpOteilUp0JTnUZyc2RZ8G1Nb
         x7AsTYShtwK6CG1rGA7PEYCmAsyFv+n4JfpNTHn8MFUPVPhfPhIdDQaxDVWFA42Qk/0X
         yQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ffM7Z3YskDRn4qbLyyIA5VmYZmTY1V9P3jrcSyJkiD4=;
        b=ewcxlJ1h/KZpw/9Lh6pFAp5IJCeg2wwAfmxfkH71N5CKHl5RNUpGxUeeK1OQcME7RA
         ONScskse98fQxtbPkKtGx0nzRsrfgp6Ry6ww8R9YDJ3TcYt9m4XsRoILgWtDAhPVQglk
         4mfCdeXfCKpuMQfAmNqgDv+apXPRg65QisxnAoiU1atZJBiUN4AeOi+fPBl8FPaCKmUZ
         HtNpAK3YbnNdnWsxTG/rL2LrJYXeC3wuO8fWry8RIshUFvJNdKvPzwwxj5w8OO3Z5q5x
         HRfsxtzbSodQWdmeQ9VhthbMKR77O37qP/kCuhcaYuUvyVY2Efi2wde41Qfdms2XfQkc
         YXGw==
X-Gm-Message-State: APt69E3d9qyIYmrnyIDoKGvwz0ObsdJvULBut/2/I48Pnksw/ZtI+l/O
        e/LLBcBonZHh2873WrXutrc=
X-Google-Smtp-Source: ADUXVKIquZ6+1+uy7zjmi2KC5yTRtWfgpwMs2BoWaLlKdt4jLfUnVrCzYWpubcTWqR+Wj6Cw3Q9t4w==
X-Received: by 2002:a2e:808e:: with SMTP id i14-v6mr1106812ljg.85.1529669076890;
        Fri, 22 Jun 2018 05:04:36 -0700 (PDT)
Received: from alpha.sai.msu.ru ([93.180.21.1])
        by smtp.gmail.com with ESMTPSA id a77-v6sm1433663lfb.37.2018.06.22.05.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 05:04:36 -0700 (PDT)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>, rostedt@goodmis.org,
        mingo@redhat.com, isely@pobox.com, bhumirks@gmail.com,
        colin.king@canonical.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, ezequiel@collabora.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v2 2/2] media: usb: pwc: Don't use coherent DMA buffers for ISO transfer
Date:   Fri, 22 Jun 2018 15:04:19 +0300
Message-Id: <20180622120419.7675-3-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180622120419.7675-1-matwey@sai.msu.ru>
References: <20180622120419.7675-1-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA cocherency slows the transfer down on systems without hardware
coherent DMA.

Based on previous commit the following performance benchmarks have been
carried out. Average memcpy() data transfer rate (rate) and handler
completion time (time) have been measured when running video stream at
640x480 resolution at 10fps.

x86_64 based system (Intel Core i5-3470). This platform has hardware
coherent DMA support and proposed change doesn't make big difference here.

 * kmalloc:            rate = (4.4 +- 1.0) GBps
                       time = (2.4 +- 1.2) usec
 * usb_alloc_coherent: rate = (4.1 +- 0.9) GBps
                       time = (2.5 +- 1.0) usec

We see that the measurements agree well within error ranges in this case.
So no performance downgrade is introduced.

armv7l based system (TI AM335x BeagleBone Black). This platform has no
hardware coherent DMA support. DMA coherence is implemented via disabled
page caching that slows down memcpy() due to memory controller behaviour.

 * kmalloc:            rate =  (190 +-  30) MBps
                       time =   (50 +-  10) usec
 * usb_alloc_coherent: rate =   (33 +-   4) MBps
                       time = (3000 +- 400) usec

Note, that quantative difference leads (this commit leads to 5 times
acceleration) to qualitative behavior change in this case. As it was
stated before, the video stream can not be successfully received at AM335x
platforms with MUSB based USB host controller due to performance issues
[1].

[1] https://www.spinics.net/lists/linux-usb/msg165735.html

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/media/usb/pwc/pwc-if.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
index 72d2897a4b9f..339a285600d1 100644
--- a/drivers/media/usb/pwc/pwc-if.c
+++ b/drivers/media/usb/pwc/pwc-if.c
@@ -427,11 +427,8 @@ static int pwc_isoc_init(struct pwc_device *pdev)
 		urb->interval = 1; // devik
 		urb->dev = udev;
 		urb->pipe = usb_rcvisocpipe(udev, pdev->vendpoint);
-		urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
-		urb->transfer_buffer = usb_alloc_coherent(udev,
-							  ISO_BUFFER_SIZE,
-							  GFP_KERNEL,
-							  &urb->transfer_dma);
+		urb->transfer_flags = URB_ISO_ASAP;
+		urb->transfer_buffer = kmalloc(ISO_BUFFER_SIZE, GFP_KERNEL);
 		if (urb->transfer_buffer == NULL) {
 			PWC_ERROR("Failed to allocate urb buffer %d\n", i);
 			pwc_isoc_cleanup(pdev);
@@ -491,10 +488,7 @@ static void pwc_iso_free(struct pwc_device *pdev)
 		if (pdev->urbs[i]) {
 			PWC_DEBUG_MEMORY("Freeing URB\n");
 			if (pdev->urbs[i]->transfer_buffer) {
-				usb_free_coherent(pdev->udev,
-					pdev->urbs[i]->transfer_buffer_length,
-					pdev->urbs[i]->transfer_buffer,
-					pdev->urbs[i]->transfer_dma);
+				kfree(pdev->urbs[i]->transfer_buffer);
 			}
 			usb_free_urb(pdev->urbs[i]);
 			pdev->urbs[i] = NULL;
-- 
2.16.4

