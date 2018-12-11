Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F0EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A38520811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A38520811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeLKT0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:26:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55970 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeLKT0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:26:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0CB4EBD;
        Tue, 11 Dec 2018 11:26:52 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D0A173F6A8;
        Tue, 11 Dec 2018 11:26:51 -0800 (PST)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Alan Hayward <alan.hayward@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: [PATCH 0/3] arm64/sve: UAPI: Disentangle ptrace.h from sigcontext.h
Date:   Tue, 11 Dec 2018 19:26:44 +0000
Message-Id: <1544556407-19897-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refactors the UAPI header definitions for the Arm SVE
extension to avoid multiple-definition problems when userspace mixes its
own sigcontext.h definitions with the kernel's ptrace.h (which is
apparently routine).

A common backend header is created to hold common definitions, suitably
namespaced, and with an appropriate header guard.

See the commit message in patch 3 for further explanation of why this
is needed.

Because of the non-trivial header guard in the new sve_context.h, patch
1 adds support to headers_install.sh to munge #if defined(_UAPI_FOO) in
a similar way to the current handling of #ifndef _UAPI_FOO.

Dave Martin (3):
  kbuild: install_headers.sh: Strip _UAPI from #if-defined() guards
  arm64/sve: ptrace: Fix SVE_PT_REGS_OFFSET definition
  arm64/sve: Disentangle <uapi/asm/ptrace.h> from
    <uapi/asm/sigcontext.h>

 arch/arm64/include/uapi/asm/ptrace.h      | 39 ++++++++++-----------
 arch/arm64/include/uapi/asm/sigcontext.h  | 56 +++++++++++++++----------------
 arch/arm64/include/uapi/asm/sve_context.h | 50 +++++++++++++++++++++++++++
 scripts/headers_install.sh                |  1 +
 4 files changed, 97 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm64/include/uapi/asm/sve_context.h

-- 
2.1.4

