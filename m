Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225yCy2KiabRiZS4Mf4Z885FoHM7jRITx7L7NJb9uPCelmipnm3KAh5y/XplL9eRxlxBbzrv
ARC-Seal: i=1; a=rsa-sha256; t=1518709110; cv=none;
        d=google.com; s=arc-20160816;
        b=0wkQN3GnwPZrgaZqPM4J199XE9dtp1U6vFwNZ+Eh8LkIi6IH3iW81oOFHp6iJGzB3a
         4dbxm3RnBsFBW3Of5OJr7YPiqXh21Y8czTgTIHvZC/9rh74z5amlLTTjopupPkIkxh0U
         nO5Wrv5p4rnX4MssXz5+vpSFXLtOYttvctGaj9Ykgd0u03Sh7YoX1cHXOrDpGQcjlGEs
         uU+YBVpVsBRNRpQsvnR3bkYcliOn1w5KK7yxToydX82epQDnUJ00auq6BbQTG0K9/ivg
         jC5UWhNndAKtTe0BfHlj65V6mNDP6Rizq79ES020/8IXjlzO6wFTc9sQhqLO5COOmYTj
         RK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LJ2ux42D0rn1c6tfe63ivRrs0v2nMwtg8PegcEABkck=;
        b=Sfd0SOyH6oOQXkXYA6MwQKm4uASfPjuD7L3PwC7rtngywsmsKrdNtnkE6F3vbzUwuG
         T4SrE9PK7Ty3xNl41rCyv8J+2c4hcI43TCJBO74Zd0qy6emDaJjE9+OByHnnKJXHSL/H
         9sGtFdPwH2BLiaUormYV44cLk+c4Aq0km2vCbQzICkGSTpYooKTj6EZ1inN9aObOMpiL
         eIvbbkT/E14x9EYEj2uCkzzNVG/+tUuC/hRPjMWDENaU7tsJi8F9+/lYRF0KTsWQrCoF
         2NRxYkT4Xy3qhpXOaHK/Lccr83ckCgNuAGaA3Au9aidFGfE/gH2G8/bkB302QLyAog93
         dDTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 194/195] scsi: lpfc: Fix crash after bad bar setup on driver attachment
Date: Thu, 15 Feb 2018 16:18:05 +0100
Message-Id: <20180215151716.081879228@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481924220701279?=
X-GMAIL-MSGID: =?utf-8?q?1592481924220701279?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -9413,44 +9413,62 @@ lpfc_sli4_pci_mem_setup(struct lpfc_hba
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
