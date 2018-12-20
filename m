Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243A6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E722620656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297939;
	bh=eGTOU3WNVTw84J+Oxrfy2jRUY45Nb+5XQShdUy/YMWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1v47RC0n93sLADe5tNUCuH7wJ89DsBdXUziLjLfzLpGjtYKSElP0xi6A6/pISn/v4
	 7eJHZrvnZt1/I5tJIUOyTOW+lqKQa+PGat1fP0e+Nfjgit1LYxNt2aB0clsVQGQ1QS
	 Og/xzKyqhUf3UWP5aG045Rmx8Evp6pkR+27FU8SU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbeLTJZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:25:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731524AbeLTJZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:25:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE4CE217D7;
        Thu, 20 Dec 2018 09:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297923;
        bh=eGTOU3WNVTw84J+Oxrfy2jRUY45Nb+5XQShdUy/YMWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Co/YRxN178UFUywcXTaz7KdM/a5GPGpxgskDpweMagNWaiOpbcNI47kwMMP7z5mH+
         tpxX4hb0Gvy1mynFoLjj7PNEv7YUMEaLZw9S6xk15ijPX5V2V5xBcegry4ANHnqEZW
         Z8K0DSmg18+FbEub43HkNQg2BNekXHzqCJwRjbWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guy Shapiro <guy.shapiro@mobi-wize.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 60/61] rtc: snvs: add a missing write sync
Date:   Thu, 20 Dec 2018 10:19:00 +0100
Message-Id: <20181220085846.170777813@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7bb633b1a9812a6b9f3e49d0cf17f60a633914e5 ]

The clear of the LPTA_EN flag should be synced before writing to the
alarm register. Omitting this synchronization creates a race when
trying to change existing alarm.

Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-snvs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 3e8fd33c2576..9af591d5223c 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -187,6 +187,7 @@ static int snvs_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	rtc_tm_to_time(alrm_tm, &time);
 
 	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR, SNVS_LPCR_LPTA_EN, 0);
+	rtc_write_sync_lp(data);
 	regmap_write(data->regmap, data->offset + SNVS_LPTAR, time);
 
 	/* Clear alarm interrupt status bit */
-- 
2.19.1



