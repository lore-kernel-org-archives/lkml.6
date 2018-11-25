Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D78C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3212084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVFCWPAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3212084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeKYWLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:11:52 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45381 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeKYWLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:11:51 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so4829909pgc.12;
        Sun, 25 Nov 2018 03:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lUTv91/JoC9v0pMFWcI/nYCUqTUVqFGh4nUuFYaDDlU=;
        b=sVFCWPANoDPnk7tEdICuoKHPsPK437DMQOpIoxrYoO5O1BTKt859I72mIs5q1i5m4+
         pnyb6VueiglYF79jXJ6kBYRlEEFirSIcu+XKtYQbrkQKmhNLQrCsK9szgyzFH9Hn9ein
         IvXtNlP1n02aQcr2y5slfy/Iy/+VlJbsVVKhougxFMBY+sRVP1yfEvccr5ZZ3z1mD0Fr
         7X5bIE2tM9ZLkqSk4r3ia0/l0DSx1wWlhDmFulgLZRGg99nMidaHY7rFb+g5Gtuyw8BN
         X6vrEn+qQVK51uWUPGdm3PzvbEQuElVsuyf6cc1cVDLbPsOBmFLMSO0rjyzm1gjGNUIx
         WGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lUTv91/JoC9v0pMFWcI/nYCUqTUVqFGh4nUuFYaDDlU=;
        b=CjfNp/t12JK7lFgZL3mteTvppOfcm3DUxGN3WVX05v25K2At0SCDQrNk3tLsj37e4k
         cv6ywPvUlkdyxQBSU5rJCBi3cAAex/fVOsY5gHvPOfTd8Kro2FtFRJpzKc+x97u9E5+u
         /nzTIeU8DAUe/pnKi8Vzj5cW8290LcZsJCcRBmK2uriLpukY9FYAKSC00Mnc8BwM27GR
         IntjszOeHi3UTC25RnjY9iuTZ7HS06Vl6V+3tFn4JuzlBN4E0euYE36xmAkLTMqhFTjd
         KIGPjxZNjA1HQ9nnq3rP/knjqWhcBQOrbmMkGcIPczQe/JUi2ScMAhkGQq0aoHnU7xV9
         +9sQ==
X-Gm-Message-State: AA+aEWbSNl+uOqzEDHOlV/M/K11uk/ZvLE1AfUrj0X2AKcQLhusHfT2h
        NsFzB8tkXiJ4ffZp9PAY9/4=
X-Google-Smtp-Source: AFSGD/UqOCQBfFfB03r3i0iN0+nFRjx/ID9BSGmpaVKBtP4+KrJW2p0d1f0bvZXnHnfxlSM9qcwWgQ==
X-Received: by 2002:a63:6150:: with SMTP id v77mr20225354pgb.266.1543144860060;
        Sun, 25 Nov 2018 03:21:00 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id l11sm16653923pff.65.2018.11.25.03.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:20:59 -0800 (PST)
Date:   Sun, 25 Nov 2018 16:50:53 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 00/26] Staging: fbtft: Switch to the gpio descriptor interface
Message-ID: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches the fbtft driver to use GPIO descriptors
rather than numerical gpios.

Nishad Kamdar (26):
  Staging: fbtft: fbtft-core: Switch to the gpio descriptor interface
  Staging: fbtft: fbtft-bus: Switch to the gpio descriptor interface
  Staging: fbtft: fbtft-io: Switch to the gpio descriptor interface
  Staging: fbtft: flexfb: Switch to the gpio descriptor interface
  Staging: fbtft: fbtft-device: Switch to the gpio descriptor interface
  Staging: fbtft: fb_upd161704: Switch to the gpio descriptor interface
  Staging: fbtft: fb_sh1106: Switch to the gpio descriptor interface
  Staging: fbtft: fb_uc1611: Switch to the gpio descriptor interface
  Staging: fbtft: fb_s6d1211: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ili9320: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ili9340: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ssd1325: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ili9325: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ssd1289: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ssd1351: Switch to the gpio descriptor interface
  Staging: fbtft: fb_uc1701: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ssd1306: Switch to the gpio descriptor interface
  Staging: fbtft: fb_bd663474: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ssd1331: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ili9163: Switch to the gpio descriptor interface
  Staging: fbtft: fb_agm1264k-fl: Switch to the gpio descriptor
    interface
  Staging: fbtft: fb_pcd8544: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ssd1305: Switch to the gpio descriptor interface
  Staging: fbtft: fb_tls8204: Switch to the gpio descriptor interface
  Staging: fbtft: fb_watterott: Switch to the gpio descriptor interface
  Staging: fbtft: fb_ra8875: Switch to the gpio descriptor interface

 drivers/staging/fbtft/fb_agm1264k-fl.c |  52 ++--
 drivers/staging/fbtft/fb_bd663474.c    |   6 +-
 drivers/staging/fbtft/fb_ili9163.c     |   6 +-
 drivers/staging/fbtft/fb_ili9320.c     |   2 +-
 drivers/staging/fbtft/fb_ili9325.c     |   6 +-
 drivers/staging/fbtft/fb_ili9340.c     |   2 +-
 drivers/staging/fbtft/fb_pcd8544.c     |   4 +-
 drivers/staging/fbtft/fb_ra8875.c      |   4 +-
 drivers/staging/fbtft/fb_s6d1121.c     |   6 +-
 drivers/staging/fbtft/fb_sh1106.c      |   2 +-
 drivers/staging/fbtft/fb_ssd1289.c     |   6 +-
 drivers/staging/fbtft/fb_ssd1305.c     |   4 +-
 drivers/staging/fbtft/fb_ssd1306.c     |   4 +-
 drivers/staging/fbtft/fb_ssd1325.c     |   6 +-
 drivers/staging/fbtft/fb_ssd1331.c     |  10 +-
 drivers/staging/fbtft/fb_ssd1351.c     |   2 +-
 drivers/staging/fbtft/fb_tls8204.c     |   6 +-
 drivers/staging/fbtft/fb_uc1611.c      |   4 +-
 drivers/staging/fbtft/fb_uc1701.c      |   6 +-
 drivers/staging/fbtft/fb_upd161704.c   |   6 +-
 drivers/staging/fbtft/fb_watterott.c   |   4 +-
 drivers/staging/fbtft/fbtft-bus.c      |   6 +-
 drivers/staging/fbtft/fbtft-core.c     | 170 ++----------
 drivers/staging/fbtft/fbtft-io.c       |  26 +-
 drivers/staging/fbtft/fbtft.h          |  21 +-
 drivers/staging/fbtft/fbtft_device.c   | 344 +------------------------
 drivers/staging/fbtft/flexfb.c         |  12 +-
 27 files changed, 142 insertions(+), 585 deletions(-)

-- 
2.17.1

