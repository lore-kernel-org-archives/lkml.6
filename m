Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1A6C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2F5254E7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2F5254E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeFYGpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:45:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752484AbeFYGpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:45:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 125A34059FFD;
        Mon, 25 Jun 2018 06:45:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-109.ams2.redhat.com [10.36.116.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36C752156892;
        Mon, 25 Jun 2018 06:45:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 38F558F51F; Mon, 25 Jun 2018 08:45:18 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     alex.williamson@redhat.com
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        kvm@vger.kernel.org (open list:VFIO MEDIATED DEVICE DRIVERS)
Subject: [PATCH 2/2] sample/mdev/mbochs: add mbochs_kunmap_dmabuf
Date:   Mon, 25 Jun 2018 08:44:52 +0200
Message-Id: <20180625064453.19768-2-kraxel@redhat.com>
In-Reply-To: <20180625064453.19768-1-kraxel@redhat.com>
References: <20180625064453.19768-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 25 Jun 2018 06:45:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 25 Jun 2018 06:45:20 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no default implementation for dma_buf_ops->unmap.
So add a function unmapping the page, otherwise we'll leak them.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 samples/vfio-mdev/mbochs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index aa25cda21d..85ac603769 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -811,11 +811,18 @@ static void *mbochs_kmap_dmabuf(struct dma_buf *buf, unsigned long page_num)
 	return kmap(page);
 }
 
+static void mbochs_kunmap_dmabuf(struct dma_buf *buf, unsigned long page_num,
+				 void *vaddr)
+{
+	kunmap(vaddr);
+}
+
 static struct dma_buf_ops mbochs_dmabuf_ops = {
 	.map_dma_buf	  = mbochs_map_dmabuf,
 	.unmap_dma_buf	  = mbochs_unmap_dmabuf,
 	.release	  = mbochs_release_dmabuf,
 	.map		  = mbochs_kmap_dmabuf,
+	.unmap		  = mbochs_kunmap_dmabuf,
 	.mmap		  = mbochs_mmap_dmabuf,
 };
 
-- 
2.9.3

