Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D22CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E3420882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E3420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeKHIEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:04:21 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36245 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeKHIEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:04:21 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so6139240otk.3;
        Wed, 07 Nov 2018 14:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M+5Ho9nHUAtTPSzbS1VSN1O9czvQcmQgR95Lw7M30Go=;
        b=T7pv8WLpYulfG1qfYvvj5AQaLV3oZM0mKnok7rXZIbcpZ5E8g+5kVwtvAZefwfj2r2
         Wk/1eUxzPRQHwFHCMvPVlgL0OF74cmash/GuQCKX9p28W+e2mOCuLvvwR5j6p4MJmuzt
         Wm6uWwyJThQoL92CFWj+IYwljDBQ6JKy9QHUpAs9PGaAmRxvHpMlMwZmCCk4N7H+ibQE
         eaYyy//+Pq8dQs5CLnbGDPJxADXum5tEQBeQ1T6BxSFVQJMVz1folxdoWL1n+ZV8HgsS
         rZlzXe+b17GOZ+TdOFTLds/TgyUlyHdrrdqCE+HWQ/B5kQBdiZEeDY20F4BUKnmTdB0V
         NbQw==
X-Gm-Message-State: AGRZ1gI5wbLsBOPoR1lxYQasyKbDv92qDpA7dfklasTHNgbVpHkYO4Aq
        mBvcX78PofQ/sScsFQ/sWA==
X-Google-Smtp-Source: AJdET5eUeyKNmwvzBTSLo5ZkCB5UDj6CVT6k+27gyQGNhv94v5ZPoWnZhZCtUauzMzbMw5rBainiKw==
X-Received: by 2002:a9d:5605:: with SMTP id e5mr1403264oti.226.1541629913129;
        Wed, 07 Nov 2018 14:31:53 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id f9sm750959oth.17.2018.11.07.14.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 14:31:52 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 0/8] sparc: OF name and device_type rework
Date:   Wed,  7 Nov 2018 16:31:43 -0600
Message-Id: <20181107223151.14991-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other platforms have been converted to only store the local node name
in device_node.full_name except Sparc. Sparc was complicated by having a
path_component_name in addition to full_name and name. By switching
full_name to just the local node name, path_component_name becomes
redundant and can be removed.

The rest of the series converts the sparc code to use printf specifiers
and helper functions to access node name and device_type instead of
directly accessing device_node full_name, name and type pointers.

I've tested this series under qemu.

Rob

Rob Herring (8):
  fs/openpromfs: use full_name instead of path_component_name
  of: Drop full path from Sparc PDT full_name
  sparc: prom: use property "name" directly to construct node names
  sparc: Convert to using %pOF instead of full_name
  sparc: Convert to using %pOFn instead of device_node.name
  sparc: Use of_node_name_eq for node name comparisons
  sparc: Remove unused leon_trans_init
  sparc: Use device_type helpers to access the node type

 arch/sparc/include/asm/leon.h        |  1 -
 arch/sparc/kernel/auxio_64.c         | 11 ++--
 arch/sparc/kernel/central.c          |  2 +-
 arch/sparc/kernel/chmc.c             |  8 +--
 arch/sparc/kernel/irq_64.c           |  2 +-
 arch/sparc/kernel/leon_kernel.c      | 14 ------
 arch/sparc/kernel/of_device_32.c     | 19 ++++---
 arch/sparc/kernel/of_device_64.c     | 56 ++++++++++-----------
 arch/sparc/kernel/of_device_common.c |  4 +-
 arch/sparc/kernel/pci.c              | 44 +++++++---------
 arch/sparc/kernel/pci_sabre.c        |  2 +-
 arch/sparc/kernel/power.c            |  4 +-
 arch/sparc/kernel/process_32.c       |  2 +-
 arch/sparc/kernel/prom_32.c          | 44 ++++++++--------
 arch/sparc/kernel/prom_64.c          | 75 +++++++++++++++-------------
 arch/sparc/kernel/prom_irqtrans.c    | 20 ++++----
 arch/sparc/kernel/reboot.c           |  3 +-
 arch/sparc/kernel/sbus.c             |  4 +-
 arch/sparc/kernel/sun4d_irq.c        | 14 +++---
 arch/sparc/kernel/time_64.c          | 16 +++---
 arch/sparc/kernel/vio.c              |  9 ++--
 drivers/of/pdt.c                     | 26 ++--------
 fs/openpromfs/inode.c                |  9 ++--
 include/linux/of.h                   |  1 -
 24 files changed, 174 insertions(+), 216 deletions(-)

--
2.19.1
