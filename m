Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9586FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3A9214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jm+oEOjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfAJMZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:25:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45996 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfAJMZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:25:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so5220454pfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 04:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=R7KG4RNn7WVmbQvqhKvIJ9jxw1xMvMrqX83v0AiI99E=;
        b=Jm+oEOjxcIAQjx1tUKVDs25RELoi8XQNj66KQbW7bZ6I1VGpeD+sJbQB2MrfeNx2x4
         ajyGaGnixLAgvSPNbCeYb0L42WP7nm6P5Z0kaM/1Upd/SJH0XuUWHtZAwCy3kLvQkI2T
         3OMwb23DjpUrcou3VaaYUVIllhteN7ew/ttd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R7KG4RNn7WVmbQvqhKvIJ9jxw1xMvMrqX83v0AiI99E=;
        b=m7AMNRoXu7JFpsuTRrGPfCiBnnm7Z/Wq74iAqsaTl31KjWf4EpYXRb/ous7fva/Ifg
         +bmW9UAiyr99gP50eXpQkEdnW1SyNKSb4yeUBLXulqFaEJtQqGjUf2ROrcD5PG+1mt+L
         8IYsEgTRXCVa9I1pJJ7FBy6Y2eV6LSlYXs8GWRkGf8/hkkW8Yh6tL4nKNbkjvkeQTQNx
         iSNL74lYox/iU+mGUSTFoKTrBjFnF+kVdUDB6ZNtBxYyef0cWodWkERARcyxklgTovTI
         6Hx/OeU5sXDdOWZ5Juz4ZY0JKCXK08dYlf62nVQ4CqcdKHu/GSye8L0K1tZGxUmnhZLf
         9Y1Q==
X-Gm-Message-State: AJcUukeYBarCjKR+Jdf63haImNUgtAQSdzCbc8oXvSR1qHU+pUD2r6n1
        vPWom+LqyIGqJGxrinHHxct5Dg==
X-Google-Smtp-Source: ALg8bN6rrtAAJfc6Yg2JWHg+PFTuRZ/QgQnMnERKMd1OnlfkW49EduF+AkjYZYjYBTPtiJEjjiORlA==
X-Received: by 2002:a62:528e:: with SMTP id g136mr10491873pfb.111.1547123134975;
        Thu, 10 Jan 2019 04:25:34 -0800 (PST)
Received: from localhost.localdomain ([117.196.233.251])
        by smtp.gmail.com with ESMTPSA id m67sm142985541pfb.25.2019.01.10.04.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 04:25:34 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jens.wiklander@linaro.org,
        mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        daniel.thompson@linaro.org, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 0/4] Introduce TEE bus driver framework
Date:   Thu, 10 Jan 2019 17:54:53 +0530
Message-Id: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a generic TEE bus driver concept for TEE based
kernel drivers which would like to communicate with TEE based devices/
services.

Patch #1 adds TEE bus concept where devices/services are identified via
Universally Unique Identifier (UUID) and drivers register a table of
device UUIDs which they can support. This concept also allows for device
enumeration to be specific to corresponding TEE implementation like
OP-TEE etc.

Patch #2 adds TEE bus device enumeration support for OP-TEE. OP-TEE
provides a pseudo TA to enumerate TAs which can act as devices/services
for TEE bus.

Patch #3 adds supp_nowait flag for non-blocking requests arising via
TEE internal client interface.

Patch #4 adds OP-TEE based hwrng driver which act as TEE bus driver.
On ARM SoC's with TrustZone enabled, peripherals like entropy sources
might not be accessible to normal world (linux in this case) and rather
accessible to secure world (OP-TEE in this case) only. So this driver
aims to provides a generic interface to OP-TEE based random number
generator service.

Example case is Developerbox based on Socionext's Synquacer SoC [1]
which provides 7 thermal sensors accessible from secure world only which
could be used as entropy sources (thermal/measurement noise).

[1] https://www.96boards.org/product/developerbox/

Changes in v2:

Based on review comments, the scope of this series has increased as
follows:

1. Added TEE bus driver framework.
2. Added OP-TEE based device enumeration.
3. Register optee-rng driver as TEE bus driver.
4. Removed DT dependency for optee-rng device UUID.
5. Added supp_nowait flag.

Sumit Garg (4):
  tee: add bus driver framework for TEE based devices
  tee: optee: add TEE bus device enumeration support
  tee: add supp_nowait flag in tee_context struct
  hwrng: add OP-TEE based rng driver

 MAINTAINERS                        |   5 +
 drivers/char/hw_random/Kconfig     |  15 ++
 drivers/char/hw_random/Makefile    |   1 +
 drivers/char/hw_random/optee-rng.c | 272 +++++++++++++++++++++++++++++++++++++
 drivers/tee/optee/Makefile         |   1 +
 drivers/tee/optee/core.c           |   4 +
 drivers/tee/optee/device.c         | 150 ++++++++++++++++++++
 drivers/tee/optee/optee_private.h  |   3 +
 drivers/tee/optee/supp.c           |  10 +-
 drivers/tee/tee_core.c             |  43 +++++-
 include/linux/tee_drv.h            |  42 ++++++
 11 files changed, 542 insertions(+), 4 deletions(-)
 create mode 100644 drivers/char/hw_random/optee-rng.c
 create mode 100644 drivers/tee/optee/device.c

-- 
2.7.4

