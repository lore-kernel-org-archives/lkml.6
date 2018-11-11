Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6219C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E25E20872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOyomgDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E25E20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbeKLISf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732908AbeKLISd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:33 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5479C22353;
        Sun, 11 Nov 2018 22:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975317;
        bh=eCQ+R1+DpqiEO/1sBW6z/qJdkUJK+ImvEPDQl0mRwzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jOyomgDKFr8BBhWV+OGiNXKL3V5q5uA2CmTnZkOJ5LD4XjFlMcSY32+fRAdUwvro1
         2OFGMaK+CaPm/UlMGc83TzNxNBtGNkpltnqLeXl4ErfJTUVgfOWBma5FLJhBpIor5y
         ZH0CxETnvTn44yz8qo2nyh1PWaDaYqE2OA9fw4wQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 308/361] media: em28xx: make v4l2-compliance happier by starting sequence on zero
Date:   Sun, 11 Nov 2018 14:20:55 -0800
Message-Id: <20181111221658.041753848@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1093,6 +1093,8 @@ int em28xx_start_analog_streaming(struct
 
 	em28xx_videodbg("%s\n", __func__);
 
+	dev->v4l2->field_count = 0;
+
 	/*
 	 * Make sure streaming is not already in progress for this type
 	 * of filehandle (e.g. video, vbi)


