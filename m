Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99361C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43906208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SSZvwP1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43906208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbeHATnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:43:04 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40805 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbeHATnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:43:03 -0400
Received: by mail-qk0-f194.google.com with SMTP id c126-v6so13282073qkd.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EpkxNxa0CKh7tWpqxQ3mh7ptshorFVxDbR5U86Al24A=;
        b=SSZvwP1vmlkPf2x7bFh88cnKSnHJpOh6UYGst/Rh37X56XwH9avFtU3k27fHm9EBFt
         tWLW7p9kseMDiRoMkF6aIk+sB1BlYgCRjnlz0OO6FR6DK+8F0n1AM14gWn0fPk67kn9Q
         oNb0fYsRnY/GnpnfajEqIt71ZTmdpGvIqefcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EpkxNxa0CKh7tWpqxQ3mh7ptshorFVxDbR5U86Al24A=;
        b=OsocXWCjUbtv9UQGrpLg2Q4mJgol3FOULnHHOhmkN1ihiDkjMSYKYXTVi+w8NwVkGw
         0S+HHrJV4MV8T2ewQM5jUtcRggfzbzyVO7aP8ntz4i+Vou2BAdWUTbHZ45eEK3A+0vjC
         9gwt/TSnJ9uDUajbgJIPgm1z8gWVhd0H/HMKsNzxyxKrJG3CPTMNqYMNG7c9qmNR5ts0
         x4R5J8SpgMjow6merU9mBJpk2vGF0U6LXEQxd76lzcy9boXt+BtoL9LU6u/pt9pncV9E
         ZIjlUcaXiq+Lv7zFLzeBLye2bk1ZDfrUUpt4iNGDb52/DAVAXt54Y4PU3HwACcxHXcfM
         qf1g==
X-Gm-Message-State: AOUpUlHDJ/8ix7U2P527iZJAEDAflsNhM1L0Sb9PYu/nhV0T6+cpje4O
        dHNVhXiqBeUOXjCMD3HeaIWC4Q==
X-Google-Smtp-Source: AAOMgpden/diHL9FiK6t3XB9yKXcODbPP37ZumHGIJlhCesPMMsSiJXtOo+iQXXkPnoLgx4NbxhF1Q==
X-Received: by 2002:a37:d7c4:: with SMTP id t65-v6mr24430157qkt.42.1533146171562;
        Wed, 01 Aug 2018 10:56:11 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m12-v6sm14401729qkl.54.2018.08.01.10.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 10:56:11 -0700 (PDT)
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
Subject: [PATCH v3 0/8] Add clock config and pm support to bcm iProc mdio mux
Date:   Wed,  1 Aug 2018 10:56:18 -0700
Message-Id: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
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

Changes from v2:
 - Addressed Andrew's comments:
     - Moved to using devm_mdiobus_alloc. Added this as a separate patch.
     - Changed to reverse christmas tree order for variable declaration in
       the clock patch
 - Addressed Florian's comments:
     - Removed null checks for the clock before calling unprepare in
       both clock and pm patches.
     - Added check for EPROBE_DEFER when fetching the clock in the clock
       patch.
 - The patch to use the devm API has been added before the clock & pm
   patches. This patch is now patch '5' in the series.
 - Added reviewed-by tags to commit messages of patches which remain
   unmodified from v2.
 - Modified PM patch to use platform_get_drvdata() in suspend/resume
   API's, similar to the recent fix that went in for the remove()
   api.

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

Arun Parameswaran (8):
  dt-bindings: net: Fix Broadcom iProc mdio mux driver base address
  net: phy: Fix the register offsets in Broadcom iProc mdio mux driver
  arm64: dts: Fix the base address of the Broadcom iProc mdio mux
  net: phy: Disable external master access in bcm mdio mux driver
  net: phy: Use devm api for mdio bus allocation in bcm iproc mdio mux
  dt-bindings: net: Add clock handle to Broadcom iProc mdio mux
  net: phy: Add support to configure clock in Broadcom iProc mdio mux
  net: phy: Add pm support to Broadcom iProc mdio mux driver

 .../bindings/net/brcm,mdio-mux-iproc.txt           |   7 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |   4 +-
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   4 +-
 drivers/net/phy/mdio-mux-bcm-iproc.c               | 111 +++++++++++++++++++--
 4 files changed, 109 insertions(+), 17 deletions(-)

-- 
1.9.1

