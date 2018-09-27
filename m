Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5068DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFA42152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFA42152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeI0Pkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:40:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56576 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeI0Pkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:40:41 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4C74C1120;
        Thu, 27 Sep 2018 09:23:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 26/64] ALSA: oxfw: fix memory leak of discovered stream formats at error path
Date:   Thu, 27 Sep 2018 11:03:43 +0200
Message-Id: <20180927090253.832339965@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 1064bc685d359f549f91c2d5f111965a9284f328 upstream.

After finishing discover of stream formats, ALSA OXFW driver has memory
leak of allocated memory object at error path.

This commit releases the memory object at the error path.

Fixes: 6c29230e2a5f ('ALSA: oxfw: delayed registration of sound card')
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/oxfw/oxfw.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -213,6 +213,7 @@ static int detect_quirks(struct snd_oxfw
 static void do_registration(struct work_struct *work)
 {
 	struct snd_oxfw *oxfw = container_of(work, struct snd_oxfw, dwork.work);
+	int i;
 	int err;
 
 	if (oxfw->registered)
@@ -275,6 +276,12 @@ error:
 	snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->rx_stream);
 	if (oxfw->has_output)
 		snd_oxfw_stream_destroy_simplex(oxfw, &oxfw->tx_stream);
+	for (i = 0; i < SND_OXFW_STREAM_FORMAT_ENTRIES; ++i) {
+		kfree(oxfw->tx_stream_formats[i]);
+		oxfw->tx_stream_formats[i] = NULL;
+		kfree(oxfw->rx_stream_formats[i]);
+		oxfw->rx_stream_formats[i] = NULL;
+	}
 	snd_card_free(oxfw->card);
 	kfree(oxfw->spec);
 	oxfw->spec = NULL;


