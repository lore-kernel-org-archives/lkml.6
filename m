Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66379C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3569120833
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sweptlaser-com.20150623.gappssmtp.com header.i=@sweptlaser-com.20150623.gappssmtp.com header.b="S10wpksu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfAaWG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:06:57 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37765 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbfAaWG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 17:06:56 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so6872858iti.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 14:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sweptlaser-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=s//WKIUtaIH0wRpbyXK/xy0gdxoHenTpSnbPv7jjHjg=;
        b=S10wpksu3gKB0l02Esx08e6f2VmxjRuauKQ7Fd/NHM6PFR/8Fy1KSMSCVS9iQcQliM
         /zOqM6Ko9b718S1B2/cKCD8kG2f8j1Exosub/+Y5EIThvE4MNnhi3zc1GSkZdDpWnEga
         zMm3PrSiE9NIv+jM0LeotMKh5vQRMEGcurvLzK9EoUqd9pduS1AWZcdsrBeH4TjDFglt
         7Fht+ZNYxt0Tp/xqZgRhfmsN1sKGBjoeUU4ikJRbpq630SIis5cfBn57Z3Be/QKldn2z
         8nvZ6gIJYJ6+6adeOqzYXWjogzFbRv59Mjbl7d2k2G2e8GgHoZjY8b/d+uMYr175VqUy
         xp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=s//WKIUtaIH0wRpbyXK/xy0gdxoHenTpSnbPv7jjHjg=;
        b=Bb68R0NyX8mKTixYFWShLBbRrcj8F/I5m7iUYNFwrspGF+Gc7vMyOBOrDgekHxy26M
         xNSYOvNIFQbcI7qkFB6KBrq8S2F6+VWf+Hob0CXqDam8MBdRSl3N/RTuwKu9iCVGfkh7
         3fZIdfwqP5AccrG5gg8vC+5keusy0OvZHdUoYww07kl2bagIt9V9jl8kLlC+Z73fZFbl
         i5Mjgt/NWDtzUwXGg35CYhBymoe3xw3aSR2+DRTkOBb6io5aKBLcy+7hftqHf/Gkkv0K
         0MTfEWSvQZVHLqKwj9t930d/vEX5IHfZZY/aHsgC+hd//L9b5egUeXpnfsQcNdlSmS/I
         ET9Q==
X-Gm-Message-State: AJcUuke3iceyZIsaYooa7h+UMnvthF92A31riVM0YbJbd9wZlCbBBnhW
        ij5OFYZPq8tSBE2HSrfAL7BICAuLfak=
X-Google-Smtp-Source: ALg8bN7xap+KRRH4zb+lS0wNlj/xrMMxrEG+riUmUos0/0BDwGvGrgitRFxo6k2fkdlluAoJ8BDGLA==
X-Received: by 2002:a02:570d:: with SMTP id u13mr22402974jaa.71.1548972415953;
        Thu, 31 Jan 2019 14:06:55 -0800 (PST)
Received: from yngvi.hq.sweptlaser.com ([63.147.146.226])
        by smtp.googlemail.com with ESMTPSA id l186sm286439itl.22.2019.01.31.14.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 14:06:55 -0800 (PST)
From:   Jeremy Gebben <jgebben@sweptlaser.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] hwmon: (lm85) add LM96000 high freqency pwm support
Date:   Thu, 31 Jan 2019 15:06:14 -0700
Message-Id: <20190131220617.15223-1-jgebben@sweptlaser.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds support for the PWM frequencies from 22.5 to 30 kHz
available on the LM96000.

It looks like this chip has been supported for a long time, but wasn't
mentioned in the docs (which I have updated).

Also, it has been using the generic 'lm85' prefix, which I have not
changed to avoid breaking userspace or device tree files. AFAICT,
lm85_detect() will only return 'lm85' for LM96000 chips, so it doesn't
look like you can get a bare 'lm85' prefix with any other chips.

I stumbled on to a 10 year old thread discussing a patch which looks
like an early attempt to add support for this chip, which may be of
interest:
https://lm-sensors.lm-sensors.narkive.com/1SIwaMDT/patch-hwmon-lm96000-support

Thanks for reviewing,

Jeremy

Changes since v1:
 - replace freq_map_mask with freq_map_size

Jeremy Gebben (3):
  hwmon: (lm85) remove freq_map size hardcodes
  hwmon: (lm85) Document the LM96000 as supported
  hwmon: (lm85) add support for LM96000 high frequencies

 Documentation/hwmon/lm85 |  9 ++++++++-
 drivers/hwmon/lm85.c     | 32 ++++++++++++++++++++++----------
 2 files changed, 30 insertions(+), 11 deletions(-)

-- 
2.17.1

