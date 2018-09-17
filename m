Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD48ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE3B214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE3B214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeIREjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:39:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbeIREjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:39:36 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0491DC49;
        Mon, 17 Sep 2018 23:10:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Christie <mchristi@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 064/158] scsi: target: fix __transport_register_session locking
Date:   Tue, 18 Sep 2018 00:41:34 +0200
Message-Id: <20180917211714.192393333@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -316,6 +316,7 @@ void __transport_register_session(
 {
 	const struct target_core_fabric_ops *tfo = se_tpg->se_tpg_tfo;
 	unsigned char buf[PR_REG_ISID_LEN];
+	unsigned long flags;
 
 	se_sess->se_tpg = se_tpg;
 	se_sess->fabric_sess_ptr = fabric_sess_ptr;
@@ -352,7 +353,7 @@ void __transport_register_session(
 			se_sess->sess_bin_isid = get_unaligned_be64(&buf[0]);
 		}
 
-		spin_lock_irq(&se_nacl->nacl_sess_lock);
+		spin_lock_irqsave(&se_nacl->nacl_sess_lock, flags);
 		/*
 		 * The se_nacl->nacl_sess pointer will be set to the
 		 * last active I_T Nexus for each struct se_node_acl.
@@ -361,7 +362,7 @@ void __transport_register_session(
 
 		list_add_tail(&se_sess->sess_acl_list,
 			      &se_nacl->acl_sess_list);
-		spin_unlock_irq(&se_nacl->nacl_sess_lock);
+		spin_unlock_irqrestore(&se_nacl->nacl_sess_lock, flags);
 	}
 	list_add_tail(&se_sess->sess_list, &se_tpg->tpg_sess_list);
 


