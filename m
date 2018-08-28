Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6726C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A375320851
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A375320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeH1Vti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:49:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:51074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727040AbeH1Vti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:49:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1ED4AD85;
        Tue, 28 Aug 2018 17:56:49 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 5FFAFA0C37; Tue, 28 Aug 2018 19:56:48 +0200 (CEST)
Message-Id: <cover.1535477409.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next 0/2] ethtool: drop get_settings and set_settings ops
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Aug 2018 19:56:48 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Andrew Lunn pointed out in recent discussion, there is only one in tree
driver left which still defines deprecated callbacks get_settings() and
set_settings() in ethtool_ops. First patch converts this driver to
get_link_ksettings() and set_link_ksettings(). Second patch then removes
the deprecated callbacks from struct ethtool_ops and ethtool code which
falls back to them.

This doesn't break old versions of ethtool or any other userspace code
using ETHTOOL_{G,S}SET. We still implement both (old) ETHTOOL_{G,S}SET and
(new) ETHTOOL_{G,S}LINKSETTINGS ioctl commands but after this series both
will be implemented only using {g,s}et_link_ksettings(). The only affected
code would be out of tree NIC drivers which have not been converted yet.

Michal Kubecek (2):
  8390/etherh: convert to ethtool_{get,set}_link_ksettings
  ethtool: drop get_settings and set_settings callbacks

 Documentation/ABI/testing/sysfs-class-net |   4 +-
 drivers/net/ethernet/8390/etherh.c        |  35 ++---
 include/linux/ethtool.h                   |  33 ++---
 include/uapi/linux/ethtool.h              |  15 +-
 net/core/ethtool.c                        | 158 +++++-----------------
 5 files changed, 69 insertions(+), 176 deletions(-)

-- 
2.18.0

