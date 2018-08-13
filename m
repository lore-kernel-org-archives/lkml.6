Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AC3C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA82217C7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgXm1ZeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA82217C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbeHMWZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 18:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729990AbeHMWZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 18:25:02 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AF13217BC;
        Mon, 13 Aug 2018 19:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534189284;
        bh=wDTr4IQZoMNJeY1XZvdz99dQlK21K4Gy372CCo5tUbk=;
        h=Date:From:To:Cc:Subject:From;
        b=tgXm1ZeVctyttzx16u1gM8znLAYMzOmzpmPHmG2I4W9jeje8s+MhGiomS3sHd9nZg
         ZwnYw9v1At35ZC0oH7riDzG3X1u5iLiBRScMZqbP5zKbNmUjW9y6n5MMZAqX76mtze
         Ajsir+KLX563DVyJyYAiVYizxoLm8Ropzbi9agh0=
Date:   Mon, 13 Aug 2018 14:41:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     f.bluethner@mailbox.org
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PCI: Add function 1 DMA alias quirk for Marvell 88SS9183
Message-ID: <20180813194123.GM113140@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks a lot for your new report
(https://bugzilla.kernel.org/show_bug.cgi?id=42679#c134).

Can you confirm that the patch below is equivalent to what you tested and
it resolves the problem?  If so, I'll try to include it for v4.19.


commit dd4e0ad485e12c9c04eb7a21ba69c24f12cb1918
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon Aug 13 14:30:41 2018 -0500

    PCI: Add function 1 DMA alias quirk for Marvell 88SS9183
    
    Add function 1 DMA alias quirk for Marvell 88SS9183 PCIe SSD Controller.
    
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=42679#c134
    Reported-by: <f.bluethner@mailbox.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index deb051583eda..6994544125ff 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3845,6 +3845,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x917a,
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c78 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9182,
 			 quirk_dma_func1_alias);
+/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c134 */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9183,
+			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c46 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x91a0,
 			 quirk_dma_func1_alias);
