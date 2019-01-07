Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD701C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E19D20651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865531;
	bh=jPS2ZwoyxihOzYUZHRsuZkRuqBqhXkUuz6+HuAufrYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xnqp7NIegNWwB39YCtqbsSMmSOcv1M5w2fMbvJdxfWDFaOFS4Nrgzx6MQYDvto70a
	 a/x7j5wqVwXLwtB9TxzHcpMzOtwG+lkdcnInXGEvTNGFn73+FnhsqML/IfR4CVMW3B
	 TG61pE3qEu6RnT5p0BNErMX8XFVPHhQobcNFA7uQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfAGMwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:52:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfAGMwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:52:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01A8020859;
        Mon,  7 Jan 2019 12:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865528;
        bh=jPS2ZwoyxihOzYUZHRsuZkRuqBqhXkUuz6+HuAufrYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4Khwa9YcCWSXShZ69f4Sbz7d/Cse4eDSd6weDdyl39mbOWB6Gr5nuuYo+hQN7i7e
         FUS9C/hcqN44UzTbpnwh9x5ZnCygKcWP4Nvms368EotVFbmZSjjcbY0GNB6Mj6YZrv
         XxNr/r++mM6UswI3g5r3+gCAjRrpj3ZAQ179pYGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 063/170] ALSA: emux: Fix potential Spectre v1 vulnerabilities
Date:   Mon,  7 Jan 2019 13:31:30 +0100
Message-Id: <20190107104500.467427706@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


