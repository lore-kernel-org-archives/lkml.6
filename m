Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762D1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C3A214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfBUPu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:50:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:50434 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbfBUPuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:50:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 21 Feb 2019 07:50:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="136108113"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 21 Feb 2019 07:50:22 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL v1 2/7] intel_th: Mark expected switch fall-throughs
Date:   Thu, 21 Feb 2019 17:50:01 +0200
Message-Id: <20190221155006.76832-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221155006.76832-1-alexander.shishkin@linux.intel.com>
References: <20190221155006.76832-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

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
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
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

