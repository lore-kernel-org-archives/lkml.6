Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518709858-2-17645302273111691567
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518709857; b=TOuSNCVcLt9EDNy7b1cJP0XaPDzZIUkWsnVDUPA1P9pncLv
    Wp29JftytaznV9jwdcdlB05V5bIzvHWh847thUx5XphBCN8958XGyP+mpTRt+3no
    IRnCOU12qB4NXzpQ5agQOJOmSgQz+yfF+jl2kikqoeZdYzLJ+8Xr3n/eo5ARZQoE
    gPXXFclPxd23evErSRp3twqiiMHbIJkoQ6JJLODnwouQPUYUJ/Fr4OCt5+QftW6O
    FSKUocEx9Ij2zySDHFfiCPLZ2PPHU/5Ow8iAQGXOgCcBclyrl/JVqn8peJN9qO8C
    0MnI9npB1eJb+mTj1kAaZjTbN0VDI8j3CoXyCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709857; bh=ScVq+tR684qZF38/nRV0Txfy31
    XySOXW3+Pr462SM9c=; b=VxV/BK7w4DW7PprXkMxHl+wL2q90m0WEQVAlCNX2Nx
    FEQTbYE/0TXqE+CNT9zBfhqL/FPtzphB8ebiBZGeup1fNJ9uWSpgDsVZg2q6sRi7
    QjZV/MbC4/9C/fUWA9fhTwUitSoqPRkw9sZDrb2qP7oiDYf8PxJ2ITlugxtSp0Rz
    CTXBkMq6tvQhkgnB8WaqNgFSm7CjNbb3IFIIG9tVdLEsFPAQ4LdWtb+90A8IakE9
    GKpJlaRnIpdGEsn3wmjKvU/OJAGhyRczsKd5kxUSYHXMbef6PL4jt+CaMpaOc6vS
    CeNuoWQPKov4OhsUVWtwzzp+x0a6fzOKxrhz3YFPytxA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425153AbeBOPuy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:50:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424947AbeBOPrx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:47:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 201/202] scsi: lpfc: Fix crash after bad bar setup on driver attachment
Date: Thu, 15 Feb 2018 16:18:21 +0100
Message-Id: <20180215151723.190638853@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>

commit e4b9794efdce13242f4af6682f3ed48ce3864a87 upstream.

In test cases where an instance of the driver is detached and
reattached, the driver will crash on reattachment. There is a compound
if statement that will skip over the bar setup if the pci_resource_start
call is not successful. The driver erroneously returns success to its
bar setup in this scenario even though the bars aren't properly
configured.

Rework the offending code segment for proper initialization steps.  If
the pci_resource_start call fails, -ENOMEM is now returned.

Sample stack:

rport-5:0-10: blocked FC remote port time out: removing rport
BUG: unable to handle kernel NULL pointer dereference at           (null)
... lpfc_sli4_wait_bmbx_ready+0x32/0x70 [lpfc]
...
...  RIP: 0010:...  ... lpfc_sli4_wait_bmbx_ready+0x32/0x70 [lpfc]
 Call Trace:
  ... lpfc_sli4_post_sync_mbox+0x106/0x4d0 [lpfc]
  ... ? __alloc_pages_nodemask+0x176/0x420
  ... ? __kmalloc+0x2e/0x230
  ... lpfc_sli_issue_mbox_s4+0x533/0x720 [lpfc]
  ... ? mempool_alloc+0x69/0x170
  ... ? dma_generic_alloc_coherent+0x8f/0x140
  ... lpfc_sli_issue_mbox+0xf/0x20 [lpfc]
  ... lpfc_sli4_driver_resource_setup+0xa6f/0x1130 [lpfc]
  ... ? lpfc_pci_probe_one+0x23e/0x16f0 [lpfc]
  ... lpfc_pci_probe_one+0x445/0x16f0 [lpfc]
  ... local_pci_probe+0x45/0xa0
  ... work_for_cpu_fn+0x14/0x20
  ... process_one_work+0x17a/0x440

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/lpfc/lpfc_init.c |   84 +++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 33 deletions(-)

--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -9421,44 +9421,62 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba
 		lpfc_sli4_bar0_register_memmap(phba, if_type);
 	}
 
