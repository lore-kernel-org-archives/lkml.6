Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D82C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D622E21B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfBKSEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:04:00 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.96]:15335 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727896AbfBKSD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:03:59 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 7282C179510
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 12:03:58 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tFvygdrfm4FKptFvygym6R; Mon, 11 Feb 2019 12:03:58 -0600
X-Authority-Reason: nr=8
Received: from [189.250.49.191] (port=41304 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtFvx-001s9Q-Mh; Mon, 11 Feb 2019 12:03:57 -0600
Date:   Mon, 11 Feb 2019 12:03:56 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] firewire: mark expected switch fall-throughs
Message-ID: <20190211180356.GA27613@embeddedor>
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
X-Source-IP: 189.250.49.191
X-Source-L: No
X-Exim-ID: 1gtFvx-001s9Q-Mh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.49.191]:41304
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

This patch fixes the following warnings:

drivers/firewire/core-device.c: In function ‘set_broadcast_channel’:
drivers/firewire/core-device.c:969:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (data & cpu_to_be32(1 << 31)) {
       ^
drivers/firewire/core-device.c:974:3: note: here
   case RCODE_ADDRESS_ERROR:
   ^~~~
drivers/firewire/core-iso.c: In function ‘manage_channel’:
drivers/firewire/core-iso.c:308:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if ((data[0] & bit) == (data[1] & bit))
       ^
drivers/firewire/core-iso.c:312:3: note: here
   default:
   ^~~~~~~
drivers/firewire/core-topology.c: In function ‘count_ports’:
drivers/firewire/core-topology.c:69:23: warning: this statement may fall through [-Wimplicit-fallthrough=]
    (*child_port_count)++;
    ~~~~~~~~~~~~~~~~~~~^~
drivers/firewire/core-topology.c:70:3: note: here
   case SELFID_PORT_PARENT:
   ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

Notice that in some cases, the code comment is modified in
accordance with what GCC is expecting to find.

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/firewire/core-device.c   | 2 +-
 drivers/firewire/core-iso.c      | 2 +-
 drivers/firewire/core-topology.c | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 7c2eed76011e..0c86548fa4a7 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -970,7 +970,7 @@ static void set_broadcast_channel(struct fw_device *device, int generation)
 				device->bc_implemented = BC_IMPLEMENTED;
 				break;
 			}
-			/* else fall through to case address error */
+			/* else, fall through - to case address error */
 		case RCODE_ADDRESS_ERROR:
 			device->bc_implemented = BC_UNIMPLEMENTED;
 		}
diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 35e784cffc23..7e5c98840b80 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -308,7 +308,7 @@ static int manage_channel(struct fw_card *card, int irm_id, int generation,
 			if ((data[0] & bit) == (data[1] & bit))
 				continue;
 
-			/* 1394-1995 IRM, fall through to retry. */
+			/* fall through - to retry for 1394-1995 IRM */
 		default:
 			if (retry) {
 				retry--;
diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 7db234d3fbdd..82c67e900aad 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -67,6 +67,7 @@ static u32 *count_ports(u32 *sid, int *total_port_count, int *child_port_count)
 		switch (port_type) {
 		case SELFID_PORT_CHILD:
 			(*child_port_count)++;
+			/* fall through */
 		case SELFID_PORT_PARENT:
 		case SELFID_PORT_NCONN:
 			(*total_port_count)++;
-- 
2.20.1

