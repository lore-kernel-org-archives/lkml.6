Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143F6C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B242081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B242081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeLIWOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:14:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38022 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728266AbeLIWOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:14:08 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW738-0002ih-EA; Sun, 09 Dec 2018 21:55:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72f-0003T9-Cj; Sun, 09 Dec 2018 21:55:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Sabrina Dubroca" <sd@queasysnail.net>,
        "Steffen Klassert" <steffen.klassert@secunet.com>,
        "Thadeu Lima de Souza Cascardo" <cascardo@canonical.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.300042549@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 185/328] xfrm6: call kfree_skb when skb is toobig
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

commit 215ab0f021c9fea3c18b75e7d522400ee6a49990 upstream.

After commit d6990976af7c5d8f55903bfb4289b6fb030bf754 ("vti6: fix PMTU caching
and reporting on xmit"), some too big skbs might be potentially passed down to
__xfrm6_output, causing it to fail to transmit but not free the skb, causing a
leak of skb, and consequentially a leak of dst references.

After running pmtu.sh, that shows as failure to unregister devices in a namespace:

[  311.397671] unregister_netdevice: waiting for veth_b to become free. Usage count = 1

The fix is to call kfree_skb in case of transmit failures.

Fixes: dd767856a36e ("xfrm6: Don't call icmpv6_send on local error")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv6/xfrm6_output.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -158,9 +158,11 @@ static int __xfrm6_output(struct sk_buff
 
 	if (toobig && xfrm6_local_dontfrag(skb)) {
 		xfrm6_local_rxpmtu(skb, mtu);
+		kfree_skb(skb);
 		return -EMSGSIZE;
 	} else if (!skb->ignore_df && toobig && skb->sk) {
 		xfrm_local_error(skb, mtu);
+		kfree_skb(skb);
 		return -EMSGSIZE;
 	}
 

