Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558FCC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123202084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545249;
	bh=bNqmYzFVdSI04s6CDUnHpgpq6IaLy1txBZ8txt/GIQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2BAcjrojYx7+unFp3Xfgta2J+p2y25wusdehwDh/Wu8kytBOQypA0eNTTIlRsRqOD
	 p5dneLRNDzHVXdjrTPHXKUpqLLiucvJXS+eaTp/VIoVxolX1IiiOmXipmbJEkOR80I
	 t0g8drUbUrTwEyavbciUqHPmsht5JzxLMEpdM6qw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123202084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbeLKQUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:20:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbeLKPos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:44:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2971320855;
        Tue, 11 Dec 2018 15:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543087;
        bh=bNqmYzFVdSI04s6CDUnHpgpq6IaLy1txBZ8txt/GIQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1jonFGVsj5xXmOU+UV0zglIy/GUeOgepjsTS9XF2Tr9ccJKseRZSU5eAtipN58m4
         XbE7rcIo5hiszYslxv5E+5lH/gawB0oFhsUvfKgaEqSnxpbflZW+EFTcO2EG3Tc3sM
         pqplOOvs/dNPIG2SrllwG6mbG5vwiY+rpvryMZcI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chanho Min <chanho.min@lge.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 45/54] ALSA: pcm: Call snd_pcm_unlink() conditionally at closing
Date:   Tue, 11 Dec 2018 16:41:33 +0100
Message-Id: <20181211151548.595323479@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2193,7 +2193,8 @@ int snd_pcm_hw_constraints_complete(stru
 
 static void pcm_release_private(struct snd_pcm_substream *substream)
 {
-	snd_pcm_unlink(substream);
+	if (snd_pcm_stream_linked(substream))
+		snd_pcm_unlink(substream);
 }
 
 void snd_pcm_release_substream(struct snd_pcm_substream *substream)


