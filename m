Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51D5C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DDB217C7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DDB217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbeHMSfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:35:21 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:37800 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbeHMSfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:35:17 -0400
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Aug 2018 14:35:16 EDT
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4856D72CCFD;
        Mon, 13 Aug 2018 18:43:36 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 38FB37CC7A1; Mon, 13 Aug 2018 18:43:36 +0300 (MSK)
Date:   Mon, 13 Aug 2018 18:43:36 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: fix linux/netfilter/nf_osf.h userspace compilation
 errors
Message-ID: <20180813154335.GA22820@altlinux.org>
Mail-Followup-To: Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move inclusion of <linux/ip.h> and <linux/tcp.h> from
linux/netfilter/xt_osf.h to linux/netfilter/nf_osf.h to fix
the following linux/netfilter/nf_osf.h userspace compilation errors:

/usr/include/linux/netfilter/nf_osf.h:59:24: error: 'MAX_IPOPTLEN' undeclared here (not in a function)
  struct nf_osf_opt opt[MAX_IPOPTLEN];
/usr/include/linux/netfilter/nf_osf.h:64:17: error: field 'ip' has incomplete type
  struct iphdr   ip;
/usr/include/linux/netfilter/nf_osf.h:65:18: error: field 'tcp' has incomplete type
  struct tcphdr   tcp;

Fixes: bfb15f2a95cb ("netfilter: extract Passive OS fingerprint infrastructure from xt_osf")
Cc: <stable@vger.kernel.org> # v4.18
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/linux/netfilter/nf_osf.h | 2 ++
 include/uapi/linux/netfilter/xt_osf.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/netfilter/nf_osf.h b/include/uapi/linux/netfilter/nf_osf.h
index 8f2f2f403183..eb5c4e20bec0 100644
--- a/include/uapi/linux/netfilter/nf_osf.h
+++ b/include/uapi/linux/netfilter/nf_osf.h
@@ -2,6 +2,8 @@
 #define _NF_OSF_H
 
 #include <linux/types.h>
+#include <linux/ip.h>
+#include <linux/tcp.h>
 
 #define MAXGENRELEN	32
 
diff --git a/include/uapi/linux/netfilter/xt_osf.h b/include/uapi/linux/netfilter/xt_osf.h
index 72956eceeb09..f1abe4c6f59d 100644
--- a/include/uapi/linux/netfilter/xt_osf.h
+++ b/include/uapi/linux/netfilter/xt_osf.h
@@ -21,8 +21,6 @@
 #define _XT_OSF_H
 
 #include <linux/types.h>
-#include <linux/ip.h>
-#include <linux/tcp.h>
 #include <linux/netfilter/nf_osf.h>
 
 #define XT_OSF_GENRE		NF_OSF_GENRE
-- 
ldv
