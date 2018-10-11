Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4D5C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F46B213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5+C4J3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F46B213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbeJKXEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJKXEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:04:12 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4382C20652;
        Thu, 11 Oct 2018 15:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272190;
        bh=4DGq5dCid/vOQAiPlfiahWejRjKC23ItipCwGN+mxI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5+C4J3+9WprmetTsae9pZT7ZBDSL6O7/frQthwUQ+7+xKaCN1uD38dOTF//5991X
         2iGqbNez4Ppo0ulvOYAZaQDkuOD2cvpAqnUrj+9FkmNi6wQfxcKyJogoio34MSefj1
         hoxkyCREZ6aAuHmQ1vD4o4xQj/iomq86RVIi1oNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Jann Horn <jannh@google.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 003/120] ALSA: emu10k1: fix possible info leak to userspace on SNDRV_EMU10K1_IOCTL_INFO
Date:   Thu, 11 Oct 2018 17:33:04 +0200
Message-Id: <20181011152549.645737249@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2521,7 +2521,7 @@ static int snd_emu10k1_fx8010_ioctl(stru
 		emu->support_tlv = 1;
 		return put_user(SNDRV_EMU10K1_VERSION, (int __user *)argp);
 	case SNDRV_EMU10K1_IOCTL_INFO:
-		info = kmalloc(sizeof(*info), GFP_KERNEL);
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info)
 			return -ENOMEM;
 		snd_emu10k1_fx8010_info(emu, info);


