Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA2AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86FD20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571363;
	bh=ba9eQMaL4xcoW4WwK6AUf74HVaFGJt6K8avoSMnhq5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bgfIYoQr2nlzVG9sdS67cFgDPOjVeEFv97o4hlAiuydzcZGbWck0aEfOUFTs9D386
	 aLF74TPtmIPd2rcFUzbTF31KgijFkFcQLYOawsY/X4ofyiMU4C+uj6wCopi5zaB63H
	 88pDhJHQb5+aCrQxz6SG2ID2jNj7aH0JSpoAmLU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbfAOQ4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732903AbfAOQl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:41:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E632054F;
        Tue, 15 Jan 2019 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570517;
        bh=ba9eQMaL4xcoW4WwK6AUf74HVaFGJt6K8avoSMnhq5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sW5UvJXa1Izh9JEpRkLWMvVYSkwG7YFMmcTr4kd8QuXypULaN36Iq/JEnWW+GMX6V
         sZm9TMA4vn8JIJt7rZ2fjl5Un48p1j4e8644lky1Ok2+o30uPIsALpJoypibvla0+Y
         ZQQJxnwHoAfgmlCqvII79EflS/NTp9sLygklEyh4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4.19 23/50] ACPI/IORT: Fix rc_dma_get_range()
Date:   Tue, 15 Jan 2019 17:35:59 +0100
Message-Id: <20190115154911.292348420@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

commit c7777236dd8f587f6a8d6800c03df318fd4d2627 upstream.

When executed for a PCI_ROOT_COMPLEX type, iort_match_node_callback()
expects the opaque pointer argument to be a PCI bus device. At the
moment rc_dma_get_range() passes the PCI endpoint instead of the bus,
and we've been lucky to have pci_domain_nr(ptr) return 0 instead of
crashing. Pass the bus device to iort_scan_node().

Fixes: 5ac65e8c8941 ("ACPI/IORT: Support address size limit for root complexes")
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/arm64/iort.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -951,9 +951,10 @@ static int rc_dma_get_range(struct devic
 {
 	struct acpi_iort_node *node;
 	struct acpi_iort_root_complex *rc;
+	struct pci_bus *pbus = to_pci_dev(dev)->bus;
 
 	node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
-			      iort_match_node_callback, dev);
+			      iort_match_node_callback, &pbus->dev);
 	if (!node || node->revision < 1)
 		return -ENODEV;
 


