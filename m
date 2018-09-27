Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1066C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8369821582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8369821582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeI0PZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:25:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeI0PZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:25:18 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9655810A4;
        Thu, 27 Sep 2018 09:08:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Wei Wang <weiwan@google.com>, Peter Oskolkov <posk@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 20/88] net/ipv6: do not copy dst flags on rt init
Date:   Thu, 27 Sep 2018 11:03:01 +0200
Message-Id: <20180927090302.935471146@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
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

From: Peter Oskolkov <posk@google.com>

[ Upstream commit 30bfd93062814d6767e452a8f5ddcd97f7e38c7e ]

DST_NOCOUNT in dst_entry::flags tracks whether the entry counts
toward route cache size (net->ipv6.sysctl.ip6_rt_max_size).

If the flag is NOT set, dst_ops::pcpuc_entries counter is incremented
in dist_init() and decremented in dst_destroy().

This flag is tied to allocation/deallocation of dst_entry and
should not be copied from another dst/route. Otherwise it can happen
that dst_ops::pcpuc_entries counter grows until no new routes can
be allocated because the counter reached ip6_rt_max_size due to
DST_NOCOUNT not set and thus no counter decrements on gc-ed routes.

Fixes: 3b6761d18bc1 ("net/ipv6: Move dst flags to booleans in fib entries")
Cc: David Ahern <dsahern@gmail.com>
Acked-by: Wei Wang <weiwan@google.com>
Signed-off-by: Peter Oskolkov <posk@google.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    2 --
 1 file changed, 2 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -946,8 +946,6 @@ static void ip6_rt_init_dst_reject(struc
 
 static void ip6_rt_init_dst(struct rt6_info *rt, struct fib6_info *ort)
 {
-	rt->dst.flags |= fib6_info_dst_flags(ort);
-
 	if (ort->fib6_flags & RTF_REJECT) {
 		ip6_rt_init_dst_reject(rt, ort);
 		return;


