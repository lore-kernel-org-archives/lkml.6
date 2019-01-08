Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272A9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EF6206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QG7l9ZRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfAHB7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 20:59:19 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39652 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfAHB7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 20:59:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so1096620pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 17:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8UqtZxeh2IygD+LRD03zDiLYo+gKqxvFa2mWBMssNQQ=;
        b=QG7l9ZRo6VZcU2oPj+WywXLMTEcy7PK21Ejrk4eXiGMFZJHXNlGqENx0P5VU9/EA5b
         Fm/cyaTFu4PXQwegDf/KvimTSnZijkXHE9as9p2iIfEVDTMXLIrJ9+tfaJ6os4xaKwRi
         KI5WN/dq/JKwclc65X20tcoGoIL++XMaQcdQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8UqtZxeh2IygD+LRD03zDiLYo+gKqxvFa2mWBMssNQQ=;
        b=PxFrcao2M+WLyeHlQDxW9DXavcgI6F7ckNUqCzi8IddyXi/QEXR5JvXGLA7VMMGf5D
         hhW3KYhYf3rtWBtT75QIH56mjbu1rcQoFx6xVIX7AqwTAGB/68i+RunL5eInJfCgVTOU
         NVyjZdHcf5Ijc7tOsroC2sKEEJ487NaRdCNeMbQrgNUE/iABQ9ETX1uE6Zcsm2nYOStt
         JoH6+qzNbdcQeTPHbLFwGZPWNUeY8vImUM52eqg7aHWswV0oGtyd25GEd5/O/t8aRZ5D
         GQU2LF97pGNfDtppCCprQslRzhc3VgreLmRRfdmdD8EapTQAr4/mNhgpBh2oiJYpNzGb
         +aig==
X-Gm-Message-State: AJcUukcdyAGgsm2kxPFetkv9V6qADLT9VsxwIddaCwR2ONgNGB8OFPuX
        vtq1PWutY/+yuRpq23+WXY1Maw==
X-Google-Smtp-Source: ALg8bN44kd1NhelnDBZnwGiVgpTTILbQ6gvqAy1e+EvfCsZGMVGoT/pHvEM+eKJEk7XqkLv0qUK9gg==
X-Received: by 2002:a63:5026:: with SMTP id e38mr12996104pgb.123.1546912758040;
        Mon, 07 Jan 2019 17:59:18 -0800 (PST)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id p2sm93942693pfb.28.2019.01.07.17.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 17:59:17 -0800 (PST)
From:   Ryan Case <ryandcase@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Subject: [PATCH v2 0/4] tty: serial: qcom_geni_serial: Assorted cleanups
Date:   Mon,  7 Jan 2019 17:58:34 -0800
Message-Id: <20190108015838.166271-1-ryandcase@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a series of cleanups for issues raised in prior reviews that
were unrelated to the patches at hand.

Changes in v2:
- Updated commit messages
- Removed CONSOLE from UART_CONSOLE_RX_WM
- Coalesced lines where possible
- Updated missed rxstale variable

Ryan Case (4):
  tty: serial: qcom_geni_serial: Remove use of *_relaxed() and mb()
  tty: serial: qcom_geni_serial: Remove set_rfr_wm() and related
    variables
  tty: serial: qcom_geni_serial: Remove xfer_mode variable
  tty: serial: qcom_geni_serial: Use u32 for register variables

 drivers/tty/serial/qcom_geni_serial.c | 279 ++++++++++----------------
 1 file changed, 106 insertions(+), 173 deletions(-)

-- 
2.20.1.97.g81188d93c3-goog

