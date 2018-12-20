Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF6BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B39820656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297768;
	bh=ijWDidjO9TMQ/eAlItbciN7b8lVwzwOBpX/VDNw0AzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PpV0QryBV7PHfRpaNy4FXL8plY8+mosPDOs/XrwJj5XU9b8ajORv8kITBbRpCZdDS
	 aC8+Wo6UB3hfZ+cylN5A/u/EWjZbDeofcBX1dnNYd0LTb6V7rWbIM8u8zf5VHJNuhd
	 WlE3ZVnjnHOst6RyvISZ5Uif4mW7tmRVcdhIrr+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbeLTJWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:22:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731388AbeLTJWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:22:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F17EA20449;
        Thu, 20 Dec 2018 09:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297763;
        bh=ijWDidjO9TMQ/eAlItbciN7b8lVwzwOBpX/VDNw0AzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQUuYeAVYiAblKY6LkXDyY3S35CJb1agASKguFSGryngjFAHuoE03yoIY5X//Ejiv
         k7bRZb3EqD2de6nzCY5YLle6EiRgdTRSq4cz51k7VGYyxgJFO67rFJT90rS4cP44XL
         kNYEVXVhJwCZHFYjKRL7n2JqLf6/y3LGIVlox/Pw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guy Shapiro <guy.shapiro@mobi-wize.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 38/40] rtc: snvs: add a missing write sync
Date:   Thu, 20 Dec 2018 10:18:50 +0100
Message-Id: <20181220085827.961861032@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index a161fbf6f172..af131682dbc9 100644
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



