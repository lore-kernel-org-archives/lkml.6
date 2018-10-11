Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AD5C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BE42085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlI12OVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BE42085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbeJKXOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbeJKXOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:14:48 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 966FB2085B;
        Thu, 11 Oct 2018 15:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272822;
        bh=YKE3ndWD+/NR6DZ5COMLmOeKWaRaPu2F/BToDswREfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlI12OVsWvg6lpm4XT4k5N2Er99H/1WNE0H5pXaT1Fs02lBdLrHSEHTlHTQW7a7/B
         p5VZ7CLNv6eKRmE176HqK2TpvGZeX+xmyF2WcjE0ME7ZAKHCiRw9mYmwkE851ecyjx
         LVUny1uHO9b7hMEnm6rZT4xUnWaGwfDKO7ShPMQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Michal Hocko <mhocko@suse.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 44/45] virtio_balloon: fix increment of vb->num_pfns in fill_balloon()
Date:   Thu, 11 Oct 2018 17:40:11 +0200
Message-Id: <20181011152510.855514157@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
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

From: Jan Stancek <jstancek@redhat.com>

commit d9e427f6ab8142d6868eb719e6a7851aafea56b6 upstream.

commit c7cdff0e8647 ("virtio_balloon: fix deadlock on OOM")
changed code to increment vb->num_pfns before call to
set_page_pfns(), which used to happen only after.

This patch fixes boot hang for me on ppc64le KVM guests.

Fixes: c7cdff0e8647 ("virtio_balloon: fix deadlock on OOM")
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virtio/virtio_balloon.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -174,13 +174,12 @@ static unsigned fill_balloon(struct virt
 	while ((page = balloon_page_pop(&pages))) {
 		balloon_page_enqueue(&vb->vb_dev_info, page);
 
-		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
-
 		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
 		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
 		if (!virtio_has_feature(vb->vdev,
 					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 			adjust_managed_page_count(page, -1);
+		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
 	}
 
 	num_allocated_pages = vb->num_pfns;


