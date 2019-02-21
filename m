Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5706C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42F92075C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550759829;
	bh=bOXycFKqDClHqPv3d4jwPy81nmDjwH/m6BAgjmDVkws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pDJYNSqIq6yItp9dA5Wpo76keueheErOOzSOlQSLKLnw1a9oOcejkkc01m0Vt/iDR
	 pqFyAmYRri6VI3uiyfDcFsxXHIo/Qj0T3fvAMmobkBs0iL9wxB7TttYGVKwLDeKuv6
	 h7vLuVbVOb3NK7kWeZ7m/LxvZsLUcTsm3KMpda5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfBUOhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728291AbfBUOhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:37:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD6DC2075C;
        Thu, 21 Feb 2019 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550759826;
        bh=bOXycFKqDClHqPv3d4jwPy81nmDjwH/m6BAgjmDVkws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ve9IlKKeYAUyvNtpHU5vwOHNUg3vTTJv9Ng+kdFgF5ZEdKjlYUqPvvHmcZrwF7WMx
         rJZ480w+Bgw0jxcxocilRDkyvxi2M4XWX2EF6cblYf0lJ5THsbci6znvfCQRjhhPIH
         BI2u1FpT8ffzf0awFxuoyB3dTGZ77yeulVuF6OHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiumei Mu <xmu@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 06/13] vsock: cope with memory allocation failure at socket creation time
Date:   Thu, 21 Feb 2019 15:35:37 +0100
Message-Id: <20190221125240.668361110@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125240.091472334@linuxfoundation.org>
References: <20190221125240.091472334@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 225d9464268599a5b4d094d02ec17808e44c7553 ]

In the unlikely event that the kmalloc call in vmci_transport_socket_init()
fails, we end-up calling vmci_transport_destruct() with a NULL vmci_trans()
and oopsing.

This change addresses the above explicitly checking for zero vmci_trans()
at destruction time.

Reported-by: Xiumei Mu <xmu@redhat.com>
Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/vmw_vsock/vmci_transport.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1663,6 +1663,10 @@ static int vmci_transport_socket_init(st
 
 static void vmci_transport_destruct(struct vsock_sock *vsk)
 {
+	/* transport can be NULL if we hit a failure at init() time */
+	if (!vmci_trans(vsk))
+		return;
+
 	if (vmci_trans(vsk)->attach_sub_id != VMCI_INVALID_ID) {
 		vmci_event_unsubscribe(vmci_trans(vsk)->attach_sub_id);
 		vmci_trans(vsk)->attach_sub_id = VMCI_INVALID_ID;


