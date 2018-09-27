Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F62C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249B92150D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249B92150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbeI0PnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:43:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56810 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbeI0PnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:43:09 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6B5F51133;
        Thu, 27 Sep 2018 09:25:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 08/44] ALSA: firewire-tascam: fix memory leak of private data
Date:   Thu, 27 Sep 2018 11:03:57 +0200
Message-Id: <20180927090119.088605554@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090117.997362691@linuxfoundation.org>
References: <20180927090117.997362691@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 8d28277c065a974873c6781d44b7bcdcd8fb4e8a upstream.

Although private data of sound card instance is usually allocated in the
tail of the instance, drivers in ALSA firewire stack allocate the private
data before allocating the instance. In this case, the private data
should be released explicitly at .private_free callback of the instance.

This commit fixes memory leak following to the above design.

Fixes: b610386c8afb ('ALSA: firewire-tascam: deleyed registration of sound card')
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/tascam/tascam.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/firewire/tascam/tascam.c
+++ b/sound/firewire/tascam/tascam.c
@@ -93,6 +93,7 @@ static void tscm_free(struct snd_tscm *t
 	fw_unit_put(tscm->unit);
 
 	mutex_destroy(&tscm->mutex);
+	kfree(tscm);
 }
 
 static void tscm_card_free(struct snd_card *card)


