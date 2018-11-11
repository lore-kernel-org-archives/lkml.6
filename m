Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA54C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FFE21582
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7JHB40z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FFE21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404834AbeKLIYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:24:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404820AbeKLIYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:24:50 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59B7221780;
        Sun, 11 Nov 2018 22:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975691;
        bh=iBfGEGQXJErhGcDTjq/xP9T8jc6bDZ5AcCHawY5PArM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7JHB40zFQUfaL9cwqH9+XYgVKFO8Jv1nqn+AeYS7A0xS1ph2r6QL/kPMPCztR42P
         yxSU+z3kybjKn7zwGQJnbHjh7Yqh6k/PsqIUlfXuZB9xALOvSJBZIoA3n8j2JlJgOI
         rA830oXgRRgKy383aA6yeTlDpnRNtYq5yE6lS9os=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Meng <bmeng.cn@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.9 094/141] PCI: Add Device IDs for Intel GPU "spurious interrupt" quirk
Date:   Sun, 11 Nov 2018 14:25:53 -0800
Message-Id: <20181111221641.087629841@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bin Meng <bmeng.cn@gmail.com>

commit d0c9606b31a21028fb5b753c8ad79626292accfd upstream.

Add Device IDs to the Intel GPU "spurious interrupt" quirk table.

For these devices, unplugging the VGA cable and plugging it in again causes
spurious interrupts from the IGD.  Linux eventually disables the interrupt,
but of course that disables any other devices sharing the interrupt.

The theory is that this is a VGA BIOS defect: it should have disabled the
IGD interrupt but failed to do so.

See f67fd55fa96f ("PCI: Add quirk for still enabled interrupts on Intel
Sandy Bridge GPUs") and 7c82126a94e6 ("PCI: Add new ID for Intel GPU
"spurious interrupt" quirk") for some history.

[bhelgaas: See link below for discussion about how to fix this more
generically instead of adding device IDs for every new Intel GPU.  I hope
this is the last patch to add device IDs.]

Link: https://lore.kernel.org/linux-pci/1537974841-29928-1-git-send-email-bmeng.cn@gmail.com
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
[bhelgaas: changelog]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org	# v3.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/quirks.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3124,7 +3124,11 @@ static void disable_igfx_irq(struct pci_
 
 	pci_iounmap(dev, regs);
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0042, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0046, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x004a, disable_igfx_irq);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0106, disable_igfx_irq);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0152, disable_igfx_irq);
 


