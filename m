Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFC8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E16420842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfBYUNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:13:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39788 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfBYUNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 15:13:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id l5so11387197wrw.6;
        Mon, 25 Feb 2019 12:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wL7LlDtNaW/gEtPVBaNpb38SRitB3f7IDOpvfaOxORg=;
        b=TO0tf2fT8jwGz1cBfjhMv9kpUs88aDfycyx2t0IaerSm9FbG5g6dVzKuW/C1edLy+h
         5AkedRkMpje7XfVpQOMq30bFR3nAeiFZ18GP68pjyvLW/t6Nl96eaI9049O0uAt22q8Z
         zIbbzBKNz0T5356rDnJaweV6E5W8qz/+wr8akljD0iwl6LoxS3OLJeO1GEnpXAUhd5RN
         7pEh/vRhrUbksgw5stA6NQxnKMrBgMsjvRkqzd2NWwueUVZ3wX2lRsaSu6z7lo3TwPSf
         bFoqVMufsqfHDcF5FcnKW2ajrrmdl4+kOie7YR2iaMoU91UoVSJj1wzeJ4Xk5J3JOIIw
         Mm1w==
X-Gm-Message-State: AHQUAuZhHZh/GOLa2XGNCLAH9mGguOW5pZErDn7ObX3DYQmDo7ew3MbB
        QwMmQyJC7YX84C3ZFEHrZOg=
X-Google-Smtp-Source: AHgI3IYC/Y8Q8TVRx98hHIvp81mQpi+9pOyCdkoShZ2Y+rKO1Lh429ekwMPsoNj1uWs2Imzu6u70SA==
X-Received: by 2002:a5d:4d12:: with SMTP id z18mr14152531wrt.115.1551125595555;
        Mon, 25 Feb 2019 12:13:15 -0800 (PST)
Received: from timur-laptop.fritz.box (dslb-146-060-168-212.146.060.pools.vodafone-ip.de. [146.60.168.212])
        by smtp.gmail.com with ESMTPSA id o12sm7901437wrw.70.2019.02.25.12.13.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Feb 2019 12:13:15 -0800 (PST)
Date:   Mon, 25 Feb 2019 21:13:13 +0100
From:   Timur Celik <mail@timurcelik.de>
To:     David Miller <davem@davemloft.net>
Cc:     eric.dumazet@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tun: remove unnecessary memory barrier
Message-ID: <20190225201313.GA30005@timur-laptop.fritz.box>
References: <20190223115313.15064-1-mail@timurcelik.de>
 <20190224.221236.905722532971991928.davem@davemloft.net>
 <b727b3bb-ec46-12bf-dd38-0363c9ca5854@gmail.com>
 <20190225.102548.247362521843809607.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225.102548.247362521843809607.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace set_current_state with __set_current_state since no memory
barrier is needed at this point.

Signed-off-by: Timur Celik <mail@timurcelik.de>
---
 drivers/net/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d291762b9e9d..53f4f37b0ffd 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2185,7 +2185,7 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
 		schedule();
 	}
 
-	set_current_state(TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&tfile->wq.wait, &wait);
 
 out:
-- 
2.20.1

