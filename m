Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE71C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB36E21736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867078;
	bh=f3uRfyNoTr6GVAOghPCfwbxjuihya0P4I792nhW8QW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DANyJ8H5b10CaQoY0vlRqi3sH7LTtDlshs5wGqCxFm5REozSoVhhM3C1k/zdjf2EO
	 faib7qJQHGOFqVSdoiHgKLrGr6xDq9lbplnITtPjri00LOIMGBWUvewGN45aFx1YOz
	 6o4RDA9B2w/1XzTnHJqVw6orUhdqEDYN4D7FRlfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfAGNR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:17:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbfAGM7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:59:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90F4821736;
        Mon,  7 Jan 2019 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865975;
        bh=f3uRfyNoTr6GVAOghPCfwbxjuihya0P4I792nhW8QW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1XRuiyIqEcv4xkTo1DB8/Ql7A98B1AyS/fp3cunruZc6bL8LOagqqM2AMMyl0R6w
         /HOxiOKj7Fbjs9g6QqR0SmEYVCGSRBvE/kY/ueB2VFGg+ZLhLr7ZsocTAcHYYDIg/f
         DUvSy17Cbeicgw4w9IQ0LqNS2spWd8/vxiG2apJ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        syzbot+e1fb118a2ebb88031d21@syzkaller.appspotmail.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 147/170] media: vb2: check memory model for VIDIOC_CREATE_BUFS
Date:   Mon,  7 Jan 2019 13:32:54 +0100
Message-Id: <20190107104510.302703527@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 62dcb4f41836bd3c44b5b651bb6df07ea4cb1551 upstream.

vb2_core_create_bufs did not check if the memory model for newly added
buffers is the same as for already existing buffers. It should return an
error if they aren't the same.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-by: syzbot+e1fb118a2ebb88031d21@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>      # for v4.16 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/common/videobuf2/videobuf2-core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -800,6 +800,9 @@ int vb2_core_create_bufs(struct vb2_queu
 		memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
 		q->memory = memory;
 		q->waiting_for_buffers = !q->is_output;
+	} else if (q->memory != memory) {
+		dprintk(1, "memory model mismatch\n");
+		return -EINVAL;
 	}
 
 	num_buffers = min(*count, VB2_MAX_FRAME - q->num_buffers);


