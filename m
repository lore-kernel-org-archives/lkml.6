Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03347C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF01D2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866939;
	bh=Ozth432OK93FKKPG4ihba7ggkBZbjLWcAz8VyGRIXRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0uMML4hnNjxhi8Rb7DpfHQTYgweBN/lGm+MZLhkVIU/GZaKJxWGAS6ETfmX8HLU1D
	 BQFxIQL8mUKEX1uphQ3ddaLE9KaYQbKi61iZ+fUdhoLD6QZK5dhqAztkHHgOkugQyQ
	 3u8CRQKJV3Dw1T8IDzIoVZK1g8GUXh//nTPDugyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbfAGNPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:15:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730659AbfAGNBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:01:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68BA32089F;
        Mon,  7 Jan 2019 13:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866101;
        bh=Ozth432OK93FKKPG4ihba7ggkBZbjLWcAz8VyGRIXRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yQElSbyJTlfQPyPPfT39O0mIwyrxwtpdad8P1RG4HfMa7y6XmKqDDA1NfPYDKJVu0
         FMl5eod1OKviiunvrv+rZHBnMYNC4wQd2ge9cNTJiFO+mb8lahWH4uWeO+nlYuCO/5
         8Sd//lkWAA4QmoDqBJLQBaIeFPBc3S9kyKytLNGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 001/101] phonet: af_phonet: Fix Spectre v1 vulnerability
Date:   Mon,  7 Jan 2019 13:31:49 +0100
Message-Id: <20190107105330.456283338@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

[ Upstream commit d686026b1e6ed4ea27d630d8f54f9a694db088b2 ]

protocol is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

net/phonet/af_phonet.c:48 phonet_proto_get() warn: potential spectre issue 'proto_tab' [w] (local cap)

Fix this by sanitizing protocol before using it to index proto_tab.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/phonet/af_phonet.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/phonet/af_phonet.c
+++ b/net/phonet/af_phonet.c
@@ -34,6 +34,8 @@
 #include <net/phonet/phonet.h>
 #include <net/phonet/pn_dev.h>
 
+#include <linux/nospec.h>
+
 /* Transport protocol registration */
 static struct phonet_protocol *proto_tab[PHONET_NPROTO] __read_mostly;
 
@@ -43,6 +45,7 @@ static struct phonet_protocol *phonet_pr
 
 	if (protocol >= PHONET_NPROTO)
 		return NULL;
+	protocol = array_index_nospec(protocol, PHONET_NPROTO);
 
 	rcu_read_lock();
 	pp = rcu_dereference(proto_tab[protocol]);


