Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EFDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E21214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vv/Q3hlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E21214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406723AbeKTD3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405697AbeKTD3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:29:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 723B12148E;
        Mon, 19 Nov 2018 17:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647102;
        bh=6kJMTAMZY/uAk0GaPoTjpxL40kv25xGzk0w7ZXa8SOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vv/Q3hlK0yrlHLhu0KiiKq9/akYm5Eo86qTykjBAxBHb1qlV28aJE6gFj6C88hio1
         VDI8oB0uJ4psC4+dyxM1l+BBoHwqNRVAQWBELUItzUcLZN235kF8L2nwnpqjYyA9HF
         QfoUp6wh2Y0QpAI+XVhMcmvHB4BVMSknci0eAJXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 3.18 51/90] media: em28xx: make v4l2-compliance happier by starting sequence on zero
Date:   Mon, 19 Nov 2018 17:29:33 +0100
Message-Id: <20181119162629.031705010@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

commit afeaade90db4c5dab93f326d9582be1d5954a198 upstream.

The v4l2-compliance tool complains if a video doesn't start
with a zero sequence number.

While this shouldn't cause any real problem for apps, let's
make it happier, in order to better check the v4l2-compliance
differences before and after patchsets.

This is actually an old issue. It is there since at least its
videobuf2 conversion, e. g. changeset 3829fadc461 ("[media]
em28xx: convert to videobuf2"), if VB1 wouldn't suffer from
the same issue.

Cc: stable@vger.kernel.org
Fixes: d3829fadc461 ("[media] em28xx: convert to videobuf2")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/em28xx/em28xx-video.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -1141,6 +1141,8 @@ static void em28xx_ctrl_notify(struct v4
 {
 	struct em28xx *dev = priv;
 
+	dev->v4l2->field_count = 0;
+
 	/*
 	 * In the case of non-AC97 volume controls, we still need
 	 * to do some setups at em28xx, in order to mute/unmute


