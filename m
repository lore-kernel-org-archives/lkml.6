Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA9FC004D5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A172F21564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nsec8cYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A172F21564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeI0HEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:04:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39416 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbeI0HEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:04:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id j8-v6so557481pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 17:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xUL1ep5YulCv8tYmJ085iDc7GTmTFmf9XugNtYkFpvo=;
        b=nsec8cYEhUD0W9Bp+gLbaplSSfAodml6GWgnL/rhcReGG3/7q3fyyx4G5AQmh9NNfo
         ZmkGI5r6KaPbysE8cfrR+7gh9gug0oeiAgPTTa2Wh+rV6B3nLN0q1aJZvuvNt0QOTYmG
         r9PDgA/63af64Q7KgX1KMNhADh+VC2GJV0k08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xUL1ep5YulCv8tYmJ085iDc7GTmTFmf9XugNtYkFpvo=;
        b=Ef0BEh4EUd+PhE22NFv2s6mg6euZ8sHQcJ+tLoRFEJofbIgBfqGFKF/88pOXTE6ruL
         /ZEWii1VZ5yuMEaLHfxJ/W38PqOKR9sv5mfrBRvVv3sXn7vkJ/fKXEvd8NiucW39fn1w
         1+4Gnljq3DCxUJlMi1L0ptPjvsBEIsYtwoTvGm9IMBT8cnTkqL2TRw8EAe0QUdc7rdzu
         4glt7fLh5s6jo1w4Ur4PJYv9eon7l0vTouOYOgs7iYMeX2qsSXDmxntwTxQdX2F66Yel
         du6IH/jo6P3xNweiPgymtjnazd3F1IE4ojqhwtbh+36kZQ/I/q138SaFiU98Yak4DhSa
         OJew==
X-Gm-Message-State: ABuFfogV1KMq1qYZnOGaWqH26CubSlmAKpvVT8X0wpPnYZhGOwZTqUFg
        CxQ07uGwQhDHWa5Toi99oa7ijA==
X-Google-Smtp-Source: ACcGV63BCrZJi5Da6bgQQwNO303kxSKITkhPU4mLfH9y5hTFjVigf/c6VwFrp1FcYTaQdsCuBzbXkw==
X-Received: by 2002:a62:25c5:: with SMTP id l188-v6mr8482081pfl.179.1538009330683;
        Wed, 26 Sep 2018 17:48:50 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id g3-v6sm404173pfi.9.2018.09.26.17.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 17:48:49 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 0/2] Add API to retrieve the Bluetooth Device Address (BD_ADDR)
Date:   Wed, 26 Sep 2018 17:48:08 -0700
Message-Id: <20180927004810.124185-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some systems the Bluetooth Device Address (BD_ADDR) isn't stored
on the Bluetooth chip itself. One way to configure the address is
through the device tree. The btqcomsmd driver is an example, it can
read the address from the DT property 'local-bd-address'. It is also
planned to extend the hci_qca driver to support setting the BD address
through the DT.

To avoid redundant open-coded reading of 'local-bd-address' and error
handling this series adds an API to retrieve the BD address of a device
and adapts the btqcomsmd driver to use this API.

Matthias Kaehlcke (2):
  Bluetooth: Add device_get_bd_address()
  Bluetooth: btqcomsmd: Get the BD address with device_get_bd_address()

 drivers/bluetooth/btqcomsmd.c     |  4 +---
 include/net/bluetooth/bluetooth.h |  2 ++
 net/bluetooth/lib.c               | 34 +++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

-- 
2.19.0.605.g01d371f741-goog

