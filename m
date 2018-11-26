Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78E4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E06221104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc8eYHeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E06221104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbeKZV4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:56:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbeKZV4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:56:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E46F21104;
        Mon, 26 Nov 2018 11:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230173;
        bh=zunTDiH9rN1gMZqE56D7hrD2cRWVRw/j4WYmX4DqzRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bc8eYHeKCB5HJuqqog+QgeDozr8uS9BFdV6achSW1hYVkpJ3q2mshDg/ZMPWVx8ou
         0DFvLMSuDk/NY90xXZm/3Pbdgc9dLqXq2oQa5jjOCX0IwvhMC0jsMdalVYpSIAI7hQ
         J1TSxjqao5jOpxXheGGQhddpVoeksuBbE1Sc08fc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        =?UTF-8?q?M=C3=A1t=C3=A9=20Eckl?= <ecklm94@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/118] netfilter: bridge: define INT_MIN & INT_MAX in userspace
Date:   Mon, 26 Nov 2018 11:50:28 +0100
Message-Id: <20181126105101.526437622@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



