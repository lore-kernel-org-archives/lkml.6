Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B87CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258482083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bj/eADDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258482083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbeGZTy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:54:26 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35914 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730323AbeGZTy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:54:26 -0400
Received: by mail-qk0-f193.google.com with SMTP id a132-v6so1663533qkg.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 11:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uIrgOYN3f03gfRFUysQcJ/JKGCsJKZ+YmEcwECocEAA=;
        b=bj/eADDb308I/Rcv8etLoxfdWXZLaCUpnyc9MJACjB5gun5Y3cjSL/YyFXkp6t21co
         6NEJ7lj1kC5V9QgQLCRw4RyZtXxlCdd9J2ttl9gk9ELAF41ZVWsciGNT4AmttX/Pg7Ql
         qKaPfACBStLg3KieZDo6FNSgZYlyfTgUl6yiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uIrgOYN3f03gfRFUysQcJ/JKGCsJKZ+YmEcwECocEAA=;
        b=GdK2HVtJWaGOjYsFM+2wc6SuKKFTwHJ1hnI8dglR+Pug0n1hX0qgH20nh3MipS3+ze
         iqFDnDB8w6HlhK6BIwWkcjxi2u0mkXblTrf2EtsoLZQyZiaoPYCBVflrPQMRqSIm9VmG
         1lLzh2q+oA0IbjQHEkw2CyPoyKuUVXXjtqnOgX9GEKxFVapFX/Hc47iqGP8CUQmwuNB6
         CEr7X1WHN9dKuWL6iXxIP64crt6OdNY8h7fYQSowLYxNs8UqSyoOF5o7ECG7IxPQBh0D
         Z18hbBVIOkxFyJdgAx58CEKvHwq2OFVgF9IFzHCWZdkkX9Vz3JGMVYhvKidwoc6V+OJW
         YOaA==
X-Gm-Message-State: AOUpUlFAR1zOYPRqp762XioQxY97BS4UZaOqQdpbdkCwanbA2SbN6SIl
        wQ0mq25OLQYoukc4h6qHWNs+3w==
X-Google-Smtp-Source: AAOMgpfNRlAzDgS4XzvcB+GHm0Beqg4RyGtxQzA9RIZ5X7svOT5t3DUK8xQnCV1MxqlWSaaxuVijXA==
X-Received: by 2002:a37:9404:: with SMTP id w4-v6mr2802323qkd.50.1532630182727;
        Thu, 26 Jul 2018 11:36:22 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a187-v6sm1383359qkd.47.2018.07.26.11.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 11:36:22 -0700 (PDT)
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Arun Parameswaran <arun.parameswaran@broadcom.com>
Subject: [PATCH 0/7] Add clock config and pm support to bcm iProc mdio mux
Date:   Thu, 26 Jul 2018 11:36:17 -0700
Message-Id: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The patchset is based on David Miller's "net" repo.

The patchset extends the Broadcom iProc mdio mux to add support for
suspend/resume and the ability to configure the internal clock
divider.

The base address of the mdio-mux-bcm-iproc is modified to point to the
start of the mdio block's address space, to be able to access all the
mdio's registers. The missing registers are required to configure the
internal clock divider registers in some of the Broadcom SoC's.

Thanks
Arun

Arun Parameswaran (7):
  dt-bindings: net: Fix Broadcom iProc mdio mux driver base address
  net: phy: Fix the register offsets in Broadcom iProc mdio mux driver
  arm64: dts: Fix the base address of the Broadcom iProc mdio mux
  dt-bindings: net: Add clock handle to Broadcom iProc mdio mux
  net: phy: Add support to configure clock in Broadcom iProc mdio mux
  net: phy: Add pm support to Broadcom iProc mdio mux driver
  net: phy: Add pm support for scan ctrl register to bcm mdio mux

 .../bindings/net/brcm,mdio-mux-iproc.txt           |  7 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |  4 +-
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  4 +-
 drivers/net/phy/mdio-mux-bcm-iproc.c               | 89 ++++++++++++++++++++--
 4 files changed, 92 insertions(+), 12 deletions(-)

-- 
1.9.1

