Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62A7C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01CD20880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543452;
	bh=zOOW3XkwnfgRFhCCWN6c+SPDl/m1IkW/OogYTGzHraE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fk3F5BmjJR2MMwdx6nL6SxeVSe3GPB0pkeRZIaJ5r4Ss84msJ0quQq3+G+oigR3/B
	 oVahUSiaqD/IcSd1F3geFZjIn0tkKCUetYqQsMq/aDGL/xo3zaTN/3E4phLyHU9V+x
	 MIc82a7UJ8BNfdwOSAdmp3AN5bF//ElaaF/anifI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01CD20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbeLKPuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:50:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbeLKPuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:50:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB5B2145D;
        Tue, 11 Dec 2018 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543446;
        bh=zOOW3XkwnfgRFhCCWN6c+SPDl/m1IkW/OogYTGzHraE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1QiZBJqOalC8n3nr6daXH22ffgE/ZgNsTXkOOUtExOtvUHkLKvGMBbYpR8qNp7lA9
         aObuq7mIu71t7iCGZoi8rwnJ4XZLRAICLPTixWq1Hr2mpaXexhV9HU03ZOf05EdmMv
         /zaY4To1mc46eScsEJOGuj6owh8/966NIlSTfZJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chanho Min <chanho.min@lge.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 27/51] ALSA: pcm: Call snd_pcm_unlink() conditionally at closing
Date:   Tue, 11 Dec 2018 16:41:35 +0100
Message-Id: <20181211151616.296412553@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit b51abed8355e5556886623b2772fa6b7598d2282 upstream.

Currently the PCM core calls snd_pcm_unlink() always unconditionally
at closing a stream.  However, since snd_pcm_unlink() invokes the
global rwsem down, the lock can be easily contended.  More badly, when
a thread runs in a high priority RT-FIFO, it may stall at spinning.

Basically the call of snd_pcm_unlink() is required only for the linked
streams that are already rare occasion.  For normal use cases, this
code path is fairly superfluous.

As an optimization (and also as a workaround for the RT problem
above in normal situations without linked streams), this patch adds a
check before calling snd_pcm_unlink() and calls it only when needed.

Reported-by: Chanho Min <chanho.min@lge.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/pcm_native.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2225,7 +2225,8 @@ int snd_pcm_hw_constraints_complete(stru
 
 static void pcm_release_private(struct snd_pcm_substream *substream)
 {
-	snd_pcm_unlink(substream);
+	if (snd_pcm_stream_linked(substream))
+		snd_pcm_unlink(substream);
 }
 
 void snd_pcm_release_substream(struct snd_pcm_substream *substream)


