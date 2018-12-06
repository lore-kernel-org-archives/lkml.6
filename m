Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C840EC67839
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F30D20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107987;
	bh=V5Mr+OZBTfCvt8IXkHREPJB8FZkVG45+TYrCGr6dlms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hOcqsHIMnIEm1wAhMuPLdxZfZuu26AoH0NmJ8JBKoMH7GlWcSOTpUOf7OHdffvDoK
	 qgZ0imAolt2vbswLoMk4vzvdZ0hmuZIRfQPcKkJ6YcBF55aJV7P550+ubnKUUPuoM5
	 y3tE4uKyT39wOKDq3JqT7Png4z456JWXIIpJb7UI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F30D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeLFOxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731124AbeLFOpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:45:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C181420661;
        Thu,  6 Dec 2018 14:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107544;
        bh=V5Mr+OZBTfCvt8IXkHREPJB8FZkVG45+TYrCGr6dlms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FLjXlOuNckLOk8+ig6OtNPs0dQgEtpATtlchad2vxEqY/ENMoUS03qYNrM6Hj0X3I
         CyGSlBt3Pib0VbAfNOt3JuHCKgLWrwS5v/TCe85NknccUGAE3ydfPrvVHb3+Vh2HnL
         NlLOFwCnWaA3w1u/YO/MNAGApmQCLcgJkCcztn4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guoqing Jiang <gqjiang@suse.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 047/101] tipc: use destination length for copy string
Date:   Thu,  6 Dec 2018 15:38:46 +0100
Message-Id: <20181206143014.276285423@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -389,7 +389,7 @@ int tipc_topsrv_start(struct net *net)
 	topsrv->tipc_conn_new		= tipc_subscrb_connect_cb;
 	topsrv->tipc_conn_release	= tipc_subscrb_release_cb;
 
-	strncpy(topsrv->name, name, strlen(name) + 1);
+	strscpy(topsrv->name, name, sizeof(topsrv->name));
 	tn->topsrv = topsrv;
 	atomic_set(&tn->subscription_count, 0);
 


