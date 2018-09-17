Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA01ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8262146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8262146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbeIREh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49908 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbeIREhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:55 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6ED3B707;
        Mon, 17 Sep 2018 23:08:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.18 034/158] ALSA: hda - Fix cancel_work_sync() stall from jackpoll work
Date:   Tue, 18 Sep 2018 00:41:04 +0200
Message-Id: <20180917211712.643874845@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 16037643969e095509cd8446a3f8e406a6dc3a2c upstream.

On AMD/ATI controllers, the HD-audio controller driver allows a bus
reset upon the error recovery, and its procedure includes the
cancellation of pending jack polling work as found in
snd_hda_bus_codec_reset().  This works usually fine, but it becomes a
problem when the reset happens from the jack poll work itself; then
calling cancel_work_sync() from the work being processed tries to wait
the finish endlessly.

As a workaround, this patch adds the check of current_work() and
applies the cancel_work_sync() only when it's not from the
jackpoll_work.

This doesn't fix the root cause of the reported error below, but at
least, it eases the unexpected stall of the whole system.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200937
Cc: <stable@vger.kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_codec.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3910,7 +3910,8 @@ void snd_hda_bus_reset_codecs(struct hda
 
 	list_for_each_codec(codec, bus) {
 		/* FIXME: maybe a better way needed for forced reset */
-		cancel_delayed_work_sync(&codec->jackpoll_work);
+		if (current_work() != &codec->jackpoll_work.work)
+			cancel_delayed_work_sync(&codec->jackpoll_work);
 #ifdef CONFIG_PM
 		if (hda_codec_is_power_on(codec)) {
 			hda_call_codec_suspend(codec);


