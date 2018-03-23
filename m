Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521806391-2-12009366421387437617
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806391; b=JbrZWkMcRu84V1Bjqx4cEIKqgyTHuKGrMijU0SsoveOp3TK
    J4b4PE+075tgl1hXQ+oN87VV0bdjbZbUDTvF5Pg3yoBDBoF26Ixo9VTS5ZY3OqKN
    t9P/GCX3oMFjHi+tWsF+bMtBj4xgklPFkD+qk1LAgdrXUUcykcmtD6RAOtvjCxQb
    fznhif6hA7FMNI54mduTFd1xg+f0VEmRT2DHuGGs3N2ZsXt1HkJ9kR+07Vi5RY6B
    ka33UbOATGeWapz3C5nozNSZiTq+2wDKip3NO314rH5PCrHSl9g92f9Dwl45BNEm
    1sHysAJThoOAE2Rpc6K04gRzS8ZtiHjObEKS9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806391; bh=kNvhUjmmpW7bZYmGe4NJfqPdla
    BTq0ehUkESxXW4lUM=; b=g2GxOOkArgXX3+YGBFInN92jhABUNyU2tqAYlbQcKO
    C8I3+aGWKj+sG8vbkMIP05RWgpS2RW/D2yCiSsCWyoNjiaxQLig/hllt7Jr1eQqg
    FwF8YYBwnwGksMPuypypN6F6bccPUGUryPJVFw+YV16XzLxsCO5AtcmzdZScmX46
    0wsS5SoeQZeCZbbNxmm0/dMJfVssZmAhaBmRfjG7Ox11oHxef5ww3VWnwoTK1+iE
    vyuICSdsocIdIMcci8KLywYSEVaHtzQl0z0AyibnlatKJtc2bRC2RCMpe34QO5WC
    4UI/A69KkzhUccFzsX3timzIMKYuMVDMs9a4kznkYhzA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1753559AbeCWKAS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:00:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36440 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753493AbeCWKAR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:00:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Hannes Reinecke <hare@suse.com>,
        Tomas Henzl <thenzl@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 01/77] scsi: megaraid_sas: Do not use 32-bit atomic request descriptor for Ventura controllers
Date: Fri, 23 Mar 2018 10:53:35 +0100
Message-Id: <20180323094142.319679627@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>

commit 9ff97fa8db94caeab59a3c5401e975df468b4d8e upstream.

Problem Statement: Sending I/O through 32 bit descriptors to Ventura series of
controller results in IO timeout on certain conditions.

This error only occurs on systems with high I/O activity on Ventura series
controllers.

Changes in this patch will prevent driver from using 32 bit descriptor and use
64 bit Descriptors.

Cc: <stable@vger.kernel.org>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Tomas Henzl <thenzl@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/megaraid/megaraid_sas_fusion.c |   42 +++++++++-------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -190,36 +190,30 @@ inline void megasas_return_cmd_fusion(st
 /**
  * megasas_fire_cmd_fusion -	Sends command to the FW
  * @instance:			Adapter soft state
- * @req_desc:			32bit or 64bit Request descriptor
+ * @req_desc:			64bit Request descriptor
  *
- * Perform PCI Write. Ventura supports 32 bit Descriptor.
- * Prior to Ventura (12G) MR controller supports 64 bit Descriptor.
+ * Perform PCI Write.
  */
 
 static void
 megasas_fire_cmd_fusion(struct megasas_instance *instance,
 		union MEGASAS_REQUEST_DESCRIPTOR_UNION *req_desc)
 {
-	if (instance->is_ventura)
-		writel(le32_to_cpu(req_desc->u.low),
-			&instance->reg_set->inbound_single_queue_port);
-	else {
 #if defined(writeq) && defined(CONFIG_64BIT)
-		u64 req_data = (((u64)le32_to_cpu(req_desc->u.high) << 32) |
-				le32_to_cpu(req_desc->u.low));
+	u64 req_data = (((u64)le32_to_cpu(req_desc->u.high) << 32) |
+		le32_to_cpu(req_desc->u.low));
 
-		writeq(req_data, &instance->reg_set->inbound_low_queue_port);
+	writeq(req_data, &instance->reg_set->inbound_low_queue_port);
 #else
-		unsigned long flags;
-		spin_lock_irqsave(&instance->hba_lock, flags);
-		writel(le32_to_cpu(req_desc->u.low),
-			&instance->reg_set->inbound_low_queue_port);
-		writel(le32_to_cpu(req_desc->u.high),
-			&instance->reg_set->inbound_high_queue_port);
-		mmiowb();
-		spin_unlock_irqrestore(&instance->hba_lock, flags);
+	unsigned long flags;
+	spin_lock_irqsave(&instance->hba_lock, flags);
+	writel(le32_to_cpu(req_desc->u.low),
+		&instance->reg_set->inbound_low_queue_port);
+	writel(le32_to_cpu(req_desc->u.high),
+		&instance->reg_set->inbound_high_queue_port);
+	mmiowb();
+	spin_unlock_irqrestore(&instance->hba_lock, flags);
 #endif
-	}
 }
 
 /**
@@ -772,7 +766,6 @@ megasas_ioc_init_fusion(struct megasas_i
 	const char *sys_info;
 	MFI_CAPABILITIES *drv_ops;
 	u32 scratch_pad_2;
-	unsigned long flags;
 
 	fusion = instance->ctrl_context;
 
@@ -900,14 +893,7 @@ megasas_ioc_init_fusion(struct megasas_i
 			break;
 	}
 
-	/* For Ventura also IOC INIT required 64 bit Descriptor write. */
-	spin_lock_irqsave(&instance->hba_lock, flags);
-	writel(le32_to_cpu(req_desc.u.low),
-	       &instance->reg_set->inbound_low_queue_port);
-	writel(le32_to_cpu(req_desc.u.high),
-	       &instance->reg_set->inbound_high_queue_port);
-	mmiowb();
-	spin_unlock_irqrestore(&instance->hba_lock, flags);
+	megasas_fire_cmd_fusion(instance, &req_desc);
 
 	wait_and_poll(instance, cmd, MFI_POLL_TIMEOUT_SECS);
 