-	if ((if_type == LPFC_SLI_INTF_IF_TYPE_0) &&
-	    (pci_resource_start(pdev, PCI_64BIT_BAR2))) {
-		/*
-		 * Map SLI4 if type 0 HBA Control Register base to a kernel
-		 * virtual address and setup the registers.
-		 */
-		phba->pci_bar1_map = pci_resource_start(pdev, PCI_64BIT_BAR2);
-		bar1map_len = pci_resource_len(pdev, PCI_64BIT_BAR2);
-		phba->sli4_hba.ctrl_regs_memmap_p =
-				ioremap(phba->pci_bar1_map, bar1map_len);
-		if (!phba->sli4_hba.ctrl_regs_memmap_p) {
-			dev_printk(KERN_ERR, &pdev->dev,
-			   "ioremap failed for SLI4 HBA control registers.\n");
+	if (if_type == LPFC_SLI_INTF_IF_TYPE_0) {
+		if (pci_resource_start(pdev, PCI_64BIT_BAR2)) {
+			/*
+			 * Map SLI4 if type 0 HBA Control Register base to a
+			 * kernel virtual address and setup the registers.
+			 */
+			phba->pci_bar1_map = pci_resource_start(pdev,
+								PCI_64BIT_BAR2);
+			bar1map_len = pci_resource_len(pdev, PCI_64BIT_BAR2);
+			phba->sli4_hba.ctrl_regs_memmap_p =
+					ioremap(phba->pci_bar1_map,
+						bar1map_len);
+			if (!phba->sli4_hba.ctrl_regs_memmap_p) {
+				dev_err(&pdev->dev,
+					   "ioremap failed for SLI4 HBA "
+					    "control registers.\n");
+				error = -ENOMEM;
+				goto out_iounmap_conf;
+			}
+			phba->pci_bar2_memmap_p =
+					 phba->sli4_hba.ctrl_regs_memmap_p;
+			lpfc_sli4_bar1_register_memmap(phba);
+		} else {
+			error = -ENOMEM;
 			goto out_iounmap_conf;
 		}
-		phba->pci_bar2_memmap_p = phba->sli4_hba.ctrl_regs_memmap_p;
-		lpfc_sli4_bar1_register_memmap(phba);
 	}
 
-	if ((if_type == LPFC_SLI_INTF_IF_TYPE_0) &&
-	    (pci_resource_start(pdev, PCI_64BIT_BAR4))) {
-		/*
-		 * Map SLI4 if type 0 HBA Doorbell Register base to a kernel
-		 * virtual address and setup the registers.
-		 */
-		phba->pci_bar2_map = pci_resource_start(pdev, PCI_64BIT_BAR4);
-		bar2map_len = pci_resource_len(pdev, PCI_64BIT_BAR4);
-		phba->sli4_hba.drbl_regs_memmap_p =
-				ioremap(phba->pci_bar2_map, bar2map_len);
-		if (!phba->sli4_hba.drbl_regs_memmap_p) {
-			dev_printk(KERN_ERR, &pdev->dev,
-			   "ioremap failed for SLI4 HBA doorbell registers.\n");
-			goto out_iounmap_ctrl;
-		}
-		phba->pci_bar4_memmap_p = phba->sli4_hba.drbl_regs_memmap_p;
-		error = lpfc_sli4_bar2_register_memmap(phba, LPFC_VF0);
-		if (error)
+	if (if_type == LPFC_SLI_INTF_IF_TYPE_0) {
+		if (pci_resource_start(pdev, PCI_64BIT_BAR4)) {
+			/*
+			 * Map SLI4 if type 0 HBA Doorbell Register base to
+			 * a kernel virtual address and setup the registers.
+			 */
+			phba->pci_bar2_map = pci_resource_start(pdev,
+								PCI_64BIT_BAR4);
+			bar2map_len = pci_resource_len(pdev, PCI_64BIT_BAR4);
+			phba->sli4_hba.drbl_regs_memmap_p =
+					ioremap(phba->pci_bar2_map,
+						bar2map_len);
+			if (!phba->sli4_hba.drbl_regs_memmap_p) {
+				dev_err(&pdev->dev,
+					   "ioremap failed for SLI4 HBA"
+					   " doorbell registers.\n");
+				error = -ENOMEM;
+				goto out_iounmap_ctrl;
+			}
+			phba->pci_bar4_memmap_p =
+					phba->sli4_hba.drbl_regs_memmap_p;
+			error = lpfc_sli4_bar2_register_memmap(phba, LPFC_VF0);
+			if (error)
+				goto out_iounmap_all;
+		} else {
+			error = -ENOMEM;
 			goto out_iounmap_all;
+		}
 	}
 
 	return 0;
