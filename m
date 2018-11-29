Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DE9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB9B21473
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGvHlUQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB9B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387706AbeK3Bc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:32:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731824AbeK3Bc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:32:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 893072133F;
        Thu, 29 Nov 2018 14:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501645;
        bh=sbqqnKAeBKOEmOs+5xGo33vsAzEceMfzNVIT3FLh5HE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGvHlUQF5vI3jFeVe3/v3izpDhVYK9l250JH3g10YMKLLDb4CVvkLPAcuorCWfSC/
         toZozDz3Ly5HFzFhQoaezTK81zQVnCXYpxV+6pv7oLq2+Pnb2yg75FX06hEnwVnRaU
         B/bHBdKxQLleWWR+/WNC+wU78cG5T9VK438gmB+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 081/100] PCI: endpoint: Populate func_no before calling pci_epc_add_epf()
Date:   Thu, 29 Nov 2018 15:12:51 +0100
Message-Id: <20181129140105.765963444@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <niklas.cassel@axis.com>

commit 0c47cd7a9b6c9c36c08113e594e9ad017fb17865 upstream.

func_no is a member of struct pci_epf.

Since struct pci_epf is used as an argument to pci_epc_add_epf() (to
bind an endpoint function to a controller), struct pci_epf.func_no
should be populated before calling pci_epc_add_epf().

Initialize the struct pci_epf.func_no member before calling
pci_epc_add_epf(), to fix the endpoint function binding to
an endpoint controller.

Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
[lorenzo.pieralisi@arm.com: rewrote the commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Suggested-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -97,16 +97,10 @@ static int pci_epc_epf_link(struct confi
 {
 	int ret;
 	u32 func_no = 0;
-	struct pci_epc *epc;
-	struct pci_epf *epf;
 	struct pci_epf_group *epf_group = to_pci_epf_group(epf_item);
 	struct pci_epc_group *epc_group = to_pci_epc_group(epc_item);
-
-	epc = epc_group->epc;
-	epf = epf_group->epf;
-	ret = pci_epc_add_epf(epc, epf);
-	if (ret)
-		goto err_add_epf;
+	struct pci_epc *epc = epc_group->epc;
+	struct pci_epf *epf = epf_group->epf;
 
 	func_no = find_first_zero_bit(&epc_group->function_num_map,
 				      BITS_PER_LONG);
@@ -116,6 +110,10 @@ static int pci_epc_epf_link(struct confi
 	set_bit(func_no, &epc_group->function_num_map);
 	epf->func_no = func_no;
 
+	ret = pci_epc_add_epf(epc, epf);
+	if (ret)
+		goto err_add_epf;
+
 	ret = pci_epf_bind(epf);
 	if (ret)
 		goto err_epf_bind;


