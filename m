Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF97ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D4B20989
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaxVvD5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D4B20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbeKIHfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:35:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbeKIHfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:35:30 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36304208E3;
        Thu,  8 Nov 2018 21:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714282;
        bh=ChECY+kuOB+QuQ1lKpJrRXZFsctuorzJeYI+K10bm1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iaxVvD5tXjEUyBGKxL+E7w3dZEnGftZ07EBVoaFaA2xCkubwd6ZDKj/wggg1xdq9O
         vYsVloDv4tvHiE2IFB2xBO0aG/8azCANW8cpxJEA0ZgYq6qeVgNgK8MSfuBZCD7/Xd
         5ADcwRHxYMCwpBSIQkflSp/eLZ69ti3/AfUggoXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 125/144] x86/PCI: Mark Broadwell-EP Home Agent 1 as having non-compliant BARs
Date:   Thu,  8 Nov 2018 13:51:36 -0800
Message-Id: <20181108215107.150739284@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit da77b67195de1c65bef4908fa29967c4d0af2da2 ]

Commit b894157145e4 ("x86/PCI: Mark Broadwell-EP Home Agent & PCU as having
non-compliant BARs") marked Home Agent 0 & PCU has having non-compliant
BARs.  Home Agent 1 also has non-compliant BARs.

Mark Home Agent 1 as having non-compliant BARs so the PCI core doesn't
touch them.

The problem with these devices is documented in the Xeon v4 specification
update:

  BDF2          PCI BARs in the Home Agent Will Return Non-Zero Values
                During Enumeration

  Problem:      During system initialization the Operating System may access
                the standard PCI BARs (Base Address Registers).  Due to
                this erratum, accesses to the Home Agent BAR registers (Bus
                1; Device 18; Function 0,4; Offsets (0x14-0x24) will return
                non-zero values.

  Implication:  The operating system may issue a warning.  Intel has not
                observed any functional failures due to this erratum.

Link: http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html
Fixes: b894157145e4 ("x86/PCI: Mark Broadwell-EP Home Agent & PCU as having non-compliant BARs")
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/pci/fixup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index f16af96c60a2..156fbb69031c 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -554,9 +554,16 @@ static void twinhead_reserve_killing_zone(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x27B9, twinhead_reserve_killing_zone);
 
+/*
+ * Broadwell EP Home Agent BARs erroneously return non-zero values when read.
+ *
+ * See http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html
+ * entry BDF2.
+ */
 static void pci_bdwep_bar(struct pci_dev *dev)
 {
 	dev->non_compliant_bars = 1;
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_bdwep_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_bdwep_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_bdwep_bar);
-- 
2.17.1



