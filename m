Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26995C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1ECB2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW1tBOfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1ECB2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbeKVFnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387893AbeKVFnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:43:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A09AC206BB;
        Wed, 21 Nov 2018 19:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827255;
        bh=19EotQv/BUKySVCypJ6qOMd6bMGe9+8DEoc6OD1uwXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GW1tBOfPDE8dwrhRqVUpkyiiOLGx8FRio80YQu8kVskn0yG6nyKkRZgZWb1aShx0+
         NPxlnYALcSWW1otCzn539F9i4DaPkP2+rIMtLUsHVtHsubE1Awp87pxDkN3VLAkZyh
         UYPaK65WPHEQymAiiq+I5BWnQA8XrykMJEDlYnpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianwen Ji <jiji@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 32/42] sctp: define SCTP_SS_DEFAULT for Stream schedulers
Date:   Wed, 21 Nov 2018 20:06:08 +0100
Message-Id: <20181121183149.360419165@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 12480e3b16982c4026de10dd8155823219cd6391 ]

According to rfc8260#section-4.3.2, SCTP_SS_DEFAULT is required to
defined as SCTP_SS_FCFS or SCTP_SS_RR.

SCTP_SS_FCFS is used for SCTP_SS_DEFAULT's value in this patch.

Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
Reported-by: Jianwen Ji <jiji@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/sctp.h |    1 +
 net/sctp/outqueue.c       |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/include/uapi/linux/sctp.h
+++ b/include/uapi/linux/sctp.h
@@ -1151,6 +1151,7 @@ struct sctp_add_streams {
 /* SCTP Stream schedulers */
 enum sctp_sched_type {
 	SCTP_SS_FCFS,
+	SCTP_SS_DEFAULT = SCTP_SS_FCFS,
 	SCTP_SS_PRIO,
 	SCTP_SS_RR,
 	SCTP_SS_MAX = SCTP_SS_RR
--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -212,7 +212,7 @@ void sctp_outq_init(struct sctp_associat
 	INIT_LIST_HEAD(&q->retransmit);
 	INIT_LIST_HEAD(&q->sacked);
 	INIT_LIST_HEAD(&q->abandoned);
-	sctp_sched_set_sched(asoc, SCTP_SS_FCFS);
+	sctp_sched_set_sched(asoc, SCTP_SS_DEFAULT);
 }
 
 /* Free the outqueue structure and any related pending chunks.


