Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F98CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F241B20862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WltTNsqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F241B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389738AbeG0WrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:47:05 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41748 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389368AbeG0WrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:47:05 -0400
Received: by mail-qt0-f195.google.com with SMTP id e19-v6so6509804qtp.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bkDf9H/lCzyN8r7W365Wx28B9L8S1jVg+xhMsFMvT7Y=;
        b=WltTNsqe0pSQeTHTYNDXGNcMPYCPWuvguNqsCDCdpUaZiNOfc3DZ6U/b/aoIHGrwi6
         DJkIrw4kfFaDvqt6QinWsv0Guc4ypROxWawAmonHGIKw9sZE/jP/uuOVxIWu8X1XKPuE
         0GA2Df1vhLAEdmYzzWc2v8A3QCAOdfbL+A2FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bkDf9H/lCzyN8r7W365Wx28B9L8S1jVg+xhMsFMvT7Y=;
        b=e7X9rtC2n7u5m5uoQpaAOA8kd8ZzU9ZycutXNRVhcAffpjUjegY4Ac9g/A0A6xhV/E
         zKm/qcGeIgCUIyNXjOBKpasDf0VyPHjxlU1+4jS4zXq4MercHFi0BEuazsBm3eUO2zzK
         PxL4MAY4Ew1RFaLWfrCzYW/GV/4U7+CHrcvHNyHXKbBfUC2M2FUGIpAFuBB8mOJabEl7
         L2g/xRCfIbdecp8VrtiFbnnooN9NfXsoigXMo7QXLsCMVdazsQm/sTvXAYjVVhugZAYg
         naPlel3UMTnK+A3ZVtHscoLQsLG+J7n/YlOg19i4fFX6xGFSXRd8CJDRdixIzkClDisS
         sGIg==
X-Gm-Message-State: AOUpUlHDm5x8xxBka9kfqkFSY05UPbflFVSc+j/FVsaILsNhVs5Nx7b3
        YKjxDF7yia2y3kYUm8MAkW6BSw==
X-Google-Smtp-Source: AAOMgpc2VCv3e+6Im30SOH5hB36Fq8vCEcYsIxWlQWtpyQIjahRKeQSlab09GDqmqaX42LBUXZ2Hcw==
X-Received: by 2002:aed:35f8:: with SMTP id d53-v6mr7856400qte.239.1532726601637;
        Fri, 27 Jul 2018 14:23:21 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e21-v6sm3416622qtc.67.2018.07.27.14.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 14:23:20 -0700 (PDT)
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
Subject: [PATCH v2 0/7] Add clock config and pm support to bcm iProc mdio mux
Date:   Fri, 27 Jul 2018 14:23:26 -0700
Message-Id: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The patchset is based on David Miller's "net-next" repo.

The patchset extends the Broadcom iProc mdio mux to add support for
suspend/resume and the ability to configure the internal clock
divider. The patchset also sets the scan control register to
disable external master access.

The base address of the mdio-mux-bcm-iproc is modified to point to the
start of the mdio block's address space, to be able to access all the
mdio's registers. The missing registers are required to configure the
internal clock divider registers in some of the Broadcom SoC's.

Changes from v1:
 - Addressed Andrew's comments.
   - Reworked the patches to be based on 'net-next'
   - Removed 'fixes' from the commit messages, the changes are related
     to the new features being added.
   - Maintained backward compatibility to older dt-blob's specifying
     base addresse with an offset. The correction is applied in the
     driver and a message is printed to update the dt-blob.
   - Re-worked and re-ordered the last four patches (4-7).
     - Added setting of the scan control register as a new patch
     - Added a call to 'clk_prepare_enable()' in the patch that adds
       the clock config support, removed the debug message when clock
       is not passed.
     - Simplified the pm support patch (removed the array used for the
       save/restore logic).

Thanks
Arun

Arun Parameswaran (7):
  dt-bindings: net: Fix Broadcom iProc mdio mux driver base address
  net: phy: Fix the register offsets in Broadcom iProc mdio mux driver
  arm64: dts: Fix the base address of the Broadcom iProc mdio mux
  net: phy: Disable external master access in bcm mdio mux driver
  dt-bindings: net: Add clock handle to Broadcom iProc mdio mux
  net: phy: Add support to configure clock in Broadcom iProc mdio mux
  net: phy: Add pm support to Broadcom iProc mdio mux driver

 .../bindings/net/brcm,mdio-mux-iproc.txt           |   7 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |   4 +-
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   4 +-
 drivers/net/phy/mdio-mux-bcm-iproc.c               | 109 +++++++++++++++++++--
 4 files changed, 109 insertions(+), 15 deletions(-)

-- 
1.9.1

