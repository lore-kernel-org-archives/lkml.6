Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14BCC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B129821873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151309;
	bh=SbRbdCL7dvVt89A5l4sx8/WBqSQNEh/srwJcsTOpm0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DZhLOtGUFRa9BUIYfqlA1NsQ3ujm/8eUyTHbhG4y4QT6s5zT5v99G1Iy7OpoLA8GR
	 DrY80egqqgkGDyhEO6Lt0DypEUvmhG0ZvmTZeUAYdg0i82A+RSZUTp+X2tmWFiV2S6
	 UZLmrvxu/G1xSBChVDEKxWlwWp+wezwybRcBWTog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeLRQls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:41:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbeLRQlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5593021873;
        Tue, 18 Dec 2018 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151305;
        bh=SbRbdCL7dvVt89A5l4sx8/WBqSQNEh/srwJcsTOpm0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohYnpsT9v2JQPgo7iE0cw7ITHVEDTCZQ6Yur3ZuIJ1Pm5gUkH42lML2b9DJ1BwpO0
         jpIyGntBRYMYW/7A6K5ZG54/xJcep8tlifjyGS7k2m6KSQuZfJAAVD43KJXJzkzWNA
         Q+AS+lfo3KIppkLVf2EqP6zJx+q8QWl/Fznz2h1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 30/44] media: vb2: dont call __vb2_queue_cancel if vb2_start_streaming failed
Date:   Tue, 18 Dec 2018 17:39:42 +0100
Message-Id: <20181218163930.965994484@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

commit 04990215dec43c424daff00d1f622167b8aafd1f upstream.

vb2_start_streaming() already rolls back the buffers, so there is no
need to call __vb2_queue_cancel(). Especially since __vb2_queue_cancel()
does too much, such as zeroing the q->queued_count value, causing vb2
to think that no buffers have been queued.

It appears that this call to __vb2_queue_cancel() is a left-over from
before commit b3379c6201bb3.

Fixes: b3379c6201bb3 ('vb2: only call start_streaming if sufficient buffers are queued')

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: <stable@vger.kernel.org>      # for v4.16 and up
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/common/videobuf2/videobuf2-core.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -1755,10 +1755,8 @@ int vb2_core_streamon(struct vb2_queue *
 		if (ret)
 			return ret;
 		ret = vb2_start_streaming(q);
-		if (ret) {
-			__vb2_queue_cancel(q);
+		if (ret)
 			return ret;
-		}
 	}
 
 	q->streaming = 1;


