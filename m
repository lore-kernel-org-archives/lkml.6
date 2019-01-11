Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A955C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A5F2064C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMP3kchM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbfAKLuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:50:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46968 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbfAKLuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:50:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so6211977pgp.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 03:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fq7MtF2ScfFMWpdvczijzx7e8y4b1AHJmZlcX4q9K6E=;
        b=MMP3kchMB/DsEDH6qKdnq4FW7h9C13s8fWAZrNzFO0A7fxdeLbdZNF8uE0IffLs8CA
         lyvM77ueEBR986Phanff3BbH9CXq5jsskuaPLrjnLUcIVqtPCup+3CfSk2IE5/vXM8lG
         Vgo5G2OojyHYYHxnG2Cta220tf0tN5US0+Ssg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fq7MtF2ScfFMWpdvczijzx7e8y4b1AHJmZlcX4q9K6E=;
        b=CvHxU1cUTWyXkWqc+8MXb/U0T1wDKHy75orR2JTKs8Q0daG9mwAergUJcf09n26cYi
         R8nnKsRWd9rqWxDclztMju8Tf20U2rKMMBGTgV4zuSXyma/EbFI4peV95PNHaGc8928M
         TRhQlwWEoqKUTfbBjZaqah7a9BgFGyx/hllCnXClpwzPFdnNL5ZyPXAe0v38O6QrOVrS
         G0ChJHZzKvdqAjqPwDBt027QvglH4CfNbAQUO9cT2XDrW5ZQTzdVDhyoqDfC12eygsOb
         4yT2+bFKWdW18yafQsIlpFyQWScDY9W2wudsSXoJXYp/VSzmheprcZTqht0YFpOc6vWG
         3dsA==
X-Gm-Message-State: AJcUukdk91neKcijVa1f/g6vWND8fGRJol+CpvUihJLgmuG0tv/1VfIr
        XZO7PDvabqWDhv182UHaeJ5cDw==
X-Google-Smtp-Source: ALg8bN4L4Q4YuEIyK/IxKjebItlbdc/puOKAnbLfwMhu7SK2SJW3WCIykfjif0Mkxoa4i93mfgFwRQ==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr13132854pgq.189.1547207398922;
        Fri, 11 Jan 2019 03:49:58 -0800 (PST)
Received: from localhost.localdomain ([117.196.233.251])
        by smtp.gmail.com with ESMTPSA id b2sm143199988pfm.3.2019.01.11.03.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 03:49:58 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jens.wiklander@linaro.org,
        mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        daniel.thompson@linaro.org, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 0/4] Introduce TEE bus driver framework
Date:   Fri, 11 Jan 2019 17:17:27 +0530
Message-Id: <1547207251-9372-1-git-send-email-sumit.garg@linaro.org>
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

Patch #2 adds supp_nowait flag for non-blocking requests arising via
TEE internal client interface.

Patch #3 adds TEE bus device enumeration support for OP-TEE. OP-TEE
provides a pseudo TA to enumerate TAs which can act as devices/services
for TEE bus.

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

Changes in v3:

1. Fixed bus error path in Patch #1.
2. Reversed order of Patch #2 and #3.
3. Fixed miscellaneous syntax comments and memory leak.
4. Added comments in Patch #2 for supp_nowait flag.

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
  tee: add supp_nowait flag in tee_context struct
  tee: optee: add TEE bus device enumeration support
  hwrng: add OP-TEE based rng driver

 MAINTAINERS                        |   5 +
 drivers/char/hw_random/Kconfig     |  15 ++
 drivers/char/hw_random/Makefile    |   1 +
 drivers/char/hw_random/optee-rng.c | 272 +++++++++++++++++++++++++++++++++++++
 drivers/tee/optee/Makefile         |   1 +
 drivers/tee/optee/core.c           |   4 +
 drivers/tee/optee/device.c         | 153 +++++++++++++++++++++
 drivers/tee/optee/optee_private.h  |   3 +
 drivers/tee/optee/supp.c           |  10 +-
 drivers/tee/tee_core.c             |  56 +++++++-
 include/linux/tee_drv.h            |  42 ++++++
 11 files changed, 558 insertions(+), 4 deletions(-)
 create mode 100644 drivers/char/hw_random/optee-rng.c
 create mode 100644 drivers/tee/optee/device.c

-- 
2.7.4

