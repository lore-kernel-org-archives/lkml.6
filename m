Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +WzdKE/0G1vAagAAmS7hNA
	; Sat, 09 Jun 2018 15:38:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C481E608C1; Sat,  9 Jun 2018 15:38:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4vvaw4U"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 42D5E606FA;
	Sat,  9 Jun 2018 15:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42D5E606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753777AbeFIPiB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933158AbeFIPgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:36:04 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FFB0208A3;
        Sat,  9 Jun 2018 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558563;
        bh=gIMM7GDF6efKAKD/ucrs/o5myHht6qXghe+OJmSCR8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4vvaw4UABrZbzndsyZ7E8XDuDTe7kKYUhyu6xz3RSRP7T/XoXV/+QkZ5k2OT8nB5
         U8GA3v1REAcU2aX0jjZs4Cml10fDzOzXq9SS8A17PBnu+xKQPxS0yGnVY6Rlb96sTP
         XSMSlKbfad9NSvzEuleZpimwvKxtOR87+doP0Hq0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 32/41] net-sysfs: Fix memory leak in XPS configuration
Date: Sat,  9 Jun 2018 17:30:04 +0200
Message-Id: <20180609152928.188974995@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1207,9 +1207,6 @@ static ssize_t xps_cpus_show(struct netd
 	cpumask_var_t mask;
 	unsigned long index;
 
-	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
-		return -ENOMEM;
-
 	index = get_netdev_queue_index(queue);
 
 	if (dev->num_tc) {
@@ -1219,6 +1216,9 @@ static ssize_t xps_cpus_show(struct netd
 			return -EINVAL;
 	}
 
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+		return -ENOMEM;
+
 	rcu_read_lock();
 	dev_maps = rcu_dereference(dev->xps_maps);
 	if (dev_maps) {
