Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uAiLDc7yG1uAYAAAmS7hNA
	; Sat, 09 Jun 2018 15:33:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A54E2608C9; Sat,  9 Jun 2018 15:33:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wLg3I8m4"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1867D606FA;
	Sat,  9 Jun 2018 15:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1867D606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932626AbeFIPdM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932599AbeFIPdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:33:05 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8F15204EC;
        Sat,  9 Jun 2018 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558385;
        bh=WieNy++E6RFKJaHs0xSDVE70IhC50KrZ3SzylsOPtD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wLg3I8m45OzkOBmB70WScvsyQc+FlQZxCYlrZ9KUIrjkostQgJOw/QXwh3+9i3Ifi
         LQEZ0PGutVr+tojggpC3tc59p1TdMq/jt0bbvUAnVwxeR1rmro8oNhrET35ww9HrvW
         9lIxJvbifU3t265DXiqc7zXXxgGorbmSQjPWXHDA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 35/48] net-sysfs: Fix memory leak in XPS configuration
Date: Sat,  9 Jun 2018 17:29:47 +0200
Message-Id: <20180609145950.266601411@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Duyck <alexander.h.duyck@intel.com>

[ Upstream commit 664088f8d68178809b848ca450f2797efb34e8e7 ]

This patch reorders the error cases in showing the XPS configuration so
that we hold off on memory allocation until after we have verified that we
can support XPS on a given ring.

Fixes: 184c449f91fe ("net: Add support for XPS with QoS via traffic classes")
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/net-sysfs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1214,9 +1214,6 @@ static ssize_t xps_cpus_show(struct netd
 	cpumask_var_t mask;
 	unsigned long index;
 
-	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
-		return -ENOMEM;
-
 	index = get_netdev_queue_index(queue);
 
 	if (dev->num_tc) {
@@ -1226,6 +1223,9 @@ static ssize_t xps_cpus_show(struct netd
 			return -EINVAL;
 	}
 
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+		return -ENOMEM;
+
 	rcu_read_lock();
 	dev_maps = rcu_dereference(dev->xps_maps);
 	if (dev_maps) {
