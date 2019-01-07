Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE671C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69E420449
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865014;
	bh=TOj3A5iJ9UTzMZFw1qxQRwfaeNTnsEblF+2/fHeeP3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zPDgruknoNoFy3UON4YVt/CTQc7ysR0We+Iy43cBDRHstp+7v4BG6/sHUcXFAxyS8
	 R0EDkxExfH2w5OAunfwjII3/kzV2Exjvb0/JN9I1iPc6KpfwK9hs/0UK8qSRpG1qBM
	 yQb7h6TJjeHkUi7n+IDZEMexWPIhvp70r/SQikZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfAGMnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:43:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbfAGMn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:43:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4658A20665;
        Mon,  7 Jan 2019 12:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865006;
        bh=TOj3A5iJ9UTzMZFw1qxQRwfaeNTnsEblF+2/fHeeP3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J4ytV8yT21uZX7mVt8RPjwDwvwB5lNUO680J3evGJwqi+DcRfUcgKHiBpnqemOGwI
         qCFF2yKQBwfbQkGrLMbxs8T2qPjoD8HQv2+gtYdvWU2vvLoCwzQaZU5N/jEYBd4WO3
         9STph0jUC/X8ZX6wjrs7YyGg1DLDDn4MowfxC9Dw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        syzbot+e1fb118a2ebb88031d21@syzkaller.appspotmail.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.20 116/145] media: vb2: check memory model for VIDIOC_CREATE_BUFS
Date:   Mon,  7 Jan 2019 13:32:33 +0100
Message-Id: <20190107104452.415812648@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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
@@ -812,6 +812,9 @@ int vb2_core_create_bufs(struct vb2_queu
 		memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
 		q->memory = memory;
 		q->waiting_for_buffers = !q->is_output;
+	} else if (q->memory != memory) {
+		dprintk(1, "memory model mismatch\n");
+		return -EINVAL;
 	}
 
 	num_buffers = min(*count, VB2_MAX_FRAME - q->num_buffers);


