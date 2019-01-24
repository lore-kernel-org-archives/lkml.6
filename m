Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C7AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753B6218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360666;
	bh=aWkewOkDqlm5URrkXnxKnyYkIZhKZhIaaD02jo/SPVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O5FU9O0wWSgI5QySRE8j4fkyL3kcLi0NGwj3LfAxCHam7K/3qZZJ89SD+ZXHOZynq
	 aLeR+JxeWySTzzOiqgKko+NmddrYe487DFUN+WzujWJEDbdSf0kFVuEIB4P9GHhZaw
	 Z6oh8Dq5Wv4v6KAbS4V0eVeP5vlfQfVYsBwa61P8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbfAXT1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:27:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730717AbfAXT1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:27:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8140218FE;
        Thu, 24 Jan 2019 19:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358031;
        bh=aWkewOkDqlm5URrkXnxKnyYkIZhKZhIaaD02jo/SPVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMsNbrzUsL5snHRUCwmaDo64WbhSx686nzx9eDZU8em4RyPaJH+d8CTrdM9Alsa8U
         eYmJBjsA6c/cPhVQqkaqfkXWWLNefTbj6/oSt4fUdRrJ7y7vm6WrC7tigNfRgSpBLC
         UvOnJkwJX1n3TC/nzqh8JlKt1CVSpJhL8unfiHsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.4 072/104] media: vb2: be sure to unlock mutex on errors
Date:   Thu, 24 Jan 2019 20:20:01 +0100
Message-Id: <20190124190203.483890742@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

commit c06ef2e9acef4cda1feee2ce055b8086e33d251a upstream.

As reported by smatch:
drivers/media/common/videobuf2/videobuf2-core.c: drivers/media/common/videobuf2/videobuf2-core.c:2159 vb2_mmap() warn: inconsistent returns 'mutex:&q->mmap_lock'.
  Locked on:   line 2148
  Unlocked on: line 2100
               line 2108
               line 2113
               line 2118
               line 2156
               line 2159

There is one error condition that doesn't unlock a mutex.

Fixes: cd26d1c4d1bc ("media: vb2: vb2_mmap: move lock up")
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/videobuf2-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -2003,7 +2003,8 @@ int vb2_mmap(struct vb2_queue *q, struct
 	if (length < (vma->vm_end - vma->vm_start)) {
 		dprintk(1,
 			"MMAP invalid, as it would overflow buffer length\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto unlock;
 	}
 
 	ret = call_memop(vb, mmap, vb->planes[plane].mem_priv, vma);


