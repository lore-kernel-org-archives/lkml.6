Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36578C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E7620818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2a7jnpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E7620818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeKJC5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:57:10 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:52563 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJC5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:57:09 -0500
Received: by mail-wm1-f54.google.com with SMTP id r11-v6so2704370wmb.2;
        Fri, 09 Nov 2018 09:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lhXesKLx/wINcjY+P0Mpiqebnq3GEuEM2shSRbnXCSQ=;
        b=g2a7jnpdiAdkEEZD0aQj0ABric7d6g8hnuSyX86bE7w9/mGiPDdcmiJ6JjAkRFkSDm
         F6qIvZU2a/H0llHkSLemJuzBxwCmBu5Rcg+u/dfnYv8kADgM8djAX5xewV0+XUpwourW
         1gCevgx5MsK+nao/XRhsGBcGJpT0fSuYbawOog6VmU2qAO6/7hJcrbTyI7fIXsMxNXhE
         4V71bSJndUncDYidDl1cUqSidHGp210AdQE3k62+9M1t4xCeQ1KDRvyNZGYsV3itH4+A
         GT28bD9nXOPt6tOicMHVYgcQrhEeJ08PcWtTtNJFvikGSyx1GOWBNJEagMZgH7DpEt25
         O3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lhXesKLx/wINcjY+P0Mpiqebnq3GEuEM2shSRbnXCSQ=;
        b=jDc1DZsBd7wCBsle+kYnNoTI4knHgwU9owj9ipDmFMW8BJZkJuQXEDfCi4asv47XfH
         xye0s4R/OAZjXCDWeBzlVUnd/0jUrMbq+B74HIVtxnh6BlKe7Kxv2++QnBteabqqvhKN
         lS4YRWbmc8YIf9HNQxu32Qa4WkssyjOS0258GRhiXC8tJw6xBPUH0YuiNpQ0EYG5RwB0
         t0PDfjz8hl9NF1Gafdz3vsllWqj68mqHGPufhNPPF0JGxb/e5C7Sb/lIM5aek5DVnBeV
         zUkcCdwa1uEzI4/gqtha1MNkrjVi4/6pkisnI61t2izXRXGlxNws7k0+yHQjq6EnhJaB
         M9wQ==
X-Gm-Message-State: AGRZ1gJw/OBCs1QUSA1Efxn1J9YtLJ5qj0zt21I+6TQRwqyBjklILkVE
        B1UgkJCEdz9KeGff8j8uxAY=
X-Google-Smtp-Source: AJdET5dxqVykZZjFw3tUqZHtfBg8R+Cu2Ss9Rsbr+Os3rmqf7rZ0048xQEu0hv2b5ljh7g9kuQBueQ==
X-Received: by 2002:a1c:4007:: with SMTP id n7-v6mr205809wma.46.1541783739112;
        Fri, 09 Nov 2018 09:15:39 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:d5f1:833d:6c7e:a28? (p200300EA8BCFE300D5F1833D6C7E0A28.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:d5f1:833d:6c7e:a28])
        by smtp.googlemail.com with ESMTPSA id m13-v6sm8521926wrw.14.2018.11.09.09.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 09:15:38 -0800 (PST)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v3 0/2] net: phy: replace PHY_HAS_INTERRUPT with a
 check for config_intr and ack_interrupt
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "maintainer:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>
Message-ID: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
Date:   Fri, 9 Nov 2018 18:15:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flag PHY_HAS_INTERRUPT is used only here for this small check. I think
using interrupts isn't possible if a driver defines neither
config_intr nor ack_interrupts callback. So we can replace checking
flag PHY_HAS_INTERRUPT with checking for these callbacks.
This allows to remove this flag from all driver configs.

v2:
- add helper for check in patch 1
- remove PHY_HAS_INTERRUPT from all drivers, not only Realtek
- remove flag PHY_HAS_INTERRUPT completely

v3:
- rebase patch 2

Heiner Kallweit (2):
  net: phy: replace PHY_HAS_INTERRUPT with a check for config_intr and ack_interrupt
  net: phy: realtek: remove flag PHY_HAS_INTERRUPT from driver configs

 drivers/net/phy/amd.c          |  1 -
 drivers/net/phy/aquantia.c     |  6 ------
 drivers/net/phy/at803x.c       |  3 ---
 drivers/net/phy/bcm63xx.c      |  4 ++--
 drivers/net/phy/bcm87xx.c      |  2 --
 drivers/net/phy/broadcom.c     | 16 ----------------
 drivers/net/phy/cicada.c       |  2 --
 drivers/net/phy/davicom.c      |  4 ----
 drivers/net/phy/dp83640.c      |  1 -
 drivers/net/phy/dp83822.c      |  1 -
 drivers/net/phy/dp83848.c      |  1 -
 drivers/net/phy/dp83867.c      |  1 -
 drivers/net/phy/dp83tc811.c    |  1 -
 drivers/net/phy/icplus.c       |  1 -
 drivers/net/phy/intel-xway.c   | 10 ----------
 drivers/net/phy/lxt.c          |  2 --
 drivers/net/phy/marvell.c      | 15 ---------------
 drivers/net/phy/meson-gxl.c    |  2 +-
 drivers/net/phy/micrel.c       | 14 --------------
 drivers/net/phy/microchip.c    |  1 -
 drivers/net/phy/microchip_t1.c |  1 -
 drivers/net/phy/mscc.c         |  6 ------
 drivers/net/phy/national.c     |  1 -
 drivers/net/phy/phy_device.c   |  8 ++++++--
 drivers/net/phy/qsemi.c        |  1 -
 drivers/net/phy/realtek.c      |  7 -------
 drivers/net/phy/smsc.c         |  7 +------
 drivers/net/phy/ste10Xp.c      |  2 --
 drivers/net/phy/vitesse.c      |  9 ---------
 include/linux/phy.h            |  5 ++---
 30 files changed, 12 insertions(+), 123 deletions(-)

-- 
2.19.1

