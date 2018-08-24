Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0EFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A8D208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZxhP2G1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A8D208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeHXW3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:29:51 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45088 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeHXW3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:29:51 -0400
Received: by mail-yw1-f66.google.com with SMTP id p206-v6so3443434ywg.12;
        Fri, 24 Aug 2018 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ty+zxAzjX9B/YBLpxjSFqIpgEQ0ysQcjTaPhtPKn+PE=;
        b=lZxhP2G1MDBBFKmNQik5zWV8C3sSJWn6/Sx0NpITjI8WVMiU3xs7jKX6AsshugIZPj
         LT4vgDjH0y8/asXtadOrG355VTU2q8Lg33oWPCipnIGyxjJICpGPii4ahV5EouT9E4z2
         aXpHfTWnj2nI8v7ZzqsKFOsCovFl+jfmGH9AKiOEjhYTIgJ704BrVgzEL7taztelcgX1
         +WQrmLgVQ8HDAH8RRUVtego2/pJC3uauYw8Jt5XAacnQf8Q9Y8dnKE04pynGuIWQANP0
         CoYRCtHQsSTnGelX4avpm3MJRVSWZ4V+QxGaIigI/TXQAp/zXpLqFr+2JHeG8kJvnOv9
         OJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ty+zxAzjX9B/YBLpxjSFqIpgEQ0ysQcjTaPhtPKn+PE=;
        b=JRzXZ/pQfTIYFMzNoOV6iMJGfH1ejWYltN3KIGeLy6+XUGFVO/5lDMtIPGt+/e1ePo
         iiFOr6LqZWCap5smY/Zw0ZJSZNrlwm5LRl+ywrfKJBGbht3nl83ZLs0F0yv/l01ZJjiu
         2KW7PhBjCHOxZZyXUzkyE28I2XwdFMEJehQKdWfn0lR2NGsbL4d1Enoz3Z9bgsgNtW9U
         rdAhFOLWBL3nx0nMtGCrMGuLSNvLYSe6JNTqFNjiB3lcvRSj02jE47rt3FVNrIa96Gr7
         Nq5C4MyN5/eHZB8JWosCPgrtQ1/iikwAQ7rnQuIrr/XMqzmgj/8VwYRuDHmnyhSU9bMC
         E3fQ==
X-Gm-Message-State: APzg51BSkw/zMEFitfjsghgiZ1EYvUXTVIP9joM8l8rLssfHAqWvQk8f
        wHlD6OGImxP/lrsRivELXo8=
X-Google-Smtp-Source: ANB0VdYd5EcUcoSJYqYL+aIlJxeb5F10puowuRPhRLT/z+5p4TOAUjPN239f2N/w3PLx9dAwnlfz2Q==
X-Received: by 2002:a0d:f302:: with SMTP id c2-v6mr1877963ywf.232.1535136839171;
        Fri, 24 Aug 2018 11:53:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:8925])
        by smtp.gmail.com with ESMTPSA id z125-v6sm8907065ywg.57.2018.08.24.11.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 11:53:58 -0700 (PDT)
Date:   Fri, 24 Aug 2018 11:53:56 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] libata changes for v4.19-rc1
Message-ID: <20180824185356.GY3978217@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, again.

Nothing too interesting.  Mostly ahci and ahci_platform changes, many
around power management.

Thanks.

The following changes since commit 9ffc59d57228d74809700be6f7ecb1db10292f05:

  Merge tag '4.18-rc1-more-smb3-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2018-06-18 14:28:19 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.19

for you to fetch changes up to 2d17f460c5d79fa9fc794e813377f3276acf81ce:

  ata: ahci_platform: enable to get and control reset (2018-08-22 08:08:28 -0700)

----------------------------------------------------------------
Corentin Labbe (4):
      ata: ahci_platform: correct parameter documentation for ahci_platform_shutdown
      ata: ahci_platform: convert kzallloc to kcalloc
      ata: ahci_platform: convert kcalloc to devm_kcalloc
      Revert "ata: ahci_platform: convert kcalloc to devm_kcalloc"

