Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB07C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0C120845
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0C120845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeHKBjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 21:39:10 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:54702
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727263AbeHKBjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 21:39:09 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id oGU0f4oyCq9i0oGU0fSK4h; Fri, 10 Aug 2018 16:06:13 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1foGU0-0000Z2-Pa; Fri, 10 Aug 2018 16:06:12 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 3/5] uio_hv_generic: increase size of receive and send buffers
Date:   Fri, 10 Aug 2018 23:06:09 +0000
Message-Id: <20180810230611.2114-3-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810230611.2114-1-kys@linuxonhyperv.com>
References: <20180810230520.2055-1-kys@linuxonhyperv.com>
 <20180810230611.2114-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfHsqQEKkIf7CyfGr4vNHEQvjCb0NoDYYqX5+FbVjP9iuZIYtVfTmZgyhPlx5wwey9QBdy/YyzIhm8XvmyJEyiFekESkytkXGU3e9Tydw+clrIl0CfU8K
 U+TSNmbW4EiD4QnRdzllapVsTIt95G2vTNRMVo6soyqizfMrsxnpr3AkPXIMhdoWlAPwzqDTs9+0Seby98c68j+SZfpEyJrBCqOH2wTqtH9jM5ORuZDv9La3
 3UhjoJPqCyTuxPL+9Pq0kTRCfNslFPh3YIprh49NLAa4e5/F02qA+RLIXtUuSPsLusg5gXLE/RddXWFPEuI1pWmDe1z2yyioJi0dd9CwiuJDDwj9QB5QxW4g
 PV/5jXty31VZ4CK683+TkM7S/QOMTE1Z8LCyQQAinecbl/mcPDTKRrT13xRgdlbb7xfDNHcIqUXjYMsRuclvFzrD0ZOSlcBnGVoE64ivKvTVGMCKAyMv2is3
 TCm6XiSkWwlYX98FlgnlR8MkYofrZIEmVwKoDiWy3fyN6rTRltaoducEOVLujR3Ge6UDA0ufFdzoAkdh3EaqaBGbh2spiybLMgL1rg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org>

When using DPDK there is significant performance boost by using
the largest possible send and receive buffer area.

Unfortunately, with UIO model there is not a good way to configure
this at run time. But it is okay to have a bigger buffer available
even if application only decides to use a smaller piece of it.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index c690d100adcd..35678d08d9d8 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -35,13 +35,13 @@
 
 #include "../hv/hyperv_vmbus.h"
 
-#define DRIVER_VERSION	"0.02.0"
+#define DRIVER_VERSION	"0.02.1"
 #define DRIVER_AUTHOR	"Stephen Hemminger <sthemmin at microsoft.com>"
 #define DRIVER_DESC	"Generic UIO driver for VMBus devices"
 
 #define HV_RING_SIZE	 512	/* pages */
-#define SEND_BUFFER_SIZE (15 * 1024 * 1024)
-#define RECV_BUFFER_SIZE (15 * 1024 * 1024)
+#define SEND_BUFFER_SIZE (16 * 1024 * 1024)
+#define RECV_BUFFER_SIZE (31 * 1024 * 1024)
 
 /*
  * List of resources to be mapped to user space
-- 
2.18.0

