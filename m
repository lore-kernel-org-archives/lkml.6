Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F3720C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB81320660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB81320660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933525AbeFKSG7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:06:59 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37747 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933385AbeFKSG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:06:58 -0400
Received: by mail-ot0-f194.google.com with SMTP id 101-v6so24864687oth.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 11:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2wVfBJExz/kyiM37pRv/Vc6rAqkWscaiD8J+QlX7+CQ=;
        b=H3p28f97sKR2JvYTz1oy/8FOSzUWB+5ndCji8xFaTBdj3rZUsoDtTHDxI7xhThpvkA
         ppMIhwvXg3sRPCUHUozemkGEHY9a37yoPlgyeTtEmnFGXHxW+WbIE2pkwRD+wV46DYMH
         PvSJkEKXFZq7bStFc4uZSz2hbW9wIqD/tq1TUHpRx7iUgnY146xKS0ZPMuFgYmUpQPir
         JJXTLEfr7Y09ThYEeAdswgQ4LUJNUZBb/1Pd8dDUB7qBDu+a6xlc/CGyoXreEuQSKOGc
         mkc/dyD3orGkwnkOX3ZTAO5Tt0TfWE8ot/CrRcsR2Ved10MOuzCO66DxFRRjUYGOi6lS
         yItQ==
X-Gm-Message-State: APt69E0CS9upoTYlv/Kkw0XX/Jpe1DRWfKHtNDibv/rMc5wDXdUVPD/P
        GOPa1D7IgNOnvTiLGrMVQXpKoA==
X-Google-Smtp-Source: ADUXVKLmZ9lghjLk3N6zczmCXCzXELYgAI+VdAkmBEPjYohsWby/CJvgJEE8ZZaUebhhTvSKJtAizw==
X-Received: by 2002:a9d:49a8:: with SMTP id g40-v6mr146581otf.223.1528740417836;
        Mon, 11 Jun 2018 11:06:57 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::d2dd])
        by smtp.gmail.com with ESMTPSA id b38-v6sm18406664otd.61.2018.06.11.11.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 11:06:56 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: android: ion: Return an ERR_PTR in ion_map_kernel
Date:   Mon, 11 Jun 2018 11:06:53 -0700
Message-Id: <20180611180653.30573-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The expected return value from ion_map_kernel is an ERR_PTR. The error
path for a vmalloc failure currently just returns NULL, triggering
a warning in ion_buffer_kmap_get. Encode the vmalloc failure as an ERR_PTR.

Reported-by: syzbot+55b1d9f811650de944c6@syzkaller.appspotmail.com
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/staging/android/ion/ion_heap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
index 772dad65396e..f32c12439eee 100644
--- a/drivers/staging/android/ion/ion_heap.c
+++ b/drivers/staging/android/ion/ion_heap.c
@@ -29,7 +29,7 @@ void *ion_heap_map_kernel(struct ion_heap *heap,
 	struct page **tmp = pages;
 
 	if (!pages)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	if (buffer->flags & ION_FLAG_CACHED)
 		pgprot = PAGE_KERNEL;
-- 
2.17.0

