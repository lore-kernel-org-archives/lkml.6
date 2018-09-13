Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C95EC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612C320881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612C320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbeIMTBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:01:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33306 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730173AbeIMTBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:01:06 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 83274D10;
        Thu, 13 Sep 2018 13:51:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Janssen <medhefgo@web.de>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 025/197] net/ipv6: Only update MTU metric if it set
Date:   Thu, 13 Sep 2018 15:29:34 +0200
Message-Id: <20180913131842.570694303@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 15a81b418e22a9aa4a0504471fdcb0f4ebf69b96 ]

Jan reported a regression after an update to 4.18.5. In this case ipv6
default route is setup by systemd-networkd based on data from an RA. The
RA contains an MTU of 1492 which is used when the route is first inserted
but then systemd-networkd pushes down updates to the default route
without the mtu set.

Prior to the change to fib6_info, metrics such as MTU were held in the
dst_entry and rt6i_pmtu in rt6_info contained an update to the mtu if
any. ip6_mtu would look at rt6i_pmtu first and use it if set. If not,
the value from the metrics is used if it is set and finally falling
back to the idev value.

After the fib6_info change metrics are contained in the fib6_info struct
and there is no equivalent to rt6i_pmtu. To maintain consistency with
the old behavior the new code should only reset the MTU in the metrics
if the route update has it set.

Fixes: d4ead6b34b67 ("net/ipv6: move metrics from dst to rt6_info")
Reported-by: Jan Janssen <medhefgo@web.de>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_fib.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -987,7 +987,10 @@ static int fib6_add_rt2node(struct fib6_
 					fib6_clean_expires(iter);
 				else
 					fib6_set_expires(iter, rt->expires);
-				fib6_metric_set(iter, RTAX_MTU, rt->fib6_pmtu);
+
+				if (rt->fib6_pmtu)
+					fib6_metric_set(iter, RTAX_MTU,
+							rt->fib6_pmtu);
 				return -EEXIST;
 			}
 			/* If we have the same destination and the same metric,


