Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC16FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1102133F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543263;
	bh=d4AmW7KN32kR5u2SlypY2SHLYWR5bzyMXGJsAOEsvtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vOwRJxp6jJ2yj6y1s7uEgXD5mQSyaRC97cB9sSnd64MnR/RNjHTpMvsAYY5rFPQ68
	 bPjA+2++0LSKxGrLnjFoqK2DlcQjmn3Edf+SGB7TvxANDfBufEU6rfTzOje2U9bj7i
	 ESvIWrcxpzwMEA8IwIqUIW1Qd+I7lRt8xXWMlCKE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1102133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeLKPrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:47:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728603AbeLKPrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:47:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B52E20989;
        Tue, 11 Dec 2018 15:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543259;
        bh=d4AmW7KN32kR5u2SlypY2SHLYWR5bzyMXGJsAOEsvtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hfbGPhwJohAtg1pqLWFAJJTwqTjt058Y2LQzy1P3HNwEgIBHNcx1M83vnFVG3Oknx
         XgJ5k56iuKUraVhNGo0HVtMy4l8rshSO5lAvZREbAHl4SBUh9See4emo05xzsUl/EM
         rZSkpIVJTg3lr+no6lUyW9eAkrlOGP8KQc2JZPT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 73/91] ALSA: usb-audio: Fix UAF decrement if card has no live interfaces in card.c
Date:   Tue, 11 Dec 2018 16:41:32 +0100
Message-Id: <20181211151612.376935704@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

From: Hui Peng <benquike@gmail.com>

commit 5f8cf712582617d523120df67d392059eaf2fc4b upstream.

If a USB sound card reports 0 interfaces, an error condition is triggered
and the function usb_audio_probe errors out. In the error path, there was a
use-after-free vulnerability where the memory object of the card was first
freed, followed by a decrement of the number of active chips. Moving the
decrement above the atomic_dec fixes the UAF.

[ The original problem was introduced in 3.1 kernel, while it was
  developed in a different form.  The Fixes tag below indicates the
  original commit but it doesn't mean that the patch is applicable
  cleanly. -- tiwai ]

Fixes: 362e4e49abe5 ("ALSA: usb-audio - clear chip->probing on error exit")
Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Signed-off-by: Hui Peng <benquike@gmail.com>
Signed-off-by: Mathias Payer <mathias.payer@nebelwelt.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/card.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -589,9 +589,12 @@ static int usb_audio_probe(struct usb_in
 
  __error:
 	if (chip) {
+		/* chip->active is inside the chip->card object,
+		 * decrement before memory is possibly returned.
+		 */
+		atomic_dec(&chip->active);
 		if (!chip->num_interfaces)
 			snd_card_free(chip->card);
-		atomic_dec(&chip->active);
 	}
 	mutex_unlock(&register_mutex);
 	return err;


