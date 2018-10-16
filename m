Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5020CC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B03620658
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wlWZD+se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B03620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbeJQBQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:16:24 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 068B320658;
        Tue, 16 Oct 2018 17:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710698;
        bh=2DtYbCb6d3gF5tRg6tJrig58Vchbqfu2lEjBBNb6H70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wlWZD+seQrHa0hhAHMLz6vxLsUenLS30m9LDKxnGPIR2BD8wnOPe/dp92bSj5MvxY
         bH8KIRslkinXIp4uUY8hSxZFxr2dsCVJ8vVASkpZ1tzbSBSNPvLvO09yVikZzgqWjg
         RFZqeU6klf52Ux0MKfDcUp2v2lrE5+OIPfIIEsfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 59/71] inet: frags: get rid of ipfrag_skb_cb/FRAG_CB
Date:   Tue, 16 Oct 2018 19:09:56 +0200
Message-Id: <20181016170542.323641535@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

ip_defrag uses skb->cb[] to store the fragment offset, and unfortunately
this integer is currently in a different cache line than skb->next,
meaning that we use two cache lines per skb when finding the insertion point.

By aliasing skb->ip_defrag_offset and skb->dev, we pack all the fields
in a single cache line and save precious memory bandwidth.

Note that after the fast path added by Changli Gao in commit
d6bebca92c66 ("fragment: add fast path for in-order fragments")
this change wont help the fast path, since we still need
to access prev->len (2nd cache line), but will show great
benefits when slow path is entered, since we perform
a linear scan of a potentially long list.

Also, note that this potential long list is an attack vector,
we might consider also using an rb-tree there eventually.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit bf66337140c64c27fa37222b7abca7e49d63fb57)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -645,6 +645,11 @@ struct sk_buff {
 		};
 		struct rb_node	rbnode; /* used in netem & tcp stack */
 	};
+
+	union {
+		int			ip_defrag_offset;
+	};
+
 	struct sock		*sk;
 	struct net_device	*dev;
 


