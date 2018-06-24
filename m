Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05182C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F722506C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F722506C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756073AbeFXPmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:42:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60054 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755228AbeFXPmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:42:20 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 30A662C;
        Sun, 24 Jun 2018 15:42:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Peres <martin.peres@free.fr>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.17 28/70] ALSA: usb-audio: Disable the quirk for Nura headset
Date:   Sun, 24 Jun 2018 23:22:20 +0800
Message-Id: <20180624142742.235160641@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
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

commit 5ebf6b1e459606d7fbf4fc67d2c28a6540953d93 upstream.

The commit 33193dca671c ("ALSA: usb-audio: Add a quirk for Nura's
first gen headset") added a quirk for Nura headset with USB ID
0a12:1243, with a hope that it doesn't conflict with others.
Unfortunately, other devices (e.g. Philips Wecall) with the very same
ID got broken by this change, spewing an error like:
  usb 2-1.8.2: 2:1: cannot set freq 48000 to ep 0x3

Until we find a proper solution, fix the regression at first by
disabling the added quirk entry.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199905
Fixes: 33193dca671c ("ALSA: usb-audio: Add a quirk for Nura's first gen headset")
Reviewed-by: Martin Peres <martin.peres@free.fr>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks-table.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3277,6 +3277,10 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge
 	}
 },
 
+/* disabled due to regression for other devices;
+ * see https://bugzilla.kernel.org/show_bug.cgi?id=199905
+ */
+#if 0
 {
 	/*
 	 * Nura's first gen headphones use Cambridge Silicon Radio's vendor
@@ -3324,6 +3328,7 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge
 		}
 	}
 },
+#endif /* disabled */
 
 {
 	/*


