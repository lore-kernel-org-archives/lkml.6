Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E5DC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5F32064A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5F32064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbeJLCeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:34:07 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.161]:18022 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727732AbeJLCeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:34:07 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 272E1F224
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 14:05:34 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id AgGxgYzDWSjJAAgH3g5dqA; Thu, 11 Oct 2018 14:05:34 -0500
X-Authority-Reason: nr=8
Received: from 57.154.24.109.rev.sfr.net ([109.24.154.57]:34996 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gAgGw-001vbr-Va; Thu, 11 Oct 2018 14:05:23 -0500
Date:   Thu, 11 Oct 2018 21:05:20 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Spencer E. Olson" <olsonse@umich.edu>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] staging: comedi: tio: fix multiple missing break in switch
 bugs
Message-ID: <20181011190520.GA12609@embeddedor.com>
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
X-Source-IP: 109.24.154.57
X-Source-L: No
X-Exim-ID: 1gAgGw-001vbr-Va
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 57.154.24.109.rev.sfr.net (embeddedor) [109.24.154.57]:34996
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there are multiple missing break statements in two switch code
blocks. This makes the execution path to fall all the way down through
to the default cases, which makes the function ni_tio_set_gate_src() to
always return -EINVAL.

Fix this by adding the missing break statements.

Also, notice that due to the absence of the break statements,
the following pieces of code are unreachable:

1078    if (ret)
1079            return ret;
1080    /* 3.  reenable & set mode to starts things back up */
1081    ni_tio_set_gate_mode(counter, src);

1098    if (ret)
1099            return ret;
1100    /* 3.  reenable & set mode to starts things back up */
1101    ni_tio_set_gate2_mode(counter, src);

So, by adding the missing breaks, this patch also fixes the problem
above.

Addresses-Coverity-ID: 1474165 ("Missing break in switch")
Addresses-Coverity-ID: 1474162 ("Structurally dead code")
Fixes: 347e244884c3 ("staging: comedi: tio: implement global tio/ctr routing")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/staging/comedi/drivers/ni_tio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/comedi/drivers/ni_tio.c b/drivers/staging/comedi/drivers/ni_tio.c
index 838614e..0eb388c 100644
--- a/drivers/staging/comedi/drivers/ni_tio.c
+++ b/drivers/staging/comedi/drivers/ni_tio.c
@@ -1070,8 +1070,10 @@ int ni_tio_set_gate_src(struct ni_gpct *counter,
 		case ni_gpct_variant_e_series:
 		case ni_gpct_variant_m_series:
 			ret = ni_m_set_gate(counter, chan);
+			break;
 		case ni_gpct_variant_660x:
 			ret = ni_660x_set_gate(counter, chan);
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1090,8 +1092,10 @@ int ni_tio_set_gate_src(struct ni_gpct *counter,
 		switch (counter_dev->variant) {
 		case ni_gpct_variant_m_series:
 			ret = ni_m_set_gate2(counter, chan);
+			break;
 		case ni_gpct_variant_660x:
 			ret = ni_660x_set_gate2(counter, chan);
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.7.4

