Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C603C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1013D20883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Swfi5ZBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1013D20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbeKIHod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:44:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732164AbeKIHoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:32 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3147E21019;
        Thu,  8 Nov 2018 22:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714821;
        bh=nnna//RqseWBRd1C6wYUfgaGKkK09M9qBDX2f2bMgSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Swfi5ZBpjZ0XdhohhbP7uo4EHvWNEvug0cAK9mvfs2FHngRCZCjkWa+fqmoACOP9m
         EqtZKMko1tyL2LAFBLeTAi3YQ4KahjVOEAcmY1enAZ6sLwj8SRm7OTL2n1LxliiRiY
         Z6ejKpYZd3Y6JP0Qr+B1g3rM7dACpRq/F/1Lycq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 149/171] net: drop skb on failure in ip_check_defrag()
Date:   Thu,  8 Nov 2018 13:51:59 -0800
Message-Id: <20181108215137.657599470@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit 7de414a9dd91426318df7b63da024b2b07e53df5 ]

Most callers of pskb_trim_rcsum() simply drop the skb when
it fails, however, ip_check_defrag() still continues to pass
the skb up to stack. This is suspicious.

In ip_check_defrag(), after we learn the skb is an IP fragment,
passing the skb to callers makes no sense, because callers expect
fragments are defrag'ed on success. So, dropping the skb when we
can't defrag it is reasonable.

Note, prior to commit 88078d98d1bb, this is not a big problem as
checksum will be fixed up anyway. After it, the checksum is not
correct on failure.

Found this during code review.

Fixes: 88078d98d1bb ("net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends")
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_fragment.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -718,10 +718,14 @@ struct sk_buff *ip_check_defrag(struct n
 	if (ip_is_fragment(&iph)) {
 		skb = skb_share_check(skb, GFP_ATOMIC);
 		if (skb) {
-			if (!pskb_may_pull(skb, netoff + iph.ihl * 4))
-				return skb;
-			if (pskb_trim_rcsum(skb, netoff + len))
-				return skb;
+			if (!pskb_may_pull(skb, netoff + iph.ihl * 4)) {
+				kfree_skb(skb);
+				return NULL;
+			}
+			if (pskb_trim_rcsum(skb, netoff + len)) {
+				kfree_skb(skb);
+				return NULL;
+			}
 			memset(IPCB(skb), 0, sizeof(struct inet_skb_parm));
 			if (ip_defrag(net, skb, user))
 				return NULL;


