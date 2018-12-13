Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2518DC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D958720849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=elementarea-net.20150623.gappssmtp.com header.i=@elementarea-net.20150623.gappssmtp.com header.b="wn2wxo1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D958720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elementarea.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeLMOoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:44:10 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38951 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMOoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:44:09 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so2227496edt.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 06:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elementarea-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=h2JlNyDoxsXlz2lbzn1cjh+9pV2K5+5zXFQeLooHKTs=;
        b=wn2wxo1EKXs5LGb5XlDQCcEC0wnrNf4g2TYY6LpfeI0HpnHnt1w93EBClyjlJBlUEi
         5uuyfDGy9lvvuVH6KwZ0CcMJD7Fxxlq1wg6wHb/v2G64VeRZF/9B8CbNwQ4C/+QGDS+o
         FGkSS5WJODH0NQjIzOo77yAOyk2Z/y2AwoIlLro+bqTxWL/h83M7ndg9cK4bKOwd5WbU
         xwP4jl/0dtEnGuMVjOsdNR8HwPdK8cQbt1L3vhuLfc/zuLmalti+q4WMrvl2wtZ/gVkp
         /FUsmppalLq6haVhutw1TkAd7KoTgrAhJCO4XMPMMesq/sMJaw+JQ+V2rfHqPZpSCmP3
         avKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h2JlNyDoxsXlz2lbzn1cjh+9pV2K5+5zXFQeLooHKTs=;
        b=B/zIkPcMTNf3rt8zUTx5oQsHs/p4FThj2mIReTB1KFNPCHaTkvVsEAQgjXKGklcGc6
         2rf/G7fWCz252Fw5BIZbASk1gpXjVwAPFXgIUVfYwnytxJjns32H4DaP+OLlTGS6+rIj
         R2raqdLe0E9z+RsCp3rEHUECalJe8E19SAEpr8LjVuN/7lqTyvd2E42FWW+aroE21Fx8
         afak+Ida2ACgIBaSmwtp4xmwLwAQKDeFRTK7FyEfpysJ8eALb54yDYwJ2CXHEHLnCNmZ
         5MHYCkSBEJF718G/XO1Dz7GSSkI7rmD3S2secjtqeVeOl5vw2C2ScIAW3MMudmQZ39fd
         CsFg==
X-Gm-Message-State: AA+aEWZoadE+pB+W/yPxJ5QrtsuXQxsmweqUa9U4Ju8ieV8MjfWO3/j1
        SY4CpLydPfT0xWC9AeL7NSSjkQ==
X-Google-Smtp-Source: AFSGD/XjPBMT6M23mYKO71Rb2A+D65o6NS98uMkmvSBeIlQ0NnnKnSyglwEvWfsC0FAKhDd2w3hr+g==
X-Received: by 2002:a50:f098:: with SMTP id v24mr22753937edl.78.1544712247950;
        Thu, 13 Dec 2018 06:44:07 -0800 (PST)
Received: from ch-sta-l-li0012.sensirion.lokal ([209.206.26.1])
        by smtp.gmail.com with ESMTPSA id q16sm656290eds.60.2018.12.13.06.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 06:44:07 -0800 (PST)
From:   Andreas Brauchli <a.brauchli@elementarea.net>
X-Google-Original-From: Andreas Brauchli <andreas.brauchli@sensirion.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Andreas Brauchli <andreas.brauchli@sensirion.com>
Subject: [PATCH v3 0/3] iio: chemical: sgp30: Support Sensirion Gas Sensors
Date:   Thu, 13 Dec 2018 15:43:21 +0100
Message-Id: <20181213144323.24820-1-andreas.brauchli@sensirion.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minimal SGP30/SGPC3 driver

Changes to v2:
* Strip all calibration params to give time to determine the preferred way
  of adding those to IIO. The sensor remains fully functional, just without
  humidity compensation, baseline support for resuming measurements, ...
* Split DT bindings into own commit
* SPDX License header
* Style and whitespace changes

(Different sender due to corporate server molesting emails)

Andreas Brauchli (3):
  iio: Add modifiers for ethanol and H2 gases
  iio: chemical: sgp30: Support Sensirion SGP30/SGPC3 sensors
  iio: chemical: sgp30: add device tree support

 Documentation/ABI/testing/sysfs-bus-iio       |   4 +
 .../bindings/iio/chemical/sensirion,sgp30.txt |  15 +
 drivers/iio/chemical/Kconfig                  |  13 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/sgp30.c                  | 603 ++++++++++++++++++
 include/uapi/linux/iio/types.h                |   2 +
 tools/iio/iio_event_monitor.c                 |   4 +
 7 files changed, 642 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
 create mode 100644 drivers/iio/chemical/sgp30.c

-- 
2.17.1

