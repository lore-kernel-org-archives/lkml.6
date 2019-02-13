Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9A0C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E03E21934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026073;
	bh=OBkOc3SVaglklbrKlRdiGOPvOERw0XdKipuOngRHhjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pi2yktQCrxmDVCX2miogqQ6bmu14UHQ2mGECAo/cEPUDFxNM6qBlt4kmiuDiVp/Yy
	 rZkS7JymhFF5dXLEKOW40fQQtN0a/b4BVykbfN71j+QqfWKjNRncsOGYR4WwBOB3u3
	 tmc6dfESXYJ/6k7ssU6dieJQiUOgoznQ4jeozlYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389748AbfBMCrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:47:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388986AbfBMCk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10D44222C2;
        Wed, 13 Feb 2019 02:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025625;
        bh=OBkOc3SVaglklbrKlRdiGOPvOERw0XdKipuOngRHhjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j83DZPpNz9FDQTUEBrMS+uwQ6EsgrnoH9xX1kLnqA+dKjeK1VxrDQmkWWt+xLv6gi
         EA4sUykatH+xAv0u0kaV7gK20OBUs5SAYzW83mmzDknHlpnk68cMwjxXJJRTby46lm
         GDoXvIVdKSqN4Lx3cAvLHCZhQXfRI6FQQrYvdNBM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 23/34] isdn: i4l: isdn_tty: Fix some concurrency double-free bugs
Date:   Tue, 12 Feb 2019 21:39:41 -0500
Message-Id: <20190213023952.21311-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023952.21311-1-sashal@kernel.org>
References: <20190213023952.21311-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 2ff33d6637393fe9348357285931811b76e1402f ]

The functions isdn_tty_tiocmset() and isdn_tty_set_termios() may be
concurrently executed.

isdn_tty_tiocmset
  isdn_tty_modem_hup
    line 719: kfree(info->dtmf_state);
    line 721: kfree(info->silence_state);
    line 723: kfree(info->adpcms);
    line 725: kfree(info->adpcmr);

isdn_tty_set_termios
  isdn_tty_modem_hup
    line 719: kfree(info->dtmf_state);
    line 721: kfree(info->silence_state);
    line 723: kfree(info->adpcms);
    line 725: kfree(info->adpcmr);

Thus, some concurrency double-free bugs may occur.

These possible bugs are found by a static tool written by myself and
my manual code review.

To fix these possible bugs, the mutex lock "modem_info_mutex" used in
isdn_tty_tiocmset() is added in isdn_tty_set_termios().

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/isdn/i4l/isdn_tty.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index d30130c8d0f3..b107452e16df 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1456,15 +1456,19 @@ isdn_tty_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 {
 	modem_info *info = (modem_info *) tty->driver_data;
 
+	mutex_lock(&modem_info_mutex);
 	if (!old_termios)
 		isdn_tty_change_speed(info);
 	else {
 		if (tty->termios.c_cflag == old_termios->c_cflag &&
 		    tty->termios.c_ispeed == old_termios->c_ispeed &&
-		    tty->termios.c_ospeed == old_termios->c_ospeed)
+		    tty->termios.c_ospeed == old_termios->c_ospeed) {
+			mutex_unlock(&modem_info_mutex);
 			return;
+		}
 		isdn_tty_change_speed(info);
 	}
+	mutex_unlock(&modem_info_mutex);
 }
 
 /*
-- 
2.19.1

