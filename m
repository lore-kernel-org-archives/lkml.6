Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5369C2F3C7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9441B20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078853;
	bh=2dn0MAVV2ZCGmHT7cb8UZ+3DBr/iovJxRuTVNB6p2aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FRHiQvjnXkW+pXz9g9RSC5VMI7eCZYfZKNhhipp1LNd0U6yjOBtE+J3xxfB1Ldwtv
	 SRjy9177DWF+09W1liHe3zBrLYYXHxEULBXi19Pyx5OwwyrzmO1/huSogD+Fs2Vkee
	 Se4QrRL5NaS1TnGtMSXYM9sKC2m0jC2iMVpeo5Ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfAUNyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:54:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729827AbfAUNyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:54:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D62F2089F;
        Mon, 21 Jan 2019 13:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078848;
        bh=2dn0MAVV2ZCGmHT7cb8UZ+3DBr/iovJxRuTVNB6p2aI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GV70GDSCISZpXdsT0gfhbHk8xo/kOVAAAzdvmg/2YhLMeyQf/B1ercO7L5EFNcOdI
         lEZVmmdN5BNPG4bJkL+pCv4BvVrXKQRjUJbJ5edfz+2K8GjalQKRIclbNG5ex2roRU
         H3ST/JCxHY5BB4nGp0A83UIAd0jpHIiVtyrwVSVs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        syzbot+53d5b2df0d9744411e2e@syzkaller.appspotmail.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.14 38/59] media: vivid: fix error handling of kthread_run
Date:   Mon, 21 Jan 2019 14:44:03 +0100
Message-Id: <20190121122501.038931320@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 701f49bc028edb19ffccd101997dd84f0d71e279 upstream.

kthread_run returns an error pointer, but elsewhere in the code
dev->kthread_vid_cap/out is checked against NULL.

If kthread_run returns an error, then set the pointer to NULL.

I chose this method over changing all kthread_vid_cap/out tests
elsewhere since this is more robust.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-by: syzbot+53d5b2df0d9744411e2e@syzkaller.appspotmail.com
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vivid/vivid-kthread-cap.c |    5 ++++-
 drivers/media/platform/vivid/vivid-kthread-out.c |    5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/media/platform/vivid/vivid-kthread-cap.c
+++ b/drivers/media/platform/vivid/vivid-kthread-cap.c
@@ -877,8 +877,11 @@ int vivid_start_generating_vid_cap(struc
 			"%s-vid-cap", dev->v4l2_dev.name);
 
 	if (IS_ERR(dev->kthread_vid_cap)) {
+		int err = PTR_ERR(dev->kthread_vid_cap);
+
+		dev->kthread_vid_cap = NULL;
 		v4l2_err(&dev->v4l2_dev, "kernel_thread() failed\n");
-		return PTR_ERR(dev->kthread_vid_cap);
+		return err;
 	}
 	*pstreaming = true;
 	vivid_grab_controls(dev, true);
--- a/drivers/media/platform/vivid/vivid-kthread-out.c
+++ b/drivers/media/platform/vivid/vivid-kthread-out.c
@@ -248,8 +248,11 @@ int vivid_start_generating_vid_out(struc
 			"%s-vid-out", dev->v4l2_dev.name);
 
 	if (IS_ERR(dev->kthread_vid_out)) {
+		int err = PTR_ERR(dev->kthread_vid_out);
+
+		dev->kthread_vid_out = NULL;
 		v4l2_err(&dev->v4l2_dev, "kernel_thread() failed\n");
-		return PTR_ERR(dev->kthread_vid_out);
+		return err;
 	}
 	*pstreaming = true;
 	vivid_grab_controls(dev, true);


