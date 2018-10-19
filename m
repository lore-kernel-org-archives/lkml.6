Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B062ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E217821470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="b05AGQAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E217821470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeJTC4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:56:03 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34670 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeJTC4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:56:03 -0400
Received: by mail-it1-f193.google.com with SMTP id l127-v6so4875792ith.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cOR2IJIowt4OkXEi+YRhZzCYyNynhKMj+YhQKSHNISY=;
        b=b05AGQAIPo7lxePa3iJZHr567v2l0b1Ldjzm9JRACleC3LvzBJ0xWPmsgxRnryqdBt
         YeTO1tYInccCiJaaufah4L8Ved1wewZUMd0DQ81EqJuvq5A/fdjJC+Sbs73X2aULDE89
         PUZVsd1a/XQNYvxkjkaYk+Iq19TgsRJWUO2Vzyu7eBcd0ZMe8vo/IHylolKsWc6V0xVO
         2tag9wlOooNX0JQcRYvl+v7PCuctHV37IvmZAsa0nlhFRWEiZ7cjS43PiqXCSPXbAST3
         0ahwt44fYM9F0VvKyYxgyqfEJQE+pIWSzeXlPp0tet8m2A+Z3bkBQrm9rmfPQZbM5mfn
         QWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cOR2IJIowt4OkXEi+YRhZzCYyNynhKMj+YhQKSHNISY=;
        b=hZjv0uvq3+Of89kFGF+IVX7OvDrbnqkrv+9CgODIxH13dBQzXCM9HY6z3LgJIYBvLT
         YZSJMe1Q46gkmXSmcvY0D2VPcUiOyRPoTvvEZYTe0IS346hT9mBqnrBSPk8oDyjuNb8I
         0GatTkKCS8pYvNndGWXo+PXCZcfqEdxkZMNCHnhoJtB2Y2+cyP1Hz3J8J8p6wOUj/LT7
         s5PjF8uB4ltjgDF84kc1lMgesmx6RmSO8Jksl3OsLLD/sbFSb6hZQC+q1lx1J90p1RMa
         ECJB3zmzcuwWnIYZl/O4jFqCrZNzz+wg6GXk7d7KCouXRN4GadzEdvt/sYa4Ezvb0Pp0
         HODw==
X-Gm-Message-State: ABuFfoiFnyum0tqIKc4qPRHfOm0rdyR+3vXSEMoSzBmiJxYiBqCCiVVP
        7NREXSRn7Panb103uKZeml5MIQ==
X-Google-Smtp-Source: ACcGV61aKh+F0b/UL3DZbcm7cPaAlkxEPwwda6xhyIOsXCU0duUBfeacPfegSOONACojQkJiHC7YKw==
X-Received: by 2002:a24:f884:: with SMTP id a126-v6mr4051948ith.113.1539974924382;
        Fri, 19 Oct 2018 11:48:44 -0700 (PDT)
Received: from viisi.dia.dnvr ([67.133.97.101])
        by smtp.gmail.com with ESMTPSA id f9-v6sm7528873iok.25.2018.10.19.11.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 11:48:43 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-serial@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] tty: serial: add DT bindings and serial driver for the SiFive FU540 UART
Date:   Fri, 19 Oct 2018 11:48:26 -0700
Message-Id: <20181019184827.12351-1-paul.walmsley@sifive.com>
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

This second version fixes a few problems identified by the 0-day
build system, mostly focused around remnants relating to
CONFIG_CONSOLE_POLL, and a missing spin_unlock() in the ISR.

Paul Walmsley (2):
  dt-bindings: serial: add documentation for the SiFive UART driver
  tty: serial: add driver for the SiFive UART

 .../bindings/serial/sifive-serial.txt         |   21 +
 drivers/tty/serial/Kconfig                    |   24 +
 drivers/tty/serial/Makefile                   |    1 +
 drivers/tty/serial/sifive.c                   | 1067 +++++++++++++++++
 include/uapi/linux/serial_core.h              |    3 +
 5 files changed, 1116 insertions(+)
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

