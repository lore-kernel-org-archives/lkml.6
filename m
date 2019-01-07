Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C22AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E681420665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865005;
	bh=FyhnPYe7ID1quoPaxXwdSuvPczTeltxsk3tPSQGgrQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YMcholyiPhAWATaD5O0cqj7s3jGGR6/WNnBDR8BcQRAv8IDcxN5n9ZnGP4HO7Md7a
	 ujG1dzsf7SN+aLoDJGcTTE7ni0lgImr92REy//Hv82Eo8lIrW6ROi1wMzmWDSMh0B7
	 0W6uZG6NQhkLZ7Dk3dAEsdleZKlfFFUdpAQfTP98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfAGMnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:43:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbfAGMnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:43:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61DCF20665;
        Mon,  7 Jan 2019 12:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865000;
        bh=FyhnPYe7ID1quoPaxXwdSuvPczTeltxsk3tPSQGgrQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DGvfonPkCs6YPVWHK2/b2UnYO2iVAMoQyMmn7gNuQP/wdeeo5+t0A21y2D7YooMjW
         8vJZ2g6+myylS914jhOXdd2h5LN2bJdKp/nCYJqKe77mqwmKpnprREyyaUbyH9lb9f
         TOHfEFZXmpJnixaL2j+GjSrUhpB8dZaw2t/6BHW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        syzbot+0cc8e3cc63ca373722c6@syzkaller.appspotmail.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.20 114/145] media: vivid: free bitmap_cap when updating std/timings/etc.
Date:   Mon,  7 Jan 2019 13:32:31 +0100
Message-Id: <20190107104452.133369375@linuxfoundation.org>
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

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 560ccb75c2caa6b1039dec1a53cd2ef526f5bf03 upstream.

When vivid_update_format_cap() is called it should free any overlay
bitmap since the compose size will change.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-by: syzbot+0cc8e3cc63ca373722c6@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>      # for v3.18 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vivid/vivid-vid-cap.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/platform/vivid/vivid-vid-cap.c
+++ b/drivers/media/platform/vivid/vivid-vid-cap.c
@@ -449,6 +449,8 @@ void vivid_update_format_cap(struct vivi
 		tpg_s_rgb_range(&dev->tpg, v4l2_ctrl_g_ctrl(dev->rgb_range_cap));
 		break;
 	}
+	vfree(dev->bitmap_cap);
+	dev->bitmap_cap = NULL;
 	vivid_update_quality(dev);
 	tpg_reset_source(&dev->tpg, dev->src_rect.width, dev->src_rect.height, dev->field_cap);
 	dev->crop_cap = dev->src_rect;


