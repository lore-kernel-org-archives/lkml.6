Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DBFC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8F521741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695194;
	bh=UqGM13Uqh801O1BQCYGEbFZImtDK9KsZXDdnPzl3caA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=npix1rt6fmqLG4pj2OGgJjGQBfDCNO+X3hdF6EpH0S5Ik0sn7QdH2BFnD+/jabVNp
	 sVAt/ODjpZFDQ+w/Pnvn6ssRtRLrTDWKrMOfyJKCHD7XxOUFo9XxrG98vzoPSawuzQ
	 ceetqNwe2Z0ViCGJeu8uEBBDwijC+bV/LQSLqB3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbfA1RGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:06:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733283AbfA1QNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF42C2148E;
        Mon, 28 Jan 2019 16:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691989;
        bh=UqGM13Uqh801O1BQCYGEbFZImtDK9KsZXDdnPzl3caA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kCJQXsOY9EyVn/z1xDpfJl18x0VZSlQAY31uZ8FCmvG3tzUIaBF5UCjtbUz7A8YUe
         o0CRdhWYlDMf0FlzojO3KT+lpSPHjgqvziFE+VaLARfQzhiRNe6JoGFX35a0/64JTn
         ClZKF8mv3lU1+fkz2q1JQgLbLu7Bubl1dj0qeA6Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Damian Kos <dkos@cadence.com>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 030/170] drm/rockchip: fix for mailbox read size
Date:   Mon, 28 Jan 2019 11:09:40 -0500
Message-Id: <20190128161200.55107-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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

