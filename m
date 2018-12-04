Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359C2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0501E2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0501E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeLDV0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:26:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:51967 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeLDV0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:26:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 13:26:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="96127309"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2018 13:26:01 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2 0/4] x86/vdso: Remove remnants of the fake section table
Date:   Tue,  4 Dec 2018 13:25:56 -0800
Message-Id: <20181204212600.28090-1-sean.j.christopherson@intel.com>
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

v1->v2:
  - Remove the definition of sym_VDSO_FAKE_SECTION_TABLE_*
  - Add patches 3/4 and 4/4 for additional cleanup

Sean Christopherson (4):
  x86/vdso: Remove obsolete "fake section table" reservation
  x86/vdso: Remove a stale/misleading comment from the linker script
  x86/vdso: Remove struct vdso_sym and its associated export option
  x86/vdso: Rename "required_syms" to "requested_syms"

 arch/x86/entry/vdso/vdso-layout.lds.S | 27 -------------------
 arch/x86/entry/vdso/vdso2c.c          | 37 +++++++++------------------
 arch/x86/entry/vdso/vdso2c.h          | 15 +++++------
 3 files changed, 19 insertions(+), 60 deletions(-)

-- 
2.19.2

