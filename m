Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CF6C65C24
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FB0205C9
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FB0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeJGXmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 19:42:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeJGXmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 19:42:17 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E3A13084033;
        Sun,  7 Oct 2018 16:34:30 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-33.brq.redhat.com [10.40.200.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 413382016367;
        Sun,  7 Oct 2018 16:34:28 +0000 (UTC)
Date:   Sun, 7 Oct 2018 18:35:02 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Hans Wippel <hwippel@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [RFC PATCH net 1/3] uapi, net/smc: move protocol constant
 definitions to UAPI
Message-ID: <adaa2e4d22f78b36c8d84bdd97c9c3c582eb4dc6.1538929504.git.esyr@redhat.com>
References: <cover.1538929504.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538929504.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sun, 07 Oct 2018 16:34:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMCPROTO_* constants are expected to be used by userspace[1],
but they were defined in a private header instead.

[1] http://manpages.ubuntu.com/manpages/cosmic/man7/af_smc.7.html

Fixes: ac7138746e14 ("smc: establish new socket family")
Fixes: aaa4d33f6da1 ("net/smc: enable ipv6 support for smc")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 include/uapi/linux/smc.h | 7 ++++++-
 net/smc/smc.h            | 4 +---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index 0e11ca4..10561f8 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -2,7 +2,8 @@
 /*
  *  Shared Memory Communications over RDMA (SMC-R) and RoCE
  *
- *  Definitions for generic netlink based configuration of an SMC-R PNET table
+ *  Definitions for SMC protocol and generic netlink based configuration
+ *  of an SMC-R PNET table
  *
  *  Copyright IBM Corp. 2016
  *
@@ -12,6 +13,10 @@
 #ifndef _UAPI_LINUX_SMC_H_
 #define _UAPI_LINUX_SMC_H_
 
+/* AF_SMC socket protocols */
+#define SMCPROTO_SMC		0	/* SMC protocol, IPv4 */
+#define SMCPROTO_SMC6		1	/* SMC protocol, IPv6 */
+
 /* Netlink SMC_PNETID attributes */
 enum {
 	SMC_PNETID_UNSPEC,
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 08786ac..f5ff2ee 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -15,12 +15,10 @@
 #include <linux/types.h>
 #include <linux/compiler.h> /* __aligned */
 #include <net/sock.h>
+#include <linux/smc.h>
 
 #include "smc_ib.h"
 
-#define SMCPROTO_SMC		0	/* SMC protocol, IPv4 */
-#define SMCPROTO_SMC6		1	/* SMC protocol, IPv6 */
-
 extern struct proto smc_proto;
 extern struct proto smc_proto6;
 
-- 
2.1.4

