Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45360C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F134F206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F134F206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbeIXSCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:02:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52954 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbeIXSCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:02:11 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6943D109A;
        Mon, 24 Sep 2018 12:00:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 025/111] video: fbdev: pxafb: clear allocated memory for video modes
Date:   Mon, 24 Sep 2018 13:51:52 +0200
Message-Id: <20180924113106.977527991@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Mack <daniel@zonque.org>

[ Upstream commit b951d80aaf224b1f774e10def672f5e37488e4ee ]

When parsing the video modes from DT properties, make sure to zero out
memory before using it. This is important because not all fields in the mode
struct are explicitly initialized, even though they are used later on.

Fixes: 420a488278e86 ("video: fbdev: pxafb: initial devicetree conversion")
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/pxafb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2128,8 +2128,8 @@ static int of_get_pxafb_display(struct d
 		return -EINVAL;
 
 	ret = -ENOMEM;
-	info->modes = kmalloc_array(timings->num_timings,
-				    sizeof(info->modes[0]), GFP_KERNEL);
+	info->modes = kcalloc(timings->num_timings, sizeof(info->modes[0]),
+			      GFP_KERNEL);
 	if (!info->modes)
 		goto out;
 	info->num_modes = timings->num_timings;


