Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDABEC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20CC20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="EIz4ikbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20CC20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeLDOPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:15:07 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39156 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeLDOPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:15:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id c72so8274199pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 06:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8JPiqVruzrD5OGaZzdip19sastO5p9E3ha1IKkMYs/A=;
        b=EIz4ikbfLjJhka7KtNZTWOVLwnJG2BE1jDRQZU8gGzbfCrKPE4Xft9SVix9Xsz4/dr
         DQ7vJ0nBSEfKsvqY1AaA+IV07GVS7OaSFkvm7tytU2D+BX+reKdcVSokKkpu9O5j3Y9/
         tDfJvJY6alklmXm5iA/gSGfjY5oeD5J8kTLJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8JPiqVruzrD5OGaZzdip19sastO5p9E3ha1IKkMYs/A=;
        b=QnGwln/C9ZUe/hWAVDsQjzgGqmCLnYvIqIJy4mu0a9VDI0n5mm/MibyLOzs9FxQfkb
         AdAZEEdb8xom0WkHWkV7gzPnzfBHEG+bceyqnHI6A0zj8G8NvsbanegVT2qJAqYxhVgs
         8gnntHZsgAfqF+V1EdqSgFhV9EQAvNQBt67iv2nGLVWi6VYEK/sz3Xwb0y0+ZUfyXPK+
         HnW/zIdWoOxYsZMZ87i2/6cW2wWM7GaAZfXlPkW1G6Arb4F1npQe33Ek93wnS6QKE56v
         9RbW8EoTnyQ+fuuSB4BkQwHF7gxpHF+5Ufs+Y0rFhXkW6e7XvyfH99lvAori0zo+6K1X
         LQFA==
X-Gm-Message-State: AA+aEWa8Q87M3b710asIo3Qs7mYgTiIcKZHklXvcMu/j+m8QhdEljdw2
        tU08b5Mi2KN+7FO80GOB2Ss4iA==
X-Google-Smtp-Source: AFSGD/U8jvgr5ygk7IiXzVM4RoOJoR5pGRq0PsdpspeDhmhInQMIIIaP2wWjBtn2+DL3gDfirwSWGA==
X-Received: by 2002:a62:5950:: with SMTP id n77mr19999151pfb.128.1543932904969;
        Tue, 04 Dec 2018 06:15:04 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
        by smtp.gmail.com with ESMTPSA id n66sm36975863pfk.19.2018.12.04.06.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 06:15:04 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH V4 0/6] net: lorawan: Add LoRaWAN soft MAC module
Date:   Tue,  4 Dec 2018 22:13:36 +0800
Message-Id: <20181204141341.4353-1-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
References: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoRaWAN(TM) is the MAC layer defined by LoRa Alliance(TM) over LoRa
devices.  LoRa is one of Low-Power Wide-Area Network (LPWAN) technology.

LoRaWAN networks typically are laid out in a star-of-stars topology in
which gateways relay messages between end-devices and a central network
server at the backend.  Gateways are connected to the network server via
standard IP connections while end-devices use single hop LoRa(TM) or FSK
communication to one or many gateways.

A LoRa network distinguishes between a basic LoRaWAN (named Class A) and
optional features (Class B, Class C ...):
* Bi-directional end-devices (Class A)
* Bi-directional end-devices with scheduled receive slots (Class B)
* Bi-directional end-devices with maximal receive slots (Class C)

This patch set add LoRaWAN class module implementing the stack,
especially the soft MAC, between socket APIs and LoRa device drivers.

socket APIs:
send and receive the data
------------------------------------------------------------------------
LoRaWAN class module implements soft MAC:
append the header/footer, encryption/decryption, timing slot and MAC
commands
------------------------------------------------------------------------
LoRa device drivers:
send and receive the messages for MAC layer
------------------------------------------------------------------------
LoRa devices

This module starts from simple and implements partial Class A
end-devices features defined in LoRaWAN(TM) Specification Ver. 1.0.2.
More features and complexity, for example regional parameters, confirmed
data messages, join request/accept messages for Over-The-Air Activation,
MAC commands ... will be added in the future.

Jian-Hong Pan (6):
  net: lorawan: Add LoRaWAN socket module
  net: lorawan: Add LoRaWAN API declaration for LoRa devices
  net: maclorawan: Add maclorawan module declaration
  net: maclorawan: Implement the crypto of maclorawan module
  net: maclorawan: Implement maclorawan class module
  net: lorawan: List LORAWAN in menuconfig

 include/linux/lora/lorawan.h        | 131 ++++++
 include/linux/lora/lorawan_netdev.h |  52 +++
 net/Kconfig                         |   2 +
 net/Makefile                        |   2 +
 net/lorawan/Kconfig                 |  10 +
 net/lorawan/Makefile                |   2 +
 net/lorawan/socket.c                | 686 ++++++++++++++++++++++++++++
 net/maclorawan/Kconfig              |  14 +
 net/maclorawan/Makefile             |   2 +
 net/maclorawan/crypto.c             | 212 +++++++++
 net/maclorawan/crypto.h             |  27 ++
 net/maclorawan/mac.c                | 518 +++++++++++++++++++++
 net/maclorawan/maclorawan.h         | 200 ++++++++
 net/maclorawan/main.c               | 605 ++++++++++++++++++++++++
 14 files changed, 2463 insertions(+)
 create mode 100644 include/linux/lora/lorawan.h
 create mode 100644 include/linux/lora/lorawan_netdev.h
 create mode 100644 net/lorawan/Kconfig
 create mode 100644 net/lorawan/Makefile
 create mode 100644 net/lorawan/socket.c
 create mode 100644 net/maclorawan/Kconfig
 create mode 100644 net/maclorawan/Makefile
 create mode 100644 net/maclorawan/crypto.c
 create mode 100644 net/maclorawan/crypto.h
 create mode 100644 net/maclorawan/mac.c
 create mode 100644 net/maclorawan/maclorawan.h
 create mode 100644 net/maclorawan/main.c

-- 
2.19.2

