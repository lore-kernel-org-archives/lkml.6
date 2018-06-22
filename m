Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B50C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EAA23FB7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 09:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EAA23FB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754280AbeFVJvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 05:51:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41128 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751242AbeFVJvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 05:51:16 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cTrKK7OH2ESR; Fri, 22 Jun 2018 11:51:14 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF3400329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:3400:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 92C671EC0236;
        Fri, 22 Jun 2018 11:51:14 +0200 (CEST)
From:   Borislav Petkov <bp@alien8.de>
To:     KVM <kvm@vger.kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] x86/kvm: Enable MCE injection in the guest
Date:   Fri, 22 Jun 2018 11:50:58 +0200
Message-Id: <20180622095101.32587-1-bp@alien8.de>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

there's this mce-inject.ko module in the kernel which allows for
injecting real MCEs and thus test the MCE handling code.

It is doubly useful to be able to inject same MCEs in a guest so that
testing of the MCE handling code can happen even easier/faster. In order
to be able to do that on an AMD guest, we need to emulate some bits
and pieces like the HWCR[McStatusWrEn] bit which allows writes to the
MCi_STATUS registers without a #GP.

The below does that and with it I'm able to properly inject MCEs in said
guest.

Thx.

Borislav Petkov (3):
  kvm/x86: Move MSR_K7_HWCR to svm.c
  x86/kvm: Implement MSR_HWCR support
  x86/kvm: Handle all MCA banks

 arch/x86/kvm/svm.c | 20 ++++++++++++++++++
 arch/x86/kvm/x86.c | 51 ++++++++++++++++++++++++++++++----------------
 2 files changed, 54 insertions(+), 17 deletions(-)

-- 
2.17.0.582.gccdcbd54c

