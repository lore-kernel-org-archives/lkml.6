Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DB2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF062075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF062075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbeIHC1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:27:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57826 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeIHC1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:27:37 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9860E100B;
        Fri,  7 Sep 2018 21:44:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 3.18 27/29] udlfb: set optimal write delay
Date:   Fri,  7 Sep 2018 23:10:48 +0200
Message-Id: <20180907210911.310806868@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210909.523240901@linuxfoundation.org>
References: <20180907210909.523240901@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit bb24153a3f13dd0dbc1f8055ad97fe346d598f66 upstream.

The default delay 5 jiffies is too much when the kernel is compiled with
HZ=100 - it results in jumpy cursor in Xwindow.

In order to find out the optimal delay, I benchmarked the driver on
1280x720x30fps video. I found out that with HZ=1000, 10ms is acceptable,
but with HZ=250 or HZ=300, we need 4ms, so that the video is played
without any frame skips.

This patch changes the delay to this value.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/video/udlfb.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/video/udlfb.h
+++ b/include/video/udlfb.h
@@ -87,7 +87,7 @@ struct dlfb_data {
 #define MIN_RAW_PIX_BYTES	2
 #define MIN_RAW_CMD_BYTES	(RAW_HEADER_BYTES + MIN_RAW_PIX_BYTES)
 
-#define DL_DEFIO_WRITE_DELAY    5 /* fb_deferred_io.delay in jiffies */
+#define DL_DEFIO_WRITE_DELAY    msecs_to_jiffies(HZ <= 300 ? 4 : 10) /* optimal value for 720p video */
 #define DL_DEFIO_WRITE_DISABLE  (HZ*60) /* "disable" with long delay */
 
 /* remove these once align.h patch is taken into kernel */


