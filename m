Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481D6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16746218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357769;
	bh=TQJ1/LNr4RmzaY9pPguQMnuxfNBsdQRwbR+qbOJV2sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hquVdvbpXZOsPOQ2KUL3bUNtDmxPLFBFh7IXwxBd5KmfMOXLUPcGXO7JlI9uD4LpH
	 rMcg5U+fqlsh4kNWN52/NB1vQsFItA9oyXi9620ug9pDwNojoipuesF3c6SDlCwts/
	 fxTK7VQhyY/RC7ZXUDU/ko8YXziQe9aCvUzIckIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfAXTWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:22:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729573AbfAXTWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:22:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE00A218CD;
        Thu, 24 Jan 2019 19:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357765;
        bh=TQJ1/LNr4RmzaY9pPguQMnuxfNBsdQRwbR+qbOJV2sA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1UmAhmnoFsX5QF/n/SudgTrOoETs1sS9ZE+W2m/5tHT/0e1+Tkoqywatt4Q4O0w3K
         pEOYkXBSJiy8UmhwzVYlO1jECmtFN9HCnO9fxMyu0wCc4S8kLFwrr4bszFOAeV8M3p
         +b465LMKCqEcp1CcCi9W7JTSm8GcDghD2MJOyGDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        syzbot+53d5b2df0d9744411e2e@syzkaller.appspotmail.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 3.18 25/52] media: vivid: fix error handling of kthread_run
Date:   Thu, 24 Jan 2019 20:19:49 +0100
Message-Id: <20190124190146.227808162@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
References: <20190124190140.879495253@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -829,8 +829,11 @@ int vivid_start_generating_vid_cap(struc
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


