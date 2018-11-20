Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492EFC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CBD20685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtzLUCf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CBD20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeKUDRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:17:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44394 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeKUDRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:17:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id s5-v6so1251318plq.11;
        Tue, 20 Nov 2018 08:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PumaF0WGuF2uCTYcjGBjM+EP2thEMaxMMKNwJDwfhqk=;
        b=AtzLUCf0AQSDwC+asNWgypn4fpPRzWBYMC7MNnPeYjakCcoWsI2KxDYBhLOyoFZXB2
         0jNi0DUI/KBwoVQRDB70+7rmrzaYXxdSFhTUGxFxkGI+4K+BcCtE4UENB8lxklf/ydxl
         ZzR9ztD8EZ/gaE0s0avSl0V/2ECukTbEONXvHWYm7Wn1mJAc8TKOcNJA0Ww5QAmVFBX8
         UEEMcE4pAkscmk5hLTqohacvzJ6jUiQwU5ZPo2oBxS8dHuq1YC3Jdh3QrzI/eiKZZhj7
         ewDBoUj57iBFpypF80IDw/PI0g2ZN4ygQhqj5D0Qm/rlqqri/lj9vurzf9nd8cADphr5
         sdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PumaF0WGuF2uCTYcjGBjM+EP2thEMaxMMKNwJDwfhqk=;
        b=fhDca+l06XuwSsJ+cF0jEndZxHjeI1sh5S7ZAowgBK4UBb97g8LX9zdsxhA26EUE8Y
         5+bOxtjHhafLd1GVUzPGVFoPi2t0OUTGtmbi65dgBjxAMwYm4WZrALiEX0eUKOi409Ry
         DXZ3FMp/akixTjNtLLKPOWf6X/Te1HlEUscGfcSGUtz+dBGLsncsFxxFJeioRH8TecW5
         sQvfyWA3qj1GBTwiQHx3CimBd33BqIAwTNkyk9CYGXmmeQgnmICNXKs+LL/FMrZXekU1
         Tn86ijwSE6LUgo4U9bRZC3pm7WyaqLiz9RF7ytCSLj+NFJHXn5BDOjFCpmnw3gZNlE6u
         np9g==
X-Gm-Message-State: AA+aEWbI4ZZv352mRrampqRVZ9SC4P+pVPe0YGGynFVbvdhRC36WrqcK
        UrJaIIP5JeX8tAh+00TDJPqnKQ0p
X-Google-Smtp-Source: AFSGD/XIcIBeP5rDKjPo6hYBFybc1NPiEi0QaYmtpWEg3H8woWkRvnV7LQT7h/y6H1xSkCzsb9WqKw==
X-Received: by 2002:a17:902:4324:: with SMTP id i33-v6mr3004194pld.253.1542732447154;
        Tue, 20 Nov 2018 08:47:27 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.152])
        by smtp.gmail.com with ESMTPSA id 7sm31762790pfm.8.2018.11.20.08.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:47:26 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Remove platform data and introduce DT bindings
Date:   Tue, 20 Nov 2018 22:17:18 +0530
Message-Id: <20181120164718.6999-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces device tree bindings for adt7316
driver and removes the usage of platform data from it.
Also, it sets the data field to it's appropriate value in
the i2c read function which was nowhere being set before.

Changes in v2:
  - Make the commit message of patch *[1/5] appropriate.

Shreeya Patel (5):
  Staging: iio: adt7316: Add of_device_id table
  Staging: iio: adt7316: Use device tree data to set ldac_pin
  Staging: iio: adt7316: Switch irq_flags to a local variable
  Staging: iio: adt7316: Change the name from irq_flags to irq_type
  Staging: iio: adt7316: Use device tree data to assign irq_type

 drivers/staging/iio/addac/adt7316-i2c.c | 14 ++++++++-
 drivers/staging/iio/addac/adt7316-spi.c |  1 -
 drivers/staging/iio/addac/adt7316.c     | 39 ++++++++++++++++++-------
 drivers/staging/iio/addac/adt7316.h     |  1 -
 4 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.17.1