Geert Uytterhoeven (2):
      ata: sata_rcar: Provide a short-hand for &pdev->dev
      ata: sata_rcar: Add rudimentary Runtime PM support

Kunihiko Hayashi (3):
      ata: add an extra argument to ahci_platform_get_resources()
      ata: libahci_platform: add reset control support
      ata: ahci_platform: enable to get and control reset

Masaharu Hayakawa (1):
      ata: sata_rcar: exclude setting of PHY registers in Gen3

Paul Menzel (2):
      ata: Guard ata_scsi_dump_cdb() by ATA_VERBOSE_DEBUG
      ata: Only output sg element mapped number in verbose debug

Samuel Morris (2):
      ata: ahci: rpm_put port on port_stop to match rpm_get in port_start
      ata: ahci_platform: allow disabling of hotplug to save power

Sebastian Andrzej Siewior (1):
      libata: remove ata_sff_data_xfer_noirq()

Srinivas Pandruvada (4):
      ata: ahci: Support state with min power but Partial low power state
      ata: ahci: Enable DEVSLP by default on x86 with SLP_S0
      ata: libahci: Correct setting of DEVSLP register
      ata: libahci: Allow reconfigure of DEVSLP register

Tejun Heo (1):
      Revert "ata: ahci_platform: allow disabling of hotplug to save power"

Wolfram Sang (2):
      ata: sata_rcar: really mask all interrupts on Gen2 and later
      ata: sata_rcar: Add r8a77965 support

 .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
 .../devicetree/bindings/ata/sata_rcar.txt          |  1 +
 Documentation/driver-api/libata.rst                |  3 +-
 drivers/ata/ahci.c                                 | 38 +++++++++--
 drivers/ata/ahci.h                                 |  1 +
 drivers/ata/ahci_brcm.c                            |  2 +-
 drivers/ata/ahci_ceva.c                            |  2 +-
 drivers/ata/ahci_da850.c                           |  2 +-
 drivers/ata/ahci_dm816.c                           |  2 +-
 drivers/ata/ahci_imx.c                             |  2 +-
 drivers/ata/ahci_mtk.c                             |  2 +-
 drivers/ata/ahci_mvebu.c                           |  2 +-
 drivers/ata/ahci_platform.c                        |  3 +-
 drivers/ata/ahci_qoriq.c                           |  2 +-
 drivers/ata/ahci_seattle.c                         |  2 +-
 drivers/ata/ahci_st.c                              |  2 +-
 drivers/ata/ahci_sunxi.c                           |  2 +-
 drivers/ata/ahci_tegra.c                           |  2 +-
 drivers/ata/ahci_xgene.c                           |  2 +-
 drivers/ata/libahci.c                              | 27 +++++---
 drivers/ata/libahci_platform.c                     | 49 ++++++++++----
 drivers/ata/libata-core.c                          |  3 +-
 drivers/ata/libata-scsi.c                          |  5 +-
 drivers/ata/libata-sff.c                           | 30 ---------
 drivers/ata/pata_cmd640.c                          |  2 +-
 drivers/ata/pata_icside.c                          |  2 +-
 drivers/ata/pata_imx.c                             |  2 +-
 drivers/ata/pata_legacy.c                          |  6 +-
 drivers/ata/pata_palmld.c                          |  2 +-
 drivers/ata/pata_pcmcia.c                          |  2 +-
 drivers/ata/pata_platform.c                        |  2 +-
 drivers/ata/pata_via.c                             |  2 +-
 drivers/ata/sata_rcar.c                            | 76 +++++++++++-----------
 include/linux/ahci_platform.h                      |  4 +-
 include/linux/libata.h                             |  5 +-
 35 files changed, 166 insertions(+), 126 deletions(-)

-- 
tejun
