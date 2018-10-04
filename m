Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662D8C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364162148D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364162148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeJDUpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:45:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbeJDUpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:45:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E934A88308;
        Thu,  4 Oct 2018 13:51:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D780B2D02A;
        Thu,  4 Oct 2018 13:51:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH net-next 9/9] rxrpc: Allow the reply time to be obtained on
 a client call
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 14:51:46 +0100
Message-ID: <153866110607.27255.9371776374717097082.stgit@warthog.procyon.org.uk>
In-Reply-To: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
References: <153866103101.27255.4710558896251591679.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 04 Oct 2018 13:51:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the epoch value to be queried on a server connection.  This is in the
rxrpc header of every packet for use in routing and is derived from the
client's state.  It's also not supposed to change unless the client gets
restarted.

AFS can make use of this information to deduce whether a fileserver has
been restarted because the fileserver makes client calls to the filesystem
driver's cache manager to send notifications (ie. callback breaks) about
conflicting changes from other clients.  These convey the fileserver's own
epoch value back to the filesystem.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/networking/rxrpc.txt |   14 ++++++++++++++
 include/net/af_rxrpc.h             |    1 +
 net/rxrpc/af_rxrpc.c               |   14 ++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/networking/rxrpc.txt b/Documentation/networking/rxrpc.txt
index 67879992b4c2..605e00cdd6be 100644
--- a/Documentation/networking/rxrpc.txt
+++ b/Documentation/networking/rxrpc.txt
@@ -1080,6 +1080,20 @@ The kernel interface functions are as follows:
      successful, the timestamp will be stored into *_ts and true will be
      returned; false will be returned otherwise.
 
+ (*) Get remote client epoch.
+
+	u32 rxrpc_kernel_get_epoch(struct socket *sock,
+				   struct rxrpc_call *call)
+
+     This allows the epoch that's contained in packets of an incoming client
+     call to be queried.  This value is returned.  The function always
+     successful if the call is still in progress.  It shouldn't be called once
+     the call has expired.  Note that calling this on a local client call only
+     returns the local epoch.
+
+     This value can be used to determine if the remote client has been
+     restarted as it shouldn't change otherwise.
+
 
 =======================
 CONFIGURABLE PARAMETERS
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index c4c912554dee..de587948042a 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -78,6 +78,7 @@ int rxrpc_kernel_retry_call(struct socket *, struct rxrpc_call *,
 int rxrpc_kernel_check_call(struct socket *, struct rxrpc_call *,
 			    enum rxrpc_call_completion *, u32 *);
 u32 rxrpc_kernel_check_life(struct socket *, struct rxrpc_call *);
+u32 rxrpc_kernel_get_epoch(struct socket *, struct rxrpc_call *);
 bool rxrpc_kernel_get_reply_time(struct socket *, struct rxrpc_call *,
 				 ktime_t *);
 
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 2fdd276f6842..013dbcb052e5 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -385,6 +385,20 @@ u32 rxrpc_kernel_check_life(struct socket *sock, struct rxrpc_call *call)
 }
 EXPORT_SYMBOL(rxrpc_kernel_check_life);
 
+/**
+ * rxrpc_kernel_get_epoch - Retrieve the epoch value from a call.
+ * @sock: The socket the call is on
+ * @call: The call to query
+ *
+ * Allow a kernel service to retrieve the epoch value from a service call to
+ * see if the client at the other end rebooted.
+ */
+u32 rxrpc_kernel_get_epoch(struct socket *sock, struct rxrpc_call *call)
+{
+	return call->conn->proto.epoch;
+}
+EXPORT_SYMBOL(rxrpc_kernel_get_epoch);
+
 /**
  * rxrpc_kernel_check_call - Check a call's state
  * @sock: The socket the call is on

