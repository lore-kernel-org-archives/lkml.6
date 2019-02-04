Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282F8C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8C02070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277314;
	bh=nt13zVEbdbJmets53KNgd0J7nh09IA4ZB8bbi8sOPko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l2Cv0Q1vwXUMIRA6bLRH3BOPvrKd1UZD256Y4kHXAGke8QzRCLoKJS58VDeyJHzkV
	 pTTVC+QVqsZ27LryYyVg7kKPVA8eeCR+WQYxWBkTpxgF8phcTOZl3FhWo35d411uUH
	 eJeT0SJFeWgexX+CXwnU9m5l/cHWxHvd+BPqxPD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbfBDKsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:48:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731836AbfBDKsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:48:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53762070C;
        Mon,  4 Feb 2019 10:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277305;
        bh=nt13zVEbdbJmets53KNgd0J7nh09IA4ZB8bbi8sOPko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFYc88AxxTQukKjvnoDd+jkHW3eaFCbeWMt798xdOu8ibFzlx0X5LtZIGlt+xHlNJ
         80cryxjfU+V5F1ZXpXGBTcgszE+hF9jX0u3JnJey9IrronaZIMQWl+DIRjYBaF8gjA
         8BBOYJxP/oagF9HVXaTswvWvJrUMfc8W5XHRE6aI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xu <yinxu@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 24/74] sctp: set chunk transport correctly when its a new asoc
Date:   Mon,  4 Feb 2019 11:36:37 +0100
Message-Id: <20190204103622.857607029@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 4ff40b86262b73553ee47cc3784ce8ba0f220bd8 ]

In the paths:

  sctp_sf_do_unexpected_init() ->
    sctp_make_init_ack()
  sctp_sf_do_dupcook_a/b()() ->
    sctp_sf_do_5_1D_ce()

The new chunk 'retval' transport is set from the incoming chunk 'chunk'
transport. However, 'retval' transport belong to the new asoc, which
is a different one from 'chunk' transport's asoc.

It will cause that the 'retval' chunk gets set with a wrong transport.
Later when sending it and because of Commit b9fd683982c9 ("sctp: add
sctp_packet_singleton"), sctp_packet_singleton() will set some fields,
like vtag to 'retval' chunk from that wrong transport's asoc.

This patch is to fix it by setting 'retval' transport correctly which
belongs to the right asoc in sctp_make_init_ack() and
sctp_sf_do_5_1D_ce().

Fixes: b9fd683982c9 ("sctp: add sctp_packet_singleton")
Reported-by: Ying Xu <yinxu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/sm_make_chunk.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -495,7 +495,10 @@ struct sctp_chunk *sctp_make_init_ack(co
 	 *
 	 * [INIT ACK back to where the INIT came from.]
 	 */
-	retval->transport = chunk->transport;
+	if (chunk->transport)
+		retval->transport =
+			sctp_assoc_lookup_paddr(asoc,
+						&chunk->transport->ipaddr);
 
 	retval->subh.init_hdr =
 		sctp_addto_chunk(retval, sizeof(initack), &initack);
@@ -642,8 +645,10 @@ struct sctp_chunk *sctp_make_cookie_ack(
 	 *
 	 * [COOKIE ACK back to where the COOKIE ECHO came from.]
 	 */
-	if (retval && chunk)
-		retval->transport = chunk->transport;
+	if (retval && chunk && chunk->transport)
+		retval->transport =
+			sctp_assoc_lookup_paddr(asoc,
+						&chunk->transport->ipaddr);
 
 	return retval;
 }


