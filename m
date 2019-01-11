Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F12C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08222183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216430;
	bh=fZGKMrCGncoRrVzqwHd4S+4M+qmiRzJVrSsPtIABLks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gwXQJx5Cnpy/BLC3OUt0BI7fOX3+dP4ahfM3ivueenUTt3JS8WUZi9Zb3VtCra88G
	 e8F3XkoRejPcdnz4jpPQTJbg3qTk1ghgneO3t8oAZrdsvUKOSSIW4yHyKTLXDQFxrf
	 Vg3Hx4dhVCoZK9u7Yvf58jNfnizUHtv/JBG1UJJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbfAKOU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:20:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfAKOU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:20:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 264232177B;
        Fri, 11 Jan 2019 14:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216425;
        bh=fZGKMrCGncoRrVzqwHd4S+4M+qmiRzJVrSsPtIABLks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpA77aMHZrFCc32ThFnGshjofJnqfWzq6YfGNxQc8BOi8vPsB+0rjIJOZiJh5ttQT
         /3o00UQzz5xzS3LNsLV5V37xuIRIopp8zI2OrlCMc1rp+uncoE8rnv3salBrF/Becl
         fKMzkKOIyQO23KK9zEYm35A1WVh26hcj72axIHJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Daniel Verkamp <dverkamp@chromium.org>
Subject: [PATCH 4.4 88/88] vhost/vsock: fix uninitialized vhost_vsock->guest_cid
Date:   Fri, 11 Jan 2019 15:08:57 +0100
Message-Id: <20190111131100.174148460@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Hajnoczi <stefanha@redhat.com>

commit a72b69dc083a931422cc8a5e33841aff7d5312f2 upstream.

The vhost_vsock->guest_cid field is uninitialized when /dev/vhost-vsock
is opened until the VHOST_VSOCK_SET_GUEST_CID ioctl is called.

kvmalloc(..., GFP_KERNEL | __GFP_RETRY_MAYFAIL) does not zero memory.
All other vhost_vsock fields are initialized explicitly so just
initialize this field too.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index c9de9c41aa97..5a5e981bd8e4 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -518,6 +518,8 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
+	vsock->guest_cid = 0; /* no CID assigned yet */
+
 	atomic_set(&vsock->queued_replies, 0);
 
 	vqs[VSOCK_VQ_TX] = &vsock->vqs[VSOCK_VQ_TX];


