Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FEEC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6865C20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qcu61Nzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6865C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeLKWXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:23:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46182 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbeLKWXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:23:30 -0500
Received: from zn.tnic (p200300EC2BCD2B0010F6E1EC68D6BA6C.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:10f6:e1ec:68d6:ba6c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 634041EC0B6D;
        Tue, 11 Dec 2018 23:23:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544567009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=NepjSrwz7tIgGSX+WREUqCyXKWdbmsO/EBYrdgOEKTo=;
        b=qcu61NzvcdiOzKoU5iFAhJzK40mzFOaIhzFGO/snEG6l2ueDGZ9dmSGdYSMfXnuww+oWGu
        Rk0Q0tcwMVvmP0FJXJXyF2zV0epT9jI5Fy+YmgKxX+IKyrLhRDLbsMBD5vEXYj9Hc3MqSJ
        3lgsjGZ0FSkEqDeehdgNM7YThx56Z6w=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH 0/4] x86/alternative: Add ALTERNATIVE_3
Date:   Tue, 11 Dec 2018 23:23:22 +0100
Message-Id: <20181211222326.14581-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

here's a patchset which adds an ALTERNATIVE_3() macro so that we can
finally do RDTSCP in rdtsc_ordered() but also not break all the possible
qemu CPU models out there like some old pentium which doesn't have even
MFENCE. Which is the reason for the three-insn alternative macro, btw.

The stuff works here on all machines I've tested it on but since we're
too close to the merge window, I'll hold on to it for another round and
let it soak slowly into 2019. Thus the RFC tag. In the meantime, it'll
collect your comments and ideas.

:-)

Thanks!

Borislav Petkov (4):
  x86/alternatives: Add macro comments
  x86/alternatives: Print containing function
  x86/alternatives: Add an ALTERNATIVE_3() macro
  x86/TSC: Use RDTSCP

 arch/x86/include/asm/alternative.h | 39 ++++++++++++++++++++++++------
 arch/x86/include/asm/msr.h         | 16 ++++++++++--
 arch/x86/kernel/alternative.c      |  4 +--
 3 files changed, 48 insertions(+), 11 deletions(-)

-- 
2.19.1

