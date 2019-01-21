Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AF1C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA37B20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078990;
	bh=Y/4lwItuwOGFT3EmwKfK/2AehA09+cFRTCtAkfnqjLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=exyjiY8U8mcHmxalddXWQmlo+w8r8r4DWw6rqQLTumEwxzdiUdBNAISNXRt3gPwFj
	 0AjnCFFwZb+3RrdMg1AGFlpDZc0K17yRP6u6a9lTrkoH930uTir8xB+qiDhFyGkclL
	 NZc6+AneSfhaWiyo+nC62kVtNuWyTKc/KPMJUjBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfAUN42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:56:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731923AbfAUN4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:56:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1139B2084C;
        Mon, 21 Jan 2019 13:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078984;
        bh=Y/4lwItuwOGFT3EmwKfK/2AehA09+cFRTCtAkfnqjLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npmfZlq1HBZ9ibG6XNJFXcwjIXxYd4BeWkNMocEck53qtOPgmQQmxq6BjBO5I6Chl
         81OzRoCvFGnB4pUflA0Vd4UdFOZ8Qbh7C0duO5dUfUcXkiD/rOPNXT7GOvKzrufDt/
         WoydhK4opbU4aIv5+KMNXvP3aJNwbteEp79Q+gVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        syzbot+be93025dd45dccd8923c@syzkaller.appspotmail.com,
        Hans Verkuil <hansverk@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.9 35/51] media: vb2: vb2_mmap: move lock up
Date:   Mon, 21 Jan 2019 14:44:31 +0100
Message-Id: <20190121122457.054250497@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

commit cd26d1c4d1bc947b56ae404998ae2276df7b39b7 upstream.

If a filehandle is dup()ped, then it is possible to close it from one fd
and call mmap from the other. This creates a race condition in vb2_mmap
where it is using queue data that __vb2_queue_free (called from close())
is in the process of releasing.

By moving up the mutex_lock(mmap_lock) in vb2_mmap this race is avoided
since __vb2_queue_free is called with the same mutex locked. So vb2_mmap
now reads consistent buffer data.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Reported-by: syzbot+be93025dd45dccd8923c@syzkaller.appspotmail.com
Signed-off-by: Hans Verkuil <hansverk@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/videobuf2-core.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -1916,9 +1916,13 @@ int vb2_mmap(struct vb2_queue *q, struct
 			return -EINVAL;
 		}
 	}
+
+	mutex_lock(&q->mmap_lock);
+
 	if (vb2_fileio_is_active(q)) {
 		dprintk(1, "mmap: file io in progress\n");
-		return -EBUSY;
+		ret = -EBUSY;
+		goto unlock;
 	}
 
 	/*
@@ -1926,7 +1930,7 @@ int vb2_mmap(struct vb2_queue *q, struct
 	 */
 	ret = __find_plane_by_offset(q, off, &buffer, &plane);
 	if (ret)
-		return ret;
+		goto unlock;
 
 	vb = q->bufs[buffer];
 
@@ -1942,8 +1946,9 @@ int vb2_mmap(struct vb2_queue *q, struct
 		return -EINVAL;
 	}
 
-	mutex_lock(&q->mmap_lock);
 	ret = call_memop(vb, mmap, vb->planes[plane].mem_priv, vma);
+
+unlock:
 	mutex_unlock(&q->mmap_lock);
 	if (ret)
 		return ret;


