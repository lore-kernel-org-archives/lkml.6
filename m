Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ECFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7815A20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7815A20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbeKLFwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:52:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51166 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730713AbeKLFsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:31 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsq-0000oN-Jo; Sun, 11 Nov 2018 19:59:00 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001js-ST; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paul Burton" <paul.burton@mips.com>,
        "Rui Wang" <rui.wang@windriver.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "James Hogan" <jhogan@kernel.org>,
        "Wolfgang Grandegger" <wg@grandegger.com>,
        linux-mips@linux-mips.org
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.572177981@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 261/366] MIPS: Fix off-by-one in pci_resource_to_user()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 38c0a74fe06da3be133cae3fb7bde6a9438e698b upstream.

The MIPS implementation of pci_resource_to_user() introduced in v3.12 by
commit 4c2924b725fb ("MIPS: PCI: Use pci_resource_to_user to map pci
memory space properly") incorrectly sets *end to the address of the
byte after the resource, rather than the last byte of the resource.

This results in userland seeing resources as a byte larger than they
actually are, for example a 32 byte BAR will be reported by a tool such
as lspci as being 33 bytes in size:

    Region 2: I/O ports at 1000 [disabled] [size=33]

Correct this by subtracting one from the calculated end address,
reporting the correct address to userland.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Rui Wang <rui.wang@windriver.com>
Fixes: 4c2924b725fb ("MIPS: PCI: Use pci_resource_to_user to map pci memory space properly")
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/19829/
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -87,7 +87,7 @@ static inline void pci_resource_to_user(
 	phys_t size = resource_size(rsrc);
 
 	*start = fixup_bigphys_addr(rsrc->start, size);
-	*end = rsrc->start + size;
+	*end = rsrc->start + size - 1;
 }
 
 /*

