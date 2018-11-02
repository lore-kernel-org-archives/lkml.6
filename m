Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E56C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B6C2084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnQZ2b/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B6C2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbeKCDyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbeKCDyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:54:23 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60D1120837;
        Fri,  2 Nov 2018 18:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184370;
        bh=8NRCr/cpqpw2JFL6wTeXCBn3EmyvbkLyFOFXyfS5hIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tnQZ2b/Mj9EcJ61tGpm227mD6LZmXbpkpaCuLZwHHbl+z11njbEeOFD2T6scMOJq1
         U4UxzcEfzLrZFhXlWiEo299zl78kAkC/apJgaZotpUCFfIT/1NUSbWmk84oYFRSihJ
         8iFMFmovQtc3QiRYWv/z/l0j9h7V7H4AvmOJYSbY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 120/150] vhost: Fix Spectre V1 vulnerability
Date:   Fri,  2 Nov 2018 19:34:42 +0100
Message-Id: <20181102182911.359261123@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit ff002269a4ee9c769dbf9365acef633ebcbd6cbe ]

The idx in vhost_vring_ioctl() was controlled by userspace, hence a
potential exploitation of the Spectre variant 1 vulnerability.

Fixing this by sanitizing idx before using it to index d->vqs.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vhost.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -30,6 +30,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/interval_tree_generic.h>
+#include <linux/nospec.h>
 
 #include "vhost.h"
 
@@ -1362,6 +1363,7 @@ long vhost_vring_ioctl(struct vhost_dev
 	if (idx >= d->nvqs)
 		return -ENOBUFS;
 
+	idx = array_index_nospec(idx, d->nvqs);
 	vq = d->vqs[idx];
 
 	mutex_lock(&vq->mutex);


