Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF798C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A312B21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499592;
	bh=WC4utT67xxDaNq7Ve0dGMUF+3iznKeNW/Q1CpYU2+YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=moyQu7rooe3OcKD/4jvArIhQV3tO2BNN4qOINV/X6YviUvBPsMjCRrmU5tYHiyqxB
	 fZadZsz9bNRjX8hQa2H1ZMIUQ0V9YgnGeRGWMkbSRzl1swg2/MXL9/d6/sMQtvQaQn
	 lUxD7VYMjJ3MmK7jlBTEM2HcHbJ0+F/CQ3O3B/SA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390849AbfBROTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:19:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389931AbfBROHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:07:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9E721917;
        Mon, 18 Feb 2019 14:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498870;
        bh=WC4utT67xxDaNq7Ve0dGMUF+3iznKeNW/Q1CpYU2+YA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9Av9UlD+YaBM/vu0Bh91/o3rP30DPpp2+ovgehYwFC8PG8adRwM6/fvs26apC29N
         +hkvucOoy2FgTwkKuUFGDjdmrSEgI5J7S1PcEZP76T5LB6Hm4loIXJ/Lu54zWUy2EU
         8Sm52z2x1FdrEnKQX4AQ65ZUe1YOQoGQEiGYXky0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manuel Reinhardt <manuel.rhdt@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 129/143] ALSA: usb-audio: Fix implicit fb endpoint setup by quirk
Date:   Mon, 18 Feb 2019 14:44:17 +0100
Message-Id: <20190218133533.703740169@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manuel Reinhardt <manuel.rhdt@gmail.com>

commit 2bc16b9f3223d049b57202ee702fcb5b9b507019 upstream.

The commit a60945fd08e4 ("ALSA: usb-audio: move implicit fb quirks to
separate function") introduced an error in the handling of quirks for
implicit feedback endpoints. This commit fixes this.

If a quirk successfully sets up an implicit feedback endpoint, usb-audio
no longer tries to find the implicit fb endpoint itself.

Fixes: a60945fd08e4 ("ALSA: usb-audio: move implicit fb quirks to separate function")
Signed-off-by: Manuel Reinhardt <manuel.rhdt@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/pcm.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -313,6 +313,9 @@ static int search_roland_implicit_fb(str
 	return 0;
 }
 
+/* Setup an implicit feedback endpoint from a quirk. Returns 0 if no quirk
+ * applies. Returns 1 if a quirk was found.
+ */
 static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 					 struct usb_device *dev,
 					 struct usb_interface_descriptor *altsd,
@@ -381,7 +384,7 @@ add_sync_ep:
 
 	subs->data_endpoint->sync_master = subs->sync_endpoint;
 
-	return 0;
+	return 1;
 }
 
 static int set_sync_endpoint(struct snd_usb_substream *subs,
@@ -420,6 +423,10 @@ static int set_sync_endpoint(struct snd_
 	if (err < 0)
 		return err;
 
+	/* endpoint set by quirk */
+	if (err > 0)
+		return 0;
+
 	if (altsd->bNumEndpoints < 2)
 		return 0;
 


