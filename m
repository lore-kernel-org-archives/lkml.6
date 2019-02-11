Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B9AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B16E21B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895865;
	bh=TBpa5vMs0JrmUz3dafruZ0iVtKGSvh7JN5xZDGADmwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wbKFrs79pIKUn9zUgAgkxaSjxMWWUuZ86y7IID++uP3KQJFnd5Mc/pgzSKFLRz5M0
	 /y539bYipwNprgRf0vcWR18JFlpZfMa0iIlvOnjsyTGcV+hrynle7B+yhIR9s2lAMg
	 SHpiARp2lQaUBnAbRqNE3rDwbi8XKhdSU0ee4v+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbfBKOhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:47094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731495AbfBKOhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:37:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD7D320700;
        Mon, 11 Feb 2019 14:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895858;
        bh=TBpa5vMs0JrmUz3dafruZ0iVtKGSvh7JN5xZDGADmwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wGGxwqWJvpXHSnQPmJ8Up9oSs2SKkTgvlMQTR1YsXuklxHPoq9o+HYZLAudz6nSmL
         I+Tq9KrHJBEG8boRJXu8T0at97lgxgFyTvb9JovVKTObNn5YaC+bEeLFTAnuyFYqwj
         jvcs52MXMbRYXywv29m1XyDUZRivSAnMon6rzl+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Secunia Research <vuln@secunia.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 305/352] sctp: walk the list of asoc safely
Date:   Mon, 11 Feb 2019 15:18:52 +0100
Message-Id: <20190211141906.269528538@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2027,7 +2027,7 @@ static int sctp_sendmsg(struct sock *sk,
 	struct sctp_endpoint *ep = sctp_sk(sk)->ep;
 	struct sctp_transport *transport = NULL;
 	struct sctp_sndrcvinfo _sinfo, *sinfo;
-	struct sctp_association *asoc;
+	struct sctp_association *asoc, *tmp;
 	struct sctp_cmsgs cmsgs;
 	union sctp_addr *daddr;
 	bool new = false;
@@ -2053,7 +2053,7 @@ static int sctp_sendmsg(struct sock *sk,
 
 	/* SCTP_SENDALL process */
 	if ((sflags & SCTP_SENDALL) && sctp_style(sk, UDP)) {
-		list_for_each_entry(asoc, &ep->asocs, asocs) {
+		list_for_each_entry_safe(asoc, tmp, &ep->asocs, asocs) {
 			err = sctp_sendmsg_check_sflags(asoc, sflags, msg,
 							msg_len);
 			if (err == 0)


