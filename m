Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C93C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F18F217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866903;
	bh=I1aT4ebsSEIyXdVW4XUuw4JdkiEopFoYaohNR8afd7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sAFRLGXiHP4P25ZWRgSdNkBF4MtFZplkL9H7tJCR6LGrmVUlKsYnGY3XmEX0UrrAr
	 1daTM6xTCfPABwOeNDv1QqWxrFb0u8ylemP1mwhEQh1uv+6u3CaBIwLMp8TNdiZIyx
	 9go4rQZJnyB4OOUb+Mx1s5hWjmiPLpTQIQ+tWn6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbfAGNPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:15:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbfAGNCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:02:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE844206BB;
        Mon,  7 Jan 2019 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866138;
        bh=I1aT4ebsSEIyXdVW4XUuw4JdkiEopFoYaohNR8afd7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQEqqXLs/tMTa9pSSdngxTkfL4GcLh5dEQkU3ml84owYrYFz9XEJfJ25vvdJ5Slm2
         j/R97MAEbmueBBySJViRVUnfwcNTMzQ/sSc/U+fMMFyGSgWAAIYHSmGRpVytuWGFeF
         hr4N02Iy45XsagW3x8gNYKleBm3NhWxNzjO6dAnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 041/101] ALSA: emux: Fix potential Spectre v1 vulnerabilities
Date:   Mon,  7 Jan 2019 13:32:29 +0100
Message-Id: <20190107105335.153209841@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 4aea96f4237cea0c51a8bc87c0db31f0f932f1f0 upstream.

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

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: stable@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/synth/emux/emux_hwdep.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/sound/synth/emux/emux_hwdep.c
+++ b/sound/synth/emux/emux_hwdep.c
@@ -22,9 +22,9 @@
 #include <sound/core.h>
 #include <sound/hwdep.h>
 #include <linux/uaccess.h>
+#include <linux/nospec.h>
 #include "emux_voice.h"
 
-
 #define TMP_CLIENT_ID	0x1001
 
 /*
@@ -66,13 +66,16 @@ snd_emux_hwdep_misc_mode(struct snd_emux
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


