Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFB0C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB132081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuwcUF+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB132081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeKCDo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbeKCDo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:44:57 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 836842081B;
        Fri,  2 Nov 2018 18:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183806;
        bh=cnOh+fdb24dHIonc0UIf4ks5VZJvUH7ePYyFowNMlwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SuwcUF+ZHUn2jVmjRm+PcKwH2cDjzWnjfaiWqzI1ftgQIno97jAWw4NbGoji93909
         4lspogvJY00iAm+jDoXN80tkqa9KDhba0oDx+bHET/Y+Wi8vKNxPj30M8OMuUj4g0g
         iPHtS27xNIWg6mb3Io1W3XBKAXQQwgKXs7N6U2r8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 13/24] net/smc: fix smc_buf_unuse to use the lgr pointer
Date:   Fri,  2 Nov 2018 19:34:46 +0100
Message-Id: <20181102182841.815946299@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182839.725385066@linuxfoundation.org>
References: <20181102182839.725385066@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karsten Graul <kgraul@linux.ibm.com>

[ Upstream commit fb692ec4117f6fd25044cfb5720d6b79d400dc65 ]

The pointer to the link group is unset in the smc connection structure
right before the call to smc_buf_unuse. Provide the lgr pointer to
smc_buf_unuse explicitly.
And move the call to smc_lgr_schedule_free_work to the end of
smc_conn_free.

Fixes: a6920d1d130c ("net/smc: handle unregistered buffers")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/smc_core.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -122,22 +122,17 @@ static void __smc_lgr_unregister_conn(st
 	sock_put(&smc->sk); /* sock_hold in smc_lgr_register_conn() */
 }
 
-/* Unregister connection and trigger lgr freeing if applicable
+/* Unregister connection from lgr
  */
 static void smc_lgr_unregister_conn(struct smc_connection *conn)
 {
 	struct smc_link_group *lgr = conn->lgr;
-	int reduced = 0;
 
 	write_lock_bh(&lgr->conns_lock);
 	if (conn->alert_token_local) {
-		reduced = 1;
 		__smc_lgr_unregister_conn(conn);
 	}
 	write_unlock_bh(&lgr->conns_lock);
-	if (!reduced || lgr->conns_num)
-		return;
-	smc_lgr_schedule_free_work(lgr);
 }
 
 /* Send delete link, either as client to request the initiation
@@ -291,7 +286,8 @@ out:
 	return rc;
 }
 
-static void smc_buf_unuse(struct smc_connection *conn)
+static void smc_buf_unuse(struct smc_connection *conn,
+			  struct smc_link_group *lgr)
 {
 	if (conn->sndbuf_desc)
 		conn->sndbuf_desc->used = 0;
@@ -301,8 +297,6 @@ static void smc_buf_unuse(struct smc_con
 			conn->rmb_desc->used = 0;
 		} else {
 			/* buf registration failed, reuse not possible */
-			struct smc_link_group *lgr = conn->lgr;
-
 			write_lock_bh(&lgr->rmbs_lock);
 			list_del(&conn->rmb_desc->list);
 			write_unlock_bh(&lgr->rmbs_lock);
@@ -315,16 +309,21 @@ static void smc_buf_unuse(struct smc_con
 /* remove a finished connection from its link group */
 void smc_conn_free(struct smc_connection *conn)
 {
-	if (!conn->lgr)
+	struct smc_link_group *lgr = conn->lgr;
+
+	if (!lgr)
 		return;
-	if (conn->lgr->is_smcd) {
+	if (lgr->is_smcd) {
 		smc_ism_unset_conn(conn);
 		tasklet_kill(&conn->rx_tsklet);
 	} else {
 		smc_cdc_tx_dismiss_slots(conn);
 	}
-	smc_lgr_unregister_conn(conn);
-	smc_buf_unuse(conn);
+	smc_lgr_unregister_conn(conn);		/* unsets conn->lgr */
+	smc_buf_unuse(conn, lgr);		/* allow buffer reuse */
+
+	if (!lgr->conns_num)
+		smc_lgr_schedule_free_work(lgr);
 }
 
 static void smc_link_clear(struct smc_link *lnk)


