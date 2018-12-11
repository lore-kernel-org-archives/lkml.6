Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878B7C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3802146F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543544;
	bh=zyheu7K6z8sRm+/vrgXK0hwaDWqZp9kgrbautQe1REM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WUbcEQzQLp1yvXs0dwyxAKSOz2usIef0I2OGHITu1bq2JpekGsGDSf2jYZJzEDfGj
	 dKJqEFzCaF0kwQzqxIMzZKN4aDg4D7HRuti2p7y3/v8XKRTXFRUXsr6Kk/WedI48vn
	 BTadlrBprp9cj47wqH5RB5t+OVyy+G+sJ/yw/mnU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3802146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbeLKPwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:52:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:40972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729676AbeLKPwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:52:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B7720855;
        Tue, 11 Dec 2018 15:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543536;
        bh=zyheu7K6z8sRm+/vrgXK0hwaDWqZp9kgrbautQe1REM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zQ5OHduwL9X4pdcVQSwyk8arD12U4qGgeakpEppHLihZuIN8uPDzZhP2ETXS+70aE
         GXM7lFLqxDTw9OpJH+0wpM9YBV7N8gc7zIHAvpjflTGZbQ2D0edRFhPWUcFaypDrYc
         6tHAZlLjDaBcAvHf8Km8MCRvQ25rjTpLGeU7DR7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Peng <benquike@gmail.com>,
        Mathias Payer <mathias.payer@nebelwelt.net>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 34/67] ALSA: usb-audio: Fix UAF decrement if card has no live interfaces in card.c
Date:   Tue, 11 Dec 2018 16:41:34 +0100
Message-Id: <20181211151632.109062236@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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


