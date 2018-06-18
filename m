Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8181EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C7B208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C7B208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933998AbeFRPkK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:40:10 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:35953 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932442AbeFRPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:40:08 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LheU5-1fzLKj45qb-00mwck; Mon, 18 Jun 2018 17:40:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: avoid using 'timespec'
Date:   Mon, 18 Jun 2018 17:39:42 +0200
Message-Id: <20180618153959.2169325-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:ZdeoPOOJT9Ro/rbS97oUpW3HbzobVPg+/VvV5rkRaRuMGMnh4gm
 GgwhoWJX4wIUnDmw7Ce3scdPv2afBkMJpoG+4nSXLLjo4TMpftpEgIIG/tDtEfrhCybqxGT
 GdSDEqCW+SmhhbG3w+ZCfNTvQtlnZvNJlxTwD1wOa1LC4rOp0FW60NBviUgUOIEWfy49oRn
 lrARVN99LjYcZESbYzn2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V4zlwv3sXTA=:LHPVF+/8LGLNnMp1dcjCgU
 L/6t9UtbLmAo7HIYuL7fh7pll0c4jXYr8ZlArtd97K7Ue40jsVdjPvXQ6JQMVxL9meQc6tLEL
 7XdMR9uMTsOZf3cz440gsZcP7MZlAb2vO2o9h8LQUYc5jvQizebSlLPj5hpXxcIwlApN9a4Ke
 qRvBTkO2hpJ13AHuL35UqhmDAc4NnH0T4/zrSm/7adaGmKQssdFJMYu8cba+uJfV33wSkfEM9
 YYTEIfp0JeoLUEuw+B35QBN3dY90Uq2sdLluUGyAgcicW0ajD8l2YJi5HJhCBMgoDcD0TKafg
 QqH9gAUG6j2fQEmkL4PJ7091l7gYtmglNwMfW2+PbpOWc9yZ1/k12laceyFLLHYNM1Y+bg+KQ
 55YUh6FjqFzEwcnAQjkhBizSgCf2mip2QG83A7hF6vatS4IeF4d/C8xEWxA/V5idfblANn1WR
 hy0uysdosdEJPM36j0PeQwO1uwf+dpjyj0SdT5mDBNqMIe++QHCv3/Z1LgCQwTPfyQPC4DdmQ
 JryB0YL+GraOB8OYEwikpxwgfRz0NsML2UBTqJDf5bF9wMXoa9UCttQRQ2TzJ9zcb1DercuVa
 VdPmqNRmdIlZ1uLYrDm+KsWEAnPKKJOt1NU92ACH2RAQqTK9SXQ5rXZlLjOuf8cZ7nbkaa35W
 9taGgiANSRgXq4L7KAVsd7iyvapR1O4l3sBV2hmj0IyZbeVs31850VtMHCCNSetOKSNE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timespec structure and associated interfaces are deprecated and will
be removed in the future because of the y2038 overflow.

The use of ktime_to_timespec() in timeout_to_jiffies() does not
suffer from that overflow, but is easy to avoid by just converting
the ktime_t into jiffies directly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/msm_drv.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index b2da1fbf81e0..cc8977476a41 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -353,8 +353,7 @@ static inline unsigned long timeout_to_jiffies(const ktime_t *timeout)
 		remaining_jiffies = 0;
 	} else {
 		ktime_t rem = ktime_sub(*timeout, now);
-		struct timespec ts = ktime_to_timespec(rem);
-		remaining_jiffies = timespec_to_jiffies(&ts);
+		remaining_jiffies = ktime_divns(rem, NSEC_PER_SEC / HZ);
 	}
 
 	return remaining_jiffies;
-- 
2.9.0

