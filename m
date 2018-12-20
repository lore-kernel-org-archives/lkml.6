Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC313C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B59F21720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297669;
	bh=otT3yRAWha/cesQi+15VOumCYOa+gEMcLxBMG1c9eFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=coIfvXuY2zS5X14mh1cLLxniTO5ph8oDVqCmPk2C+T6ncaYwow1ekkQDKfxhWnAZM
	 H/unjciwfwiu6INHTV6Rh0rwc0+JPXT3X49ivU/bSXm7woSe/zMJ1OnS20+Dokr7YC
	 UyCo+M55Hy3E+iakwZCxtSkGFD8E+AjwH61x7ng4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbeLTJVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:21:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730967AbeLTJVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:21:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7391821720;
        Thu, 20 Dec 2018 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297665;
        bh=otT3yRAWha/cesQi+15VOumCYOa+gEMcLxBMG1c9eFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TzD6pkIiiKMWHNXEopJhHTk4Uw75zDF0qy1YPaIA9hZcjTyoeSfhUHZCiRoULPi0t
         vhu2l/Zyt/XnW2nBYN6b+x/j/0k4azYVbfRqIjWYorf7ro5pMc3PyhqXkMEYkGQMkN
         gIh0ySlcSYUR2IhKZNVzNXklQTcKIwSkM0fE1FY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Radu Rendec <radu.rendec@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 13/40] powerpc/msi: Fix NULL pointer access in teardown code
Date:   Thu, 20 Dec 2018 10:18:25 +0100
Message-Id: <20181220085827.009530462@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Radu Rendec <radu.rendec@gmail.com>

commit 78e7b15e17ac175e7eed9e21c6f92d03d3b0a6fa upstream.

The arch_teardown_msi_irqs() function assumes that controller ops
pointers were already checked in arch_setup_msi_irqs(), but this
assumption is wrong: arch_teardown_msi_irqs() can be called even when
arch_setup_msi_irqs() returns an error (-ENOSYS).

This can happen in the following scenario:
  - msi_capability_init() calls pci_msi_setup_msi_irqs()
  - pci_msi_setup_msi_irqs() returns -ENOSYS
  - msi_capability_init() notices the error and calls free_msi_irqs()
  - free_msi_irqs() calls pci_msi_teardown_msi_irqs()

This is easier to see when CONFIG_PCI_MSI_IRQ_DOMAIN is not set and
pci_msi_setup_msi_irqs() and pci_msi_teardown_msi_irqs() are just
aliases to arch_setup_msi_irqs() and arch_teardown_msi_irqs().

The call to free_msi_irqs() upon pci_msi_setup_msi_irqs() failure
seems legit, as it does additional cleanup; e.g.
list_del(&entry->list) and kfree(entry) inside free_msi_irqs() do
happen (MSI descriptors are allocated before pci_msi_setup_msi_irqs()
is called and need to be cleaned up if that fails).

Fixes: 6b2fd7efeb88 ("PCI/MSI/PPC: Remove arch_msi_check_device()")
Cc: stable@vger.kernel.org # v3.18+
Signed-off-by: Radu Rendec <radu.rendec@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/msi.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/msi.c
+++ b/arch/powerpc/kernel/msi.c
@@ -34,5 +34,10 @@ void arch_teardown_msi_irqs(struct pci_d
 {
 	struct pci_controller *phb = pci_bus_to_host(dev->bus);
 
-	phb->controller_ops.teardown_msi_irqs(dev);
+	/*
+	 * We can be called even when arch_setup_msi_irqs() returns -ENOSYS,
+	 * so check the pointer again.
+	 */
+	if (phb->controller_ops.teardown_msi_irqs)
+		phb->controller_ops.teardown_msi_irqs(dev);
 }


