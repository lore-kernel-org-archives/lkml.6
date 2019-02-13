Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8F8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280CF222D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083316;
	bh=Q/rp6iW3ubVP3wJ/shDYAkVt91wZyUCt4tczSnWSspg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jdnOcR4eDHj1r59aUcmYZRdheEg6Qfb8dOSl4eovm3s++py3iR4KVIosTWWDPDtVK
	 8teXFRV2TR2ujGdurny5eZGhGy/c51VO2Wmy8lrG0DzBbOj2VP1W2JNGyI240Yj9dU
	 sGtXn74RtiQiYiZ6GHid+9bnbPnWEP9Sb1Xj8Kew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405553AbfBMSly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:41:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403859AbfBMSlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:41:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF92A222D5;
        Wed, 13 Feb 2019 18:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083313;
        bh=Q/rp6iW3ubVP3wJ/shDYAkVt91wZyUCt4tczSnWSspg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uKhE6XlHL3ILVCXIHa6rqaxmVaSxKIRM8NsceuKEjYLUPSkPD8WAWDHf4if4Ij8BY
         uzHvWgEomOXlFrwxJkThFf24fzdVsfGzrRDJ3oKUvQFSb/7Hrbgg2Neh3eFKXqBo3l
         xi+4I9P6Re1su+9tba7zujlfoXfb6YfYTq6cXgy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xiubo Li <xiubli@redhat.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 30/35] uio: use request_threaded_irq instead
Date:   Wed, 13 Feb 2019 19:38:25 +0100
Message-Id: <20190213183707.428286627@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
References: <20190213183706.176685027@linuxfoundation.org>
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

From: Xiubo Li <xiubli@redhat.com>

commit 9421e45f5ff3d558cf8b75a8cc0824530caf3453 upstream.

Prepraing for changing to use mutex lock.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/uio/uio.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -911,8 +911,9 @@ int __uio_register_device(struct module
 		 * FDs at the time of unregister and therefore may not be
 		 * freed until they are released.
 		 */
-		ret = request_irq(info->irq, uio_interrupt,
-				  info->irq_flags, info->name, idev);
+		ret = request_threaded_irq(info->irq, NULL, uio_interrupt,
+					   info->irq_flags, info->name, idev);
+
 		if (ret) {
 			info->uio_dev = NULL;
 			goto err_request_irq;


