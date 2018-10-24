Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34ABC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5450620824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5450620824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeJXUV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 16:21:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:36222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbeJXUV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 16:21:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E014AD68;
        Wed, 24 Oct 2018 11:54:06 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     pablo@netfilter.org
Cc:     kadlec@blackhole.kfki.hu, fw@strlen.de,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        =?UTF-8?q?M=C3=A1t=C3=A9=20Eckl?= <ecklm94@gmail.com>
Subject: [PATCH] netfilter: bridge: define INT_MIN & INT_MAX in userspace
Date:   Wed, 24 Oct 2018 13:54:03 +0200
Message-Id: <20181024115403.3938-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 4.19, programs like ebtables fail to build when they include
"linux/netfilter_bridge.h". It is caused by commit 94276fa8a2a4 which
added a use of INT_MIN and INT_MAX to the header:
: In file included from /usr/include/linux/netfilter_bridge/ebtables.h:18,
:                  from include/ebtables_u.h:28,
:                  from communication.c:23:
: /usr/include/linux/netfilter_bridge.h:30:20: error: 'INT_MIN' undeclared here (not in a function)
:   NF_BR_PRI_FIRST = INT_MIN,
:                     ^~~~~~~

Define these constants by including "limits.h" when !__KERNEL__ (the
same way as for other netfilter_* headers).

Fixes: 94276fa8a2a4 ("netfilter: bridge: Expose nf_tables bridge hook priorities through uapi")
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Máté Eckl <ecklm94@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/uapi/linux/netfilter_bridge.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/netfilter_bridge.h b/include/uapi/linux/netfilter_bridge.h
index 156ccd089df1..1610fdbab98d 100644
--- a/include/uapi/linux/netfilter_bridge.h
+++ b/include/uapi/linux/netfilter_bridge.h
@@ -11,6 +11,10 @@
 #include <linux/if_vlan.h>
 #include <linux/if_pppox.h>
 
+#ifndef __KERNEL__
+#include <limits.h> /* for INT_MIN, INT_MAX */
+#endif
+
 /* Bridge Hooks */
 /* After promisc drops, checksum checks. */
 #define NF_BR_PRE_ROUTING	0
-- 
2.19.1

