Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1720711-1520641429-2-149672466461509920
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520641428; b=HHkmSGtAC9AysZMGgp18s5Wqtx7CKR7I/ADGaQUcN0SLAZ1
    luzp4xCEFAP34+uo5LtrHpm2LTPF8ZHbUiYFeemTY5Uz+Kcb6XTdtu66rywO8niZ
    TScEDwGFYLFo7CdChvtIJ3p2LDOVQaKieMraGHn6H4fCkYbW2nKRF56TZ0FVnSOS
    JxhO8CQJU5GVW0l6s8+CTqe/RG/aM/eW/PAChZWa+Tv8JulK1XMw1iMVf9o8MBLM
    8mbTHtJKRQ3Qv0Nv6rXvqVwFsHgMOI0dJpo3IuYAripiaQgQe3hIiz1rnGTnnKwj
    k+z+Y0tj5pWEo8OBHZTolXfdQo4CDn6aX/ZNkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641428; bh=YZ2pwC1Tz4ydFS0kq9DNL7xEiz
    Yi8VBDfZOOIMcE6i8=; b=wqwHHnpNTYEs1qDZSQggXYdVHGMbUnZtzrVtbr1WmZ
    oCtJ9H3t1IeR9dkhPGFmgjfcYDBTmHwt16s/NupvWz3jn3ZMWR2+1vKg1B52zIQV
    mIy0ePPSXWx95FKkypGqygiI4qlS0KN6PcnOiLcSbmqFRY6WM2kWq4x7T0mBZgp4
    yFV17bXohz44H5LaXgecfQ9lVZuGXaVRS+KVxoXrGcvCO7IFbg+bpPwo3nUTchTD
    tMxeWShjYZalu6GIwEvj+C/iVxHLJUtG9iCgdlsmg1KpCKlKriNSmbL7rNRZZGcI
    77hFpadFvP2Y4645lvXVnm1e6xKCXQamdxw094FaN+1A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933857AbeCJAXj (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:23:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40944 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933088AbeCJAXi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:23:38 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 10/11] scsi: mpt3sas: wait for and flush running commands on shutdown/unload
Date: Fri,  9 Mar 2018 16:19:24 -0800
Message-Id: <20180310001835.126447960@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001834.560857664@linuxfoundation.org>
References: <20180310001834.560857664@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>

commit c666d3be99c000bb889a33353e9be0fa5808d3de upstream.

This patch finishes all outstanding SCSI IO commands (but not other commands,
e.g., task management) in the shutdown and unload paths.

It first waits for the commands to complete (this is done after setting
'ioc->remove_host = 1 ', which prevents new commands to be queued) then it
flushes commands that might still be running.

This avoids triggering error handling (e.g., abort command) for all commands
possibly completed by the adapter after interrupts disabled.

[mauricfo: introduced something in commit message.]

Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Tested-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[mauricfo: backport to linux-4.15.y (a few updates to context lines)]
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c  |    8 ++++----
 drivers/scsi/mpt3sas/mpt3sas_base.h  |    3 +++
 drivers/scsi/mpt3sas/mpt3sas_scsih.c |   10 +++++++++-
 3 files changed, 16 insertions(+), 5 deletions(-)

--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -6289,14 +6289,14 @@ _base_reset_handler(struct MPT3SAS_ADAPT
 }
 
 /**
- * _wait_for_commands_to_complete - reset controller
+ * mpt3sas_wait_for_commands_to_complete - reset controller
  * @ioc: Pointer to MPT_ADAPTER structure
  *
  * This function waiting(3s) for all pending commands to complete
  * prior to putting controller in reset.
  */
-static void
-_wait_for_commands_to_complete(struct MPT3SAS_ADAPTER *ioc)
+void
+mpt3sas_wait_for_commands_to_complete(struct MPT3SAS_ADAPTER *ioc)
 {
 	u32 ioc_state;
 	unsigned long flags;
@@ -6375,7 +6375,7 @@ mpt3sas_base_hard_reset_handler(struct M
 			is_fault = 1;
 	}
 	_base_reset_handler(ioc, MPT3_IOC_PRE_RESET);
-	_wait_for_commands_to_complete(ioc);
+	mpt3sas_wait_for_commands_to_complete(ioc);
 	_base_mask_interrupts(ioc);
 	r = _base_make_ioc_ready(ioc, type);
 	if (r)
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1435,6 +1435,9 @@ void mpt3sas_base_update_missing_delay(s
 
 int mpt3sas_port_enable(struct MPT3SAS_ADAPTER *ioc);
 
+void
+mpt3sas_wait_for_commands_to_complete(struct MPT3SAS_ADAPTER *ioc);
+
 
 /* scsih shared API */
 u8 mpt3sas_scsih_event_callback(struct MPT3SAS_ADAPTER *ioc, u8 msix_index,
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -4614,7 +4614,7 @@ _scsih_flush_running_cmds(struct MPT3SAS
 		_scsih_set_satl_pending(scmd, false);
 		mpt3sas_base_free_smid(ioc, smid);
 		scsi_dma_unmap(scmd);
-		if (ioc->pci_error_recovery)
+		if (ioc->pci_error_recovery || ioc->remove_host)
 			scmd->result = DID_NO_CONNECT << 16;
 		else
 			scmd->result = DID_RESET << 16;
@@ -9904,6 +9904,10 @@ static void scsih_remove(struct pci_dev
 	unsigned long flags;
 
 	ioc->remove_host = 1;
+
+	mpt3sas_wait_for_commands_to_complete(ioc);
+	_scsih_flush_running_cmds(ioc);
+
 	_scsih_fw_event_cleanup_queue(ioc);
 
 	spin_lock_irqsave(&ioc->fw_event_lock, flags);
@@ -9980,6 +9984,10 @@ scsih_shutdown(struct pci_dev *pdev)
 	unsigned long flags;
 
 	ioc->remove_host = 1;
+
+	mpt3sas_wait_for_commands_to_complete(ioc);
+	_scsih_flush_running_cmds(ioc);
+
 	_scsih_fw_event_cleanup_queue(ioc);
 
 	spin_lock_irqsave(&ioc->fw_event_lock, flags);
