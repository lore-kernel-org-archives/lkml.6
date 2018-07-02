Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F35FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136F0258A5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nF9OpJdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136F0258A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753215AbeGBXEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:04:09 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34110 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbeGBXEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:04:08 -0400
Received: by mail-pf0-f195.google.com with SMTP id e10-v6so31783pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 16:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=j52PxxBZFD392YLxqXBfktYq+SYMg02NDKdDs6tKnm8=;
        b=nF9OpJdJbPbv6E6aCFXqAT8P3d3dwfGT/IAznuNxhguBoN0ZYt7Nt0rSKDB1TGKMVh
         moKTHe7q+yGwRMlOMCzGssEdL5EneXiBr0peMu/PUgnPvP2lcyQTUqfJQN9PcSu3cryk
         9KBtcCrqJktlJOi7msYNf8YIS4hrkHVB2Zp2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j52PxxBZFD392YLxqXBfktYq+SYMg02NDKdDs6tKnm8=;
        b=cyrnuq5WJvCdhHLLmwJgK/4aHblRx2pnk3YiuoVf9cjsIRdzcrsvV+XI4Cyenv3jF9
         DseKdCK0Jxb8aIe6+oCfLPEEoORxgKwxkgo1uC/ERKFdCLLc0klq0ESJVNvTnlI1F5Sp
         p7HJBnl129IP+wVbjWF1P0GfVQFTctyPr4C+kGkgEhK05UKFUG7PUgZ3PauDBFFKdAEN
         sOq2vUMBYzgOAsATPL7aNpzJenkKScw/1OvAJPlj4L0OyBUGi0So4dHUSz+yLLdjedOj
         bmxhzKebXDY0P65MXaTLzfaI+RKxRJJ1+Mo5ltcp1R4ngpENdzf368zvcL4JWOj1vgTK
         DZwg==
X-Gm-Message-State: APt69E1Gvxb7iQ2UDXHwtp0cXbwKZ8efpBGfhNZ4fSrfyloNBVbMHgqK
        lTGVk4sCdAlaXwYVDjliE8S6Lg==
X-Google-Smtp-Source: AAOMgpe0DRo0VWddcpNo0/LbQsEZnFYBLe2INQtW9JjeRSByPIyHPw9AKsv07gV3VAJ2/Zz8EGLTww==
X-Received: by 2002:a62:c819:: with SMTP id z25-v6mr26201973pff.44.1530572647942;
        Mon, 02 Jul 2018 16:04:07 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:0:1000:1511:116f:8bf3:133b:f7fd])
        by smtp.gmail.com with ESMTPSA id k13-v6sm48902509pfg.130.2018.07.02.16.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 16:04:06 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sam Hurst <shurst@google.com>, Evan Green <evgreen@chromium.org>
Subject: [PATCH] loop: Add LOOP_SET_BLOCK_SIZE in compat ioctl
Date:   Mon,  2 Jul 2018 16:03:46 -0700
Message-Id: <20180702230346.72350-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds LOOP_SET_BLOCK_SIZE as one of the supported ioctls
in lo_compat_ioctl. It only takes an unsigned long argument, and
in practice a 32-bit value works fine.

Signed-off-by: Evan Green <evgreen@chromium.org>
---
 drivers/block/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d6b6f434fd4b..4cb1d1be3cfb 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1613,6 +1613,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 		arg = (unsigned long) compat_ptr(arg);
 	case LOOP_SET_FD:
 	case LOOP_CHANGE_FD:
+	case LOOP_SET_BLOCK_SIZE:
 		err = lo_ioctl(bdev, mode, cmd, arg);
 		break;
 	default:
-- 
2.16.4

