Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E30C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792C7222A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896911;
	bh=cDKcoyNH60BxyY8ZaSRF56U3CTCL+7LpbKzRFmIjVWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DvJhM5tALP/zX7QxLv1j0AvUOTIm1CswVLEk5lfV6+cqvNc9mjsi0FLICEsosSYlw
	 XCAZEgfXkJKDzpg1tXWvmYnM0+/Ov6KjPfPXbO/BRpxHEkypM+2dFVgY9ZOUWB8KVR
	 vn3Bmsrki5Ia5wE4ksTyVtVdOysMEYHYsndXYh10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388923AbfBKOzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:55:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388518AbfBKOzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:55:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B58DD222A6;
        Mon, 11 Feb 2019 14:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896906;
        bh=cDKcoyNH60BxyY8ZaSRF56U3CTCL+7LpbKzRFmIjVWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yrQrhw9oUW6DQYjuGYX0Q/hURP446IsJUpSFfnP1Rc0DkYK14v7CZ/0WpQ7+6eHbS
         pId9O6tGc4rS0U4lYDZw0CQuhKDmokeYbRUqzupog3JFzAQtsmyKKYyh4d6gqWBblC
         IOMR+slAHVWjHe/EWGaMG1hlKflrEVBv7demEdJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Damian Kos <dkos@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 027/205] drm/rockchip: fix for mailbox read size
Date:   Mon, 11 Feb 2019 15:17:05 +0100
Message-Id: <20190211141829.544144217@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

[ Upstream commit fa68d4f8476bea4cdf441062b614b41bb85ef1da ]

Some of the functions (like cdn_dp_dpcd_read, cdn_dp_get_edid_block)
allow to read 64KiB, but the cdn_dp_mailbox_read_receive, that is
used by them, can read only up to 255 bytes at once. Normally, it's
not a big issue as DPCD or EDID reads won't (hopefully) exceed that
value.
The real issue here is the revocation list read during the HDCP
authentication process. (problematic use case:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4/drivers/gpu/drm/rockchip/cdn-dp-reg.c#1152)
The list can reach 127*5+4 bytes (num devs * 5 bytes per ID/Bksv +
4 bytes of an additional info).
In other words - CTSes with HDCP Repeater won't pass without this
fix. Oh, and the driver will most likely stop working (best case
scenario).

Signed-off-by: Damian Kos <dkos@cadence.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/1541518625-25984-1-git-send-email-dkos@cadence.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/cdn-dp-reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index b14d211f6c21..0ed7e91471f6 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -147,7 +147,7 @@ static int cdn_dp_mailbox_validate_receive(struct cdn_dp_device *dp,
 }
 
 static int cdn_dp_mailbox_read_receive(struct cdn_dp_device *dp,
-				       u8 *buff, u8 buff_size)
+				       u8 *buff, u16 buff_size)
 {
 	u32 i;
 	int ret;
-- 
2.19.1



