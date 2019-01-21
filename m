Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD0BC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E0620861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079887;
	bh=L1pb08f6z7zxYR16XpGyT9bxk/+ZvD8S0Gmc66ELjOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S32Cp2ucmY2Ts3N52zjQv7LNoTfl+3r//Bb6Vfy5bFpwM0wKTVXBDTbdPdFPOElLE
	 KqtcEJKoD9pOhXw9QwZKqNAlliQ9wJnuWHb6o+6hC2c88+7xCkyx5t2mPEYtWUcAyu
	 9XI7Ha2IUKRqAjUbkwEAFdLYJG1VRl3H3VzcWroU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbfAUNyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:54:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731424AbfAUNyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:54:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D43C621019;
        Mon, 21 Jan 2019 13:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078851;
        bh=L1pb08f6z7zxYR16XpGyT9bxk/+ZvD8S0Gmc66ELjOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xnRINeOW6hVLEltryZBqtiD7Kkh+nogldrZ3HbagjYaYsdmavCpPAQfATS6BAn8ri
         KE/sIM2mYuDKi0h7oJvQk5Zx0thtpO0HAu/6UhoYULzZwqDzwGMXq39Sx89jkhXk3j
         raZRLjvG+r+pvapURWYyVSLua6b4h6SGFgZpTHb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        syzbot+57c3d83d71187054d56f@syzkaller.appspotmail.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.14 39/59] media: vivid: set min width/height to a value > 0
Date:   Mon, 21 Jan 2019 14:44:04 +0100
Message-Id: <20190121122501.140288298@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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
-	V4L2_INIT_BT_TIMINGS(0, MAX_WIDTH, 0, MAX_HEIGHT, 14000000, 775000000,
+	V4L2_INIT_BT_TIMINGS(16, MAX_WIDTH, 16, MAX_HEIGHT, 14000000, 775000000,
 		V4L2_DV_BT_STD_CEA861 | V4L2_DV_BT_STD_DMT |
 		V4L2_DV_BT_STD_CVT | V4L2_DV_BT_STD_GTF,
 		V4L2_DV_BT_CAP_PROGRESSIVE | V4L2_DV_BT_CAP_INTERLACED)


