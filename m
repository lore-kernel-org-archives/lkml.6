Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04DDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65BC2190C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498731;
	bh=/EGLtWXX8qQ5x3PDE3JkF0S2vtxL6TvE20FUSdxe/ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W2+mai9zmGIXLp355ZgyAIJrvIGvQme2lULqnyzcrDjJ6lEj5GkWLK78FhsPogcFB
	 C74CE9tIy8ZYhxdqewmcSiJcj32sd7QRYmRSQBpMbERO9M8CfLj0sLxcOZT3Q58GBm
	 DXBEx4nQG4S8CmHHWgKSM0GuBz2d6rpmDU87QvD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390163AbfBROFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:05:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389643AbfBROFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:05:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 534E1204FD;
        Mon, 18 Feb 2019 14:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498724;
        bh=/EGLtWXX8qQ5x3PDE3JkF0S2vtxL6TvE20FUSdxe/ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tJia0uvyCCKaG6Ou9TtPGGuC2b5GPf0a2dzGziqHmeZZVoO6eZPNA85U8KxPnYLyE
         zNNwPuJQsvmKmR4qK0lu4lHDF/lhr+jGcBZe9x99n6mv2KG+tWnJR9L9iv1NGYvfcO
         Xh53hJnDE9J+hxHamLIbBjS/Z6xguW8M1elZ1ftA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guoqing Jiang <gqjiang@suse.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 075/143] tipc: use destination length for copy string
Date:   Mon, 18 Feb 2019 14:43:23 +0100
Message-Id: <20190218133531.831329997@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

From: Guoqing Jiang <gqjiang@suse.com>

commit 29e270fc32192e7729057963ae7120663856c93e upstream.

Got below warning with gcc 8.2 compiler.

net/tipc/topsrv.c: In function ‘tipc_topsrv_start’:
net/tipc/topsrv.c:660:2: warning: ‘strncpy’ specified bound depends on the length of the source argument [-Wstringop-overflow=]
  strncpy(srv->name, name, strlen(name) + 1);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/tipc/topsrv.c:660:27: note: length computed here
  strncpy(srv->name, name, strlen(name) + 1);
                           ^~~~~~~~~~~~
So change it to correct length and use strscpy.

Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
Acked-by: Ying Xue <ying.xue@windriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/tipc/subscr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/tipc/subscr.c
+++ b/net/tipc/subscr.c
@@ -337,7 +337,7 @@ int tipc_topsrv_start(struct net *net)
 	topsrv->tipc_conn_new		= tipc_subscrb_connect_cb;
 	topsrv->tipc_conn_shutdown	= tipc_subscrb_shutdown_cb;
 
-	strncpy(topsrv->name, name, strlen(name) + 1);
+	strscpy(topsrv->name, name, sizeof(topsrv->name));
 	tn->topsrv = topsrv;
 	atomic_set(&tn->subscription_count, 0);
 


