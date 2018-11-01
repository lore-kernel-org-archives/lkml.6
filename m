Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013DEC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A445120657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ajjJKtRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A445120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeKBILN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:11:13 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:4428 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeKBILM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:11:12 -0400
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Nov 2018 04:11:11 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2987; q=dns/txt; s=iport;
  t=1541113571; x=1542323171;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PjG4dp8Wrf8iJY2QV4+vWPxe+e11A/Oco55XnNa4W2o=;
  b=ajjJKtRy1d5gxyQHoiBuM8KnYFHZLYsAsnZ2Xbm+mxDs7D4BI6DGVfpf
   BxaaZ6Wg7KbskxS+4P85IxzYBeTR4bakJtr368VTlEIU9fsPxucS+K+aT
   WYrVVxAk7hvVyQIRVR6KoMq01PF6X9kIXTu9CUcW0BCp1pLam5E74Bpm7
   8=;
X-IronPort-AV: E=Sophos;i="5.54,454,1534809600"; 
   d="scan'208";a="195171145"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 22:56:44 +0000
Received: from sjc-ads-2614.cisco.com (sjc-ads-2614.cisco.com [171.70.32.49])
        by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTP id wA1Muirh013034;
        Thu, 1 Nov 2018 22:56:44 GMT
From:   Nikunj Kela <nkela@cisco.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Nikunj Kela <nkela@cisco.com>, xe-linux-external@cisco.com,
        Rod Whitby <rod@whitby.id.au>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Make JFFS2 endianness configurable
Date:   Thu,  1 Nov 2018 15:56:03 -0700
Message-Id: <20181101225603.17806-1-nkela@cisco.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.70.32.49, sjc-ads-2614.cisco.com
X-Outbound-Node: alln-core-4.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows the endianness of the JFSS2 filesystem to be
specified by config options.

It defaults to native-endian (the previously hard-coded option).

Some architectures benefit from having a single known endianness
of JFFS2 filesystem (for data, not executables) independent of the
endianness of the processor (ARM processors can be switched to either
endianness at run-time).

This patch is taken from:
http://www.infradead.org/pipermail/linux-mtd/2006-January/014717.html

Cc: xe-linux-external@cisco.com
Signed-off-by: Rod Whitby <rod@whitby.id.au>
Signed-off-by: Nikunj Kela <nkela@cisco.com>
---
 fs/jffs2/Kconfig    | 25 +++++++++++++++++++++++++
 fs/jffs2/nodelist.h |  8 +++-----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/fs/jffs2/Kconfig b/fs/jffs2/Kconfig
index ad850c5bf2ca..86e93fbc9d74 100644
--- a/fs/jffs2/Kconfig
+++ b/fs/jffs2/Kconfig
@@ -182,3 +182,28 @@ config JFFS2_CMODE_FAVOURLZO
 	  decompression) at the expense of size.
 
 endchoice
+
+choice
+	prompt "JFFS2 endianness"
+	default JFFS2_NATIVE_ENDIAN
+	depends on JFFS2_FS
+	help
+	  You can set here the default endianness of JFFS2 from
+	  the available options. Do not touch if unsure.
+
+config JFFS2_NATIVE_ENDIAN
+	bool "native endian"
+	help
+	  Uses a native endian bytestream.
+
+config JFFS2_BIG_ENDIAN
+	bool "big endian"
+	help
+	  Uses a big endian bytestream.
+
+config JFFS2_LITTLE_ENDIAN
+	bool "little endian"
+	help
+	  Uses a little endian bytestream.
+
+endchoice
diff --git a/fs/jffs2/nodelist.h b/fs/jffs2/nodelist.h
index 0637271f3770..a1ebf04f217c 100644
--- a/fs/jffs2/nodelist.h
+++ b/fs/jffs2/nodelist.h
@@ -27,12 +27,10 @@
 #include "os-linux.h"
 #endif
 
-#define JFFS2_NATIVE_ENDIAN
-
 /* Note we handle mode bits conversion from JFFS2 (i.e. Linux) to/from
    whatever OS we're actually running on here too. */
 
-#if defined(JFFS2_NATIVE_ENDIAN)
+#if defined(CONFIG_JFFS2_NATIVE_ENDIAN)
 #define cpu_to_je16(x) ((jint16_t){x})
 #define cpu_to_je32(x) ((jint32_t){x})
 #define cpu_to_jemode(x) ((jmode_t){os_to_jffs2_mode(x)})
@@ -43,7 +41,7 @@
 #define je16_to_cpu(x) ((x).v16)
 #define je32_to_cpu(x) ((x).v32)
 #define jemode_to_cpu(x) (jffs2_to_os_mode((x).m))
-#elif defined(JFFS2_BIG_ENDIAN)
+#elif defined(CONFIG_JFFS2_BIG_ENDIAN)
 #define cpu_to_je16(x) ((jint16_t){cpu_to_be16(x)})
 #define cpu_to_je32(x) ((jint32_t){cpu_to_be32(x)})
 #define cpu_to_jemode(x) ((jmode_t){cpu_to_be32(os_to_jffs2_mode(x))})
@@ -54,7 +52,7 @@
 #define je16_to_cpu(x) (be16_to_cpu(x.v16))
 #define je32_to_cpu(x) (be32_to_cpu(x.v32))
 #define jemode_to_cpu(x) (be32_to_cpu(jffs2_to_os_mode((x).m)))
-#elif defined(JFFS2_LITTLE_ENDIAN)
+#elif defined(CONFIG_JFFS2_LITTLE_ENDIAN)
 #define cpu_to_je16(x) ((jint16_t){cpu_to_le16(x)})
 #define cpu_to_je32(x) ((jint32_t){cpu_to_le32(x)})
 #define cpu_to_jemode(x) ((jmode_t){cpu_to_le32(os_to_jffs2_mode(x))})
-- 
2.19.1

