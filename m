Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FED5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD9520656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNszd5RX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfANUmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:42:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51190 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfANUmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:42:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so1074214wmd.0;
        Mon, 14 Jan 2019 12:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MLWXQwLvr9hb7Fk+ZmcM5gEYv8XZb3b6HMKxsoSdYW8=;
        b=CNszd5RXY93a697cxSO0ftos0HSjDQxl3iKIfM9c1hDiHXB0iUBh+pYugzJfL85dwq
         fvk5iNH7LSqulFxCfvlpJoke2W31lQY0jJlSh9ZCE6MYdd3XQPDQexrXFaW7iwahCd+j
         4kgqeGJ2nrgB881jlJAuH7jQa+uvH4row4t4FDpj1b7lLzbtrYp0LD1vkNvhSiOV10ex
         /upGzibAYAvsgBbc1AAvojBQ/C8RFhVTYyl/Dhi3qaHuKwJ+GH/oByQbYZ/UB5oD+B+Q
         3nFDXwb7eAbFiBpD7px8JwlS3blNxoCDhnUByX15FnVKYZGMaoKDHyktcoNs5r8h5bVo
         GXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=MLWXQwLvr9hb7Fk+ZmcM5gEYv8XZb3b6HMKxsoSdYW8=;
        b=tyfYFtjs+mI864JJg2LyoNQrdT+ClsSG+hq5WMuY3AKIvINvTVscNk6r8nBikyZzvb
         NMm2/ZxvyPzprWRddQTxodGf/4y0TxMjIcoZCEy4SJHcp5mcSyHdTOTSycclb7qZycDB
         HKVWPhXx8DzRgB1+EQBtXYbjx0saz+7F9YarVh7MGGzjgfRBF7uzENY7UGCEG1Urb94C
         RgKegMRJHKvnsYuPHHJOomDItojtFRQyCXUhwKceE0ngIcIpwwp+RuBiLdzcW5sgyij7
         JblkgtxkTneT0BAFpnyxUlo9jUbjdNPpP60WiuiDdQ/uFuPPSOBMBYJ6eELIcjUUOPbN
         GnVQ==
X-Gm-Message-State: AJcUukcl/T5Ilk1OuPosrj+NoEt989xbnrpPDb5LAZ8vtSb6nsIZqHtQ
        iGl2Xsw5NjMEsO1hohxXZCg36iCb
X-Google-Smtp-Source: ALg8bN6GhccFhSkq+CcfANcK8jsE78/au+r51pDOhZhZnwXhyCRQ+q2BaXN/bJN/jCTAbaRszvaYTg==
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr756704wmj.10.1547498535257;
        Mon, 14 Jan 2019 12:42:15 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id e17sm123327308wri.36.2019.01.14.12.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:42:14 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 6488511422AD; Mon, 14 Jan 2019 21:42:13 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:42:11 +0100
Message-Id: <20190114204211.21386-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

In this particular case rewrote the comment to start with the string "fall
through", so as to match the regular expression expected by GCC. Truncate
the comment slightly to fit the max line length of 80 characters.

This commit remove the following warning:

  drivers/mmc/core/host.c:196:14: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/mmc/core/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index f57f5de54206..0052d6fed7c8 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -194,7 +194,7 @@ int mmc_of_parse(struct mmc_host *host)
 	switch (bus_width) {
 	case 8:
 		host->caps |= MMC_CAP_8_BIT_DATA;
-		/* Hosts capable of 8-bit transfers can also do 4 bits */
+		/* fall through - Hosts capable of 8-bit can also do 4 bits */
 	case 4:
 		host->caps |= MMC_CAP_4_BIT_DATA;
 		break;
-- 
2.19.2

