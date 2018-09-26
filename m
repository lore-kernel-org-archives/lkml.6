Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FD1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F0E214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="suLbkgCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F0E214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeIZWOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:14:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeIZWOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0yMlnVnYLp4myAdL1KL9g55fRweq4trZXtK5P6Zr+QM=; b=suLbkgCJgQXI0J8sy2zIh6AmH
        m4wRJfXc4zIqAbnDGeCkn8sunihVorLINezNVN6vDI2zTyYtyg++5P50O7G1eh1Q3x0HB4e9EYZSx
        I4w+mWutQPZddDO5IJL4UYI/SWKWiGu3606W8K5XJjR+S9J1BnCzW+4lVk8e3j/KplhLVq3RWFdA2
        QAhSHtME8Zh7aj8uqC5utEl4bIIwCvMg51f+vwZjxc12pQ+NaIBbfwIsTEQ6Fmc6m7zFx+HhIqhYK
        O8poKlor8ziwD+wZIRoVGmwq9O++FOuwsXqMCf+iqCeH5myxLtJzEdoGMKNJ8LMV4OtpKAEhYwQKZ
        mn6pZL71Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5CEt-0004EB-7r; Wed, 26 Sep 2018 16:00:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Improve virtio ID allocation
Date:   Wed, 26 Sep 2018 09:00:27 -0700
Message-Id: <20180926160031.15721-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed you were using IDRs where you could be using the more efficient
IDAs, then while fixing that I noticed the lack of error handling,
and I decided to follow that up with an efficiency improvement.

There's probably a v2 of this to follow because I couldn't figure
out how to properly handle one of the error cases ... see the comment
embedded in one of the patches.

Matthew Wilcox (4):
  drm/virtio: Replace IDRs with IDAs
  drm/virtio: Handle context ID allocation errors
  drm/virtio: Handle object ID allocation errors
  drm/virtio: Use IDAs more efficiently

 drivers/gpu/drm/virtio/virtgpu_drv.h   |  9 ++---
 drivers/gpu/drm/virtio/virtgpu_fb.c    | 10 ++++--
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 10 ++++--
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 ++-
 drivers/gpu/drm/virtio/virtgpu_kms.c   | 46 +++++++++-----------------
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 19 ++++-------
 6 files changed, 44 insertions(+), 55 deletions(-)

-- 
2.19.0

