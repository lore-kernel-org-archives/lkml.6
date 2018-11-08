Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A6BC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C832081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TL/+mcj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C832081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeKHWUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:20:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42970 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKHWUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:20:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id y15-v6so21092637wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 04:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UuEFhChS0o2AeIb6otLN03OMltWhym+SCLRjM3/Px6I=;
        b=TL/+mcj1UHdYBsdEBdcl+H5pKR3QLoq8NTNTypb0SpUH1VO2dWC3uE1XOrG4p6vBsM
         p6y684Gm6rjwA57r10NVs/ze5syOL+b5/nIY2lRbaUuh7NPG9ovFqrcx0Z7OllsOqLPW
         RrKergWah5I75rCtfVP8RwCExOOvkLbMqlKWlxdm91DCj3X/E6SYsi9coq5JgmfbmGh5
         pSI9wxtiIGsxZbeIGAhdZoGDeAIkTQLet354bJh4PSRlyey8cc1x3ctOgsV8Z0qhWNiA
         cw9Pfo8Pk6pCs2tjcN9dJEvPqtRmNKbzWGH2ty6dXddywK8hDN+eGPzHfFJoO3tHyz32
         FR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UuEFhChS0o2AeIb6otLN03OMltWhym+SCLRjM3/Px6I=;
        b=EQ3f6CWJypk1LgHF9YELSQ09KHTcExOpyrvvAswrUoL3bn3lZJEzQddY7KV+Li8bY1
         x+AG8tntJBmnTBAKaXAwf/IS2hwPe/qvqoy0N1dBD4lR2DGavrcDKm02N91KvzHhU++O
         dVd/G9nMxi9y/InqXNAkQinB5JVNUV2gvKVMd19kMXS85hOYU464wZW48YHBvKm15AOc
         zABwk+V2qVN2ZUnKWov0Y4c9xOGHiVXfQ5aDBsCFaDvrwB4oKUCg/k/9bQ7/b8PRM2Ja
         QsZ3CBLgpdbPE0uiDq4tTZ7E65JYXk6eLNLc0M4XylkoIaBqq1NPj0RTzTP2F/PDUVl4
         5Vig==
X-Gm-Message-State: AGRZ1gI0+kiSh7JACwfATs7OD3j5vY1QLM/beL54aKLfxSiqb6+scCF7
        EZX4OTlWi4t2MEXyPl3aMRueuOcXydA=
X-Google-Smtp-Source: AJdET5e8D9W0ibigyUgrcdtO2uRUKdb9KzhD4rYtNxcdjDzPoubZdHjOg3H3xWjovjqk6FE3PUpvVw==
X-Received: by 2002:a5d:4012:: with SMTP id n18-v6mr3928018wrp.185.1541681091822;
        Thu, 08 Nov 2018 04:44:51 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 126-v6sm2788827wme.48.2018.11.08.04.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 04:44:51 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Yasunari.Takiguchi@sony.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: cxd2880-spi: fix probe when dvb_attach fails
Date:   Thu,  8 Nov 2018 13:44:48 +0100
Message-Id: <1541681088-7385-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dvb_attach fails, probe returns 0, and remove crashes afterwards.
This patch sets the return value to -ENODEV when attach fails.

Fixes: bd24fcddf6b8 ("media: cxd2880-spi: Add support for CXD2880 SPI interface")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/media/spi/cxd2880-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/spi/cxd2880-spi.c b/drivers/media/spi/cxd2880-spi.c
index 11ce510..c437309 100644
--- a/drivers/media/spi/cxd2880-spi.c
+++ b/drivers/media/spi/cxd2880-spi.c
@@ -536,6 +536,7 @@ cxd2880_spi_probe(struct spi_device *spi)
 
 	if (!dvb_attach(cxd2880_attach, &dvb_spi->dvb_fe, &config)) {
 		pr_err("cxd2880_attach failed\n");
+		ret = -ENODEV;
 		goto fail_attach;
 	}
 
-- 
2.7.4

