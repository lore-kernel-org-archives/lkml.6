Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ED5C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D462D2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788956;
	bh=KkUP2mVR+i+xQ51wlqMV+IuY69SmkBWMeUopSSz9fmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w5Q6Be2lqASisFqL0RvkYzqHUTOpok918Fi+5DNFRhM0mdwQSucRd2U48rSeAWeYW
	 dhKBPuH3Ham55UeqRSCgY3f66v9UFmiZ1/7CqICmfA56KUVdPaaaN3NEr5VQrGr9mR
	 xkEVU7nVUXeg/LumeZRS9aYSBby/QkEmDac5geyw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D462D2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeLNMCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:45546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730069AbeLNMCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E304B21473;
        Fri, 14 Dec 2018 12:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788953;
        bh=KkUP2mVR+i+xQ51wlqMV+IuY69SmkBWMeUopSSz9fmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Og4oBMmC8sP9DMqZGiTWGbLoNt2JGHEPG1CP56bSBGdlZ6eGDq3Ou5MxQn0DaVn1y
         vldmrAKcAGGkPQdNdwNteRqmNs0H9pDtw9QuGG+wMqDAtUYMoZD+66cImtkqVFFyCZ
         kv4tzYql19xSY47CQ9UD/parG0/Ss17m32DCLgHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Audykowicz <jakub.audykowicz@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 019/142] sctp: update frag_point when stream_interleave is set
Date:   Fri, 14 Dec 2018 12:58:24 +0100
Message-Id: <20181214115747.816593005@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

[ Upstream commit 4135cce7fd0a0d755665c02728578c7c5afe4726 ]

sctp_assoc_update_frag_point() should be called whenever asoc->pathmtu
changes, but we missed one place in sctp_association_init(). It would
cause frag_point is zero when sending data.

As says in Jakub's reproducer, if sp->pathmtu is set by socketopt, the
new asoc->pathmtu inherits it in sctp_association_init(). Later when
transports are added and their pmtu >= asoc->pathmtu, it will never
call sctp_assoc_update_frag_point() to set frag_point.

This patch is to fix it by updating frag_point after asoc->pathmtu is
set as sp->pathmtu in sctp_association_init(). Note that it moved them
after sctp_stream_init(), as stream->si needs to be set first.

Frag_point's calculation is also related with datachunk's type, so it
needs to update frag_point when stream->si may be changed in
sctp_process_init().

v1->v2:
  - call sctp_assoc_update_frag_point() separately in sctp_process_init
    and sctp_association_init, per Marcelo's suggestion.

Fixes: 2f5e3c9df693 ("sctp: introduce sctp_assoc_update_frag_point")
Reported-by: Jakub Audykowicz <jakub.audykowicz@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/associola.c     |    7 ++++---
 net/sctp/sm_make_chunk.c |    3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -118,9 +118,6 @@ static struct sctp_association *sctp_ass
 	asoc->flowlabel = sp->flowlabel;
 	asoc->dscp = sp->dscp;
 
-	/* Initialize default path MTU. */
-	asoc->pathmtu = sp->pathmtu;
-
 	/* Set association default SACK delay */
 	asoc->sackdelay = msecs_to_jiffies(sp->sackdelay);
 	asoc->sackfreq = sp->sackfreq;
@@ -252,6 +249,10 @@ static struct sctp_association *sctp_ass
 			     0, gfp))
 		goto fail_init;
 
+	/* Initialize default path MTU. */
+	asoc->pathmtu = sp->pathmtu;
+	sctp_assoc_update_frag_point(asoc);
+
 	/* Assume that peer would support both address types unless we are
 	 * told otherwise.
 	 */
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2462,6 +2462,9 @@ int sctp_process_init(struct sctp_associ
 			     asoc->c.sinit_max_instreams, gfp))
 		goto clean_up;
 
+	/* Update frag_point when stream_interleave may get changed. */
+	sctp_assoc_update_frag_point(asoc);
+
 	if (!asoc->temp && sctp_assoc_set_id(asoc, gfp))
 		goto clean_up;
 


