Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D70EC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25B8218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357804;
	bh=e1dYzrEXrlkpXm68a1Dinb40TpjhqcRgDhNmx+YkHnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KldJGt8OUVEOLrU80mftce9l8oM8Z5iGm4PM5u2SQWYnYb25v4Gr1h9jUE9gO7kpE
	 tw+V8DFx8MSJF0otON7GfK3m6HD+oL0yAswUBboj4vpe4srLfyd1P0kcqYwMR+UWIp
	 STbnfC+QRZEz9G72IcaAgd7w1aL+N1vaqsp2nhls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfAXTXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:23:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729805AbfAXTXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:23:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BA92218D9;
        Thu, 24 Jan 2019 19:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357796;
        bh=e1dYzrEXrlkpXm68a1Dinb40TpjhqcRgDhNmx+YkHnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MjbnN6p6m9ToJOmK4YaeMhI4q0UOK3nEsa/utmpWkiWUrVVa+cqBoBGgTSmYFuBJq
         G/DTkbcc5jKFrbGXYMK8mmPQOx/408mtmrcPsu+Rlv2qDpPDECEux1EZpTSEhoH+D0
         bR3EeuKwAtdi1bYa3KxJfMFoxaysNnsqY3/4ikOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        syzbot+57c3d83d71187054d56f@syzkaller.appspotmail.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 3.18 26/52] media: vivid: set min width/height to a value > 0
Date:   Thu, 24 Jan 2019 20:19:50 +0100
Message-Id: <20190124190146.554141242@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
References: <20190124190140.879495253@linuxfoundation.org>
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

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 9729d6d282a6d7ce88e64c9119cecdf79edf4e88 upstream.

The capture DV timings capabilities allowed for a minimum width and
height of 0. So passing a timings struct with 0 values is allowed
and will later cause a division by zero.

Ensure that the width and height must be >= 16 to avoid this.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-by: syzbot+57c3d83d71187054d56f@syzkaller.appspotmail.com
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vivid/vivid-vid-common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/vivid/vivid-vid-common.c
+++ b/drivers/media/platform/vivid/vivid-vid-common.c
@@ -33,7 +33,7 @@ const struct v4l2_dv_timings_cap vivid_d
 	.type = V4L2_DV_BT_656_1120,
 	/* keep this initialization for compatibility with GCC < 4.4.6 */
 	.reserved = { 0 },
-	V4L2_INIT_BT_TIMINGS(0, MAX_WIDTH, 0, MAX_HEIGHT, 25000000, 600000000,
+	V4L2_INIT_BT_TIMINGS(16, MAX_WIDTH, 16, MAX_HEIGHT, 25000000, 600000000,
 		V4L2_DV_BT_STD_CEA861 | V4L2_DV_BT_STD_DMT,
 		V4L2_DV_BT_CAP_PROGRESSIVE | V4L2_DV_BT_CAP_INTERLACED)
 };


