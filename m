Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1AEC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4717C20895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4717C20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbeG0LI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:08:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51484 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbeG0LIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:08:25 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E38B6BB6;
        Fri, 27 Jul 2018 09:47:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Rui Wang <rui.wang@windriver.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 4.17 04/66] MIPS: Fix off-by-one in pci_resource_to_user()
Date:   Fri, 27 Jul 2018 11:44:57 +0200
Message-Id: <20180727093809.530578598@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org # v3.12+
Patchwork: https://patchwork.linux-mips.org/patch/19829/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/pci/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -54,5 +54,5 @@ void pci_resource_to_user(const struct p
 	phys_addr_t size = resource_size(rsrc);
 
 	*start = fixup_bigphys_addr(rsrc->start, size);
-	*end = rsrc->start + size;
+	*end = rsrc->start + size - 1;
 }


