Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC903C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9268B20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9268B20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeLLVgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:36:33 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.133]:16981 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726297AbeLLVgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:36:32 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 670D3400C745D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 15:36:31 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id XCBDgL67Jp9J8XCBDgzaLp; Wed, 12 Dec 2018 15:36:31 -0600
X-Authority-Reason: nr=8
Received: from [189.250.70.203] (port=58926 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gXCBC-00447J-MA; Wed, 12 Dec 2018 15:36:30 -0600
Date:   Wed, 12 Dec 2018 15:36:28 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: pcm: Fix potential Spectre v1 vulnerability
Message-ID: <20181212213628.GA29911@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.70.203
X-Source-L: No
X-Exim-ID: 1gXCBC-00447J-MA
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.70.203]:58926
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stream is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

sound/core/pcm.c:140 snd_pcm_control_ioctl() warn: potential spectre issue 'pcm->streams' [r] (local cap)

Fix this by sanitizing stream before using it to index pcm->streams

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/core/pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index fdb9b92fc8d6..23141003a90d 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -32,6 +32,8 @@
 #include <sound/control.h>
 #include <sound/info.h>
 
+#include <linux/nospec.h>
+
 #include "pcm_local.h"
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>, Abramo Bagnara <abramo@alsa-project.org>");
@@ -129,6 +131,7 @@ static int snd_pcm_control_ioctl(struct snd_card *card,
 				return -EFAULT;
 			if (stream < 0 || stream > 1)
 				return -EINVAL;
+			stream = array_index_nospec(stream, 2);
 			if (get_user(subdevice, &info->subdevice))
 				return -EFAULT;
 			mutex_lock(&register_mutex);
-- 
2.17.1

