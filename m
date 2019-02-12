Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79F7C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B99222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbfBLRjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:39:08 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.51]:44968 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726480AbfBLRjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:39:07 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id EC229ABB2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 11:39:05 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tc1RgzUVg4FKptc1RgKDpa; Tue, 12 Feb 2019 11:39:05 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=49562 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtc1Q-001fyj-EZ; Tue, 12 Feb 2019 11:39:04 -0600
Date:   Tue, 12 Feb 2019 11:39:02 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Samuel Ortiz <sameo@linux.intel.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] NFC: st21nfca: Fix a couple of fall-through warnings
Message-ID: <20190212173902.GA6829@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gtc1Q-001fyj-EZ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:49562
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings by adding a missing break
and a fall-through annotation:

drivers/nfc/st21nfca/dep.c: In function ‘st21nfca_tm_event_send_data’:
drivers/nfc/st21nfca/dep.c:391:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   switch (cmd1) {
   ^~~~~~
drivers/nfc/st21nfca/dep.c:404:2: note: here
  default:
  ^~~~~~~
In file included from ./include/linux/kernel.h:15,
                 from ./include/linux/skbuff.h:17,
                 from ./include/net/nfc/hci.h:21,
                 from drivers/nfc/st21nfca/dep.c:17:
drivers/nfc/st21nfca/dep.c: In function ‘st21nfca_im_recv_dep_res_cb’:
./include/linux/printk.h:303:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/nfc/st21nfca/dep.c:622:4: note: in expansion of macro ‘pr_err’
    pr_err("Received a ACK/NACK PDU\n");
    ^~~~~~
drivers/nfc/st21nfca/dep.c:623:3: note: here
   case ST21NFCA_NFC_DEP_PFB_I_PDU:
   ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/nfc/st21nfca/dep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nfc/st21nfca/dep.c b/drivers/nfc/st21nfca/dep.c
index 3420c5104c94..60f013063f80 100644
--- a/drivers/nfc/st21nfca/dep.c
+++ b/drivers/nfc/st21nfca/dep.c
@@ -401,6 +401,7 @@ static int st21nfca_tm_event_send_data(struct nfc_hci_dev *hdev,
 		default:
 			return 1;
 		}
+		break;
 	default:
 		return 1;
 	}
@@ -620,6 +621,7 @@ static void st21nfca_im_recv_dep_res_cb(void *context, struct sk_buff *skb,
 		switch (ST21NFCA_NFC_DEP_PFB_TYPE(dep_res->pfb)) {
 		case ST21NFCA_NFC_DEP_PFB_ACK_NACK_PDU:
 			pr_err("Received a ACK/NACK PDU\n");
+			/* fall through */
 		case ST21NFCA_NFC_DEP_PFB_I_PDU:
 			info->dep_info.curr_nfc_dep_pni =
 			    ST21NFCA_NFC_DEP_PFB_PNI(dep_res->pfb + 1);
-- 
2.20.1

