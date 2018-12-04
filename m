Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF06C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380E620659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380E620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeLDQRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:17:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:54397 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbeLDQRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:17:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 08:17:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,314,1539673200"; 
   d="scan'208";a="122855725"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by fmsmga002.fm.intel.com with ESMTP; 04 Dec 2018 08:17:44 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 0/2] x86/vdso: Remove remnants of the fake section table
Date:   Tue,  4 Dec 2018 08:17:39 -0800
Message-Id: <20181204161741.12292-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove pieces of the vDSO's fake section table mechanism that were left
behind when the vDSO build process reverted to using "objdump -S" to
strip the userspace image.

One of the removed pieces is a 0x340 byte reservation (for 64-bit) in
the .rodata section.  Trimming that fat drops the current image's size
to under 4k, i.e. reduces the effective size of the userspace vDSO
mapping by a full page.

Sean Christopherson (2):
  x86/vdso: Remove obsolete "fake section table" reservation
  x86/vdso: Remove a stale/misleading comment from the linker script

 arch/x86/entry/vdso/vdso-layout.lds.S | 27 ---------------------------
 arch/x86/entry/vdso/vdso2c.c          |  6 ------
 2 files changed, 33 deletions(-)

-- 
2.19.2

