Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EB2C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5D22089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGQb+sm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5D22089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJBPle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:41:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35372 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbeJBPle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:41:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id f8-v6so655446plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v2+8hzeFLHCSUeaT2K3yvYs8N+huBEIjdrPtfM8YYWY=;
        b=kGQb+sm4XHD+/epLssdxgd1XkmMS2/2/O+YcaBwfhU00HT4g5XUq3D2uCOHdn2qIvT
         a/sg9Px9WLNqszjL1X6zz26ETgo/dIgZ6rEw7TgQSZTC8k+7f0QnAKesMxpaH6vDEBoJ
         QZjZyuKQuox0cu3EFX84khPeeeVQfwFRHub/XxmQwnLWeTJlo9Pj/tC5YIhRHC24FZUs
         ag7WAt3HqO8OOD0HDupvmYcjhoLppK9PlXkzXniGsoXRPwFXSN2B8J4kPrxZGzpCzBx6
         2f2chlWPGWa/ZDxOxSslU/LjsVWJsFWjGLoXHfe9Ov+fiDnTzGeo2jZhuyWf+MxKhi9k
         jNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v2+8hzeFLHCSUeaT2K3yvYs8N+huBEIjdrPtfM8YYWY=;
        b=GBJ1ARNVUfYD7fwVOE6HBlVVAZWMvao7gw1bsGYPnZ6fUJUE8uKHx06dwfu5VQBkLp
         RLFG7SrOqxDD4iuNuo8cMDkaH8dyQ7P/7GmQr64jwtb3rdxv8I7/ORVPAz4BYz8q7HOV
         GE7xgSl5AAmYMAdntODD6ulQBddh8suhSqyU8xvwaTaMy8dsOaWpB3s9Ry/yaNh0wWw8
         H00v452CJaFCr4QFkZq9PhTrNfqCGbVSB0Qs42BqSzmHjnLiYN1eLT8PdJ2WfBRbY6O6
         Ls3YVmxg02B2jw5FRYuqRfVar2mLz4LkUtehqmARgtlIAw1BbZMmWgQYZdTSR8/LLRyQ
         84+Q==
X-Gm-Message-State: ABuFfog9fSmDRBhMqnFZEbGs4U8FJRtUd01jV2HYceB9RcWrXr+y/0mL
        cthqfQ23OrPfTiGWSzmhUuY=
X-Google-Smtp-Source: ACcGV628VDBqJqaUuX9jA+nCw06oyh4oWndKWFzmrNIwVnS6tgdzbemIfnsQK28A0oL2D46u/AwtgQ==
X-Received: by 2002:a63:cf0e:: with SMTP id j14-v6mr13367379pgg.195.1538470761959;
        Tue, 02 Oct 2018 01:59:21 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id 62-v6sm5057927pgc.58.2018.10.02.01.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 01:59:21 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v3 0/5] Fix some bugs on RV32 build fail and issue
Date:   Tue,  2 Oct 2018 16:52:26 +0800
Message-Id: <cover.1538387524.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches contain the modificaion as follows:
1. Fix up the building fail on RV32.
2. Add umoddi3 and udivmoddi4 functions for RV32.
3. Fix ioremap problem on RV32.

Changes in v3:
 - Change the copyright notices to GPLv2 from  gcc 4.2.1.

Changes in v2:
 - Retain the copyright notices from libgcc in umoddi3.c and udivmoddi4.c.

Vincent Chen (1):
  RISC-V: Avoid corrupting the upper 32-bit of phys_addr_t in ioremap

Zong Li (4):
  RISC-V: Build tishift only on 64-bit
  RISC-V: Use swiotlb on RV64 only
  lib: Add umoddi3 and udivmoddi4 of GCC library routines
  RISC-V: Select GENERIC_LIB_UMODDI3 on RV32

 arch/riscv/Kconfig        |   1 +
 arch/riscv/kernel/setup.c |   3 +
 arch/riscv/lib/Makefile   |   3 +-
 arch/riscv/mm/ioremap.c   |   2 +-
 lib/Kconfig               |   3 +
 lib/Makefile              |   1 +
 lib/udivmoddi4.c          | 310 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/umoddi3.c             |  32 +++++
 8 files changed, 353 insertions(+), 2 deletions(-)
 create mode 100644 lib/udivmoddi4.c
 create mode 100644 lib/umoddi3.c

-- 
2.7.4

