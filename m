Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B41121901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497747;
	bh=QD4RaPuFzMa4QOoF2w9ZHCbsDKWetjlTw2IVSIooBzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zpzOjatfbaAqMa5UixGTdaD2SP6wTuWI3P352wVCtbnDqsL4OedsolKUJipD9MGcG
	 aMYsPEBIQm7I+0AHm341mRKEa8v6WAB2bgLwMAlvu7qbo2e4lAhQjN8icYTkGKt4OM
	 cAf1blhrh94SU9qG/ykL2//71dEFW33tBAWeykCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfBRNtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:49:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729305AbfBRNtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:49:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E09920842;
        Mon, 18 Feb 2019 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497741;
        bh=QD4RaPuFzMa4QOoF2w9ZHCbsDKWetjlTw2IVSIooBzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=isfU1cREi3s3KORiTwa/puDhP4mWa/tu7rUS7nsBYFbYbCUcfLsKVV3VCXY7aDMbr
         EJ0AuACfnWMTmafRS5ywXK6B4AgQSczVImoHpI11tU6bWuYylcTaeFbQNbKASKrhPp
         ChJ5uvAVF//FN9LbVzZZGm8HU6rtii1whsQEoQYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 4.20 88/92] drm: Use array_size() when creating lease
Date:   Mon, 18 Feb 2019 14:43:31 +0100
Message-Id: <20190218133503.548110481@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

From: Matthew Wilcox <willy@infradead.org>

commit 69ef943dbc14b21987c79f8399ffea08f9a1b446 upstream.

Passing an object_count of sufficient size will make
object_count * 4 wrap around to be very small, then a later function
will happily iterate off the end of the object_ids array.  Using
array_size() will saturate at SIZE_MAX, the kmalloc() will fail and
we'll return an -ENOMEM to the norty userspace.

Fixes: 62884cd386b8 ("drm: Add four ioctls for managing drm mode object leases [v7]")
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: <stable@vger.kernel.org> # v4.15+
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_lease.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -521,7 +521,8 @@ int drm_mode_create_lease_ioctl(struct d
 
 	object_count = cl->object_count;
 
-	object_ids = memdup_user(u64_to_user_ptr(cl->object_ids), object_count * sizeof(__u32));
+	object_ids = memdup_user(u64_to_user_ptr(cl->object_ids),
+			array_size(object_count, sizeof(__u32)));
 	if (IS_ERR(object_ids))
 		return PTR_ERR(object_ids);
 


