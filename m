Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA8DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23838218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxlhUgBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388645AbeLUBfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 20:35:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45475 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731379AbeLUBfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 20:35:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so1761360pfd.12;
        Thu, 20 Dec 2018 17:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ig6ZK3uKf2YzNjOJ1fzCFypF2C758BsmRflTMinMBtU=;
        b=nxlhUgBMY4pkaaBTIW6iJeUFgTjbQ6+bs5mNH1Q+oIUS5s/Lc6KobW78o+YrjyLQhp
         9PokePKY2uTySmQCY2BRxhFhtO/Et9RQahDYVASxJP0DdPnWZSS1d44sbd/juDwb48ft
         yIri7T3H9CuOqG0YspXYmNPyA0SKJhL+qPEX9qosvIZ4Rx6CSirVeods0/sppyrCm+z5
         EmaKO+C5VCTGDuaIr51FAVVZHOHJQ8NcgWkT8QZ3hbeYTM4IgEdZhEA1cfGAr07bOc+Q
         Vj8A8UqHFIVhxadVp90y7LuioE/qGRZ641zNMOgkFMukPf30LFCa44qRtWt1gy6QvAiU
         w92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ig6ZK3uKf2YzNjOJ1fzCFypF2C758BsmRflTMinMBtU=;
        b=uglmwWckwqwwRbRE+KvaiaJat+/j+jjNMxiuqjXUYsw1G6FeHB2zEUM6pLmmIgrVI4
         Ntv/QRPXE69rLBe6IEHMoeTd1fgTJGlcCZ1v1kz9fIWLrunT1jf8AsY2YAwFGLCGM6md
         OD42td5ll5X35uOx4zCewHGteWVkJfJI9ArStpIR+59THayUKVUZgiyCfXmW/aNLanTi
         hJkeHA/M/rY06MtrdpxFeR2oN4BhlPFoYY+7HKo76A8KtnXJn8Oo9y8AcwdtPIuZUqfd
         sFPgwFqZP7VYp/dm+DbfPtcdUeHAD6anEBfsWU0Z4+e/0rUTzCxk8kaaboTsAzhqLgid
         OIKQ==
X-Gm-Message-State: AJcUukdUCrI5kpyiN3zyFFzQHHU5Ldy1z+8yk7d6fbvUPnYgm+XAjXmy
        EHoZdy4I56lSCuO9E2dBWvXHF5Kk
X-Google-Smtp-Source: ALg8bN5sXpkmygbHir8fDT9ICsydwZu3WENdV1yIFqJ2MN00pemcBOdGzxWnypDIqB6FZa+Luywi6A==
X-Received: by 2002:a63:235f:: with SMTP id u31mr514009pgm.122.1545356100477;
        Thu, 20 Dec 2018 17:35:00 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id g70sm36590854pfg.98.2018.12.20.17.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 17:34:59 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     p.zabel@pengutronix.de, linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 0/2] reset: Add Broadcom STB SW_INIT reset controller driver
Date:   Thu, 20 Dec 2018 17:34:07 -0800
Message-Id: <20181221013409.14324-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

This patch series adds support for the Broadcom STB reset controller
using SW_INIT-style registers which have one or more banks of 32
reset lines and separate CLEAR/SET/STATUS registers.

Thanks!

Florian Fainelli (2):
  dt-bindings: reset: Add document for Broadcom STB reset controller
  reset: Add Broadcom STB SW_INIT reset controller driver

 .../devicetree/bindings/reset/brcm,reset.txt  |  27 ++++
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-brcmstb.c                 | 121 ++++++++++++++++++
 4 files changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,reset.txt
 create mode 100644 drivers/reset/reset-brcmstb.c

-- 
2.17.1

