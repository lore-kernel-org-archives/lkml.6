Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4F3C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6050C20651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865434;
	bh=yh9HmfRlpM/pnx6/oLqzIJsdsNRsil/KteFSepHh+N0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DnuE3oKfGA7Fp06OM7KcxIiDIzKsml4u2H+4WIA9gDBUv0A6FVwSTPysmj/c2E6WW
	 5dPjFckMnWktTDZMdQ9O+RyesyKKCURL1II0uDxsR93tGflllVUAz4dzmFcvx607rT
	 ePoXfaZUaC7tVLEx76CVHUqIfaqby6GaT7ICuXGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfAGMud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:50:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbfAGMtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:49:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2003D206BB;
        Mon,  7 Jan 2019 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865370;
        bh=yh9HmfRlpM/pnx6/oLqzIJsdsNRsil/KteFSepHh+N0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vwql5uQGBSesw1xjIoR2wUu3eo1oTdkQyoArJfKbQIM1wyr8uEHnEQtKH2fzO8BgH
         cWHrAbJNROQmhdH8urWEs5kVEHjZNI1sVKP9mOAGGlQl3CBFLWkt5cyWcDYKIm4CMC
         8R1pZ42vh2fHUyupmP9NArJ2fexHIt2dvkiPdS40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 070/170] ALSA: fireface: fix for state to fetch PCM frames
Date:   Mon,  7 Jan 2019 13:31:37 +0100
Message-Id: <20190107104501.279453219@linuxfoundation.org>
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

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 3d16200a3e55a39caa1c88419cb559c00316f721 upstream.

According to my memo at hand and saved records, writing 0x00000001 to
SND_FF_REG_FETCH_PCM_FRAMES disables fetching PCM frames in corresponding
channel, however current implement uses reversed logic. This results in
muted volume in device side during playback.

This commit corrects the bug.

Cc: <stable@vger.kernel.org> # v4.12+
Fixes: 76fdb3a9e13a ('ALSA: fireface: add support for Fireface 400')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/fireface/ff-protocol-ff400.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/firewire/fireface/ff-protocol-ff400.c
+++ b/sound/firewire/fireface/ff-protocol-ff400.c
@@ -152,7 +152,7 @@ static int ff400_switch_fetching_mode(st
 	if (reg == NULL)
 		return -ENOMEM;
 
-	if (enable) {
+	if (!enable) {
 		/*
 		 * Each quadlet is corresponding to data channels in a data
 		 * blocks in reverse order. Precisely, quadlets for available


