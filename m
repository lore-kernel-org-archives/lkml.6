Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7277C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44B62171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548719274;
	bh=PdFQ2j3/ccbjwiOUsBMoLmDYMxSAKtZiPXudmFBMdR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k3az4STr2KcloUaaJQPlm23FHg0nv643drhOL6gscewq56kc8DeJWMAWW0NA8d/M+
	 31XxDkTe60cD0uuHfHVcInmMFfUebjZS2ilZpw/gGzMmbM4hQS5VNTdrnmAAhJgahY
	 eMVtn5lA2i6+1QpoyD9qtOwM2b4kOmk7o0lAFKD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfA1Xrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbfA1Xra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:47:30 -0500
Received: from localhost (203-69-98-252.HINET-IP.hinet.net [203.69.98.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07FD02171F;
        Mon, 28 Jan 2019 23:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548719249;
        bh=PdFQ2j3/ccbjwiOUsBMoLmDYMxSAKtZiPXudmFBMdR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNDYXJUs8NX9z1kfHLSSP1djkkUfW6yIFZsROqlss9OAyLqYO43uGWtKlv67u1OJ6
         vvmo82JV0UOZ7gppw9lMJ/0cro8mwbJiqQuxTPXMz8Y1KIehQvQMSVdfz4qUJyO1Ps
         mdCfcTnTy0w8hbtJCKdYn8qcwt3Lnd7kXTdyJ7ck=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/7] f2fs: don't wake up too frequently, if there is lots of IOs
Date:   Tue, 29 Jan 2019 07:47:14 +0800
Message-Id: <20190128234717.77225-4-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20190128234717.77225-1-jaegeuk@kernel.org>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, it wakes up discard thread which will sleep again by busy IOs
in a loop.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index a77f76f528b6..5c7ed0442d6e 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -865,7 +865,7 @@ static inline void wake_up_discard_thread(struct f2fs_sb_info *sbi, bool force)
 		}
 	}
 	mutex_unlock(&dcc->cmd_lock);
-	if (!wakeup)
+	if (!wakeup || !is_idle(sbi, DISCARD_TIME))
 		return;
 wake_up:
 	dcc->discard_wake = 1;
-- 
2.19.0.605.g01d371f741-goog

