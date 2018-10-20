Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE54C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 10:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8764B2150F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 10:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ChUUulNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8764B2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJTSWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 14:22:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33407 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeJTSWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 14:22:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id u1-v6so4065510wrn.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WeinUrQ7ysF/m1cR0ZveHabHJtWalvfdrlRj+hVPwbo=;
        b=ChUUulNA3u9H3v37Z4/3MyliL/YP7RfUWNE+gEQoaB8dklJ/5KeOcYzaiFhxi24mmc
         sNven5kjfrrzyZq9Eug+G8IbjjGN40dFpjTYcjlK5zqe1KK7mATJDwJ/BZZPNdzPigNs
         +apQimZZ/3foYoLMejGhzIYJIDDu4SuozjvWZdFHbi9J53aBCobB8FLr8SzWvkG+Vvdx
         4oJZskMcddBnY21RCi1HVqOyoC2PxWebWN9RKNvZFUdNcvn/pcleo+aJ3i9v12ieGgHo
         A3VIg7M9NeAflW2sQPoSkfAbAXu2kfBqcSx99sLZLhOJPx1xfewdkiTFghiLyffXYQrq
         h/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WeinUrQ7ysF/m1cR0ZveHabHJtWalvfdrlRj+hVPwbo=;
        b=t20IBqv6LhZ1jHm1fL0SPVXK4XZ9A82DgJ3Ler8ZEb1c21K/AgJpPHwAEBT0GaFvAM
         5EgWh4vxV/Qkz+K1A30HrcAeeypigw7sawgjchVHm7fD61zMChEnpAPhxg5+QKQx3Ucd
         SM9mVq4R0kt4yvZqkREs8tGJqxOP7bCJyelmYq1FqdklzssOGBjfQmzq0B2mV1IyVVcr
         S5UirLac8/X4pqn2/Kn+U6VKuHkd0+m/KRYUI5lm3hShu8DrkOjxGGguleOXRTjse2aX
         uRK6jg+yBlCS5plXRLuR9xj5DAiCmBS78PpYuuqSkm2G8CQKkVCZZH0FYy72sNkbnNZu
         Y64w==
X-Gm-Message-State: ABuFfogIOWaQ8/8GFXEwy8WvH9rdVdp1HyMGd7fg6SPbzPl5XBugFm5k
        HL21S28YVtskr5PrhOCM09gveQ==
X-Google-Smtp-Source: ACcGV60KOuq/Qj141/dOvDHTj+LCEpiuxs4vuPEOXktbHfZ3Au80Z3W9XvLMd14seGyfYDmMdl/1CQ==
X-Received: by 2002:adf:91e4:: with SMTP id 91-v6mr38551871wri.97.1540030324620;
        Sat, 20 Oct 2018 03:12:04 -0700 (PDT)
Received: from viisi.sifive.com ([37.152.39.96])
        by smtp.gmail.com with ESMTPSA id 2-v6sm23773438wro.96.2018.10.20.03.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 03:12:03 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-serial@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
Date:   Sat, 20 Oct 2018 03:10:44 -0700
Message-Id: <20181020101045.15991-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a serial driver, with console support, for the
UART IP block present on the SiFive FU540 SoC.  The programming
model is straightforward, but unique.

Boot-tested on a SiFive FU540 HiFive-U board (with appropriate patches
to the DT data).

The patches in this series can also be found at:

https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v4.19-rc7

This third version updates the DT binding documentation per discussion
with Rob Herring and fixes one additional issue identified by the 0-day
build system related to MODULE_DEVICE_TABLE.

Paul Walmsley (2):
  dt-bindings: serial: add documentation for the SiFive UART driver
  tty: serial: add driver for the SiFive UART

 .../bindings/serial/sifive-serial.txt         |   33 +
 drivers/tty/serial/Kconfig                    |   24 +
 drivers/tty/serial/Makefile                   |    1 +
 drivers/tty/serial/sifive.c                   | 1067 +++++++++++++++++
 include/uapi/linux/serial_core.h              |    3 +
 5 files changed, 1128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
 create mode 100644 drivers/tty/serial/sifive.c


Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Wesley Terpstra <wesley@sifive.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

-- 
2.19.1

