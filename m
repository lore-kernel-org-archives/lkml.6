Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AA9C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB692146E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543568;
	bh=yOcMnFI15QpVxlu9SOF0w4mrW8WV1e2b7GBW1GfMKCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PilYrE/0LQVlMOndSps88c3kPXytg0C98Rx7fIDwL/xDagepfg12DS/sZxZuiQO5B
	 iZ5VHmY1/eNiUBFelo2/GhLWZIgFELZvSvUGO5Jbjd4HOkEsmXH5YIjb5cq0D/ATJD
	 ab/fXbHr1CZ9ftNNHd85NHijaEBEZ0Jih38qegv8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB692146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeLKPwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:52:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbeLKPwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:52:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B9BC2145D;
        Tue, 11 Dec 2018 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543559;
        bh=yOcMnFI15QpVxlu9SOF0w4mrW8WV1e2b7GBW1GfMKCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aLTbphFzv+6g0ufCmYovF3F1XDKcAT0bLDx9E7t0dbcR7TxCWfhD0n31Vo6Z+87V1
         GqafRKqEhJfOklEN1KR2JGExIdBMUuXZzi272zrCnM4LGKAKw5apmqB18DwA0smreW
         TofqSiG7CO6LaEVsZQaAwTBAugeMkE5c2yT5z98o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chanho Min <chanho.min@lge.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 37/67] ALSA: pcm: Call snd_pcm_unlink() conditionally at closing
Date:   Tue, 11 Dec 2018 16:41:37 +0100
Message-Id: <20181211151632.267356344@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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
@@ -2338,7 +2338,8 @@ int snd_pcm_hw_constraints_complete(stru
 
 static void pcm_release_private(struct snd_pcm_substream *substream)
 {
-	snd_pcm_unlink(substream);
+	if (snd_pcm_stream_linked(substream))
+		snd_pcm_unlink(substream);
 }
 
 void snd_pcm_release_substream(struct snd_pcm_substream *substream)


