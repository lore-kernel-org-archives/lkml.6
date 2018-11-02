Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC397C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D95F20843
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAaNDYnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D95F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbeKCDzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbeKCDzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:55:37 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AAEB20837;
        Fri,  2 Nov 2018 18:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184443;
        bh=CSBfPXU3aKS3akEwoxUMoTJ9tG8/2D5SlQUs0yzCRic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAaNDYnwn/y0/Zc15onpZ5i3BFAhMcJigkhLUABiysb5KMn7AdSxsWSDAREWFfnKW
         gRyseczSnlApdiypgYfFeltB8OVxjiykkRWGnBS6q4J12YCpvY3k5PvnGD6GF5hMaR
         cykngVCmLmg0N8FT56RJBPq4OJIyz826blWPUcMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c7dd55d7aec49d48e49a@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 117/150] sctp: fix race on sctp_id2asoc
Date:   Fri,  2 Nov 2018 19:34:39 +0100
Message-Id: <20181102182911.223628407@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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

From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

[ Upstream commit b336decab22158937975293aea79396525f92bb3 ]

syzbot reported an use-after-free involving sctp_id2asoc.  Dmitry Vyukov
helped to root cause it and it is because of reading the asoc after it
was freed:

        CPU 1                       CPU 2
(working on socket 1)            (working on socket 2)
	                         sctp_association_destroy
sctp_id2asoc
   spin lock
     grab the asoc from idr
   spin unlock
                                   spin lock
				     remove asoc from idr
				   spin unlock
				   free(asoc)
   if asoc->base.sk != sk ... [*]

This can only be hit if trying to fetch asocs from different sockets. As
we have a single IDR for all asocs, in all SCTP sockets, their id is
unique on the system. An application can try to send stuff on an id
that matches on another socket, and the if in [*] will protect from such
usage. But it didn't consider that as that asoc may belong to another
socket, it may be freed in parallel (read: under another socket lock).

We fix it by moving the checks in [*] into the protected region. This
fixes it because the asoc cannot be freed while the lock is held.

Reported-by: syzbot+c7dd55d7aec49d48e49a@syzkaller.appspotmail.com
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/socket.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -270,11 +270,10 @@ struct sctp_association *sctp_id2assoc(s
 
 	spin_lock_bh(&sctp_assocs_id_lock);
 	asoc = (struct sctp_association *)idr_find(&sctp_assocs_id, (int)id);
+	if (asoc && (asoc->base.sk != sk || asoc->base.dead))
+		asoc = NULL;
 	spin_unlock_bh(&sctp_assocs_id_lock);
 
-	if (!asoc || (asoc->base.sk != sk) || asoc->base.dead)
-		return NULL;
-
 	return asoc;
 }
 


