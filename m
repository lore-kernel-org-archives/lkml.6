Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBD4C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703CD208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703CD208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeHUJor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:44:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55726 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbeHUJor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:44:47 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 679BABE1;
        Tue, 21 Aug 2018 06:25:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.17 25/42] ALSA: seq: Fix poll() error return
Date:   Tue, 21 Aug 2018 08:20:57 +0200
Message-Id: <20180821055018.890422334@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055017.596264829@linuxfoundation.org>
References: <20180821055017.596264829@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit a49a71f6e25da2acc637fcd31e73debd96ca18f8 upstream.

The sanity checks in ALSA sequencer and OSS sequencer emulation codes
return falsely -ENXIO from poll callback.  They should be EPOLLERR
instead.

This was caught thanks to the recent change to the return value.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/oss/seq_oss.c   |    2 +-
 sound/core/seq/seq_clientmgr.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/sound/core/seq/oss/seq_oss.c
+++ b/sound/core/seq/oss/seq_oss.c
@@ -203,7 +203,7 @@ odev_poll(struct file *file, poll_table
 	struct seq_oss_devinfo *dp;
 	dp = file->private_data;
 	if (snd_BUG_ON(!dp))
-		return -ENXIO;
+		return EPOLLERR;
 	return snd_seq_oss_poll(dp, file, wait);
 }
 
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1101,7 +1101,7 @@ static __poll_t snd_seq_poll(struct file
 
 	/* check client structures are in place */
 	if (snd_BUG_ON(!client))
-		return -ENXIO;
+		return EPOLLERR;
 
 	if ((snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_INPUT) &&
 	    client->data.user.fifo) {


