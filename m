Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F795C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB4E206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB4E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeJBSc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:32:58 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:36828 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeJBSc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:32:57 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994586AbeJBLuAvKkbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:50:00 +0200
Date:   Tue, 2 Oct 2018 12:50:00 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] MIPS: memset: Fix `noreorder' issues
Message-ID: <alpine.LFD.2.21.1810020209310.20762@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 A recent change broke CPU_DADDI_WORKAROUNDS support in memset.S, due to a 
delay-slot instruction expanding to multiple hardware operations for the 
affected configurations.

 The underlying cause is the excessive use of the `noreorder' assembly 
mode, while it is only needed in couple of places where either there is a 
data dependency between a branch and its delay slot instruction, or there 
is a section switch involved that would prevent automatic delay slot 
scheduling.

 These changes address both problems and for clarity, not to mix multiple 
conceptually separate changes and to make backporting easier I made them a 
small patch series.  See individual change descriptions for details.

 This has been build-time and run-time verified with 32-bit and 64-bit 
DECstation configurations, build-time verified with big-endian and 
little-endian 64-bit SWARM configurations.  Build-time verification was 
made by running `objdump -d arch/mips/lib/memset.o' with a pristine and 
and a patched build to make sure there has been no change in machine code 
generation, except for the delay-slot multiple instruction with the 64-bit 
CPU_DADDI_WORKAROUNDS DECstation configuration.

 Please apply.

  Maciej
