Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51151C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EB22175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691292;
	bh=d/Bf4LUC8RVEHryUovEHlCKsUc+6pTOP4DFtJngc3P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=obwSrc4vxyCySjsU6UnNT6/6/wVG/dZCYNrw3ryZkNSgUOWDOB7G6rVFKk96u1ORu
	 3dTZdyJBqEzQy2ahfyOGc7bRKA5bWJjYzj9zVXfmlCp/bveobPFN8hGMdayE/rTiQL
	 Gjwz7M7n+tDBuIZ8k0OlAzawRJcQ4lpc6uE7XuNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfA1QBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:01:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730575AbfA1QB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:01:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06DCE21848;
        Mon, 28 Jan 2019 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691285;
        bh=d/Bf4LUC8RVEHryUovEHlCKsUc+6pTOP4DFtJngc3P0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pDd9ELOLe8N//ju8MmOLtWrRbn/O/NubQI5fxP/p8hCvpH0C0sTyZ1JRtlhi+yfyU
         +wY/MuZquyjdfR0frnNtA9cLRnSwBG1CsU4lEcR89/p9XtvMk+DdYIA+yYrybUNIuv
         WmfZU0ce2z4P+C64Jsjp3rn8tpCohsWtyX5gjbFU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Damian Kos <dkos@cadence.com>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 046/258] drm/rockchip: fix for mailbox read size
Date:   Mon, 28 Jan 2019 10:55:52 -0500
Message-Id: <20190128155924.51521-46-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damian Kos <dkos@cadence.com>

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
index 3105965fc260..5a485489a1e2 100644
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

