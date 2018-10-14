Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF59C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F77D20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F77D20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeJNXRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:17:12 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36672 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727388AbeJNXRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:17:11 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM3-0004cm-7e; Sun, 14 Oct 2018 16:30:55 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000Ka-Bc; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "=?UTF-8?q?Fabi=C3=A1n=20Inostroza?=" <soulsonceonfire@gmail.com>,
        "=?UTF-8?Q?Fabi=C3=A1n=20?=Inostroza" <fabianinostroza@udec.cl>,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.817872641@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 140/366] ALSA: line6: Use correct endpoint type for
 midi output
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Fabián Inostroza <soulsonceonfire@gmail.com>

commit 7ecb46e9ee9af18e304eb9e7d6804c59a408e846 upstream.

Sending MIDI messages to a PODxt through the USB connection shows
"usb_submit_urb failed" in dmesg and the message is not received by
the POD.

The error is caused because in the funcion send_midi_async() in midi.c
there is a call to usb_sndbulkpipe() for endpoint 3 OUT, but the PODxt
USB descriptor shows that this endpoint it's an interrupt endpoint.

Patch tested with PODxt only.

[ The bug has been present from the very beginning in the staging
  driver time, but Fixes below points to the commit moving to sound/
  directory so that the fix can be cleanly applied -- tiwai ]

Fixes: 61864d844c29 ("ALSA: move line6 usb driver into sound/usb")
Signed-off-by: Fabián Inostroza <fabianinostroza@udec.cl>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/line6/midi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/line6/midi.c
+++ b/drivers/staging/line6/midi.c
@@ -135,7 +135,7 @@ static int send_midi_async(struct usb_li
 	}
 
 	usb_fill_int_urb(urb, line6->usbdev,
-			 usb_sndbulkpipe(line6->usbdev,
+			 usb_sndintpipe(line6->usbdev,
 					 line6->ep_control_write),
 			 transfer_buffer, length, midi_sent, line6,
 			 line6->interval);

