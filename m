Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE2EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A7B20A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="dNe/V/fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A7B20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbeHWUt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:49:27 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:38071 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbeHWUt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:49:26 -0400
Received: by mail-pg1-f170.google.com with SMTP id k8-v6so2941558pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Mbhgccled8ON2zZ1ZNg5hBR+nbD+zHDDfC2udkEdW8c=;
        b=dNe/V/fqThxz0r6jijE/G+pE6s3fA+IMi9Rz4gFf0j0Wv81Kt4QBVxRRi1HOqQHFHV
         eeHDq176duFP3PTNwIvRXD78LoVSSrZz5gzI5pNZxh67maaDCNeTLgeF/p7eAKhAS8TY
         WLLNfKKVbLFuQ+RHgZLxSEiHtKGWBB3IohcUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mbhgccled8ON2zZ1ZNg5hBR+nbD+zHDDfC2udkEdW8c=;
        b=K4LGe/SXSNC5IpFWiBR4ucOJ8M2ijyrQJHj5j9IWy4jVwRxa6mOwzQF08NipRf+yJG
         XeKs0MZ3txYBIghTzT5r1+5Iji7zou3sjZQHTxu2xVrX5uJhosgyYH8unmvUCu1Vj2uz
         PDPAAYarp7ElylXCDf5LohmP6/MgRhGmJVWm0PqpIdcD74zheWsxWASa93H4Sa17LXtg
         GBTFobW8IOs0SnKohk6/dEEBsJyPtjKWZ9G1xiRVQzL9hfmY4LQe3QDLE+tMXocEii99
         Xw6uGDbMHBZIsSHYnzKKWCt2ST2IeyxtV+Si6dppb5AgS313wCMP0PUpQzaPyyYiMvgT
         0Kww==
X-Gm-Message-State: APzg51BQsYkqQ3dVqUhDiPzYe2FUu49YQZr9WRGsllI+kltlQjHPLzUW
        XRPgAn1z7ESWNCdN1oaPfYBFxA==
X-Google-Smtp-Source: ANB0VdZU1+lz4SgRQPsbeXvU20a5tITDcRAIMfgpM6eEN4e6DqnTHacyKTHjIzaA5CXqeaPKgn7UFA==
X-Received: by 2002:a63:7058:: with SMTP id a24-v6mr5918145pgn.206.1535044724412;
        Thu, 23 Aug 2018 10:18:44 -0700 (PDT)
Received: from starnight.local ([150.116.244.148])
        by smtp.gmail.com with ESMTPSA id n9-v6sm7483404pfg.21.2018.08.23.10.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 10:18:43 -0700 (PDT)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?q?Michael=20R=C3=B6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?q?Konstantin=20B=C3=B6hm?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>,
        "contact@snootlab.com" <contact@snootlab.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        Alexander Graf <agraf@suse.de>,
        =?UTF-8?q?Michal=20Kube=C4=8Dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Pieter ROBYNS <pieter.robyns@uhasselt.be>,
        Hasnain Virk <Hasnain.Virk@arm.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Daniele Comel <dcomel@mipot.com>, shess@hessware.de,
        Xue Liu <liuxuenetmail@gmail.com>
Cc:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [RFC 0/3 net] lorawan: Add LoRaWAN soft MAC module
Date:   Fri, 24 Aug 2018 01:15:40 +0800
Message-Id: <cover.1535039998.git.starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.18.0
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

Besides, I upload these patches and open discussion.  For example, the
more common/flexible interface for compatible LoRa device drivers and
protocols implementation, etc.

Another idea mentioned by Andreas: Make PF_LORA and PF_LORAWAN like
PF_INET and PF_INET6 exist at the same time.  That is also interesting.

Jian-Hong Pan (3):
  lorawan: Add LoRaWAN class module
  lorawan: Add macro and definition for LoRaWAN class modlue
  lorawan: List LORAWAN in menuconfig

 include/linux/maclorawan/lora.h     | 239 ++++++++++
 include/linux/socket.h              |   5 +-
 include/uapi/linux/if_arp.h         |   1 +
 include/uapi/linux/if_ether.h       |   1 +
 net/Kconfig                         |   1 +
 net/Makefile                        |   1 +
 net/core/dev.c                      |   4 +-
 net/maclorawan/Kconfig              |  14 +
 net/maclorawan/Makefile             |   2 +
 net/maclorawan/lorawan.h            | 219 +++++++++
 net/maclorawan/lrwsec.c             | 237 ++++++++++
 net/maclorawan/lrwsec.h             |  57 +++
 net/maclorawan/mac.c                | 552 ++++++++++++++++++++++
 net/maclorawan/main.c               | 665 ++++++++++++++++++++++++++
 net/maclorawan/socket.c             | 700 ++++++++++++++++++++++++++++
 security/selinux/hooks.c            |   4 +-
 security/selinux/include/classmap.h |   4 +-
 17 files changed, 2701 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/maclorawan/lora.h
 create mode 100644 net/maclorawan/Kconfig
 create mode 100644 net/maclorawan/Makefile
 create mode 100644 net/maclorawan/lorawan.h
 create mode 100644 net/maclorawan/lrwsec.c
 create mode 100644 net/maclorawan/lrwsec.h
 create mode 100644 net/maclorawan/mac.c
 create mode 100644 net/maclorawan/main.c
 create mode 100644 net/maclorawan/socket.c

-- 
2.18.0

