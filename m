Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE69C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFB920844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFB920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407275AbeHATOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:14:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51972 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390462AbeHATOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:14:19 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 28F0DC3C;
        Wed,  1 Aug 2018 17:27:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 022/144] netfilter: ipset: List timing out entries with "timeout 1" instead of zero
Date:   Wed,  1 Aug 2018 18:50:49 +0200
Message-Id: <20180801164950.891138548@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>

[ Upstream commit bd975e691486ba52790ba23cc9b4fecab7bc0d31 ]

When listing sets with timeout support, there's a probability that
just timing out entries with "0" timeout value is listed/saved.
However when restoring the saved list, the zero timeout value means
permanent elelements.

The new behaviour is that timing out entries are listed with "timeout 1"
instead of zero.

Fixes netfilter bugzilla #1258.

Signed-off-by: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/netfilter/ipset/ip_set_timeout.h |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/include/linux/netfilter/ipset/ip_set_timeout.h
+++ b/include/linux/netfilter/ipset/ip_set_timeout.h
@@ -65,8 +65,14 @@ ip_set_timeout_set(unsigned long *timeou
 static inline u32
 ip_set_timeout_get(unsigned long *timeout)
 {
-	return *timeout == IPSET_ELEM_PERMANENT ? 0 :
-		jiffies_to_msecs(*timeout - jiffies)/MSEC_PER_SEC;
+	u32 t;
+
+	if (*timeout == IPSET_ELEM_PERMANENT)
+		return 0;
+
+	t = jiffies_to_msecs(*timeout - jiffies)/MSEC_PER_SEC;
+	/* Zero value in userspace means no timeout */
+	return t == 0 ? 1 : t;
 }
 
 #endif	/* __KERNEL__ */


