Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6B3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E744F20676
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUBw5jpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E744F20676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeIYC7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:59:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36088 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeIYC7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:59:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so9800782pgo.3;
        Mon, 24 Sep 2018 13:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W5ObGYohiYh3opXCQL0ZqmiKFuQBEQhB9NwwFc7+YYU=;
        b=NUBw5jpf/bvHpWkqHv0Yn0k7ySOorDInBK22/3WelQV7G5ADfnVVpGYV/QWZv36qyn
         LVldLifbBX10AMl4LXPvZ+HOfNTTP3ECtfcQuoixr/eYJamZ8dNr0G5DxBF3f5IPIgA7
         TKC1kpDsokWkKkKkMDaKOW1Man6cKOW5UOenupF72Hx8wfuS1LOCT4FNfqZphqWhKl22
         Op1C506j59YKt2YRLeMPd15mhtedvS9cHgoF98R+kFmi8NJxlaX6mDqrg1pOvW1x8TcZ
         ITmHc0eBZ93iNv7pV+JNQb9buwUStTibk8xS5pXcYBjWJEIUgf2nICZfadC55rpZhUoY
         56dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W5ObGYohiYh3opXCQL0ZqmiKFuQBEQhB9NwwFc7+YYU=;
        b=fJtjBb/RSEY9wADEHGwz3Hp4F0fErCKnDktsbXnN3FbvOc5G838wgnNMwSqjARzkEC
         Z2uuopmx1x+qDd//AyxyxLdWWWju2hQi1VkxsnoTaBCq2dPluZfi2yaLMI3S2XNHMsPB
         vVgC/0txQWACUOn/+qEEj+3X5ZQ+tqTR+RU3etTIPbf5O5dAJwountyJW4GDxGAx6WWF
         26si5QwQITpOgoIkUlZFeBDyMZVs3ab/4YBS4blx6sqJff5BX9HU4rrp49jIn4I99gqg
         L37BW1qfTWOoD0RbEJ9v785NcA93smhU5P9AAJ7igu8xgZn9/y7vVQcGnKcgMDl7K8iU
         LJ/w==
X-Gm-Message-State: ABuFfog6GCAaIFg7WLgoCTikrzbQSjexrqT0UrqbCTVFIj6O5msIdH7q
        Re7ZEiWEHNJjq/MFkd59WxdMXbJD
X-Google-Smtp-Source: ACcGV62o1Ma5YxI6PzVyjTNKGMNkeh3JuAQ4jEFv6Hoc3yNWrV/7IS/UQWOlyXS/RlTmRzw1iEmJig==
X-Received: by 2002:a17:902:748b:: with SMTP id h11-v6mr478269pll.192.1537822517105;
        Mon, 24 Sep 2018 13:55:17 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b62-v6sm260160pfm.183.2018.09.24.13.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 13:55:16 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Kees Cook <keescook@chromium.org>,
        Alexander Kurz <akurz@blala.de>,
        Hayes Wang <hayeswang@realtek.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Grant Grundler <grundler@chromium.org>,
        zhong jiang <zhongjiang@huawei.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ran Wang <ran.wang_1@nxp.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 0/7] net: usb: Check for Wake-on-LAN modes
Date:   Mon, 24 Sep 2018 13:54:13 -0700
Message-Id: <20180924205420.31309-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Most of our USB Ethernet drivers don't seem to be checking properly
whether the user is supplying a correct Wake-on-LAN mode to enter, so
the experience as an user could be confusing, since it would generally
lead to either no wake-up, or the device not being marked for wake-up.

Please review!

Florian Fainelli (7):
  asix: Check for supported Wake-on-LAN modes
  ax88179_178a: Check for supported Wake-on-LAN modes
  lan78xx: Check for supported Wake-on-LAN modes
  sr9800: Check for supported Wake-on-LAN modes
  r8152: Check for supported Wake-on-LAN Modes
  smsc75xx: Check for Wake-on-LAN modes
  smsc95xx: Check for Wake-on-LAN modes

 drivers/net/usb/asix_common.c  | 3 +++
 drivers/net/usb/ax88179_178a.c | 3 +++
 drivers/net/usb/lan78xx.c      | 3 +++
 drivers/net/usb/r8152.c        | 3 +++
 drivers/net/usb/smsc75xx.c     | 3 +++
 drivers/net/usb/smsc95xx.c     | 3 +++
 drivers/net/usb/sr9800.c       | 3 +++
 7 files changed, 21 insertions(+)

-- 
2.17.1

