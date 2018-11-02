Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC733C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D0620848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD4DW+UU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D0620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbeKCEEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeKCEED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:04:03 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3A352084C;
        Fri,  2 Nov 2018 18:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184947;
        bh=RxUfAVJxSfgwe0KjXGZR83Ldy0Jd2+40BItKNC5xG9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cD4DW+UU8rWOTgsBF7P1Kz4FD3oHWQdlznTekiy2J8Snrjv9IlRab99mGuFNn5Ou0
         BGOkXR4hGWiPLAjBiHz1RMzC4UsoIGAWQlyyz0onBvAszIgnyWXcXm60P+sGFwA0Ao
         +mNGt3rTixVXI9xMI48AqO5HKLbhONRdlDgysj2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 137/143] net: drop skb on failure in ip_check_defrag()
Date:   Fri,  2 Nov 2018 19:35:22 +0100
Message-Id: <20181102182908.684975463@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -720,10 +720,14 @@ struct sk_buff *ip_check_defrag(struct n
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


