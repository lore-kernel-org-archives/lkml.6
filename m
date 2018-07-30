Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E848C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1289720892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMjywlV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1289720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbeG3Wbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 18:31:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44571 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbeG3Wbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 18:31:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so7878103pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 13:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to;
        bh=cy/3pXjkep3M/L/Tj0ud/Zs1kpYrhFra5uDqMg77AVM=;
        b=WMjywlV8I3n1mSRzGrNt5TdoIMSP3T3GboGAnn6MmWkjbL13Ekq0ZWrToy3WxEX02s
         KBIM/D3efpbFFnljRYlVAxlEwqGvY10GB9PvYUPuF2HBUqFoz9IveNBjP+uC8pk8y5BA
         Xj46z7+HCB4aqaemMpavJkXVFUAjic4VHAPlbAIh/BoBIEL3mWWjLcm2agrtkonA30X/
         I9mDKdvrVMzfUll2jAT1j1Oseq3Yun0ZePSPY67ShVAnmwSdkZcYebm14+59rKiwc3Ca
         UH7avdzqJuUP/v9NuZ6eZAJvTTCa1IHkAZxIKQjVEjj4Dn0OYMjDq+v3EyYbLCQIET/I
         +Oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cy/3pXjkep3M/L/Tj0ud/Zs1kpYrhFra5uDqMg77AVM=;
        b=l+ps3ezRD11wG/izh1z7dt94zBe25WbkG/vaxfKgWIwwtpvPLs4V55XqU3KQxWcPnm
         rFxM9YI9jQypwruRpif/INIFjJcBSwGlEqT5zJKQY9MHdBq67tWFC1xw+ndJbNm3z2Jt
         49jiN9ScigqLa+dlu0CswyH/FTNHXhKu3/PgM9PZBkrImvhkZqX4U+kWpf+s9VhTC6LO
         G0rq9t+h2jEuDnpc8x2jeEkRF3e8ui/gZD2d26rgMu+kfnDyq0QOby029VJmoNIXqwi5
         60IKNRMPN8QdlJQIwgvlpsoBm4PnMfVSbvdO8ngoWLkPB/uPmRBNh1lvY3lLsFalwpEz
         60zA==
X-Gm-Message-State: AOUpUlE9T3847fVZe0CYAnXAI1r7iZzcqN1V51ReC9NcC1LXzJu9rtT6
        1KAP9BHde3GyL2OdQfKE+x0=
X-Google-Smtp-Source: AAOMgpf1SxTNvn7kluIMWVzs53D/8afat/NiI4QJZIQrf4RzggqldUsVZ8Vgv2qAeNCwY5qV3ffnsQ==
X-Received: by 2002:a63:35c3:: with SMTP id c186-v6mr17706161pga.217.1532984099213;
        Mon, 30 Jul 2018 13:54:59 -0700 (PDT)
Received: from mhkkerneltest.corp.microsoft.com ([131.107.160.207])
        by smtp.gmail.com with ESMTPSA id y33-v6sm15347430pga.41.2018.07.30.13.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 13:54:58 -0700 (PDT)
From:   mhkelley58@gmail.com
X-Google-Original-From: mikelley@microsoft.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        marcelo.cerri@canonical.com, sthemmin@microsoft.com,
        kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH char-misc 1/1] Drivers: hv: vmbus: Remove use of slow_virt_to_phys()
Date:   Mon, 30 Jul 2018 13:17:11 -0700
Message-Id: <1532981831-28816-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: mikelley@microsoft.com
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
---
 drivers/hv/channel.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index ba0a092..d972a12 100644
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
1.8.3.1

