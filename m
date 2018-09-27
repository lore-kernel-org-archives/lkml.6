Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A53C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDE421533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDE421533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbeI0PwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:52:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57380 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeI0PwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:52:00 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D6B3B1132;
        Thu, 27 Sep 2018 09:34:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Jann Horn <jannh@google.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 05/28] ALSA: emu10k1: fix possible info leak to userspace on SNDRV_EMU10K1_IOCTL_INFO
Date:   Thu, 27 Sep 2018 11:06:29 +0200
Message-Id: <20180927090637.904117871@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090637.687829444@linuxfoundation.org>
References: <20180927090637.687829444@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/emu10k1/emufx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -2520,7 +2520,7 @@ static int snd_emu10k1_fx8010_ioctl(stru
 		emu->support_tlv = 1;
 		return put_user(SNDRV_EMU10K1_VERSION, (int __user *)argp);
 	case SNDRV_EMU10K1_IOCTL_INFO:
-		info = kmalloc(sizeof(*info), GFP_KERNEL);
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info)
 			return -ENOMEM;
 		snd_emu10k1_fx8010_info(emu, info);


