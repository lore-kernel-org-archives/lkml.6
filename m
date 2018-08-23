Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD53FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C67208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C67208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbeHWLuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:50:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46796 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbeHWLuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:50:12 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 082B1C83;
        Thu, 23 Aug 2018 08:21:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 067/217] sctp: fix erroneous inc of snmp SctpFragUsrMsgs
Date:   Thu, 23 Aug 2018 09:53:00 +0200
Message-Id: <20180823075508.536277821@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

[ Upstream commit fedb1bd3d274b33c432cb83c80c6b3cf54d509c8 ]

Currently it is incrementing SctpFragUsrMsgs when the user message size
is of the exactly same size as the maximum fragment size, which is wrong.

The fix is to increment it only when user message is bigger than the
maximum fragment size.

Fixes: bfd2e4b8734d ("sctp: refactor sctp_datamsg_from_user")
Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/chunk.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/sctp/chunk.c
+++ b/net/sctp/chunk.c
@@ -230,7 +230,9 @@ struct sctp_datamsg *sctp_datamsg_from_u
 	/* Account for a different sized first fragment */
 	if (msg_len >= first_len) {
 		msg->can_delay = 0;
-		SCTP_INC_STATS(sock_net(asoc->base.sk), SCTP_MIB_FRAGUSRMSGS);
+		if (msg_len > first_len)
+			SCTP_INC_STATS(sock_net(asoc->base.sk),
+				       SCTP_MIB_FRAGUSRMSGS);
 	} else {
 		/* Which may be the only one... */
 		first_len = msg_len;


