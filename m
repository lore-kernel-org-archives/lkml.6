Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F952C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186C720869
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EG5n7FGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186C720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389488AbeKPU4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:56:18 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:47748 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeKPU4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:56:18 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 1784724E10E9;
        Fri, 16 Nov 2018 02:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542365072; bh=kCPYB2jQ/w0IfwYzOdggZsIISG93zH3jNtdKWKDCm2w=;
        h=From:To:Cc:Subject:Date:From;
        b=EG5n7FGXTWpXcMAHI/VYFoJoGMX0eQqnjALJR9l6DXYMn2kOv0EdsvQZc1Okp0lgw
         vJf0f+0ifauZ6SKWjFZn28prtrzJtoYhX5V60X0mQModoycc+2bBbsR6VKzJfRrLCV
         sa8n+d2M7EfczcSy7aaDfG4tXvSrHmN6YX1kkC/LHeEH7CxYNhLnvEBTreaZTLK3OR
         jUTPHHi0Hf6Uo8lVRrzXxVyEjbDOJrdhjoRerX9t2y2pMyvh7KTbNDt7vXISc0Mnlr
         yVx+R0iRnsOjcxOcgNysk4Gndgxkgxo5gRqATjBlHexMjl9Xg7AzMOCd5OtzKet36c
         vaJrt2Hod/F+Q==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 295705527;
        Fri, 16 Nov 2018 02:44:29 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 0/3] ARC: ARCv2: Introduce SmaRT support
Date:   Fri, 16 Nov 2018 13:44:24 +0300
Message-Id: <20181116104427.25264-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compile-time 'ARC_SMART_TRACE' option for enabling SmaRT support.
Small real time trace (SmaRT) is an optional on-chip debug hardware
component that captures instruction-trace history. It stores the
address of the most recent non-sequential instructions executed into
internal buffer.

NOTE:
this PATCH series has prerequisite:
  http://patchwork.ozlabs.org/patch/986820/

Changes RFCv2->PATCHv1:
 * Move smart_exists, smart_supported and smart_stack_size functions
   to smart.h
 * Improve Kconfig SmaRT help description.
 * Other minor changes.

Changes RFCv1->RFCv2:
 * Changes in output display:
   * Only print VMAs if they are changed.
   * Split entry for two lines and print source and destination
     addresses on different lines.
 * Add procfs options to configure/suspend SmaRT in runtime.
 * Add SmaRT version check. Limit supported SmaRT versions to >= 0x03.
 * Move all SmaRT related stuff to smart.h and smart.c
 * Other minor changes.

Eugeniy Paltsev (3):
  ARC: split show_faulting_vma for logic and representation parts
  ARC: ARCv2: Introduce SmaRT support
  ARC: show detaled SmaRT configuration in mumbojumbo

 arch/arc/Kconfig               |  12 ++
 arch/arc/include/asm/arcregs.h |  23 ++++
 arch/arc/include/asm/bug.h     |   9 ++
 arch/arc/include/asm/smart.h   |  62 ++++++++++
 arch/arc/kernel/Makefile       |   1 +
 arch/arc/kernel/setup.c        |  21 +++-
 arch/arc/kernel/smart.c        | 253 +++++++++++++++++++++++++++++++++++++++++
 arch/arc/kernel/traps.c        |   8 ++
 arch/arc/kernel/troubleshoot.c |  46 ++++++--
 arch/arc/mm/fault.c            |   2 +
 10 files changed, 420 insertions(+), 17 deletions(-)
 create mode 100644 arch/arc/include/asm/smart.h
 create mode 100644 arch/arc/kernel/smart.c

-- 
2.14.5

