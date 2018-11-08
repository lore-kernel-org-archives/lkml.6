Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA36C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3822086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TQMqk2CQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3822086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeKHWZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:25:34 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:50450 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKHWZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:25:34 -0500
Received: by mail-wm1-f49.google.com with SMTP id 124-v6so1150029wmw.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 04:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=g4KMERMa9jB0AD+47MTvpEgoTlXHyibUPZD685ReJNE=;
        b=TQMqk2CQqbvUVgfKMgNXbIO02Z2A0aOhDD3XPcv3qOPyzYN00jVrsNwWkkrMR6m1Eq
         kPEoUNvWmuvIMSD2Zn3H8/blVdRUCLO/0c5gD5YBCeJkiifSKHC1VUtcb25D9c8xEQRQ
         aSPXR4ShFhjFehvFE8b7ZMrQDoj2OqtHcOJcrTny5fvt6G8DWAC3bgPpcHfCVlCc2BlH
         7l3L7OiynVnVWv7Mir6+0kprsvePeTE0lpW2v3bSiT8iKF3A9mQdlzn2b3AHJed+1ZRl
         VXJKj40lOBf96q4YLL81BLfGTJKukofh6NynOvFiyJSvqpuAiQW1b4POHw3ZnZi536QP
         FWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g4KMERMa9jB0AD+47MTvpEgoTlXHyibUPZD685ReJNE=;
        b=pIZoO1MJfYi/2w+DKElHxzzr1/uahdfm1SmpxNi8qAWw6LlrZKww7JPJVJiVnZjd17
         /2hjBczN7ewuFOuBjksiaSN/CHljBzoQ1zq1tXgC2s7KJ2obUe+aoZspGEfBcsrL5KUp
         3HHD/ROJ4RqIiv9SfFHumTyQWg9mrpOGwdEZP2DVsuPyeoaHtSEQ41Ie2pwAx9cnUuaj
         qWk8oBgDA6ZohWvqTNpfQ0R5htLEoB2WFfb5pwdWSEmbnU5prjamrWBahjhCwoz7ZfH+
         XQt6AIxfESFRvy3VvI/PHCt0jmcrl55fL12tmQ+TLWN7eAHDws93iA5aj7yp5q7cqt7Z
         pLfA==
X-Gm-Message-State: AGRZ1gKFyTYTBCnWIOQZAB4vXN9UwXLbIaSRBxdgyv419MphjACjL6C+
        wf+leyDcs3paqopf1XGI3aAEEA==
X-Google-Smtp-Source: AJdET5dvQxUxjiWJ80DUVhdhVLSRB19Z+s355u66bOQSKGt/fwEqjyNLGpuoGa39l4DZFpAbUFfFNA==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184-v6mr1118951wmf.143.1541681412395;
        Thu, 08 Nov 2018 04:50:12 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e5-v6sm2470014wru.88.2018.11.08.04.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 04:50:11 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Yasunari.Takiguchi@sony.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] sony-cxd2880: add optional vcc regulator
Date:   Thu,  8 Nov 2018 13:50:08 +0100
Message-Id: <1541681410-8187-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds an optional VCC regulator to the bindings and driver to
make sure power is enabled to the module before starting attaching to
the device.

Neil Armstrong (2):
  media: cxd2880-spi: Add optional vcc regulator
  media: sony-cxd2880: add optional vcc regulator to bindings

 .../devicetree/bindings/media/spi/sony-cxd2880.txt       |  4 ++++
 drivers/media/spi/cxd2880-spi.c                          | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.7.4

