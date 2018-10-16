Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B21C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB5120866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq+AnzSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB5120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbeJQBJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbeJQBJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:09:21 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21AF420866;
        Tue, 16 Oct 2018 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710277;
        bh=kSt0fbNW2nH5z+C51wP6vaR4JtoCKfse3ybALJI27pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kq+AnzSgVfGTewZPmZ02jxlGIkJHZZN1nQ1ySO2lvCuLb1dqrBGc/pJzMTN2srcvc
         I+8kcuWgl4Bt2q/gTTt+DNk+bPaSklaI0iX+Eddz/xa0NWwUI3mI6BXvS8rvicpNSy
         vVIBVwnwD7iVotOhcEPZbbGwLuV4bwEHaZoyC6kA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Jiri Kosina <jkosina@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 025/109] udp: Unbreak modules that rely on external __skb_recv_udp() availability
Date:   Tue, 16 Oct 2018 19:04:53 +0200
Message-Id: <20181016170526.469778328@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
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

From: Jiri Kosina <jkosina@suse.cz>

[ Upstream commit 7e823644b60555f70f241274b8d0120dd919269a ]

Commit 2276f58ac589 ("udp: use a separate rx queue for packet reception")
turned static inline __skb_recv_udp() from being a trivial helper around
__skb_recv_datagram() into a UDP specific implementaion, making it
EXPORT_SYMBOL_GPL() at the same time.

There are external modules that got broken by __skb_recv_udp() not being
visible to them. Let's unbreak them by making __skb_recv_udp EXPORT_SYMBOL().

Rationale (one of those) why this is actually "technically correct" thing
to do: __skb_recv_udp() used to be an inline wrapper around
__skb_recv_datagram(), which itself (still, and correctly so, I believe)
is EXPORT_SYMBOL().

Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>
Fixes: 2276f58ac589 ("udp: use a separate rx queue for packet reception")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1565,7 +1565,7 @@ busy_check:
 	*err = error;
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(__skb_recv_udp);
+EXPORT_SYMBOL(__skb_recv_udp);
 
 /*
  * 	This should be easy, if there is something there we


