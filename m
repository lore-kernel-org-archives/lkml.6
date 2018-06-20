Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78840C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DC0204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X/B5l8My"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DC0204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754750AbeFTS1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:27:30 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35236 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeFTS10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:27:26 -0400
Received: by mail-pg0-f67.google.com with SMTP id i7-v6so203309pgp.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 11:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cRMUqFnmw99GrtpcjZjr8sw148NRGhLAHTFdivDQJM0=;
        b=X/B5l8MynhsUtuAwUsmQqV9VMEqWAegW/Q6DvOd1c08BEZ9qABO2vy4PD5jITInG4Z
         8IOlRwW3ILo0t1M8N6dL9a/CI1Y8y8fnaXHXld04rkWalf6n40irOwTuUaXRhVjwtjXP
         +IXGa58lpztnxuQLjLGC2A6TovstIpwD6tPCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cRMUqFnmw99GrtpcjZjr8sw148NRGhLAHTFdivDQJM0=;
        b=sNtde4KS4p1lyRZcb8Ylq5ehClwD+os/dTvvwTXtQzttPw2g4NylnDjF9ETsQe3kai
         KQuDZLrulUfLgzH+ftMrgmKg5FEzcJKJjDEqiUQHo2L1wBqDG4eGNV0ZF9vLiUdqMNIR
         Ok7xNb6c7nqWIEfA1oUFrKk1E63toULKbXgQB/RBEY9kvlY2b5FDwDsSTxsIzFJb2LU7
         p6Nhpx7+ZsmKgGE5GNBe+aecfN2jO7agwOfSdRfhLoA0bjQr0hVAlk3OA04xnRmbonKp
         RtnpotbWM8ltSbyv4gHjyVUhVM8LTI+EPHjHHV0y43lD3IGx1lBT/8ws3KyjEfsSidne
         jNQA==
X-Gm-Message-State: APt69E2lK73S6pa+4vzd1Qo56lYOBVwi3IITX2W1DRAJxJoYYPrWsqlE
        dGo03AV3NrypTXBhzKrP/bTC8w==
X-Google-Smtp-Source: ADUXVKKE/XDzdoBaRw7wcI2UaP0TCsZAOoekr6kytGYDNOCFUZia0s+z0BvbNxvgCZe9xYpdhIrtjQ==
X-Received: by 2002:a65:51cb:: with SMTP id i11-v6mr20052260pgq.320.1529519245376;
        Wed, 20 Jun 2018 11:27:25 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id j23-v6sm4566967pfi.137.2018.06.20.11.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:27:24 -0700 (PDT)
Date:   Wed, 20 Jun 2018 11:27:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Airlie <airlied@linux.ie>
Cc:     linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i2c: tda9950: Remove VLA usage
Message-ID: <20180620182723.GA24430@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
sets the buffer to maximum size and adds a sanity check.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/i2c/tda9950.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda9950.c b/drivers/gpu/drm/i2c/tda9950.c
index 3f7396caad48..28314433c351 100644
--- a/drivers/gpu/drm/i2c/tda9950.c
+++ b/drivers/gpu/drm/i2c/tda9950.c
@@ -76,9 +76,12 @@ struct tda9950_priv {
 static int tda9950_write_range(struct i2c_client *client, u8 addr, u8 *p, int cnt)
 {
 	struct i2c_msg msg;
-	u8 buf[cnt + 1];
+	u8 buf[CEC_MAX_MSG_SIZE + 3];
 	int ret;
 
+	if (WARN_ON(cnt > sizeof(buf)))
+		return -EINVAL;
+
 	buf[0] = addr;
 	memcpy(buf + 1, p, cnt);
 
-- 
2.17.1


-- 
Kees Cook
Pixel Security
