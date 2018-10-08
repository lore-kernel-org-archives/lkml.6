Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161FEC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D254A214C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYXrRSIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D254A214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbeJIB5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:57:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbeJIB53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:57:29 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 842722064A;
        Mon,  8 Oct 2018 18:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024264;
        bh=G8Ed9Ium8y4ZXWhlhH1hqOuPCGVOSH7XjLAw5ax9hgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYXrRSIcNI9Ldl6x5ggz4xllzHR5yJNgT5GhR1DqP1DdhHOxYnqhsfxKj/dS1jVMS
         jYu334PKAyN7hISfX2YEO2nA58a/r2Bo2r/nL5YCltfAD/7wJeExA746MIEE+6yrJN
         Hw4YHHl/ujiOC3CLk3zG8cc1+7zBhJfWUiY7Zx6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wei Liu <wei.liu2@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 76/94] xen/manage: dont complain about an empty value in control/sysrq node
Date:   Mon,  8 Oct 2018 20:31:57 +0200
Message-Id: <20181008175610.154930401@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
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
@@ -283,9 +283,11 @@ static void sysrq_handler(struct xenbus_
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


