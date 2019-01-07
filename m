Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47ADC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41FC206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864508;
	bh=6QQo4F7cAyCcyrT9kuHtzNB3HvVKZx8oElpb4mo1D10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1I2uXQhecx4am6vZOV5yWDDIZXjw04fXpPw1XFsTC5vJHJBCu3bk36+qgnQRgEuo5
	 7ofTQ7466xXcok+DaQEEtLVGTs9N0wV9hbj59EOqzYOFmrByZGV3nGL6Q0HcN2JCUC
	 mU3YKrFrNnFmu5D7PdOSXeEeFzhyp6cvmE1GuQUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfAGMfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbfAGMfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:35:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 400B4206BB;
        Mon,  7 Jan 2019 12:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864503;
        bh=6QQo4F7cAyCcyrT9kuHtzNB3HvVKZx8oElpb4mo1D10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnODXN589bHgY7xlRTxEz/uGDn1QKhMeCVo95WE6egaKqYan/Pg1O0Q2FpPIJIjOO
         6ZdLqCaDVsHjf49l5r/N1DHpOR7uzlxNnSjas2n3knciBbHUhqYwkDoAGqt6UoHusP
         8Dr+1CE+353VGYF5C/i0FAUzLK5LPQP0lROKULvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 033/145] ALSA: firewire-lib: fix wrong handling payload_length as payload_quadlet
Date:   Mon,  7 Jan 2019 13:31:10 +0100
Message-Id: <20190107104441.669659245@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit ada79fa5a0b374dd2c2262137c734da7524a8263 upstream.

In IEC 61883-1/6 engine of ALSA firewire stack, a packet handler has a
second argument for 'the number of bytes in payload of isochronous
packet'. However, an incoming packet handler without CIP header uses the
value as 'the number of quadlets in the payload'. This brings userspace
applications to receive the number of PCM frames as four times against
real time.

This commit fixes the bug.

Cc: <stable@vger.kernel.org> # v4.12+
Fixes: 3b196c394dd ('ALSA: firewire-lib: add no-header packet processing')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/amdtp-stream.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -654,15 +654,17 @@ end:
 }
 
 static int handle_in_packet_without_header(struct amdtp_stream *s,
-			unsigned int payload_quadlets, unsigned int cycle,
+			unsigned int payload_length, unsigned int cycle,
 			unsigned int index)
 {
 	__be32 *buffer;
+	unsigned int payload_quadlets;
 	unsigned int data_blocks;
 	struct snd_pcm_substream *pcm;
 	unsigned int pcm_frames;
 
 	buffer = s->buffer.packets[s->packet_index].buffer;
+	payload_quadlets = payload_length / 4;
 	data_blocks = payload_quadlets / s->data_block_quadlets;
 
 	trace_in_packet_without_header(s, cycle, payload_quadlets, data_blocks,


