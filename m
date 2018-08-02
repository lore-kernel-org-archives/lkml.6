Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334E5C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B7F20862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B7F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeHBE6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:58:25 -0400
Received: from a2nlsmtp01-02.prod.iad2.secureserver.net ([198.71.225.36]:52560
        "EHLO a2nlsmtp01-02.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbeHBE6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:58:25 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id l3yVfhAX3dH2El3yVfAe9D; Wed, 01 Aug 2018 20:08:27 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1fl3yU-0002oU-TD; Wed, 01 Aug 2018 20:08:26 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 2/3] Drivers: hv: vmbus: Remove use of slow_virt_to_phys()
Date:   Thu,  2 Aug 2018 03:08:24 +0000
Message-Id: <20180802030825.10768-2-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180802030825.10768-1-kys@linuxonhyperv.com>
References: <20180802030718.10708-1-kys@linuxonhyperv.com>
 <20180802030825.10768-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfEkfWbyj9PYFQnLEbS2u9nKBVA/DpumB3d0+xbBxGICqRIyxCcv0jRxng+B2HuYJkboWPVj0X+xUv06gWc+s+AjzOAG8suZDfOQxLNv6d4tG6ndPFZWj
 5IK9YBsft0AoAbM31XNhhS+XOgbOoNcsotlPbI4BSkp3aW//XggcQJTDdo+G7JgXhXsX6Ce8s1WXZ5TYkXSd6R7zr95kISu/I/XhV8EzsHhW9CiWfdtZRyxp
 l3uJg8ZGZXwAPEkxkE3OHfaWgf/enCqqO/YmPwCoWicRiLyOFmmTGyodl8rif1FmHfmf+wCoycBoIfcf9dPt+8HQGSUxegXoP50PThGhmdyxw34z4jt9NyJl
 IEGsO3bvArUwAGB41SUOHKA60qeZgDiv73+T6Nv0H76yyZkUtNZ+jP5QnLsVMLO3BeWLk9WYiizSZvb2WHPGPBtOoVCfWoB2tY+OWn0ubcp8YDKFrZ4i0ncn
 tbey9XN8WDpdkj78Vmn/d2V4G9SioW5xtR+9uPUUIXzvCd/TpOpOY6ASgq0uNIPz/uY6m9sC5BxbY05Y9fYD41RneCFZDoC3+HiO8g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

slow_virt_to_phys() is only implemented for arch/x86.
Remove its use in arch independent Hyper-V drivers, and
replace with test for vmalloc() address followed by
appropriate v-to-p function. This follows the typical
pattern of other drivers and avoids the need to implement
slow_virt_to_phys() for Hyper-V on ARM64.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/channel.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index c3949220b770..741857d80da1 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -29,12 +29,26 @@
 #include <linux/hyperv.h>
 #include <linux/uio.h>
 #include <linux/interrupt.h>
+#include <asm/page.h>
 
 #include "hyperv_vmbus.h"
 
 #define NUM_PAGES_SPANNED(addr, len) \
 ((PAGE_ALIGN(addr + len) >> PAGE_SHIFT) - (addr >> PAGE_SHIFT))
 
+static unsigned long virt_to_hvpfn(void *addr)
+{
+	unsigned long paddr;
+
+	if (is_vmalloc_addr(addr))
+		paddr = page_to_phys(vmalloc_to_page(addr)) +
+					 offset_in_page(addr);
+	else
+		paddr = __pa(addr);
+
+	return  paddr >> PAGE_SHIFT;
+}
+
 /*
  * vmbus_setevent- Trigger an event notification on the specified
  * channel.
@@ -298,8 +312,8 @@ static int create_gpadl_header(void *kbuffer, u32 size,
 		gpadl_header->range[0].byte_offset = 0;
 		gpadl_header->range[0].byte_count = size;
 		for (i = 0; i < pfncount; i++)
-			gpadl_header->range[0].pfn_array[i] = slow_virt_to_phys(
-				kbuffer + PAGE_SIZE * i) >> PAGE_SHIFT;
+			gpadl_header->range[0].pfn_array[i] = virt_to_hvpfn(
+				kbuffer + PAGE_SIZE * i);
 		*msginfo = msgheader;
 
 		pfnsum = pfncount;
@@ -350,9 +364,8 @@ static int create_gpadl_header(void *kbuffer, u32 size,
 			 * so the hypervisor guarantees that this is ok.
 			 */
 			for (i = 0; i < pfncurr; i++)
-				gpadl_body->pfn[i] = slow_virt_to_phys(
-					kbuffer + PAGE_SIZE * (pfnsum + i)) >>
-					PAGE_SHIFT;
+				gpadl_body->pfn[i] = virt_to_hvpfn(
+					kbuffer + PAGE_SIZE * (pfnsum + i));
 
 			/* add to msg header */
 			list_add_tail(&msgbody->msglistentry,
@@ -380,8 +393,8 @@ static int create_gpadl_header(void *kbuffer, u32 size,
 		gpadl_header->range[0].byte_offset = 0;
 		gpadl_header->range[0].byte_count = size;
 		for (i = 0; i < pagecount; i++)
-			gpadl_header->range[0].pfn_array[i] = slow_virt_to_phys(
-				kbuffer + PAGE_SIZE * i) >> PAGE_SHIFT;
+			gpadl_header->range[0].pfn_array[i] = virt_to_hvpfn(
+				kbuffer + PAGE_SIZE * i);
 
 		*msginfo = msgheader;
 	}
-- 
2.17.1

