Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61167C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294E820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294E820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeLIWNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:13:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37872 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727943AbeLIWNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:13:10 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73L-0002im-PW; Sun, 09 Dec 2018 21:55:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003HP-Ev; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.310329406@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 066/328] ALSA: seq: Fix poll() error return
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit a49a71f6e25da2acc637fcd31e73debd96ca18f8 upstream.

The sanity checks in ALSA sequencer and OSS sequencer emulation codes
return falsely -ENXIO from poll callback.  They should be EPOLLERR
instead.

This was caught thanks to the recent change to the return value.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16: s/EPOLLERR/POLLERR/]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/seq/oss/seq_oss.c   | 2 +-
 sound/core/seq/seq_clientmgr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/sound/core/seq/oss/seq_oss.c
+++ b/sound/core/seq/oss/seq_oss.c
@@ -194,7 +194,7 @@ odev_poll(struct file *file, poll_table
 	struct seq_oss_devinfo *dp;
 	dp = file->private_data;
 	if (snd_BUG_ON(!dp))
-		return -ENXIO;
+		return POLLERR;
 	return snd_seq_oss_poll(dp, file, wait);
 }
 
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1110,7 +1110,7 @@ static unsigned int snd_seq_poll(struct
 
 	/* check client structures are in place */
 	if (snd_BUG_ON(!client))
-		return -ENXIO;
+		return POLLERR;
 
 	if ((snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_INPUT) &&
 	    client->data.user.fifo) {

