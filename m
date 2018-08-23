Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C1FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA132064E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA132064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeHWLfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:35:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44726 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHWLft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:35:49 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3CB3FBB6;
        Thu, 23 Aug 2018 08:07:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 017/130] libahci: Fix possible Spectre-v1 pmp indexing in ahci_led_store()
Date:   Thu, 23 Aug 2018 09:52:13 +0200
Message-Id: <20180823074928.471574521@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Garry <john.garry@huawei.com>

[ Upstream commit fae2a63737e5973f1426bc139935a0f42e232844 ]

Currently smatch warns of possible Spectre-V1 issue in ahci_led_store():
drivers/ata/libahci.c:1150 ahci_led_store() warn: potential spectre issue 'pp->em_priv' (local cap)

Userspace controls @pmp from following callchain:
em_message->store()
->ata_scsi_em_message_store()
-->ap->ops->em_store()
--->ahci_led_store()

After the mask+shift @pmp is effectively an 8b value, which is used to
index into an array of length 8, so sanitize the array index.

Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libahci.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -35,6 +35,7 @@
 #include <linux/kernel.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -1124,10 +1125,12 @@ static ssize_t ahci_led_store(struct ata
 
 	/* get the slot number from the message */
 	pmp = (state & EM_MSG_LED_PMP_SLOT) >> 8;
-	if (pmp < EM_MAX_SLOTS)
+	if (pmp < EM_MAX_SLOTS) {
+		pmp = array_index_nospec(pmp, EM_MAX_SLOTS);
 		emp = &pp->em_priv[pmp];
-	else
+	} else {
 		return -EINVAL;
+	}
 
 	/* mask off the activity bits if we are in sw_activity
 	 * mode, user should turn off sw_activity before setting


