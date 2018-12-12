Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF819C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7628320851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7628320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeLLRUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:20:53 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.212]:20216 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727756AbeLLRUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:20:52 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 915DC77651
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 11:20:51 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id X8BngqS3M957pX8BngX2HR; Wed, 12 Dec 2018 11:20:51 -0600
X-Authority-Reason: nr=8
Received: from [189.250.70.203] (port=39074 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gX8Bm-001A90-Qi; Wed, 12 Dec 2018 11:20:50 -0600
Date:   Wed, 12 Dec 2018 11:20:49 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: emux_hwdep: Fix potential Spectre v1 vulnerabilities
Message-ID: <20181212172049.GA22723@embeddedor>
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
X-Exim-ID: 1gX8Bm-001A90-Qi
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.70.203]:39074
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

info.mode and info.port are indirectly controlled by user-space,
hence leading to a potential exploitation of the Spectre variant 1
vulnerability.

These issues were detected with the help of Smatch:

sound/synth/emux/emux_hwdep.c:72 snd_emux_hwdep_misc_mode() warn: potential spectre issue 'emu->portptrs[i]->ctrls' [w] (local cap)
sound/synth/emux/emux_hwdep.c:75 snd_emux_hwdep_misc_mode() warn: potential spectre issue 'emu->portptrs' [w] (local cap)
sound/synth/emux/emux_hwdep.c:75 snd_emux_hwdep_misc_mode() warn: potential spectre issue 'emu->portptrs[info.port]->ctrls' [w] (local cap)

Fix this by sanitizing both info.mode and info.port before using them
to index emu->portptrs[i]->ctrls, emu->portptrs[info.port]->ctrls and
emu->portptrs.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/synth/emux/emux_hwdep.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/synth/emux/emux_hwdep.c b/sound/synth/emux/emux_hwdep.c
index e557946718a9..a0d5cd99572f 100644
--- a/sound/synth/emux/emux_hwdep.c
+++ b/sound/synth/emux/emux_hwdep.c
@@ -24,6 +24,7 @@
 #include <linux/uaccess.h>
 #include "emux_voice.h"
 
+#include <linux/nospec.h>
 
 #define TMP_CLIENT_ID	0x1001
 
@@ -66,13 +67,16 @@ snd_emux_hwdep_misc_mode(struct snd_emux *emu, void __user *arg)
 		return -EFAULT;
 	if (info.mode < 0 || info.mode >= EMUX_MD_END)
 		return -EINVAL;
+	info.mode = array_index_nospec(info.mode, EMUX_MD_END);
 
 	if (info.port < 0) {
 		for (i = 0; i < emu->num_ports; i++)
 			emu->portptrs[i]->ctrls[info.mode] = info.value;
 	} else {
-		if (info.port < emu->num_ports)
+		if (info.port < emu->num_ports) {
+			info.port = array_index_nospec(info.port, emu->num_ports);
 			emu->portptrs[info.port]->ctrls[info.mode] = info.value;
+		}
 	}
 	return 0;
 }
-- 
2.17.1

