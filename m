Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCC3C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B382064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tk0OvqyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B382064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbeJIBxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbeJIBxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:53:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 754D42064A;
        Mon,  8 Oct 2018 18:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024010;
        bh=1TbjO7bTKuxE99/QWH1kdtwMI7QlkqtJ1MqGqpkYF9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tk0OvqyJKkn2fLB1KMv7ghS6Xs62jtPgfyJHJWzbyRH5+PsMdkcMiyziDipvrAkHx
         8WEH4knRAUEpXT/oQcxcbS+EFGdcgJ5t0n0RYQWzQf+Gx0UzORYQnUuQbDw0dtirIn
         8vyTaYpKuu0cYbCphkkKJeAjJ2jKMkDZFgLG/0Ys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wei Liu <wei.liu2@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 49/59] xen/manage: dont complain about an empty value in control/sysrq node
Date:   Mon,  8 Oct 2018 20:31:56 +0200
Message-Id: <20181008175552.205117911@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175546.620836256@linuxfoundation.org>
References: <20181008175546.620836256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 87dffe86d406bee8782cac2db035acb9a28620a7 ]

When guest receives a sysrq request from the host it acknowledges it by
writing '\0' to control/sysrq xenstore node. This, however, make xenstore
watch fire again but xenbus_scanf() fails to parse empty value with "%c"
format string:

 sysrq: SysRq : Emergency Sync
 Emergency Sync complete
 xen:manage: Error -34 reading sysrq code in control/sysrq

Ignore -ERANGE the same way we already ignore -ENOENT, empty value in
control/sysrq is totally legal.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Wei Liu <wei.liu2@citrix.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/manage.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/xen/manage.c
+++ b/drivers/xen/manage.c
@@ -282,9 +282,11 @@ static void sysrq_handler(struct xenbus_
 		/*
 		 * The Xenstore watch fires directly after registering it and
 		 * after a suspend/resume cycle. So ENOENT is no error but
-		 * might happen in those cases.
+		 * might happen in those cases. ERANGE is observed when we get
+		 * an empty value (''), this happens when we acknowledge the
+		 * request by writing '\0' below.
 		 */
-		if (err != -ENOENT)
+		if (err != -ENOENT && err != -ERANGE)
 			pr_err("Error %d reading sysrq code in control/sysrq\n",
 			       err);
 		xenbus_transaction_end(xbt, 1);


