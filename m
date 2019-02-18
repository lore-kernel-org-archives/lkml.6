Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E6DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60DE21905
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498022;
	bh=FaUCWUL0E+cVL7VNnJE5Pn1K+e9U8eknfwiztOgRI+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g+fA+IvOm0RYSE27GdsyYuYgC45A+j95z4rv8THKPpSkXfmhV2erUNNksFlxSxaim
	 SkJlotPYEkTD7uNmHs4Maow6gnsCGK2lInjfAElugr4yzuXsDZQj0unDTGXtlxhm6O
	 ufrgF4TeM59fDVhTpc11+6xHRuTBsaaaPzpwQ38o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfBRNxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:53:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729373AbfBRNxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:53:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7123120842;
        Mon, 18 Feb 2019 13:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498016;
        bh=FaUCWUL0E+cVL7VNnJE5Pn1K+e9U8eknfwiztOgRI+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=llCK6s1EZYBDcT4K0mwuI18u/F+EajkRjS5cUvgE3gOnlTFGRPQ5j1gW0MD5nAiJm
         3hnYp+LNPq8KwswSgFldA0FJgHJXu7MKJudu9xuaxzjJt2+ffL9wi4dyOe4BmDdb6h
         O2YjiB2C85BiBxlf/SFa6+1rPRA7Y9X2CF2ZrdnU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manuel Reinhardt <manuel.rhdt@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 57/85] ALSA: usb-audio: Fix implicit fb endpoint setup by quirk
Date:   Mon, 18 Feb 2019 14:43:23 +0100
Message-Id: <20190218133505.626296767@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -314,6 +314,9 @@ static int search_roland_implicit_fb(str
 	return 0;
 }
 
+/* Setup an implicit feedback endpoint from a quirk. Returns 0 if no quirk
+ * applies. Returns 1 if a quirk was found.
+ */
 static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 					 struct usb_device *dev,
 					 struct usb_interface_descriptor *altsd,
@@ -384,7 +387,7 @@ add_sync_ep:
 
 	subs->data_endpoint->sync_master = subs->sync_endpoint;
 
-	return 0;
+	return 1;
 }
 
 static int set_sync_endpoint(struct snd_usb_substream *subs,
@@ -423,6 +426,10 @@ static int set_sync_endpoint(struct snd_
 	if (err < 0)
 		return err;
 
+	/* endpoint set by quirk */
+	if (err > 0)
+		return 0;
+
 	if (altsd->bNumEndpoints < 2)
 		return 0;
 


