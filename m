Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0FEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109DF208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109DF208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbeHWLvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:51:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47006 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeHWLvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:51:06 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 56A32C83;
        Thu, 23 Aug 2018 08:22:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 085/217] ALSA: seq: Fix UBSAN warning at SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT ioctl
Date:   Thu, 23 Aug 2018 09:53:18 +0200
Message-Id: <20180823075509.329709357@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit c9a4c63888dbb79ce4d068ca1dd8b05bc3f156b1 ]

The kernel may spew a WARNING with UBSAN undefined behavior at
handling ALSA sequencer ioctl SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT:

UBSAN: Undefined behaviour in sound/core/seq/seq_clientmgr.c:2007:14
signed integer overflow:
2147483647 + 1 cannot be represented in type 'int'
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x122/0x1c8 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x86 lib/ubsan.c:159
 handle_overflow+0x1c2/0x21f lib/ubsan.c:190
  __ubsan_handle_add_overflow+0x2a/0x31 lib/ubsan.c:198
 snd_seq_ioctl_query_next_client+0x1ac/0x1d0 sound/core/seq/seq_clientmgr.c:2007
 snd_seq_ioctl+0x264/0x3d0 sound/core/seq/seq_clientmgr.c:2144
 ....

It happens only when INT_MAX is passed there, as we're incrementing it
unconditionally.  So the fix is trivial, check the value with
INT_MAX.  Although the bug itself is fairly harmless, it's better to
fix it so that fuzzers won't hit this again later.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200211
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/seq/seq_clientmgr.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2001,7 +2001,8 @@ static int snd_seq_ioctl_query_next_clie
 	struct snd_seq_client *cptr = NULL;
 
 	/* search for next client */
-	info->client++;
+	if (info->client < INT_MAX)
+		info->client++;
 	if (info->client < 0)
 		info->client = 0;
 	for (; info->client < SNDRV_SEQ_MAX_CLIENTS; info->client++) {


