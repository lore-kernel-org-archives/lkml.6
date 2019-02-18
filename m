Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5701C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF9C217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499287;
	bh=0J5i8xdsAcnjmYggTGcvNcfS8PrR6A3ZpLam0rfM7ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bDI178PFLgxV6m/9o2NVOgzcu/I52O0n40A8J+ZH2mHjMgdAgL8jNepgH/AucheqU
	 bYT9ekAgNc98JIIIpO0/fjxOV4FFVoAmbiXT+d0HvjVBNYdW1wV2rGuOAR+zvx01x/
	 uR2WK1X6EjLyUC/VsNi3YyNYsCx5nWwzv+4+5X8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391551AbfBROMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:12:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:57434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392151AbfBROMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:12:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D776721905;
        Mon, 18 Feb 2019 14:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499166;
        bh=0J5i8xdsAcnjmYggTGcvNcfS8PrR6A3ZpLam0rfM7ZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKWuC6G5TYaAqRHjwRcxdiryZ9Nu0zoGNl4L/JH9QzyyfNFa2No9QJbEFrVA1meYV
         mZImB8YcajB/5YEuoCBJE3nJ2iCylUjfym5zzQhaFDxofLjlOuaixEt+Aigj4srGCB
         Ctuy5+Qg4epqKFBvu0s85WUBsbbIndrtqGhaZ0CQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manuel Reinhardt <manuel.rhdt@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 097/108] ALSA: usb-audio: Fix implicit fb endpoint setup by quirk
Date:   Mon, 18 Feb 2019 14:44:33 +0100
Message-Id: <20190218133524.155240213@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -311,6 +311,9 @@ static int search_roland_implicit_fb(str
 	return 0;
 }
 
+/* Setup an implicit feedback endpoint from a quirk. Returns 0 if no quirk
+ * applies. Returns 1 if a quirk was found.
+ */
 static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 					 struct usb_device *dev,
 					 struct usb_interface_descriptor *altsd,
@@ -370,7 +373,7 @@ add_sync_ep:
 
 	subs->data_endpoint->sync_master = subs->sync_endpoint;
 
-	return 0;
+	return 1;
 }
 
 static int set_sync_endpoint(struct snd_usb_substream *subs,
@@ -395,6 +398,10 @@ static int set_sync_endpoint(struct snd_
 	if (err < 0)
 		return err;
 
+	/* endpoint set by quirk */
+	if (err > 0)
+		return 0;
+
 	if (altsd->bNumEndpoints < 2)
 		return 0;
 


