Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cZzNCQ5aGVtVDQAAmS7hNA
	; Thu, 07 Jun 2018 16:15:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D29986089E; Thu,  7 Jun 2018 16:15:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 41BEE60590;
	Thu,  7 Jun 2018 16:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41BEE60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936118AbeFGQPh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:15:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39112 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932894AbeFGOI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:08:58 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0005Zl-FP; Thu, 07 Jun 2018 15:08:56 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvaw-0002gB-WE; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Julien Gomes" <julien@arista.com>,
        "Cong Wang" <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.590744536@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 002/410] tun: allow positive return values on
 dev_get_valid_name() call
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Julien Gomes <julien@arista.com>

commit 5c25f65fd1e42685f7ccd80e0621829c105785d9 upstream.

If the name argument of dev_get_valid_name() contains "%d", it will try
to assign it a unit number in __dev__alloc_name() and return either the
unit number (>= 0) or an error code (< 0).
Considering positive values as error values prevent tun device creations
relying this mechanism, therefor we should only consider negative values
as errors here.

Signed-off-by: Julien Gomes <julien@arista.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1648,7 +1648,7 @@ static int tun_set_iff(struct net *net,
 		if (!dev)
 			return -ENOMEM;
 		err = dev_get_valid_name(net, dev, name);
-		if (err)
+		if (err < 0)
 			goto err_free_dev;
 
 		dev_net_set(dev, net);
