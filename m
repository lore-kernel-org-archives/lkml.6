Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3229C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E3C222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899395;
	bh=Il8dBxNkESBnBi81MpJqx9tfhzVQgNWP6AhsD5bQm0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=USwtp1g1O967yBW67e8bgvKTn1oym7mi5D+BR9tEcSGXu/yvxl0/GbksfP1s/kgRN
	 VBbBeNVq7n+36yaIIF5D/L6HGzBmiakDW4Patk4xzgEiMcqyZ9V59bOzAewD+bk8SW
	 cEUFpkyTeKWEQJWBzg8Pgfd6FXhj3kF5FaKtv2bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbfBKPge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:36:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387406AbfBKOvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:51:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B06F20700;
        Mon, 11 Feb 2019 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896703;
        bh=Il8dBxNkESBnBi81MpJqx9tfhzVQgNWP6AhsD5bQm0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QFQUzH2zQcqKX4HAKND2qYxiGrS27raWCrUkppTp/nl718949ppRnKzg/cSgHxWat
         DtzpshQSSZircGhrRijpRjp+GY1HwO3emO9rB4m6JHtRhtOvqEe9oaB+dCW5CssoGi
         4Xc9f6IHp/2mj04MfbYSAGcHR7k9P+pLvQsg8qqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Secunia Research <vuln@secunia.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 273/313] sctp: walk the list of asoc safely
Date:   Mon, 11 Feb 2019 15:19:13 +0100
Message-Id: <20190211141911.511204092@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit ba59fb0273076637f0add4311faa990a5eec27c0 ]

In sctp_sendmesg(), when walking the list of endpoint associations, the
association can be dropped from the list, making the list corrupt.
Properly handle this by using list_for_each_entry_safe()

Fixes: 4910280503f3 ("sctp: add support for snd flag SCTP_SENDALL process in sendmsg")
Reported-by: Secunia Research <vuln@secunia.com>
Tested-by: Secunia Research <vuln@secunia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/socket.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -2045,7 +2045,7 @@ static int sctp_sendmsg(struct sock *sk,
 	struct sctp_endpoint *ep = sctp_sk(sk)->ep;
 	struct sctp_transport *transport = NULL;
 	struct sctp_sndrcvinfo _sinfo, *sinfo;
-	struct sctp_association *asoc;
+	struct sctp_association *asoc, *tmp;
 	struct sctp_cmsgs cmsgs;
 	union sctp_addr *daddr;
 	bool new = false;
@@ -2071,7 +2071,7 @@ static int sctp_sendmsg(struct sock *sk,
 
 	/* SCTP_SENDALL process */
 	if ((sflags & SCTP_SENDALL) && sctp_style(sk, UDP)) {
-		list_for_each_entry(asoc, &ep->asocs, asocs) {
+		list_for_each_entry_safe(asoc, tmp, &ep->asocs, asocs) {
 			err = sctp_sendmsg_check_sflags(asoc, sflags, msg,
 							msg_len);
 			if (err == 0)


