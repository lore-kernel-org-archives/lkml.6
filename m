Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2281FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD56E2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Os9YUxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD56E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeKOI1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbeKOI1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:12 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 104CE22511;
        Wed, 14 Nov 2018 22:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234129;
        bh=DEsOqQqd8uqeK3VdhnQr/b6NfLk4apK7i9craI7XF3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Os9YUxWzJAtOC/nq3/F+87z3n0o3lIb1+UAwfPvD5oVJfp07jAGFT8PPnmcMRwWR
         T0raEm7pVVrdb+demq7jvHlSSCz2pP2Yn8xIBBLpjKVbGqx5191T36m0gOUVfCdaTx
         qdFxcTjkWMTDuul8WKn3rbiX5q8+tJdnMN3GJjw0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 03/73] netfilter: bridge: define INT_MIN & INT_MAX in userspace
Date:   Wed, 14 Nov 2018 17:20:57 -0500
Message-Id: <20181114222207.98701-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

[ Upstream commit 5a8de47b3c250521dd632cdedaac6db88367defa ]

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
Acked-by: Máté Eckl <ecklm94@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.17.1

