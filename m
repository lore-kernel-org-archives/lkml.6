Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC38C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C1C20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5xv3o0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C1C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeJQBCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbeJQBCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:02:51 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12E8F21476;
        Tue, 16 Oct 2018 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709889;
        bh=SlkuqQxIGq1A9luawFpkLMjrvPrV5qlMUMVWIUqSlaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5xv3o0QbNOd22sHlgz2XKTYfINwYtNILUk+JTs8w81vqAegyFVwR+Hre+m3bFAhj
         Ls+ar86atofVYYRMpgdxZrls7qmBzC9f24AbIH13ywmYFPaKBoJMS0BbLDauJDRzEp
         AwjPCQ5rub+6c3+Gs4Bg57poM+kwvQ6FiMX5dnrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 030/135] tun: remove unused parameters
Date:   Tue, 16 Oct 2018 19:04:20 +0200
Message-Id: <20181016170517.152620698@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 06e55addd3f40b5294e448c2cb7605ca4f28c2e3 ]

tun_napi_disable() and tun_napi_del() do not need
a pointer to the tun_struct

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -323,13 +323,13 @@ static void tun_napi_init(struct tun_str
 	}
 }
 
-static void tun_napi_disable(struct tun_struct *tun, struct tun_file *tfile)
+static void tun_napi_disable(struct tun_file *tfile)
 {
 	if (tfile->napi_enabled)
 		napi_disable(&tfile->napi);
 }
 
-static void tun_napi_del(struct tun_struct *tun, struct tun_file *tfile)
+static void tun_napi_del(struct tun_file *tfile)
 {
 	if (tfile->napi_enabled)
 		netif_napi_del(&tfile->napi);
@@ -688,8 +688,8 @@ static void __tun_detach(struct tun_file
 	tun = rtnl_dereference(tfile->tun);
 
 	if (tun && clean) {
-		tun_napi_disable(tun, tfile);
-		tun_napi_del(tun, tfile);
+		tun_napi_disable(tfile);
+		tun_napi_del(tfile);
 	}
 
 	if (tun && !tfile->detached) {
@@ -756,7 +756,7 @@ static void tun_detach_all(struct net_de
 	for (i = 0; i < n; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
 		BUG_ON(!tfile);
-		tun_napi_disable(tun, tfile);
+		tun_napi_disable(tfile);
 		tfile->socket.sk->sk_shutdown = RCV_SHUTDOWN;
 		tfile->socket.sk->sk_data_ready(tfile->socket.sk);
 		RCU_INIT_POINTER(tfile->tun, NULL);
@@ -772,7 +772,7 @@ static void tun_detach_all(struct net_de
 	synchronize_net();
 	for (i = 0; i < n; i++) {
 		tfile = rtnl_dereference(tun->tfiles[i]);
-		tun_napi_del(tun, tfile);
+		tun_napi_del(tfile);
 		/* Drop read queue */
 		tun_queue_purge(tfile);
 		xdp_rxq_info_unreg(&tfile->xdp_rxq);


