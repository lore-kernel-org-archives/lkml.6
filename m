Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE0CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45822177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216971;
	bh=UgUsrGelP/xtNaMl9r6VOj8eq6qnos+tV12mToNV9V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ud/EV06VAAETcwm4JHk09DrLdeAqQE5UBAsgG8tzHdlaEkgMF+VEWnLF0goBx2fYQ
	 k+PTPn2O7VLMXjBhLE0nMGinP6D6AEW3PQC9vPmLhQsO7MVTacWg4RnZFRe603aKZ7
	 rPPwJDIA5rRwHq8g1erqfsCS/1MkyJscbb+cHehs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388729AbfAKO33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:29:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388716AbfAKO3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:29:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F066A2063F;
        Fri, 11 Jan 2019 14:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216964;
        bh=UgUsrGelP/xtNaMl9r6VOj8eq6qnos+tV12mToNV9V0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGxDEFl7gnoo1Z/pDL9P409scn8BV/136dSGoGN/RCQpAtvFjst6huumnX5jh0Xs1
         PXBP5/QWn5F5KZ4OxteeZZpjBiTYVZoL8cws7AWuvY6lO1rqWbQkEGJekjZKe3xCIG
         p/sjvYukch2sbmMAmKvKCycwTzboZvIL4JTkFGLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Priit Laes <plaes@plaes.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 54/63] b43: Fix error in cordic routine
Date:   Fri, 11 Jan 2019 15:14:57 +0100
Message-Id: <20190111131054.272074009@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 8ea3819c0bbef57a51d8abe579e211033e861677 upstream.

The cordic routine for calculating sines and cosines that was added in
commit 6f98e62a9f1b ("b43: update cordic code to match current specs")
contains an error whereby a quantity declared u32 can in fact go negative.

This problem was detected by Priit Laes who is switching b43 to use the
routine in the library functions of the kernel.

Fixes: 986504540306 ("b43: make cordic common (LP-PHY and N-PHY need it)")
Reported-by: Priit Laes <plaes@plaes.org>
Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: Stable <stable@vger.kernel.org> # 2.6.34
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Priit Laes <plaes@plaes.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/broadcom/b43/phy_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/broadcom/b43/phy_common.c
+++ b/drivers/net/wireless/broadcom/b43/phy_common.c
@@ -616,7 +616,7 @@ struct b43_c32 b43_cordic(int theta)
 	u8 i;
 	s32 tmp;
 	s8 signx = 1;
-	u32 angle = 0;
+	s32 angle = 0;
 	struct b43_c32 ret = { .i = 39797, .q = 0, };
 
 	while (theta > (180 << 16))


