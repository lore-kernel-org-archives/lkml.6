Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39FEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91865214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 21:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z8oOF+Vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfABVgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 16:36:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43536 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfABVgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 16:36:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so15086274pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 13:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IaZyy8Fg7iEuCp2A66DNhkny4glyEvhssxULXZBqEvo=;
        b=Z8oOF+VorYndnd9uKBuUf4BwaWuSPLC47eLOprMuZV/voGJjTM53FRR6toazzEHksk
         rPTVY2uEl4g2eZqBF0vA5k4s/pimrDPBS20SH9Ahv0SxKj7u8UL9LzZVET0qiOj7H+YO
         nbli32pADUSmAVd7c/6k2q7VlOhDzmAY6nXoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IaZyy8Fg7iEuCp2A66DNhkny4glyEvhssxULXZBqEvo=;
        b=mgQAEAd27uO4WmJkPfm31MGSmU9szZOyhAYRnFJx3zfgKc+wOSWrRtlxHB6rqyBlRR
         esMFsPLs12tV8Q2IughrV//zRKTTzv5AGPPYr3Xn+lf43XnTFfOxVqSfmRJ9zCbrOx+A
         tF1YFpcIHQAvpLsPWoMgznHPtYPHH37I/xwV+gzx6ghliZr2PAnp52ZXX3FH9xEU96/+
         /aaHzWELCwqrQtw1pDnmYAa5Q0v5hgMeDauzQoouL+Gxbmbi7b8/mIG6MbcdwteAQtzp
         Dq8FO6f0owmTL3zRbOvGXSyLe5Oswt2EJ+HcKmzrlR2oSFXct1ECpOWsGgQD5av/fRwk
         yylw==
X-Gm-Message-State: AJcUukfs2bt+xUtvh+oY175sjepCKZ/y1gXVT+OyBO7uvbJnMK/LLaSr
        1fqzOZL5gJcGd/V6Pl6CpJEI4w==
X-Google-Smtp-Source: ALg8bN4YdIM1rGx1/fmSHKszyemrBd9+ENHyVAnmQpROan6zPkEDM7NMHRyonY+XYnfz8XsnqtJARA==
X-Received: by 2002:a63:2315:: with SMTP id j21mr15039555pgj.297.1546465010675;
        Wed, 02 Jan 2019 13:36:50 -0800 (PST)
Received: from ryandcase.mtv.corp.google.com ([2620:15c:202:201:ed1c:3d1c:9d92:99cb])
        by smtp.gmail.com with ESMTPSA id m67sm105323631pfb.25.2019.01.02.13.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 13:36:50 -0800 (PST)
From:   Ryan Case <ryandcase@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Subject: [PATCH 0/4] tty: serial: qcom_geni_serial: Assorted cleanups
Date:   Wed,  2 Jan 2019 13:36:32 -0800
Message-Id: <20190102213636.40866-1-ryandcase@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a series of cleanups for issues raised in prior reviews that
were unrelated to the patches at hand.


Ryan Case (4):
  tty: serial: qcom_geni_serial: Remove use of *_relaxed() and mb()
  tty: serial: qcom_geni_serial: Remove set_rfr_wm() and related
    variables
  tty: serial: qcom_geni_serial: Remove xfer_mode variable
  tty: serial: qcom_geni_serial: Use u32 for register variables

 drivers/tty/serial/qcom_geni_serial.c | 270 ++++++++++----------------
 1 file changed, 104 insertions(+), 166 deletions(-)

-- 
2.20.1.415.g653613c723-goog

