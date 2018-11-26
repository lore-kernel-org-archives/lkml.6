Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F77C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032F4214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6mzWfaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032F4214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeKZVql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbeKZVqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:46:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C46921479;
        Mon, 26 Nov 2018 10:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229576;
        bh=ptnjmNxjOY6t3R3FWznFPI0QGCec8fOWmCtccptT/kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6mzWfaWc6cJPs2aJJQb85AdAeK0Fq3KAV4oRTl9eCviyNEN2SM5MPXSPyHeESrEA
         Ryrkb4o5Ic64YKvH3bBrF124llwMHb/6WR+ybKWtD8cjt+FG0D/N5YGrsbsmlWc45S
         vPjVySH6QArxZpbnjktuBc1AFIkZBObFZJPvSeWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Thore <Mathias.Thore@infinera.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 3.18 16/24] uio: Fix an Oops on load
Date:   Mon, 26 Nov 2018 11:51:10 +0100
Message-Id: <20181126105032.100557952@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105029.790599475@linuxfoundation.org>
References: <20181126105029.790599475@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 432798195bbce1f8cd33d1c0284d0538835e25fb upstream.

I was trying to solve a double free but I introduced a more serious
NULL dereference bug.  The problem is that if there is an IRQ which
triggers immediately, then we need "info->uio_dev" but it's not set yet.

This patch puts the original initialization back to how it was and just
sets info->uio_dev to NULL on the error path so it should solve both
the Oops and the double free.

Fixes: f019f07ecf6a ("uio: potential double frees if __uio_register_device() fails")
Reported-by: Mathias Thore <Mathias.Thore@infinera.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable <stable@vger.kernel.org>
Tested-by: Mathias Thore <Mathias.Thore@infinera.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/uio/uio.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -841,14 +841,17 @@ int __uio_register_device(struct module
 	if (ret)
 		goto err_uio_dev_add_attributes;
 
+	info->uio_dev = idev;
+
 	if (info->irq && (info->irq != UIO_IRQ_CUSTOM)) {
 		ret = devm_request_irq(idev->dev, info->irq, uio_interrupt,
 				  info->irq_flags, info->name, idev);
-		if (ret)
+		if (ret) {
+			info->uio_dev = NULL;
 			goto err_request_irq;
+		}
 	}
 
-	info->uio_dev = idev;
 	return 0;
 
 err_request_irq:


