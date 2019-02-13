Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BB3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A5820811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083807;
	bh=9sRGFVfN2rWnnC7aPKbCkaLIXUBXKfC5nje/CzVxfi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zzha1PBZEu3WG0FOU5/W7X2sJdl2sH5NIg5NdGRG/oarTvYULuOb7g8NH6EGnKjI8
	 XlqHNqx4NRLKgbFmh9NLazELF5GFLF2YC71+twO00t+nwoQKgrc1+3fdJU0oosZL6E
	 lr0oZjOrcFnQDJdVYm0A1XeBtcSMbbBnOzykuORA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394005AbfBMSuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:50:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388923AbfBMSoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:44:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59B40222D1;
        Wed, 13 Feb 2019 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083478;
        bh=9sRGFVfN2rWnnC7aPKbCkaLIXUBXKfC5nje/CzVxfi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQHOkKCMtldJwPHlmgJY2cc/HmQGiUEFQwjlIrkDyxvmJrdJFJYZXC46dx40fgBT3
         28MJ85rhy9RzZOWGMnFapHNdPV4E+4ABXNy6BuV4tLBf02ACyoWyllxCe0xrKn233D
         ntyCwzoxP1LGDgPqgNRz5uF5LT71arrStPDhA6SM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Don Dutile <ddutile@redhat.com>
Subject: [PATCH 4.19 43/44] svcrdma: Reduce max_send_sges
Date:   Wed, 13 Feb 2019 19:38:44 +0100
Message-Id: <20190213183655.396138646@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

commit f3c1fd0ee294abd4367dfa72d89f016c682202f0 upstream.

There's no need to request a large number of send SGEs because the
inline threshold already constrains the number of SGEs per Send.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Cc: Don Dutile <ddutile@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -475,10 +475,12 @@ static struct svc_xprt *svc_rdma_accept(
 
 	/* Qualify the transport resource defaults with the
 	 * capabilities of this particular device */
-	newxprt->sc_max_send_sges = dev->attrs.max_send_sge;
-	/* transport hdr, head iovec, one page list entry, tail iovec */
-	if (newxprt->sc_max_send_sges < 4) {
-		pr_err("svcrdma: too few Send SGEs available (%d)\n",
+	/* Transport header, head iovec, tail iovec */
+	newxprt->sc_max_send_sges = 3;
+	/* Add one SGE per page list entry */
+	newxprt->sc_max_send_sges += svcrdma_max_req_size / PAGE_SIZE;
+	if (newxprt->sc_max_send_sges > dev->attrs.max_send_sge) {
+		pr_err("svcrdma: too few Send SGEs available (%d needed)\n",
 		       newxprt->sc_max_send_sges);
 		goto errout;
 	}


