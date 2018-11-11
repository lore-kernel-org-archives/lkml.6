Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E97DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAF72154B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCFci5n6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAF72154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404115AbeKLIXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390866AbeKLIXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:02 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D55223CB;
        Sun, 11 Nov 2018 22:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975585;
        bh=ibSWNeGlobesSXXlq/4o+ITM/VkSb+/68VQgnwMBcok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCFci5n67jhl+hZzUY8BX8do2rJkNt+CokOOp+7JjQHVo2qCz977cuOnEFiuUwhda
         MsHHg7FLVBLFYaaWJ/C425qzTSNRgd60B116CypYqyGpyPa9dqvGX/Oee7gsJdnvpr
         LzdKPbQ1oUUSj6gDmav/+DORz1f6frfTjJWoGMHA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.14 187/222] media: em28xx: make v4l2-compliance happier by starting sequence on zero
Date:   Sun, 11 Nov 2018 14:24:44 -0800
Message-Id: <20181111221703.688488683@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -900,6 +900,8 @@ static int em28xx_enable_analog_tuner(st
 	if (!mdev || !v4l2->decoder)
 		return 0;
 
+	dev->v4l2->field_count = 0;
+
 	/*
 	 * This will find the tuner that is connected into the decoder.
 	 * Technically, this is not 100% correct, as the device may be


