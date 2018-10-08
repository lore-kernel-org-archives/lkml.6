Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6335C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F48220645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2sPEmYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F48220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbeJICE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731723AbeJICEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:04:55 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DECBD20645;
        Mon,  8 Oct 2018 18:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024707;
        bh=ZTfzFRpNN1iOtUZYnmx+BfWblMCsth++/s4jTA3Uf5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2sPEmYmeVaKif4PO6r4mycD3pFMGThyk+4iyCZNoYNferMwEDkzM151Sy0X7Wx9l
         XGcXmapaHXP32zECu81FrYc3amX2gYbtKzAK5TSbQ3r3dMG5qYFtCuAxK3GqmZfX/T
         GiGPnvqxdMzQZo7pFHyHe0kFPMZCeS6ERhb6yuJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michal vorner Vaner <michal.vaner@avast.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 128/168] netfilter: nfnetlink_queue: Solve the NFQUEUE/conntrack clash for NF_REPEAT
Date:   Mon,  8 Oct 2018 20:31:48 +0200
Message-Id: <20181008175624.912361214@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Michal 'vorner' Vaner <michal.vaner@avast.com>

[ Upstream commit ad18d7bf68a3da860ebb62a59c449804a6d237b4 ]

NF_REPEAT places the packet at the beginning of the iptables chain
instead of accepting or rejecting it right away. The packet however will
reach the end of the chain and continue to the end of iptables
eventually, so it needs the same handling as NF_ACCEPT and NF_DROP.

Fixes: 368982cd7d1b ("netfilter: nfnetlink_queue: resolve clash for unconfirmed conntracks")
Signed-off-by: Michal 'vorner' Vaner <michal.vaner@avast.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nfnetlink_queue.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -233,6 +233,7 @@ static void nfqnl_reinject(struct nf_que
 	int err;
 
 	if (verdict == NF_ACCEPT ||
+	    verdict == NF_REPEAT ||
 	    verdict == NF_STOP) {
 		rcu_read_lock();
 		ct_hook = rcu_dereference(nf_ct_hook);


