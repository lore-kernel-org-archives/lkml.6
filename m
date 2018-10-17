Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25143C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61AA214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61AA214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeJQLIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:08:41 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:59382
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727258AbeJQLIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:08:40 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id CcHggUvXvsezkCcHggAZnh; Tue, 16 Oct 2018 20:14:08 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gCcHg-0000DG-EH; Tue, 16 Oct 2018 20:14:08 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/5] Drivers: hv: vmbus: Get rid of unnecessary state in hv_context
Date:   Wed, 17 Oct 2018 03:14:02 +0000
Message-Id: <20181017031406.773-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181017031241.669-1-kys@linuxonhyperv.com>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfLK9MjpBsderNzzVwxmz0YPdhAHYckRBt9fI/KvkFxvc/I5vfF+EDeOUUUAtJV5rRDDMY8S9GyaVeVEqNInma+3Tt7e9YTKw/qhNCrz0IAV6FY1beBZw
 mc9LWvCild4h65jX4OQiDLSIiz4/X6/1H+u23BwsbKQYYoRBdsCW3Ul5bd+Yhi5clxI8ql8l+lhYJV/JBXgjXEMirdgR8lsykOXU8XLLhUxegPj+N0v2uBJC
 sHf7wUg/7B/sRfBN32wPpa6WbW4Ua4PyLsfAW8z7Imk38LCKb8rbFj5PYIk+isLZTtvrdz6szpXAbTRU0+R8Ze72G1i/rAc8R/bpP3rMwy6COIid79po+H9m
 8ZRrT7uN1WY2ZV1+yXs0rXIOt7gFwnumf+yh+Bc4pa+M4WShekzfTsliuI4Za79sliuc9k5rqkafGqH7K+SyR7Rxa6VCdHuE89A3Cr4dFW8XX0wlItwARLXk
 v7rm189dckdGpx4S9SyQi+QNGwmP/zRbLt6VCRIJZq/x0KiWaxKV1I+Y9gp9ySJXnox3bw2fOy/Egf0O
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "K. Y. Srinivasan" <kys@microsoft.com>

Currently we are replicating state in struct hv_context that is unnecessary -
this state can be retrieved from the hypervisor. Furthermore, this is a per-cpu
state that is being maintained as a global state in struct hv_context.
Get rid of this state in struct hv_context.

Reply-To: kys@microsoft.com

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv.c           | 10 +++-------
 drivers/hv/hyperv_vmbus.h |  2 --
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 332d7c34be5c..166c2501de17 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -33,9 +33,7 @@
 #include "hyperv_vmbus.h"
 
 /* The one and only */
-struct hv_context hv_context = {
-	.synic_initialized	= false,
-};
+struct hv_context hv_context;
 
 /*
  * If false, we're using the old mechanism for stimer0 interrupts
@@ -326,8 +324,6 @@ int hv_synic_init(unsigned int cpu)
 
 	hv_set_synic_state(sctrl.as_uint64);
 
-	hv_context.synic_initialized = true;
-
 	/*
 	 * Register the per-cpu clockevent source.
 	 */
@@ -373,7 +369,8 @@ int hv_synic_cleanup(unsigned int cpu)
 	bool channel_found = false;
 	unsigned long flags;
 
-	if (!hv_context.synic_initialized)
+	hv_get_synic_state(sctrl.as_uint64);
+	if (sctrl.enable != 1)
 		return -EFAULT;
 
 	/*
@@ -435,7 +432,6 @@ int hv_synic_cleanup(unsigned int cpu)
 	hv_set_siefp(siefp.as_uint64);
 
 	/* Disable the global synic bit */
-	hv_get_synic_state(sctrl.as_uint64);
 	sctrl.enable = 0;
 	hv_set_synic_state(sctrl.as_uint64);
 
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 72eaba3d50fc..f17c06a5e74b 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -230,8 +230,6 @@ struct hv_context {
 
 	void *tsc_page;
 
-	bool synic_initialized;
-
 	struct hv_per_cpu_context __percpu *cpu_context;
 
 	/*
-- 
2.18.0

