Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5D7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DC42080D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760160;
	bh=B984v3yk0qjRFU8QmHPF2jQZvK+wpmMXNql080sN/DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sQVd1KYi+p2L5/goSVtHp3b/AjUHRIs5lpZfMi4h43Ol2RiBB0kCyKtn7gCEu5uEp
	 YPNCyXPMO5NXvIOWfQF7GeKTsJK+RRG+NOSkq+7Aa6I0KcZ9xK9rAA91g+yk3sbfI+
	 8cyEPOv3ishG5bWUjEfH0Ciff5Y9H65lNSaggvZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfBUOmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:42:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729544AbfBUOmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:42:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 086B62075A;
        Thu, 21 Feb 2019 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760152;
        bh=B984v3yk0qjRFU8QmHPF2jQZvK+wpmMXNql080sN/DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OOCTBI+gzMjWBRi5ZUvVj6YNqP9LJbunsg/zloY3JRB1AxxA8c4NO4jobeKL6wXIp
         H0Y8aoWGVZ4lvr0heYy/Q6MjzK+wnaw3Usb1wqZ2PpJ2gcxVvaZDt78AlBjRqvhVEk
         Xtf3JbSo5pBK2bswEGaxcR3NP8Zr5BMIdrNza9Fk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiumei Mu <xmu@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 04/32] vsock: cope with memory allocation failure at socket creation time
Date:   Thu, 21 Feb 2019 15:35:52 +0100
Message-Id: <20190221125251.103846166@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.855065214@linuxfoundation.org>
References: <20190221125250.855065214@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index c361ce7824123..c3d5ab01fba7b 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1651,6 +1651,10 @@ static void vmci_transport_cleanup(struct work_struct *work)
 
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



