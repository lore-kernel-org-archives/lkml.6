Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EA9C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1AF208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLED9VQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbfACPk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:40:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37756 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730285AbfACPk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:40:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so16162150pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 07:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=iQ/hozz6h1sPdZTwW5rQK+ct9SafGx3dxp1vjGgqKKE=;
        b=PLED9VQ8kawvi8zFTMroY11BRMNvfyFT5kgui5T6P7qQrWLg50udMr7NEWvA41rx7p
         AIQB2d1T5qxcBUnbJqRWjmZ44QskWLwIzwDNJACeq2qdzvCi1rV4NvdIaz844CbNLiP9
         trNWyUy8A4xN3SQbQmxpkMwHp6Ha9vlZpsHAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iQ/hozz6h1sPdZTwW5rQK+ct9SafGx3dxp1vjGgqKKE=;
        b=bD3xUGjsfTBBoDfVhmGfunDYmcx9a+r3xDCnD0Rokx5mAOj7WLywYY7/Lhv48GudkQ
         zrUik1OFoNk0NGmoPoaEXRB0FQY93LtQM1LzJg1QPGyrvJhNLjiEgx5OIDz95n8hMZr7
         2EJ220AKeVtcVAIrFAobU/p4zPLwM4HcHSEYqG6KkCIMv1WhWIOPYO7zXqozXbCfEYLU
         NvsSQrZA0xrD81O1d6qAVP/GN+U+0EPDtL12weJuIReYDxHTPbyXOc+/KIdRhED7SeRx
         5tWgf34ziPOqTSBe4z2djV/kuJoS875blBoX/gutBNbX/1qV6d/89DvA8ureETpQ/y5X
         r6bA==
X-Gm-Message-State: AJcUukc3bfT1sWoU6diu+7GBWQ5wfCSnqA+QNlJ6pQMpMheQWedacRGF
        ghaCdThGu+/Rl2DXq2TNbFIHjw==
X-Google-Smtp-Source: ALg8bN7/mSASNjq6yTt+wJia7ODMRHvCu/sQD/0BlbyTrF6QCEPj5XkGPIhFPP3k3OApXuEcCU1lsg==
X-Received: by 2002:a63:5c22:: with SMTP id q34mr17428052pgb.417.1546530054994;
        Thu, 03 Jan 2019 07:40:54 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id w10sm66155494pgi.81.2019.01.03.07.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Jan 2019 07:40:54 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 0/3] arm64: system call table generation for asm-generic
Date:   Thu,  3 Jan 2019 21:10:22 +0530
Message-Id: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be an automated scripts to provide easy support
for add/modify/delete the system call entry by add in 
respective *.tbl file.

System call table generation support for asm-generic is
provide for arm64 architecture which will use the common
scripts resides in scripts directory and use syscall.tbl
syscall_arm32.tbl files as inputs. This implementation 
will replace asm-generic/unistd.h.

This patch depends on:
 https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
 https://lore.kernel.org/lkml/1546520681-24453-1-git-send-email-firoz.khan@linaro.org/

Firoz Khan (3):
  arm64: add system call table generation files
  arm64: assign __NR_*_Linux_syscalls generated by the scripts
  arm64: generate uapi and kapi headers

 arch/arm64/Makefile                          |   3 +
 arch/arm64/include/asm/Kbuild                |   2 +
 arch/arm64/include/asm/unistd.h              |  10 +-
 arch/arm64/include/asm/unistd32.h            | 826 ---------------------------
 arch/arm64/include/uapi/asm/Kbuild           |   4 +
 arch/arm64/include/uapi/asm/unistd.h         |  13 +-
 arch/arm64/kernel/sys.c                      |   8 +-
 arch/arm64/kernel/sys32.c                    |   8 +-
 arch/arm64/kernel/syscall.c                  |   4 +-
 arch/arm64/kernel/syscalls/Makefile          |  70 +++
 arch/arm64/kernel/syscalls/syscall_arm32.tbl | 434 ++++++++++++++
 lib/compat_audit.c                           |   2 +-
 12 files changed, 540 insertions(+), 844 deletions(-)
 delete mode 100644 arch/arm64/include/asm/unistd32.h
 create mode 100644 arch/arm64/kernel/syscalls/Makefile
 create mode 100644 arch/arm64/kernel/syscalls/syscall_arm32.tbl

-- 
1.9.1

