Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAFAC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B6D2578F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B6D2578F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755259AbeFYKlo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 06:41:44 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:39641 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755200AbeFYKln (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Mon, 25 Jun 2018 06:41:43 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Mon, 25 Jun 2018 04:41:42 -0600
Message-Id: <5B30C6E202000078001CD724@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date:   Mon, 25 Jun 2018 04:41:38 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     <akpm@linux-foundation.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>
Cc:     "xen-devel" <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] compat-ioctl/Xen: support at least some IOCTLs of
 evtchn and privcmd
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this is only a start (IOCTL_PRIVCMD_MMAP* and IOCTL_PRIVCMD_DM_OP
require more work), it at least allows some simple operations (like
"xl dmesg") which have always been available on XenoLinux to work again
with a 64-bit kernel underneath a 32-bit distro.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 fs/compat_ioctl.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- 4.18-rc2/fs/compat_ioctl.c
+++ 4.18-rc2-xen-privcmd-compat-ioctls/fs/compat_ioctl.c
@@ -115,6 +115,12 @@
 #include <asm/fbio.h>
 #endif
 
+#ifdef CONFIG_XEN
+#include <xen/interface/xen.h>
+#include <xen/evtchn.h>
+#include <xen/privcmd.h>
+#endif
+
 #define convert_in_user(srcptr, dstptr)			\
 ({							\
 	typeof(*srcptr) val;				\
@@ -1300,6 +1306,17 @@ IGNORE_IOCTL(FBIOGETCMAP32)
 IGNORE_IOCTL(FBIOSCURSOR32)
 IGNORE_IOCTL(FBIOGCURSOR32)
 #endif
+
+#ifdef CONFIG_XEN
+COMPATIBLE_IOCTL(IOCTL_PRIVCMD_HYPERCALL)
+COMPATIBLE_IOCTL(IOCTL_PRIVCMD_RESTRICT)
+COMPATIBLE_IOCTL(IOCTL_EVTCHN_BIND_VIRQ)
+COMPATIBLE_IOCTL(IOCTL_EVTCHN_BIND_INTERDOMAIN)
+COMPATIBLE_IOCTL(IOCTL_EVTCHN_BIND_UNBOUND_PORT)
+COMPATIBLE_IOCTL(IOCTL_EVTCHN_UNBIND)
+COMPATIBLE_IOCTL(IOCTL_EVTCHN_NOTIFY)
+COMPATIBLE_IOCTL(IOCTL_EVTCHN_RESET)
+#endif
 };
 
 /*



