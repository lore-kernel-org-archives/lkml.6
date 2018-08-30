Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1326C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EB220661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 00:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EB220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeH3EtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 00:49:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35498 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeH3EtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 00:49:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id w8-v6so1493789pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 17:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ixak4wWVJ8yuojewKcz4wT551koQdYX2V8RI8GCDCEQ=;
        b=cy4QAxh6+O3BEYRw661FPU4Ga1GgJjvxn2wD5dCum35Gi/hIVcMMgOv5wO0ofU6aFg
         ST9bgyp3p89WydNA4GT9xhxIGNNpcGgLVuNVL5InaVd4wdiOqA6UrlvLW7XJVWIdxMbS
         15hyuOt96RYmZL4v4Ta6+XouqFZcSxy8sM9y27njF9cl/Q7rMHKK3FI/vyzU4c44MFTw
         huKyLPx7zOr39eBf00aavxOKSYa9cPNgENwhJLrx6woKvgDsixLA4SGTpXyQ7HrOSAWC
         MPGdyNw/msdmUYNBCAgj2u5E/QD1mitp8G1O2yPNXvBqlctdYnY+h0N87Ec3bmAntIyc
         op4g==
X-Gm-Message-State: APzg51AfoShi/jw2kocomKw63duArNxQq0w0bEmXP3WuaNE1+pCu7E+r
        sXQfopnvRDk6psJumVjCm81ZXg==
X-Google-Smtp-Source: ANB0VdZJYdf8Dk6aIXZrQJeZJ+06fT8UnZv37o/RRpyZOq80Z0xxnuib4JcTBifunwztqrYyq6GfXA==
X-Received: by 2002:a62:9b46:: with SMTP id r67-v6mr8112832pfd.105.1535590193996;
        Wed, 29 Aug 2018 17:49:53 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id n22-v6sm12878074pfj.68.2018.08.29.17.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 17:49:53 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     davem@davemloft.net
Cc:     keescook@chromium.org, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        alex.williams@ni.com, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH net-next 0/3] nixge: fixed-link support
Date:   Wed, 29 Aug 2018 17:40:43 -0700
Message-Id: <20180830004046.9417-1-mdf@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series adds support for using nixge with fixed-link nodes,
as well as an early attempt to support nixge as a subdevice of
another device.

This series goes on top of: https://lkml.org/lkml/2018/8/28/1011

Patch 1: Adds of based fixed-link support, and hopefully isn't too
         controversial barring grave mistakes.

Patch 2: Is an attempt at making sure that nixge works as a subdevice
         of another (pci) device without a PHY. Note that same as Patch
         3 the actual platform data might still change since the parent
         device driver is still under development. So this is more of an
         RFC, too.

Patch 3: Is more of an RFC at this point since the PCI parent device is
         still under development, but required to run with IOMMU
         support. Feedback on this one would be appreciated.

Thanks for your input,

Moritz

Moritz Fischer (3):
  net: nixge: Add support for fixed-link subnodes
  net: nixge: Add support for having nixge as subdevice
  net: nixge: Use sysdev instead of ndev->dev.parent for DMA

 drivers/net/ethernet/ni/nixge.c     | 187 ++++++++++++++++++++++------
 include/linux/platform_data/nixge.h |  19 +++
 2 files changed, 165 insertions(+), 41 deletions(-)
 create mode 100644 include/linux/platform_data/nixge.h

-- 
2.18.0

