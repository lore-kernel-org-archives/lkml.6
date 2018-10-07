Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AEAC64EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70E82087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70E82087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeJGW3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:29:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbeJGW3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 18:29:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 651DA83F3F;
        Sun,  7 Oct 2018 15:21:38 +0000 (UTC)
Received: from rf.usersys.redhat.com (ovpn-116-29.gru2.redhat.com [10.97.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35A8010021B2;
        Sun,  7 Oct 2018 15:21:37 +0000 (UTC)
From:   Rodrigo Freire <rfreire@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org, piastryyy@gmail.com
Subject: [PATCH v3 1/2] CIFS: Adds information-level logging function
Date:   Sun,  7 Oct 2018 12:21:25 -0300
Message-Id: <3e9246011e68c3ebeea111c8bb743d1a189ce6ac.1538873915.git.rfreire@redhat.com>
In-Reply-To: <cover.1538873915.git.rfreire@redhat.com>
References: <cover.1538873915.git.rfreire@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 07 Oct 2018 15:21:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, CIFS lacks a internal logging function that prints out data
when CIFS_DEBUG=n. When CIFS_DEBUG=y, the only message level for CIFS
events are KERN_ERR or KERN_DEBUG.

This patch creates cifs_info(), which is useful for printing
non-critical event messges, at either CIFS_DEBUG state.

Signed-off-by: Rodrigo Freire <rfreire@redhat.com>
---
 fs/cifs/cifs_debug.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/cifs/cifs_debug.h b/fs/cifs/cifs_debug.h
index f4f3f08..72db298 100644
--- a/fs/cifs/cifs_debug.h
+++ b/fs/cifs/cifs_debug.h
@@ -47,6 +47,17 @@
  */
 #ifdef CONFIG_CIFS_DEBUG
 
+/* Information level messages, minor events */
+#define cifs_info_func(ratefunc, fmt, ...)			\
+do {								\
+	pr_info_ ## ratefunc("CIFS: " fmt, ##__VA_ARGS__); 	\
+} while (0)
+
+#define cifs_info(fmt, ...)					\
+do { 								\
+	cifs_info_func(ratelimited, fmt, ##__VA_ARGS__); 	\
+} while (0)
+
 /* information message: e.g., configuration, major event */
 #define cifs_dbg_func(ratefunc, type, fmt, ...)			\
 do {								\
@@ -81,6 +92,11 @@
 	if (0)								\
 		pr_debug(fmt, ##__VA_ARGS__);				\
 } while (0)
+
+#define cifs_info(fmt, ...)						\
+do {									\
+	pr_info("CIFS: "fmt, ##__VA_ARGS__);				\
+} while (0)
 #endif
 
 #endif				/* _H_CIFS_DEBUG */
-- 
1.8.3.1

