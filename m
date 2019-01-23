Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11C6C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6439D20868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg4r9Dbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfAWAdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:33:50 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34305 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfAWAdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:33:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so245297pfg.1;
        Tue, 22 Jan 2019 16:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JGX1Ly4z5f3bXKnacbZ85ykhGo/mX1yILkHHVN3dZqs=;
        b=dg4r9DbwnDaAsFdQ97K3S7DEkC8oLVejOyPGbeLMgqKZz9EC6Aazcs85yYI6gl4ceF
         uYKMZ8Dy8ps/8dEtZ3a4zCRXLmAuBd/MHeU/mJgdNUbXUP86+UqW1UyXYHyeX/taZ8eC
         FdXcuUurnGCHXl498YsDywouiYNeNId7NotwXUUGWrMQBt1kPJDCVei4YitVp5L+cnxa
         L5fBclneQK2Dbk423w1pWM50m02e5oW6VtgV9q7CexWj262f3Q8qSyuIECaENXPzpGWC
         TYZASVwBUfHWWp5u8KzkDWvtBeBtF3DYohCwvTvZ3biFfsJWvInAtyRGMPN9QjrtGN1s
         841g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JGX1Ly4z5f3bXKnacbZ85ykhGo/mX1yILkHHVN3dZqs=;
        b=PeVDLSZp0Fu0Qt5NqnKo99HQf4gydhIstQtLJzjIJ41I8yp5NXUXcW4lNvYCqLa8Tc
         /rQnTLPZcem61ByZXiFSMbXkq9aMM/R4kdCRvK9KjAfQkF9h42fxGuANkQjsvhqx7ZZ7
         V9j85SvN+2lNfWwT2H4WzhCL6y4F6D7oPzrPDBOy/N0nTbZYaTx3+3i0dPyY/SjjYbuX
         hOR8eN0x++IBBcEtM1j8vKVShI01G5Wcr0GF2yz2pRjY34TXVnvnqiS9fbNVj9G9gFXc
         P9RPMfdMG+B+/zJEQJfMCidxu3fIT74mMZM6er0F8/J2FJDn01r0jSZDJEtY04s4wkno
         l07Q==
X-Gm-Message-State: AJcUukd30hTECRgs2CRAfo44PbU7wHRnZ2E/Gj+tna+ctbi7zvFEdjTe
        vMJePcklFNqyyAw8gxRX4WcT8nX5
X-Google-Smtp-Source: ALg8bN7dLxJAroblpO8C3P39gJe2W9L7DTNMwQpvqXH/iox7V2bPHjTtITuUU6IC2bEOGnK8TW1TPQ==
X-Received: by 2002:a65:560e:: with SMTP id l14mr109616pgs.168.1548203628775;
        Tue, 22 Jan 2019 16:33:48 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id e86sm25465257pfb.6.2019.01.22.16.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 16:33:47 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE), rdunlap@infradead.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        paul.gortmaker@windriver.com
Subject: [PATCH reset-next 0/2] reset: brcmstb: Misc fixes
Date:   Tue, 22 Jan 2019 16:33:43 -0800
Message-Id: <20190123003345.13750-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

These two patches fix some recent issues brought up by Paul and Randy,
feel free to squash into c196cdc7659d ("reset: Add Broadcom STB SW_INIT
reset controller driver") since this is only in reset/next and
linux-next so far.

Thank you!

Florian Fainelli (2):
  reset: brcmstb: Make it tristate
  reset: brcmstb: Fix 32-bit build with 64-bit resource_size_t

 drivers/reset/Kconfig         | 3 ++-
 drivers/reset/reset-brcmstb.c | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.17.1

