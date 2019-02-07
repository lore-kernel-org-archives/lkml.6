Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155FBC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CB121908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539782;
	bh=7RNYN+uRtxRQ7agnUfIJ7uzbPpJGK5QJNVm2RN+mbe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hYFi+AdMShLTm10cdFTDMuyY1OG4wq7jzG0srOBdj/Ztq/XaXkOhaIzeE83TUa6Kk
	 BqMznVx84xFEUZ05M8FeReuMbj62VcQuu8M6Q+k2DDeSa9ezOtcm0/jPy34EGgsG+J
	 BQFmDTUAH3YN8aw5+ZinJizeTB13A1XG6ZgHkyzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfBGLnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:43:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfBGLm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:42:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C424721904;
        Thu,  7 Feb 2019 11:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539778;
        bh=7RNYN+uRtxRQ7agnUfIJ7uzbPpJGK5QJNVm2RN+mbe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y4dCLTtkMQALaWDpCiqdDcfbLrobVEW5Pg0l3fKbWXMBOHraIltM8KyzA3N3aXjkr
         X1XmTmoycD1eiuFf6Ss7ZbkS3xxuQ9win+qqdKaBb3tfnQ6DgVmWzK3sGZ13lJnnxL
         jdyTBnmShtOe7XFsK4Pkog3de5y6kK0ggr79cWbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 20/34] inet: frags: get rid of ipfrag_skb_cb/FRAG_CB
Date:   Thu,  7 Feb 2019 12:42:02 +0100
Message-Id: <20190207113026.358197610@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit bf66337140c64c27fa37222b7abca7e49d63fb57 upstream.

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
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -558,6 +558,11 @@ struct sk_buff {
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
 


