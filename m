Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FD7C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7A62084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfBCN6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:58:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53724 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728337AbfBCNt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:59 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9k-0003tu-SU; Sun, 03 Feb 2019 13:49:57 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9g-0007At-35; Sun, 03 Feb 2019 14:49:52 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Mathias Thore" <Mathias.Thore@infinera.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.80585554@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 186/305] uio: Fix an Oops on load
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

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
Tested-by: Mathias Thore <Mathias.Thore@infinera.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/uio/uio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -852,14 +852,17 @@ int __uio_register_device(struct module
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

