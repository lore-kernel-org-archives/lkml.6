Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9D4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369DA206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRBaVdbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369DA206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404160AbeKLIoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:44:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404000AbeKLIW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:58 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B2E223C8;
        Sun, 11 Nov 2018 22:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975580;
        bh=R8EIzeqfEUveB8Abu+ZYsxTAOqzn7xVpRTw+DeawsMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cRBaVdbl82fOJ8CabjzhdFVDU2dznrqqrsh7UepWnBgM2mrJ0H+sELA52hOtMOWDC
         zWzqRh/wMPMVB4B46x0gRYY/NkiPmGj2fjZbZC98CtAcKs3K4y3xtaAfPduyRz9Bn9
         PHOUX1KScu2Sni//Pg3NRfuC28b9tiDPC9PAygr4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4.14 171/222] nfsd: Fix an Oops in free_session()
Date:   Sun, 11 Nov 2018 14:24:28 -0800
Message-Id: <20181111221702.501633059@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trondmy@gmail.com>

commit bb6ad5572c0022e17e846b382d7413cdcf8055be upstream.

In call_xpt_users(), we delete the entry from the list, but we
do not reinitialise it. This triggers the list poisoning when
we later call unregister_xpt_user() in nfsd4_del_conns().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/svc_xprt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1040,7 +1040,7 @@ static void call_xpt_users(struct svc_xp
 	spin_lock(&xprt->xpt_lock);
 	while (!list_empty(&xprt->xpt_users)) {
 		u = list_first_entry(&xprt->xpt_users, struct svc_xpt_user, list);
-		list_del(&u->list);
+		list_del_init(&u->list);
 		u->callback(u);
 	}
 	spin_unlock(&xprt->xpt_lock);


