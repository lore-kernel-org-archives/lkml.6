Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEC9ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892832145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:38:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892832145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbeIXRkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:40:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50464 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeIXRkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:40:05 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7A506106F;
        Mon, 24 Sep 2018 11:38:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Christie <mchristi@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 040/105] scsi: target: fix __transport_register_session locking
Date:   Mon, 24 Sep 2018 13:33:26 +0200
Message-Id: <20180924113118.106699391@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Christie <mchristi@redhat.com>

[ Upstream commit 6a64f6e1591322beb8ce16e952a53582caf2a15c ]

When __transport_register_session is called from transport_register_session
irqs will already have been disabled, so we do not want the unlock irq call
to enable them until the higher level has done the final
spin_unlock_irqrestore/ spin_unlock_irq.

This has __transport_register_session use the save/restore call.

Signed-off-by: Mike Christie <mchristi@redhat.com>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/target_core_transport.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -323,6 +323,7 @@ void __transport_register_session(
 	void *fabric_sess_ptr)
 {
 	unsigned char buf[PR_REG_ISID_LEN];
+	unsigned long flags;
 
 	se_sess->se_tpg = se_tpg;
 	se_sess->fabric_sess_ptr = fabric_sess_ptr;
@@ -345,7 +346,7 @@ void __transport_register_session(
 		}
 		kref_get(&se_nacl->acl_kref);
 
-		spin_lock_irq(&se_nacl->nacl_sess_lock);
+		spin_lock_irqsave(&se_nacl->nacl_sess_lock, flags);
 		/*
 		 * The se_nacl->nacl_sess pointer will be set to the
 		 * last active I_T Nexus for each struct se_node_acl.
@@ -354,7 +355,7 @@ void __transport_register_session(
 
 		list_add_tail(&se_sess->sess_acl_list,
 			      &se_nacl->acl_sess_list);
-		spin_unlock_irq(&se_nacl->nacl_sess_lock);
+		spin_unlock_irqrestore(&se_nacl->nacl_sess_lock, flags);
 	}
 	list_add_tail(&se_sess->sess_list, &se_tpg->tpg_sess_list);
 


