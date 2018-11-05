Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C23C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5CD20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="UY6F5BDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5CD20819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbeKFCRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:17:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41947 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387677AbeKFCRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:17:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id k13so4485904pga.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5zrWXe3aeo+B0EAWT+gxm5OSW82SxwQuqY501axr2ww=;
        b=UY6F5BDM447rCCXUwAdO2UGqy96PxsKxP5vwbrr1u6Xx6514Xh7k5KKdYULbI8sLmp
         6fdEQ7JDATAUh2/G9mqtnN55A2ZN93KTEEPxbXvqqjx/6PWtuswWUQ7AFZk0bQz0T8Lm
         MYJ7cZtf7b7SnVVyEVjYUzMRfkNAvOm6XS7EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zrWXe3aeo+B0EAWT+gxm5OSW82SxwQuqY501axr2ww=;
        b=aYoit49uQoNtlVOCJyyGyqoSYXihC2MbvgG7Ehtal3Ncp/fqo5Qp7yM3ogCrbj26Wn
         5DvFGZ11N+HKyKZeFpPnhsu+jazv8PxTAWX86IvPTA0JQ29aX0b6PRBu2Hfr9LRQSCf7
         PIcQZwtIoq0lDiiowT4EqWUDzoyEhc1gX0wgSq5HO/+jnaKQSaJmJjHJ/n/4W2NzFSUt
         3brsWWZniPdVqOBvVkK1A7S886lwq/8UNZ1LF7QhhwcXk/fqXMCuzLLWYWLcRQ2l93nk
         hkRC8XeCCAEBprjY1LwQ2poeW+dfEAHrvBLA+jO0iyMdN8fKm/kvUSDlwmDLF2PIFgOr
         iulA==
X-Gm-Message-State: AGRZ1gKaYndvEakuAtByurXGJoV6KUkuAITHewL+poHWMQcU2jVqIFug
        2klxoan4WiqRbs84TYscCfX9MA==
X-Google-Smtp-Source: AJdET5dlx0zVk1TqmyfmoWwrIXIJPHcik9s3kOkBQ2Eu8sus1sIw5ywWLapOBentAz049sNz/tgdyQ==
X-Received: by 2002:a63:8e43:: with SMTP id k64mr20611497pge.346.1541437020349;
        Mon, 05 Nov 2018 08:57:00 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
        by smtp.gmail.com with ESMTPSA id l16-v6sm58445129pfj.179.2018.11.05.08.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 08:56:59 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH V2 0/7] net: lorawan: Add LoRaWAN soft MAC module
Date:   Tue,  6 Nov 2018 00:55:38 +0800
Message-Id: <20181105165544.5215-1-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
References: <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
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

Jian-Hong Pan (7):
  net: lorawan: Add macro and definition for LoRaWAN
  net: lorawan: Add LoRaWAN socket module
  net: lorawan: Add LoRaWAN API declaration for LoRa devices
  net: maclorawan: Add maclorawan module declaration
  net: maclorawan: Implement the crypto of maclorawan module
  net: maclorawan: Implement maclorawan class module
  net: lorawan: List LORAWAN in menuconfig

 include/linux/lora/lorawan.h        | 137 ++++++
 include/linux/lora/lorawan_netdev.h |  52 +++
 include/linux/socket.h              |   5 +-
 include/uapi/linux/if_arp.h         |   1 +
 include/uapi/linux/if_ether.h       |   1 +
 net/Kconfig                         |   2 +
 net/Makefile                        |   2 +
 net/core/dev.c                      |   4 +-
 net/lorawan/Kconfig                 |  10 +
 net/lorawan/Makefile                |   2 +
 net/lorawan/socket.c                | 681 ++++++++++++++++++++++++++++
 net/maclorawan/Kconfig              |  14 +
 net/maclorawan/Makefile             |   2 +
 net/maclorawan/crypto.c             | 209 +++++++++
 net/maclorawan/crypto.h             |  27 ++
 net/maclorawan/mac.c                | 522 +++++++++++++++++++++
 net/maclorawan/maclorawan.h         | 199 ++++++++
 net/maclorawan/main.c               | 600 ++++++++++++++++++++++++
 security/selinux/hooks.c            |   4 +-
 security/selinux/include/classmap.h |   4 +-
 20 files changed, 2473 insertions(+), 5 deletions(-)
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
2.19.1

