Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3D5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44885208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="l1Hmcf/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44885208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbeKOCGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:06:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46582 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeKOCGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:06:23 -0500
Received: by mail-pf1-f196.google.com with SMTP id s9-v6so8109280pfm.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 08:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6X8LCNbuXsshq4L5XV7wRBvxJVJhc2BBuwqGIn2Nj9c=;
        b=l1Hmcf/nBo9nxIA99CUlL++Vy334u+HqsW0YyuWD/cEVzq/wG3A58GJsJr/sRYhCT7
         FxjhS/l+gDUn0vM9yZHFA65vjcvJhbdRdcdqLfJRJF3viRODYaQHJTZu37tVkUCZ4Jit
         LuSRXHGdMt8vkoZeI6q9fQwTp4B+5bTw9+T2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6X8LCNbuXsshq4L5XV7wRBvxJVJhc2BBuwqGIn2Nj9c=;
        b=maYV1wdEgqz6ogRzzF0N23VxewYU64HylRcUmydr97VYyt60ykTqEMdmCMJZ7yso1o
         qcDX8KPkyX8KnqKFZjGcIwdLqQt5GAKPAvgvtwrCekT0nLCKOQlBnCnhKhXBax4J07rK
         aCXcX9Fak66KA0FuF6iEpQzOKCumfdb+wuXhArm8G7m0CdTAnniUzK4/44SaE7ltdNQS
         N/g+u+wTteXiqnF+aH3Q5i6xLWg7J1JDl8BWwj9ySOd450fi/zHY9tXpGuTIxsWpxxZm
         /rwwz7mL09F8GDPguHfIU3DK7kw65yPVN8MKE7edDGwXK3a+jn/OuYOnYUZ3MfamkYzG
         fL9A==
X-Gm-Message-State: AGRZ1gIvd5Dr1xEL8MDb4lmETS0SJ+R56G5E7ZeECQlpFjS0XU3TqmAD
        4EIWTfVULfG6gDTBhIMBBq5QJw==
X-Google-Smtp-Source: AJdET5f4YRk9PMl6EcaRELZjHBDpcQydYq0u/gtDnWoCZAM0AfkPpFYFii8PIm4J+OmZUTXjUX5kkA==
X-Received: by 2002:aa7:8552:: with SMTP id y18mr2574710pfn.83.1542211353124;
        Wed, 14 Nov 2018 08:02:33 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
        by smtp.gmail.com with ESMTPSA id s2-v6sm53449854pfk.133.2018.11.14.08.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:02:32 -0800 (PST)
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
Subject: [PATCH V3 0/7] net: lorawan: Add LoRaWAN soft MAC module
Date:   Thu, 15 Nov 2018 00:01:20 +0800
Message-Id: <20181114160126.4445-1-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105.101610.1437737564548154497.davem@davemloft.net>
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
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

 include/linux/lora/lorawan.h        | 131 ++++++
 include/linux/lora/lorawan_netdev.h |  49 ++
 include/linux/socket.h              |   5 +-
 include/uapi/linux/if_arp.h         |   1 +
 include/uapi/linux/if_ether.h       |   1 +
 net/Kconfig                         |   2 +
 net/Makefile                        |   2 +
 net/core/dev.c                      |   4 +-
 net/lorawan/Kconfig                 |  10 +
 net/lorawan/Makefile                |   2 +
 net/lorawan/socket.c                | 688 ++++++++++++++++++++++++++++
 net/maclorawan/Kconfig              |  14 +
 net/maclorawan/Makefile             |   2 +
 net/maclorawan/crypto.c             | 209 +++++++++
 net/maclorawan/crypto.h             |  27 ++
 net/maclorawan/mac.c                | 520 +++++++++++++++++++++
 net/maclorawan/maclorawan.h         | 199 ++++++++
 net/maclorawan/main.c               | 605 ++++++++++++++++++++++++
 security/selinux/hooks.c            |   4 +-
 security/selinux/include/classmap.h |   4 +-
 20 files changed, 2474 insertions(+), 5 deletions(-)
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

