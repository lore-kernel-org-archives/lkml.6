Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252E1C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8032152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8032152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbeI0PfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:35:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbeI0PfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:35:06 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EAEAD1112;
        Thu, 27 Sep 2018 09:17:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 21/64] ALSA: fireface: fix memory leak in ff400_switch_fetching_mode()
Date:   Thu, 27 Sep 2018 11:03:38 +0200
Message-Id: <20180927090252.954632600@linuxfoundation.org>
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

commit 36f3a6e02c143a7e9e4e143e416371f67bc1fae6 upstream.

An allocated memory forgets to be released.

Fixes: 76fdb3a9e13 ('ALSA: fireface: add support for Fireface 400')
Cc: <stable@vger.kernel.org> # 4.12+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/fireface/ff-protocol-ff400.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/sound/firewire/fireface/ff-protocol-ff400.c
+++ b/sound/firewire/fireface/ff-protocol-ff400.c
@@ -146,6 +146,7 @@ static int ff400_switch_fetching_mode(st
 {
 	__le32 *reg;
 	int i;
+	int err;
 
 	reg = kzalloc(sizeof(__le32) * 18, GFP_KERNEL);
 	if (reg == NULL)
@@ -163,9 +164,11 @@ static int ff400_switch_fetching_mode(st
 			reg[i] = cpu_to_le32(0x00000001);
 	}
 
-	return snd_fw_transaction(ff->unit, TCODE_WRITE_BLOCK_REQUEST,
-				  FF400_FETCH_PCM_FRAMES, reg,
-				  sizeof(__le32) * 18, 0);
+	err = snd_fw_transaction(ff->unit, TCODE_WRITE_BLOCK_REQUEST,
+				 FF400_FETCH_PCM_FRAMES, reg,
+				 sizeof(__le32) * 18, 0);
+	kfree(reg);
+	return err;
 }
 
 static void ff400_dump_sync_status(struct snd_ff *ff,


