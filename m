Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59934C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2178D205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sch5VUGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2178D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbeK3BXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:23:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729763AbeK3BXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:23:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BF3E21104;
        Thu, 29 Nov 2018 14:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501087;
        bh=pb9IbpFQsiGXFgGXOq8vgHRg0+zKZGe9pe/OYK353FU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sch5VUGMAebwMz720yYZ9Zb5QXzRbJ/RG4VXXgGUDKR7CBZanHTzqyggLP/70NLL0
         6EoM72soXzTMiWdqmRJy7kOYG9uDYY6aMNdSP8s2z98OQzZG9icDt5tbr/BAx1pqaA
         Dd+EPP8WB40wgnumE543uoDSUkTTdTYSWWuWDzDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+56a40ceee5fb35932f4d@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 07/86] sctp: clear the transport of some out_chunk_list chunks in sctp_assoc_rm_peer
Date:   Thu, 29 Nov 2018 15:11:32 +0100
Message-Id: <20181129140110.521138743@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit df132eff463873e14e019a07f387b4d577d6d1f9 upstream.

If a transport is removed by asconf but there still are some chunks with
this transport queuing on out_chunk_list, later an use-after-free issue
will be caused when accessing this transport from these chunks in
sctp_outq_flush().

This is an old bug, we fix it by clearing the transport of these chunks
in out_chunk_list when removing a transport in sctp_assoc_rm_peer().

Reported-by: syzbot+56a40ceee5fb35932f4d@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sctp/associola.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -486,8 +486,9 @@ void sctp_assoc_set_primary(struct sctp_
 void sctp_assoc_rm_peer(struct sctp_association *asoc,
 			struct sctp_transport *peer)
 {
-	struct list_head	*pos;
-	struct sctp_transport	*transport;
+	struct sctp_transport *transport;
+	struct list_head *pos;
+	struct sctp_chunk *ch;
 
 	pr_debug("%s: association:%p addr:%pISpc\n",
 		 __func__, asoc, &peer->ipaddr.sa);
@@ -543,7 +544,6 @@ void sctp_assoc_rm_peer(struct sctp_asso
 	 */
 	if (!list_empty(&peer->transmitted)) {
 		struct sctp_transport *active = asoc->peer.active_path;
-		struct sctp_chunk *ch;
 
 		/* Reset the transport of each chunk on this list */
 		list_for_each_entry(ch, &peer->transmitted,
@@ -565,6 +565,10 @@ void sctp_assoc_rm_peer(struct sctp_asso
 				sctp_transport_hold(active);
 	}
 
+	list_for_each_entry(ch, &asoc->outqueue.out_chunk_list, list)
+		if (ch->transport == peer)
+			ch->transport = NULL;
+
 	asoc->peer.transport_count--;
 
 	sctp_transport_free(peer);


