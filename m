Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA76C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069A620850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108353;
	bh=7ZIIj1laTzBIxb6GrBSnnS8p397DY40qsOF9T2/6D2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PRVzBT2cD3xP/iA560xbCxR7RDswu4+PlirlwMCSU1h0Gl6+e9FE5Vne+J+dYd9KC
	 l7P1n0p1fK7Ai+V4kqUkOIGaUBiTOYuOeY9dNO/BkB51JMYKp6Ph8+8ynJdsx11vBI
	 2pl8h6SRa8pWyA5s6iXudINlAu8kcq7o0t9OWQnw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069A620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeLFO7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:59:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730278AbeLFOlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:41:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5081121479;
        Thu,  6 Dec 2018 14:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107294;
        bh=7ZIIj1laTzBIxb6GrBSnnS8p397DY40qsOF9T2/6D2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRz6oiJaFcvVbPfM4QJl41n8mmcnNPqXgKoSQdVOWO2HhD8U111rB/aGpG4R/JO0O
         owKrJJODVT5yTG8n7WcxK0MFf2yKK6lRY4sXL69+aD2xir1ogl/EX7SHmR6vSb1Iec
         SrGzvwklLtjXT5lHrHQJUbGmX6cVVQoe8DNJ0jsA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guoqing Jiang <gqjiang@suse.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 41/41] tipc: use destination length for copy string
Date:   Thu,  6 Dec 2018 15:39:21 +0100
Message-Id: <20181206142954.069346323@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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

diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index d8956f7daac4..4bdea0057171 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -651,7 +651,7 @@ int tipc_topsrv_start(struct net *net)
 	srv->max_rcvbuf_size = sizeof(struct tipc_subscr);
 	INIT_WORK(&srv->awork, tipc_topsrv_accept);
 
-	strncpy(srv->name, name, strlen(name) + 1);
+	strscpy(srv->name, name, sizeof(srv->name));
 	tn->topsrv = srv;
 	atomic_set(&tn->subscription_count, 0);
 


