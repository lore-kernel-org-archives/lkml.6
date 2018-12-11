Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6B9C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8082084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544799;
	bh=gdYCI4xs1aYeKaV5MNDfGiAciPXZeNxZ/GdiO00UOxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KHsXLtgZaoFwdYc5LziuSZeagoDhGWvVF2NRSSaDAaBawgJv2VMxvHq8BcHJTFKqa
	 izWfVu/VPMGxrUuFG8/AfkB3+CP1uI/fYW+/z5oJCDZxLJthTml6BZW3oeWe5TC3lO
	 80kz9q2YPJ3ANUS6kkbzk92gwVK6XqkP13saC+qE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8082084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeLKPtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:49:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:38188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbeLKPtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:49:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2FB42146D;
        Tue, 11 Dec 2018 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543388;
        bh=gdYCI4xs1aYeKaV5MNDfGiAciPXZeNxZ/GdiO00UOxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tYIo9ekdu0emc3dZUMtvfkBBhIL77gwYqW6SiEaKWezB+3VlI8yTQ+Twxev4UTLz9
         B7uEDue6jas6NFuC9/JTp0LgAoyZfWr7lC3yGmdgK47IO8LoaPXdw5UlQNeWIdSZvn
         Z/k4kYz3NyHp6BfLR8HRaXkXxkyCHbKvL6QtjhtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 24/51] ALSA: usb-audio: Fix UAF decrement if card has no live interfaces in card.c
Date:   Tue, 11 Dec 2018 16:41:32 +0100
Message-Id: <20181211151615.456699292@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
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
@@ -644,9 +644,12 @@ static int usb_audio_probe(struct usb_in
 
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


