Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0CAC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE7120862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE7120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbeHATzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:55:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405778AbeHATIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6831C10C6;
        Wed,  1 Aug 2018 17:03:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
        Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Hans Verkuil <hansverk@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 198/336] media: rcar_jpu: Add missing clk_disable_unprepare() on error in jpu_open()
Date:   Wed,  1 Aug 2018 18:48:53 +0200
Message-Id: <20180801165036.670145621@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

[ Upstream commit 43d0d3c52787df0221d1c52494daabd824fe84f1 ]

Add the missing clk_disable_unprepare() before return from
jpu_open() in the software reset error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Acked-by: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hansverk@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/rcar_jpu.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/rcar_jpu.c
+++ b/drivers/media/platform/rcar_jpu.c
@@ -1280,7 +1280,7 @@ static int jpu_open(struct file *file)
 		/* ...issue software reset */
 		ret = jpu_reset(jpu);
 		if (ret)
-			goto device_prepare_rollback;
+			goto jpu_reset_rollback;
 	}
 
 	jpu->ref_count++;
@@ -1288,6 +1288,8 @@ static int jpu_open(struct file *file)
 	mutex_unlock(&jpu->mutex);
 	return 0;
 
+jpu_reset_rollback:
+	clk_disable_unprepare(jpu->clk);
 device_prepare_rollback:
 	mutex_unlock(&jpu->mutex);
 v4l_prepare_rollback:


