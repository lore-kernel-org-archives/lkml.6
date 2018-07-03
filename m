Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF496C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EA621925
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EA621925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932876AbeGCHiO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:38:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45643 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933238AbeGCHiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:38:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1faFt3-0001Mu-7A; Tue, 03 Jul 2018 07:38:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: vmci: remove redundant variable is_local
Date:   Tue,  3 Jul 2018 08:38:08 +0100
Message-Id: <20180703073808.29752-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable is_local is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'is_local' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/vmw_vmci/vmci_queue_pair.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
index b4d7774cfe07..9ee47244a308 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -2214,7 +2214,6 @@ int vmci_qp_broker_map(struct vmci_handle handle,
 {
 	struct qp_broker_entry *entry;
 	const u32 context_id = vmci_ctx_get_id(context);
-	bool is_local = false;
 	int result;
 
 	if (vmci_handle_is_invalid(handle) || !context ||
@@ -2243,7 +2242,6 @@ int vmci_qp_broker_map(struct vmci_handle handle,
 		goto out;
 	}
 
-	is_local = entry->qp.flags & VMCI_QPFLAG_LOCAL;
 	result = VMCI_SUCCESS;
 
 	if (context_id != VMCI_HOST_CONTEXT_ID) {
@@ -2325,7 +2323,6 @@ int vmci_qp_broker_unmap(struct vmci_handle handle,
 {
 	struct qp_broker_entry *entry;
 	const u32 context_id = vmci_ctx_get_id(context);
-	bool is_local = false;
 	int result;
 
 	if (vmci_handle_is_invalid(handle) || !context ||
@@ -2354,8 +2351,6 @@ int vmci_qp_broker_unmap(struct vmci_handle handle,
 		goto out;
 	}
 
-	is_local = entry->qp.flags & VMCI_QPFLAG_LOCAL;
-
 	if (context_id != VMCI_HOST_CONTEXT_ID) {
 		qp_acquire_queue_mutex(entry->produce_q);
 		result = qp_save_headers(entry);
-- 
2.17.1

