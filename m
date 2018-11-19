Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2350CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF84D20989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrUOfwXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF84D20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732399AbeKTDCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:02:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731789AbeKTDCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:02:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 456A5208E4;
        Mon, 19 Nov 2018 16:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645487;
        bh=oWCtfpi68nU95c62X41bkqd3ZvfdYleF9rXbC4jTux0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KrUOfwXGBVp86B1SZM5OW+q6t1d5UkWvNMnOCMNPGxLO8uLlyxdp5Ixv+LI0bv98Z
         0MAPd9Q2qZe+2STFF0kA5OxzbKS5K+subF9uv1BSqVOSi3I7VAMTAfJZjonNECMQwR
         dIGc4cWS1tYyc05cBk/22cH0rC9UFpAHHvCkbaf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 4.19 180/205] drm/etnaviv: fix bogus fence complete check in timeout handler
Date:   Mon, 19 Nov 2018 17:28:07 +0100
Message-Id: <20181119162641.178596387@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
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

From: Lucas Stach <l.stach@pengutronix.de>

commit 6fce3a406108ee6c8a61e2a33e52e9198a626ea0 upstream.

The GPU hardware fences and the job out-fences are on different timelines
so it's wrong to compare them. Fix this by only looking at the out-fence.

Cc: <stable@vger.kernel.org>
Fixes: 2c83a726d6fb (drm/etnaviv: bring back progress check in job
                     timeout handler)
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/etnaviv/etnaviv_sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
@@ -93,7 +93,7 @@ static void etnaviv_sched_timedout_job(s
 	 * If the GPU managed to complete this jobs fence, the timout is
 	 * spurious. Bail out.
 	 */
-	if (fence_completed(gpu, submit->out_fence->seqno))
+	if (dma_fence_is_signaled(submit->out_fence))
 		return;
 
 	/*


