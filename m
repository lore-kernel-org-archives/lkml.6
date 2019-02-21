Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A8CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570B22080D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760027;
	bh=pqXFUHtbg+D77JgZmUzaXHJtbmDBadv2uNZgJkjzwsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o8c08EMh65IwljEW9VUq+jPHBes8AguFNJqaklr9JR7rihsJ4Mt/MS2lc4AdtdN5X
	 GAg4DvfuPN6n7h/PeAHwNKiNsXFuSaRf33v4496ecWfwB6dL8vnPh/aXdsrQAOav5o
	 SRMe6pKfmpzNe/YD0mMNHJCFsC7nQ7pI1uUZuE14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfBUOkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:40:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbfBUOkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:40:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F7E2084D;
        Thu, 21 Feb 2019 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760023;
        bh=pqXFUHtbg+D77JgZmUzaXHJtbmDBadv2uNZgJkjzwsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QP+7tqU1muONxQvq8EyRbkYUash+HnrS9friW0+Yhzaqppf8Qw8S5X27hZL/B859t
         kZuAaGJA5kJGx1OiQpKodhDoB6385depKC6RlZyC5vFJPoczMiAffjyUQv8fkKvjQJ
         C2lnJm7D6dokqbFBWbNWS0giETlXxvpc3MbyJUC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiumei Mu <xmu@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 04/23] vsock: cope with memory allocation failure at socket creation time
Date:   Thu, 21 Feb 2019 15:35:46 +0100
Message-Id: <20190221125246.591403675@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125246.162644302@linuxfoundation.org>
References: <20190221125246.162644302@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/vmci_transport.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index bf7c516444467..ad3f47a714f36 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1648,6 +1648,10 @@ static void vmci_transport_cleanup(struct work_struct *work)
 
 static void vmci_transport_destruct(struct vsock_sock *vsk)
 {
+	/* transport can be NULL if we hit a failure at init() time */
+	if (!vmci_trans(vsk))
+		return;
+
 	/* Ensure that the detach callback doesn't use the sk/vsk
 	 * we are about to destruct.
 	 */
-- 
2.19.1



