Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A832EC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4295F218FC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aF6Np2Cl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4295F218FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389649AbeHGTRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:17:37 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33548 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388534AbeHGTRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:17:37 -0400
Received: by mail-qk0-f193.google.com with SMTP id 27-v6so11944787qkv.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BcQviJ6ammr9BiE687Pk5RKSEqII8UyLrdOlOdbsIIc=;
        b=aF6Np2Clr9xU73mEH5RFsIgewjgFNLNYDUK3Osi5lInNsqU8M9dStNZ1Qc6LERJLLP
         up0DKnfoMscLQLA4EcDTyK7tzIYHzuEN7VjZn8V4Hg0UPSQwtKLG1iA0D2qs1KUcIyKv
         WC0PF1KE6V3J6EGqkFWf631Pq/dbKmdG9cN6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BcQviJ6ammr9BiE687Pk5RKSEqII8UyLrdOlOdbsIIc=;
        b=nMR4NBjzOzhfZ/Nx3p+DXEN2usdQ/uD76uOYy4oGWJwSPmEpsyLEsd/SXP9Uzl3J9n
         mvo17kIcOR1JmvJu8yYcA/eWduayo8E8fMYSqK5cGxDHwadBo5D1rMB4r2sVlepVCUTu
         4DnIv2GaA5nDdo7ayNDf2xwiDNeK5sjFkdb1eAxWBMbbTdhTxCSrUTWJMoARpcSOet/p
         jDQiuhXrnUTn1zqHrEHF39hUXdP08z2DOqv7bI9hihRWqZNqW00lm2lk403rE0h/YXHK
         HhuqHwDk/D3b6/AqabYzSWlEw+j1KsXn+dVi4t4xAiHr4fZE+/IZ6tmJU57wp8fN7cLm
         Dhqg==
X-Gm-Message-State: AOUpUlH11QDLAnfHlvCdVFU+SQwUwcY/PWxc/pu00PD87etN3opWC+bV
        SLT/k+PAouMnLOKZ4FAgRC21yw==
X-Google-Smtp-Source: AAOMgpcLqj5Oh+RWQ1I91MgHyUgPduXAW/8jp9Ae8Qt40f144dizni/XlcCdFE9AcklKiO2ttg0SZA==
X-Received: by 2002:a37:3447:: with SMTP id b68-v6mr17959605qka.171.1533661342742;
        Tue, 07 Aug 2018 10:02:22 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d12-v6sm867483qth.35.2018.08.07.10.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 10:02:21 -0700 (PDT)
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Arun Parameswaran <arun.parameswaran@broadcom.com>
Subject: [PATCH 0/3] Add Broadcom Omega SoC internal switch and phy
Date:   Tue,  7 Aug 2018 10:02:41 -0700
Message-Id: <1533661364-15381-1-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patchset is based on David Miller's "net-next" repo.

The patches add support for the Broadcom Omega SoC's internal ethernet
switch and the internal gphy.

The internal ethernet switch in the Omega is a b53 srab based switch.
The support for the switch is added to the b53 driver in the dsa
framework.

The gphy support is added to the bcm7xxx driver.

Thanks
Arun

Arun Parameswaran (3):
  dt-bindings: net: dsa: Add compatibility strings for Broadcom Omega
  net: dsa: b53: Add support for Broadcom Omega SoC internal switch
  net: phy: Add support for Broadcom Omega internal Combo GPHY

 Documentation/devicetree/bindings/net/dsa/b53.txt | 8 ++++++++
 drivers/net/dsa/b53/b53_srab.c                    | 1 +
 drivers/net/phy/bcm7xxx.c                         | 2 ++
 include/linux/brcmphy.h                           | 1 +
 4 files changed, 12 insertions(+)

-- 
1.9.1

