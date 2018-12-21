Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDB0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5F321929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390573AbeLUUtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:49:07 -0500
Received: from gateway30.websitewelcome.com ([192.185.149.4]:32175 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730307AbeLUUtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:49:06 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 874D4CFD5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 14:49:05 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id aRjFgEOFO4FKpaRjFgjOJv; Fri, 21 Dec 2018 14:49:05 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=33332 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gaRjE-0004yz-Q0; Fri, 21 Dec 2018 14:49:04 -0600
Date:   Fri, 21 Dec 2018 14:49:01 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] net: core: Fix Spectre v1 vulnerability
Message-ID: <20181221204901.GA30045@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gaRjE-0004yz-Q0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.44]:33332
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flen is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

net/core/filter.c:1101 bpf_check_classic() warn: potential spectre issue 'filter' [w]

Fix this by sanitizing flen before using it to index filter at line 1101:

	switch (filter[flen - 1].code) {

and through pc at line 1040:
	
	const struct sock_filter *ftest = &filter[pc];

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 447dd1bad31f..8ec4337256ed 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -73,6 +73,7 @@
 #include <linux/seg6_local.h>
 #include <net/seg6.h>
 #include <net/seg6_local.h>
+#include <linux/nospec.h>
 
 /**
  *	sk_filter_trim_cap - run a packet through a socket filter
@@ -1035,6 +1036,7 @@ static int bpf_check_classic(const struct sock_filter *filter,
 	bool anc_found;
 	int pc;
 
+	flen = array_index_nospec(flen, BPF_MAXINSNS + 1);
 	/* Check the filter code now */
 	for (pc = 0; pc < flen; pc++) {
 		const struct sock_filter *ftest = &filter[pc];
-- 
2.20.1

