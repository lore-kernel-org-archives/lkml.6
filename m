Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DE1C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60AD20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60AD20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeLIWWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:22:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35174 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726510AbeLIVzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:21 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0002ic-6o; Sun, 09 Dec 2018 21:55:18 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0003Yd-GZ; Sun, 09 Dec 2018 21:55:15 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jann Horn" <jannh@google.com>,
        "Takashi Iwai" <tiwai@suse.de>, "Willy Tarreau" <w@1wt.eu>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.328174599@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 228/328] ALSA: emu10k1: fix possible info leak to
 userspace on SNDRV_EMU10K1_IOCTL_INFO
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

From: Willy Tarreau <w@1wt.eu>

commit 49434c6c575d2008c0abbc93e615019f39e01252 upstream.

snd_emu10k1_fx8010_ioctl(SNDRV_EMU10K1_IOCTL_INFO) allocates
memory using kmalloc() and partially fills it by calling
snd_emu10k1_fx8010_info() before returning the resulting
structure to userspace, leaving uninitialized holes. Let's
just use kzalloc() here.

BugLink: http://blog.infosectcbr.com.au/2018/09/linux-kernel-infoleaks.html
Signed-off-by: Willy Tarreau <w@1wt.eu>
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/emu10k1/emufx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -2521,7 +2521,7 @@ static int snd_emu10k1_fx8010_ioctl(stru
 		emu->support_tlv = 1;
 		return put_user(SNDRV_EMU10K1_VERSION, (int __user *)argp);
 	case SNDRV_EMU10K1_IOCTL_INFO:
-		info = kmalloc(sizeof(*info), GFP_KERNEL);
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info)
 			return -ENOMEM;
 		snd_emu10k1_fx8010_info(emu, info);

