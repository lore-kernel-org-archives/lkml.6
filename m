Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3403DECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD29D21019
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuT4BgDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD29D21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbeKIHi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:38:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbeKIHi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:38:27 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08EF620989;
        Thu,  8 Nov 2018 22:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714459;
        bh=pKetddId1z3buId3afSJThTDC6IEIO20d85iVR3CPno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZuT4BgDAs+nNvOTKKKljbVqFi2LvltvQTZJ5Go7so7nK2GE4daUDy5kzRwoPtg+VU
         obuKcTdCpB7hPi34Bax5ao9iiFgC6VdVqIb6dV2y0kwfdZaK5vw81IRj+8eN/Caggs
         5NKSyGA0YLwnZmFAhZcLriDztqzJLrHpvg8n9Ou0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 099/114] vhost: Fix Spectre V1 vulnerability
Date:   Thu,  8 Nov 2018 13:51:54 -0800
Message-Id: <20181108215109.654652832@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -27,6 +27,7 @@
 #include <linux/cgroup.h>
 #include <linux/module.h>
 #include <linux/sort.h>
+#include <linux/nospec.h>
 
 #include "vhost.h"
 
@@ -748,6 +749,7 @@ long vhost_vring_ioctl(struct vhost_dev
 	if (idx >= d->nvqs)
 		return -ENOBUFS;
 
+	idx = array_index_nospec(idx, d->nvqs);
 	vq = d->vqs[idx];
 
 	mutex_lock(&vq->mutex);


