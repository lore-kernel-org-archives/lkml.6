Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87DBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7695721B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898664;
	bh=u8wOfgbRPwfzjAx5qdRTCPp/pdcCDwJi9A+JwUD9wuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZqUyqjQPGqPwuoD5UJ48dFFaOhx1erSeWXKHgS8n43ggy+IOVxdqNJbvJu52ywdy1
	 tLER/+GZxrVGK8r3P3aUvgZZmx7SUbd6GpXDjMrDGt/Sdey+uaRYgaHW04kayA9uY+
	 wZ4rZnKGBIjA3aH6Ss0TrZSqG5IwNW1jFZ2Y0SMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390208AbfBKPYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390439AbfBKPCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:02:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25151222A7;
        Mon, 11 Feb 2019 15:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897356;
        bh=u8wOfgbRPwfzjAx5qdRTCPp/pdcCDwJi9A+JwUD9wuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6FrcNzjNzGDc3mbuYJ9uRdWmT8FTrnIZfb7Bi42wnBz9zhcjkwL6uLwYvDiy8xng
         /VGGcd6urwHvi7JvpcD1uY232gi9bjCN1fmMCdrKm0gcFwVSZU4JxMwREWPi6OMvMS
         vSR+o0cQhR+bO5v4UMlEMxhzTJVHu6PHnXS61g8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 175/205] ALSA: compress: Fix stop handling on compressed capture streams
Date:   Mon, 11 Feb 2019 15:19:33 +0100
Message-Id: <20190211141839.817450732@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

From: Charles Keepax <ckeepax@opensource.cirrus.com>

commit 4f2ab5e1d13d6aa77c55f4914659784efd776eb4 upstream.

It is normal user behaviour to start, stop, then start a stream
again without closing it. Currently this works for compressed
playback streams but not capture ones.

The states on a compressed capture stream go directly from OPEN to
PREPARED, unlike a playback stream which moves to SETUP and waits
for a write of data before moving to PREPARED. Currently however,
when a stop is sent the state is set to SETUP for both types of
streams. This leaves a capture stream in the situation where a new
start can't be sent as that requires the state to be PREPARED and
a new set_params can't be sent as that requires the state to be
OPEN. The only option being to close the stream, and then reopen.

Correct this issues by allowing snd_compr_drain_notify to set the
state depending on the stream direction, as we already do in
set_params.

Fixes: 49bb6402f1aa ("ALSA: compress_core: Add support for capture streams")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/sound/compress_driver.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -186,7 +186,11 @@ static inline void snd_compr_drain_notif
 	if (snd_BUG_ON(!stream))
 		return;
 
-	stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+	if (stream->direction == SND_COMPRESS_PLAYBACK)
+		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+	else
+		stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
+
 	wake_up(&stream->runtime->sleep);
 }
 


