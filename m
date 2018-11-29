Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FB7C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7DA2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSWgCPsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7DA2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbeK3BUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbeK3BUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:20:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C1E7205C9;
        Thu, 29 Nov 2018 14:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543500874;
        bh=Iu8bjsrBwYgKi5Z7zhhDMxr4BXe88rfr8vPuM0cuZSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSWgCPsuGO3UHDX7fJBeoU1fpCnP4r53nPW+D9J8JrHt16TUCBKToFofbs7rxQNfw
         jSZJZ3mXmmbBZ436KOyOyHT3k+jR4BdGZrGUweW33/TW2sEMgk6Cwwp0yRhcALGJCc
         GRYqffFPKS/Db766pTaQ7WFTZfwRxyFL5zEF06Z4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+56a40ceee5fb35932f4d@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 04/83] sctp: clear the transport of some out_chunk_list chunks in sctp_assoc_rm_peer
Date:   Thu, 29 Nov 2018 15:11:22 +0100
Message-Id: <20181129140138.261155061@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -487,8 +487,9 @@ void sctp_assoc_set_primary(struct sctp_
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
@@ -544,7 +545,6 @@ void sctp_assoc_rm_peer(struct sctp_asso
 	 */
 	if (!list_empty(&peer->transmitted)) {
 		struct sctp_transport *active = asoc->peer.active_path;
-		struct sctp_chunk *ch;
 
 		/* Reset the transport of each chunk on this list */
 		list_for_each_entry(ch, &peer->transmitted,
@@ -566,6 +566,10 @@ void sctp_assoc_rm_peer(struct sctp_asso
 				sctp_transport_hold(active);
 	}
 
+	list_for_each_entry(ch, &asoc->outqueue.out_chunk_list, list)
+		if (ch->transport == peer)
+			ch->transport = NULL;
+
 	asoc->peer.transport_count--;
 
 	sctp_transport_free(peer);


