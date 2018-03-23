Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805340-3-13442207293386691013
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
    t=1521805339; b=USEDEOoEaTwaDsmnsFR6bZ6ZFihuT9HwzdgPjupWsZ5VH65
    Xh0BRJvpGMyFy7HVBmfGUkJTRf7k06jwBJE+RGGd0CvcABHLKNvR76tRg/8NzVpl
    5CrRiVwk1frT4FeOggcwu0utrUYmqw1EwbGyBb8toZmScKkV0dO84Pv356dROHxt
    hIaFfeiCxXK46NzQEKqBjht6TtTlcihJ4xJ7ceh0hvxiaAFuQlHvfedUH0y8peVn
    P0EsxOU82VqbhdCo5BV2yOajDBPLY+6wxMeu2om4rA10nzKKL1IzwOu08cpb/+K1
    xzin5eOSG0AZZPi6iBYvi9dPBJNEwwRYTKvdReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805339; bh=T5U+A+OLkNEeiH1i9+LOuZGNc4
    kTxjVNbLJ1SdiKAjw=; b=SdteMFLJjZetsOQoYpNFl/g0tdBc8oHYczui1paGLs
    0jliik+5Gpn08j+KO7k147ieBA7UQ5/GXjlzZM316eSWmj/+DVfA6ZGXH4/G+nju
    Pev3wsvYiNXB9l8skLqOal3f2diMzvh/9ZSn4jD0iI+FXi1lPWYOOF3qIomLt6L8
    hxwAZsgtvyAgqUfWO6QtjTQGhsh62G0aK5g58LlcAqdCer7CIcnIKgm+dB4XNfWQ
    rWEBmgKNSnM+lz4/XblOXpgyb5CcoxtuTMl8FyTY+pPM9C9g8jjeEqtO1eeZ+LdP
    37yNlWaAnsaSWw7a4FkTiBWi8c8WVRK8mXkbDEKZ6JbQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754554AbeCWKDx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:03:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeCWKDv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:03:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 68/77] scsi: mpt3sas: wait for and flush running commands on shutdown/unload
Date: Fri, 23 Mar 2018 10:54:42 +0100
Message-Id: <20180323094146.843289647@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
[mauricfo: backport to linux-4.14.y (a few updates to context lines)]
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/mpt3sas/mpt3sas_base.c  |    8 ++++----
 drivers/scsi/mpt3sas/mpt3sas_base.h  |    3 +++
 drivers/scsi/mpt3sas/mpt3sas_scsih.c |   10 +++++++++-
 3 files changed, 16 insertions(+), 5 deletions(-)

--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5659,14 +5659,14 @@ _base_reset_handler(struct MPT3SAS_ADAPT
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
@@ -5745,7 +5745,7 @@ mpt3sas_base_hard_reset_handler(struct M
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
@@ -1292,6 +1292,9 @@ void mpt3sas_base_update_missing_delay(s
 
 int mpt3sas_port_enable(struct MPT3SAS_ADAPTER *ioc);
 
+void
+mpt3sas_wait_for_commands_to_complete(struct MPT3SAS_ADAPTER *ioc);
+
 
 /* scsih shared API */
 u8 mpt3sas_scsih_event_callback(struct MPT3SAS_ADAPTER *ioc, u8 msix_index,
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -3960,7 +3960,7 @@ _scsih_flush_running_cmds(struct MPT3SAS
 		_scsih_set_satl_pending(scmd, false);
 		mpt3sas_base_free_smid(ioc, smid);
 		scsi_dma_unmap(scmd);
-		if (ioc->pci_error_recovery)
+		if (ioc->pci_error_recovery || ioc->remove_host)
 			scmd->result = DID_NO_CONNECT << 16;
 		else
 			scmd->result = DID_RESET << 16;
@@ -8243,6 +8243,10 @@ static void scsih_remove(struct pci_dev
 	unsigned long flags;
 
 	ioc->remove_host = 1;
+
+	mpt3sas_wait_for_commands_to_complete(ioc);
+	_scsih_flush_running_cmds(ioc);
+
 	_scsih_fw_event_cleanup_queue(ioc);
 
 	spin_lock_irqsave(&ioc->fw_event_lock, flags);
@@ -8313,6 +8317,10 @@ scsih_shutdown(struct pci_dev *pdev)
 	unsigned long flags;
 
 	ioc->remove_host = 1;
+
+	mpt3sas_wait_for_commands_to_complete(ioc);
+	_scsih_flush_running_cmds(ioc);
+
 	_scsih_fw_event_cleanup_queue(ioc);
 
 	spin_lock_irqsave(&ioc->fw_event_lock, flags);
