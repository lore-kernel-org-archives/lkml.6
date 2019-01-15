Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE81DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B4920645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570768;
	bh=mq03ULgkvFS67zK5ltqYOhAzfaHfXFIXq+gr+Nf3pEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lWIk25Ur1cT240fg5AT6ofhVezquIqs7LwgptrV1CToaUJQ4ktUsrgqHhc6+kaOZ7
	 JBh3NgQ/yWqVTFvCIizgzmWSgqv1k+C0+2iFH+vxyfhab+FAwUYcFAPlnGnTcPdvnp
	 QdmzImisYo/BkVqpRshIGxWt7rZFH7bHQSh0udb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbfAOQqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387899AbfAOQqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:46:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C08E520675;
        Tue, 15 Jan 2019 16:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570762;
        bh=mq03ULgkvFS67zK5ltqYOhAzfaHfXFIXq+gr+Nf3pEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDjIQaJ8kZLFtUJsGPrG9OjfB9Q4NJCA9dLwnJq0ErdSZPHFLk3VHlQTC1WivEVwS
         rzpb1ryrkbjGmhzTw+LMmCF+Xl6rJK9SShbz54udSvsDAuWO0cxQhYsQmYb1ahSjJm
         TELBh2hlzjxZ+AKWw/n3IpYlnNIPyi1Jy4jowWjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pei Zhang <pezhang@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 4.20 36/57] vfio/type1: Fix unmap overflow off-by-one
Date:   Tue, 15 Jan 2019 17:36:17 +0100
Message-Id: <20190115154912.798297882@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154910.734892368@linuxfoundation.org>
References: <20190115154910.734892368@linuxfoundation.org>
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

From: Alex Williamson <alex.williamson@redhat.com>

commit 58fec830fc19208354895d9832785505046d6c01 upstream.

The below referenced commit adds a test for integer overflow, but in
doing so prevents the unmap ioctl from ever including the last page of
the address space.  Subtract one to compare to the last address of the
unmap to avoid the overflow and wrap-around.

Fixes: 71a7d3d78e3c ("vfio/type1: silence integer overflow warning")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1662291
Cc: stable@vger.kernel.org # v4.15+
Reported-by: Pei Zhang <pezhang@redhat.com>
Debugged-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vfio/vfio_iommu_type1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -878,7 +878,7 @@ static int vfio_dma_do_unmap(struct vfio
 		return -EINVAL;
 	if (!unmap->size || unmap->size & mask)
 		return -EINVAL;
-	if (unmap->iova + unmap->size < unmap->iova ||
+	if (unmap->iova + unmap->size - 1 < unmap->iova ||
 	    unmap->size > SIZE_MAX)
 		return -EINVAL;
 


