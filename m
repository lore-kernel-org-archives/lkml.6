Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567EBC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1701A214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjRFaaZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1701A214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeLDKzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:55:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbeLDKzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:55:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44A672087F;
        Tue,  4 Dec 2018 10:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543920921;
        bh=DkAtdtudO0aa6Ma62keWaRPouU7AyQECizrjuVFiHX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjRFaaZJrYyP3CKGt7Km0MziPshgw+cCh6uccv4XY7EvaWubf9P7qtJAxbzVvuFO2
         N42833ZRoGWoJIRYKG/UIC8v8I8At7475SpdoP/OvJKa6HPBiM2cRPofN+mECgrE+k
         ZGT7TuYXAVV+6RusL4pej7JB8OSc68t/wFmsLIsA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 012/139] net: dont keep lonely packets forever in the gro hash
Date:   Tue,  4 Dec 2018 11:48:13 +0100
Message-Id: <20181204103650.493272051@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 605108acfe6233b72e2f803aa1cb59a2af3001ca ]

Eric noted that with UDP GRO and NAPI timeout, we could keep a single
UDP packet inside the GRO hash forever, if the related NAPI instance
calls napi_gro_complete() at an higher frequency than the NAPI timeout.
Willem noted that even TCP packets could be trapped there, till the
next retransmission.
This patch tries to address the issue, flushing the old packets -
those with a NAPI_GRO_CB age before the current jiffy - before scheduling
the NAPI timeout. The rationale is that such a timeout should be
well below a jiffy and we are not flushing packets eligible for sane GRO.

v1  -> v2:
 - clarified the commit message and comment

RFC -> v1:
 - added 'Fixes tags', cleaned-up the wording.

Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Fixes: 3b47d30396ba ("net: gro: add a per device gro flush timer")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Acked-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5945,11 +5945,14 @@ bool napi_complete_done(struct napi_stru
 		if (work_done)
 			timeout = n->dev->gro_flush_timeout;
 
+		/* When the NAPI instance uses a timeout and keeps postponing
+		 * it, we need to bound somehow the time packets are kept in
+		 * the GRO layer
+		 */
+		napi_gro_flush(n, !!timeout);
 		if (timeout)
 			hrtimer_start(&n->timer, ns_to_ktime(timeout),
 				      HRTIMER_MODE_REL_PINNED);
-		else
-			napi_gro_flush(n, false);
 	}
 	if (unlikely(!list_empty(&n->poll_list))) {
 		/* If n->poll_list is not empty, we need to mask irqs */


