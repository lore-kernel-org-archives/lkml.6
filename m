Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66BAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA1F222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbfBLVnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:43:10 -0500
Received: from gateway33.websitewelcome.com ([192.185.147.108]:13321 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730907AbfBLVnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:43:07 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id EE6621FCA7D6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 15:43:06 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id tfpagWsRjiQertfpagmKpI; Tue, 12 Feb 2019 15:43:06 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=60010 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gtfpZ-003q1E-IE; Tue, 12 Feb 2019 15:43:05 -0600
Date:   Tue, 12 Feb 2019 15:43:02 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] intel_th: Mark expected switch fall-throughs
Message-ID: <20190212214302.GA23708@embeddedor>
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
X-Exim-ID: 1gtfpZ-003q1E-IE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:60010
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 35
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/hwtracing/intel_th/sth.c: In function ‘sth_stm_packet’:
drivers/hwtracing/intel_th/sth.c:86:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
   reg += 4;
   ~~~~^~~~
drivers/hwtracing/intel_th/sth.c:87:2: note: here
  case STP_PACKET_XSYNC:
  ^~~~
drivers/hwtracing/intel_th/sth.c:88:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
   reg += 8;
   ~~~~^~~~
drivers/hwtracing/intel_th/sth.c:89:2: note: here
  case STP_PACKET_TRIG:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/hwtracing/intel_th/sth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/intel_th/sth.c b/drivers/hwtracing/intel_th/sth.c
index 4b7ae47789d2..3a1f4e650378 100644
--- a/drivers/hwtracing/intel_th/sth.c
+++ b/drivers/hwtracing/intel_th/sth.c
@@ -84,8 +84,12 @@ static ssize_t notrace sth_stm_packet(struct stm_data *stm_data,
 	/* Global packets (GERR, XSYNC, TRIG) are sent with register writes */
 	case STP_PACKET_GERR:
 		reg += 4;
+		/* fall through */
+
 	case STP_PACKET_XSYNC:
 		reg += 8;
+		/* fall through */
+
 	case STP_PACKET_TRIG:
 		if (flags & STP_PACKET_TIMESTAMPED)
 			reg += 4;
-- 
2.20.1

