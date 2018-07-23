Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DDDECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF2C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF2C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbeGWSJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:09:30 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.233]:29557 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388200AbeGWSJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:09:30 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id C5B4614D0F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 12:07:20 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id heIBfY8E5bXuJheIafezpl; Mon, 23 Jul 2018 12:07:20 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=58708 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fheIA-000ctJ-B5; Mon, 23 Jul 2018 12:06:38 -0500
Date:   Mon, 23 Jul 2018 12:06:37 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] scsi: mptfusion: Fix potential Spectre v1
Message-ID: <20180723170637.GA19396@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fheIA-000ctJ-B5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:58708
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

port can be indirectly controlled by user-space, hence leading to a
potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/message/fusion/mptctl.c:1360 mptctl_getiocinfo() warn:
potential spectre issue 'ioc->pfacts'

Fix this by sanitizing port before using it to index ioc->pfacts

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/message/fusion/mptctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index 4470630..6751a40 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -66,6 +66,9 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_tcq.h>
 
+/* Hardening for Spectre-v1 */
+#include <linux/nospec.h>
+
 #define COPYRIGHT	"Copyright (c) 1999-2008 LSI Corporation"
 #define MODULEAUTHOR	"LSI Corporation"
 #include "mptbase.h"
@@ -1306,7 +1309,7 @@ mptctl_getiocinfo (unsigned long arg, unsigned int data_size)
 		kfree(karg);
 		return -EINVAL;
 	}
-	port = karg->hdr.port;
+	port = array_index_nospec(karg->hdr.port, 2);
 
 	karg->port = port;
 	pdev = (struct pci_dev *) ioc->pcidev;
-- 
2.7.4

